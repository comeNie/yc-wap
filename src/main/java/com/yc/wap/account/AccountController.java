package com.yc.wap.account;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.exception.SystemException;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.slp.balance.api.fundquery.interfaces.IFundQuerySV;
import com.ai.slp.balance.api.fundquery.param.AccountIdParam;
import com.ai.slp.balance.api.fundquery.param.FundInfo;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCUserInfoResponse;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.constants.Constants;
import com.yc.wap.system.constants.ConstantsResultCode;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.DecimalFormat;

/**
 * Created by ldy on 2016/11/9.
 */
@Controller
@RequestMapping(value = "account")
public class AccountController extends BaseController {
    private Log log = LogFactory.getLog(AccountController.class);

    private IFundQuerySV iFundQuerySV = DubboConsumerFactory.getService(IFundQuerySV.class);
    private IYCUserServiceSV iycUserServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);

    @RequestMapping(value = "recharge")
    public String recharge() {
        log.info("account-recharge invoked");
        String balance = request.getParameter("balance");

        request.setAttribute("balance", balance);
        return "account/recharge";
    }

    @RequestMapping(value = "balance")
    public String balance() {
        log.info("account-balance invoked");

        return "account/balance";
    }

    @RequestMapping(value = "GetBalance")
    @ResponseBody
    public Object GetBalance() {
        MsgBean result = new MsgBean();
        String Balance = "0.00";
        String UID = (String) session.getAttribute("UID");

        SearchYCUserRequest userRequest = new SearchYCUserRequest();
        userRequest.setUserId(UID);
        YCUserInfoResponse infoResponse = iycUserServiceSV.searchYCUserInfo(userRequest);
        Long AccountId = infoResponse.getAccountId();

        AccountIdParam req = new AccountIdParam();
        req.setAccountId(AccountId);
        req.setTenantId(Constants.TENANTID);
        log.info("QueryUsableFundUID: " + UID);
        try {
            FundInfo resp = iFundQuerySV.queryUsableFund(req);
            if (resp.getResponseHeader().getResultCode().equals(ConstantsResultCode.FUNDSUCCESS)) {
                log.info("QueryUsableFundReturn: " + com.alibaba.fastjson.JSONArray.toJSONString(resp));
                Double _Balance = (double) resp.getBalance() / 1000;
                DecimalFormat df = new DecimalFormat("######0.00");
                result.put("balance", df.format(_Balance) + "");
            } else if (resp.getResponseHeader().getResultCode().equals(ConstantsResultCode.NOACCOUNT)) {
                log.info("QueryUsableFundReturnNoAccount");
                Balance = "0.00";
                result.put("balance", Balance);
            } else {
                log.info("QueryUsableFund: " + resp.getResponseHeader().getResultCode() + ", Msg: " + resp.getResponseHeader().getResultMessage());
                throw new RuntimeException("QueryUsableFundFailed");
            }
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("QueryUsableFundFailed");
        }
        return result.returnMsg();
    }

    @RequestMapping(value = "rechargesuccess")
    public String rechargesuccess() {
        log.info("account-rechargesuccess invoked");

        return "account/rechargesuccess";
    }

}

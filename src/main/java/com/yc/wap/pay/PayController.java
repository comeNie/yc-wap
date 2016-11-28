package com.yc.wap.pay;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.exception.SystemException;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.slp.balance.api.deduct.interfaces.IDeductSV;
import com.ai.slp.balance.api.deduct.param.DeductParam;
import com.ai.slp.balance.api.deduct.param.DeductResponse;
import com.ai.slp.balance.api.deposit.interfaces.IDepositSV;
import com.ai.slp.balance.api.deposit.param.DepositParam;
import com.ai.slp.balance.api.deposit.param.TransSummary;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCUserInfoResponse;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.constants.Constants;
import com.yc.wap.system.constants.ConstantsResultCode;
import com.yc.wap.system.utils.ConfigUtil;
import com.yc.wap.system.utils.PaymentUtil;
import com.yc.wap.system.utils.VerifyUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Nozomi on 11/14/2016.
 */
@Controller
@RequestMapping(value = "pay")
public class PayController extends BaseController {
    private Log log = LogFactory.getLog(PayController.class);
    private IDepositSV iDepositSV = DubboConsumerFactory.getService(IDepositSV.class);
    private IYCUserServiceSV iycUserServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
    private IDeductSV iDeductSV = DubboConsumerFactory.getService(IDeductSV.class);

    private String TENANTID = ConfigUtil.getProperty("TENANT_ID");


    @RequestMapping(value = "/gotoPay")
    public void gotoPayByOrg(String orderId, String orderAmount, String currencyUnit, String merchantUrl, String payOrgCode,
                             HttpServletRequest request, HttpServletResponse response) throws Exception {

        String notifyUrl = ConfigUtil.getProperty("NOTIFY_URL");//+"/"+orderType+"/"+ UserUtil.getUserId();
        String returnUrl = ConfigUtil.getProperty("RETURN_URL");

        Map<String, String> map = new HashMap<String, String>();
        map.put("tenantId", TENANTID);
        map.put("orderId", orderId);
        map.put("returnUrl", returnUrl);
        map.put("notifyUrl", notifyUrl);
        map.put("merchantUrl", merchantUrl);
        map.put("requestSource", "2");
        map.put("orderAmount", orderAmount);
        map.put("currencyUnit", currencyUnit);
        map.put("subject", "orderPay");
        map.put("payOrgCode", payOrgCode);
        // 加密
        String infoStr = orderId + VerifyUtil.SEPARATOR + orderAmount + VerifyUtil.SEPARATOR + notifyUrl + VerifyUtil.SEPARATOR + TENANTID;
        String infoMd5 = VerifyUtil.encodeParam(infoStr, ConfigUtil.getProperty("REQUEST_KEY"));
        map.put("infoMd5", infoMd5);
        log.info("开始前台通知:" + map);
        String htmlStr = PaymentUtil.generateAutoSubmitForm(ConfigUtil.getProperty("ACTION_URL"), map);
        log.info("发起支付申请:" + htmlStr);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write(htmlStr);
        response.getWriter().flush();
    }

    @RequestMapping(value = "payResult")
    public String payResult() {
        log.info("PayResult-NOTIFY_URL");
        String orderId = request.getParameter("orderId");
        String payStates = request.getParameter("payStates");
        String orderAmount = request.getParameter("orderAmount");
        log.info("orderId" + orderId + ",payStates" + payStates + ",orderAmount: " + orderAmount);
        if (payStates.equals("00")) {
            request.setAttribute("result", "success");
            BalanceRecharge(orderId, orderAmount);


        } else if (payStates.equals("01")) {
            request.setAttribute("result", "fail");
        }
        return "written/payresult";
    }

    @RequestMapping(value = "payResultView")
    public String payResultView() {
        log.info("PayResult-RETURN_URL");
        String orderId = request.getParameter("orderId");
        String payStates = request.getParameter("payStates");
        log.info("orderId" + orderId + ",payStates" + payStates);
        if (payStates.equals("00")) {
            request.setAttribute("result", "success");
        } else if (payStates.equals("01")) {
            request.setAttribute("result", "fail");
        }
        return "written/payresult";
    }

    private boolean BalanceRecharge(String orderId, String Amount) {
        String UID = (String) session.getAttribute("UID");

        SearchYCUserRequest req = new SearchYCUserRequest();
        req.setUserId(UID);
        YCUserInfoResponse resp = iycUserServiceSV.searchYCUserInfo(req);
        String AccountId = resp.getUserId();

        log.info("UID: " + UID);
        log.info("AccountId: " + AccountId);

        DepositParam param = new DepositParam();
        param.setAccountId(Long.parseLong(AccountId));  //	账户ID
        param.setBusiDesc("余额");    //业务描述
        param.setBusiSerialNo(orderId);

        TransSummary summary = new TransSummary();  //交易摘要
        summary.setAmount(Long.parseLong(Amount) * 1000);
        summary.setSubjectId(100000);

        List<TransSummary> transSummaryList = new ArrayList<TransSummary>();
        transSummaryList.add(summary);
        param.setTransSummary(transSummaryList);

        param.setCurrencyUnit("RMB");   //币种,RMB:人民币  USD：美元
        param.setBusiOperCode("300000");    //固定值
        param.setPayStyle("1");   //业务渠道,0：余额 1：支付宝 2：网银 3：pay pal 5：后付 6：积分 7：优惠劵 对应serial表中的CHANNEL字段
        param.setTenantId(Constants.TENANTID);
        param.setSystemId("Cloud-UAC_WEB"); //固定值

        try {
            String serialCode = iDepositSV.depositFund(param);
            log.info("serialCode: " + serialCode);

            return true;
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("BalanceRechargeFail");
        }
    }

    @RequestMapping(value = "BalancePayment")
    public void BalancePayment(String OrderId, String Amount) {
        String UID = (String) session.getAttribute("UID");

        SearchYCUserRequest req = new SearchYCUserRequest();
        req.setUserId(UID);
        YCUserInfoResponse resp = iycUserServiceSV.searchYCUserInfo(req);
        String AccountId = resp.getUserId();

        DeductParam Param = new DeductParam();
        Param.setSystemId(TENANTID);
        Param.setExternalId(OrderId);
        Param.setBusinessCode("1");
        Param.setAccountId(Long.parseLong(AccountId));
        Param.setCheckPwd(0);
        Param.setTotalAmount(Long.parseLong(Amount));
        Param.setChannel("中译语通科技有限公司");

        try {
            DeductResponse response = iDeductSV.deductFund(Param);
            if (response.getResponseHeader().getResultCode().equals(ConstantsResultCode.SUCCESS)) {
                String serialNo = response.getSerialNo();
                // Todo 支付成功
            } else {
                // Todo 支付失败
            }
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("BalancePaymentFail");
        }
    }
}

package com.yc.wap.pay;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.slp.balance.api.deposit.interfaces.IDepositSV;
import com.ai.slp.balance.api.deposit.param.DepositParam;
import com.ai.slp.balance.api.deposit.param.TransSummary;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.constants.Constants;
import com.yc.wap.system.utils.ConfigUtil;
import com.yc.wap.system.utils.PaymentUtil;
import com.yc.wap.system.utils.VerifyUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by Nozomi on 11/14/2016.
 */
@Controller
@RequestMapping(value = "pay")
public class PayController extends BaseController {
    private Log log = LogFactory.getLog(PayController.class);
    private IDepositSV iDepositSV = DubboConsumerFactory.getService(IDepositSV .class);
    @RequestMapping(value = "/gotoPay")
    public void gotoPayByOrg(String orderId, Long orderAmount, String currencyUnit, String merchantUrl, String payOrgCode,
                             String orderType, HttpServletRequest request, HttpServletResponse response) throws Exception {

        log.info("PayController-gotoPay");

        String tenantId = ConfigUtil.getProperty("TENANT_ID");
        String notifyUrl = ConfigUtil.getProperty("NOTIFY_URL");//+"/"+orderType+"/"+ UserUtil.getUserId();
        String returnUrl = ConfigUtil.getProperty("RETURN_URL");

        Map<String, String> map = new HashMap<String, String>();
        map.put("tenantId", tenantId);
        map.put("orderId", orderId);
        map.put("returnUrl", returnUrl);
        map.put("notifyUrl", notifyUrl);
        map.put("merchantUrl",merchantUrl);
        map.put("requestSource", "2");
        map.put("orderAmount", String.valueOf(orderAmount));
        map.put("currencyUnit",currencyUnit);
        map.put("subject", "orderPay");
        map.put("payOrgCode", payOrgCode);
        // 加密
        String infoStr = orderId + VerifyUtil.SEPARATOR + orderAmount + VerifyUtil.SEPARATOR + notifyUrl + VerifyUtil.SEPARATOR + tenantId;
        String infoMd5 = VerifyUtil.encodeParam(infoStr, ConfigUtil.getProperty("REQUEST_KEY"));
        map.put("infoMd5", infoMd5);
        log.info("开始前台通知:" + map);
        String htmlStr = PaymentUtil.generateAutoSubmitForm(ConfigUtil.getProperty("ACTION_URL"), map);
        log.info("发起支付申请:" + htmlStr);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write(htmlStr);
        response.getWriter().flush();
    }

    @RequestMapping(value = "BalanceRecharge")
    @ResponseBody
    public Object BalanceRecharge(){
        MsgBean result = new MsgBean();

        String uid = (String) session.getAttribute("UID");
        String time = (new Date()).getTime() + "";
        String busiSerial = uid + time;

        DepositParam param = new DepositParam();
        param.setAccountId(11651);  //	账户ID
        param.setBusiDesc("余额");    //业务描述
        param.setBusiSerialNo(busiSerial);

        TransSummary summary = new TransSummary();  //交易摘要
        summary.setAmount(10);
        summary.setSubjectId(100000);

        List<TransSummary> transSummaryList = new ArrayList<TransSummary>();
        transSummaryList.add(summary);
        param.setTransSummary(transSummaryList);

        param.setCurrencyUnit("RMB");   //币种,RMB:人民币  USD：美元
        param.setBusiOperCode("300000");    //固定值
        param.setPayStyle("1");   //业务渠道,0：余额 1：支付宝 2：网银 3：pay pal 5：后付 6：积分 7：优惠劵 对应serial表中的CHANNEL字段
        param.setTenantId(Constants.TENANTID);
        param.setSystemId("Cloud-UAC_WEB"); //固定值
        String string = iDepositSV.depositFund(param);
        log.info(string);
        return result.returnMsg();
    }

    @RequestMapping(value = "payResult")
    public String payResult() {
        log.info("PayResult-NOTIFY_URL");
        request.setAttribute("result", "success");
        return "written/payresult";
    }

    @RequestMapping(value = "payResultView")
    public String payResultView() {
        log.info("PayResult-RETURN_URL");
        request.setAttribute("result", "fail");
        return "written/payresult";
    }

}

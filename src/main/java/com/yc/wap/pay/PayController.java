package com.yc.wap.pay;

import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.utils.ConfigUtil;
import com.yc.wap.system.utils.PaymentUtil;
import com.yc.wap.system.utils.VerifyUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Nozomi on 11/14/2016.
 */
@Controller
@RequestMapping(value = "pay")
public class PayController extends BaseController {
    private Log log = LogFactory.getLog(PayController.class);

    @RequestMapping(value = "/gotoPay")
    public void gotoPayByOrg(String orderId, Long orderAmount, String currencyUnit, String merchantUrl, String payOrgCode,
                             String orderType, HttpServletRequest request, HttpServletResponse response) throws Exception {
        log.info("PayController-gotoPay");
        //租户
        String tenantId = ConfigUtil.getProperty("TENANT_ID");
        //服务异步通知地址
        String notifyUrl = ConfigUtil.getProperty("NOTIFY_URL");//+"/"+orderType+"/"+ UserUtil.getUserId();

        String returnUrl = ConfigUtil.getProperty("RETURN_URL");

        Map<String, String> map = new HashMap<String, String>();
        map.put("tenantId", tenantId);
        map.put("orderId", orderId);
        map.put("returnUrl", returnUrl);
        map.put("notifyUrl", notifyUrl);
        map.put("requestSource", "1");
        map.put("orderAmount", String.valueOf(orderAmount));
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
    }

    @RequestMapping(value = "payResult")
    public String payResult() {
        request.setAttribute("result", "success");
        return "written/payresult";
    }

    @RequestMapping(value = "payResultView")
    public String payResultView() {
        request.setAttribute("result", "fail");
        return "written/payresult";
    }

}

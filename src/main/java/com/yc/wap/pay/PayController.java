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

    @RequestMapping(value = "/gotoPayByOrg")
    public void gotoPayByOrg(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String tenantId = request.getParameter("tenantId");
        String orderId = request.getParameter("orderId");
        String returnUrl = request.getParameter("returnUrl");
        String notifyUrl = request.getParameter("notifyUrl");
        String orderAmount = request.getParameter("orderAmount");
        String subject = request.getParameter("subject");
        String requestSource = request.getParameter("requestSource");

        Map<String, String> map = new HashMap<String, String>();
        map.put("tenantId", tenantId);
        map.put("orderId", orderId);
        map.put("returnUrl", returnUrl);
        map.put("notifyUrl", notifyUrl);
        map.put("requestSource", requestSource);
        map.put("orderAmount", String.valueOf(orderAmount));
        map.put("subject", subject);
        map.put("payOrgCode", "ZFB");
        // 加密
        String infoStr = orderId + VerifyUtil.SEPARATOR
                + orderAmount + VerifyUtil.SEPARATOR
                + notifyUrl + VerifyUtil.SEPARATOR
                + tenantId;
        String infoMd5 = VerifyUtil.encodeParam(infoStr, ConfigUtil.getProperty("REQUEST_KEY"));
        map.put("infoMd5", infoMd5);
        log.info("开始前台通知:" + map);
        String htmlStr = PaymentUtil.generateAutoSubmitForm(ConfigUtil.getProperty("BY_PAY_ORG_ACTION_URL"), map);
        log.info("发起支付申请:" + htmlStr);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write(htmlStr);
    }

}

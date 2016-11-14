package com.yc.wap.system.utils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

/**
 * Created by Nozomi on 11/14/2016.
 */
public class PaymentUtil {
    private static Log log = LogFactory.getLog(PaymentUtil.class);

    private PaymentUtil() {

    }

    public static String generateAutoSubmitForm(String actionUrl, Map<String, String> paramMap) {
        StringBuilder html = new StringBuilder();
        html.append("<script language=\"javascript\">window.onload=function(){document.pay_form.submit();}</script>\n");
        html.append("<form id=\"pay_form\" name=\"pay_form\" action=\"").append(actionUrl)
                .append("\" method=\"post\">\n");

        Set<Map.Entry<String, String>> set = paramMap.entrySet();
        Iterator<Map.Entry<String, String>> iterator = set.iterator();
        while (iterator.hasNext()) {
            Map.Entry<String, String> entry = iterator.next();
            String key = entry.getKey();
            String value = entry.getValue();
            html.append("<input type=\"hidden\" name=\"" + key + "\" id=\"" + key + "\" value=\""
                    + value + "\">\n");
        }
        html.append("</form>\n");
        log.info(html);
        return html.toString();
    }
}

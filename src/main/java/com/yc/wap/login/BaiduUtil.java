package com.yc.wap.login;

import com.baidu.api.Baidu;
import com.baidu.api.BaiduApiException;
import com.baidu.api.BaiduOAuthException;
import com.baidu.api.domain.User;
import com.baidu.api.store.BaiduCookieStore;
import com.baidu.api.store.BaiduStore;
import com.yc.wap.system.utils.ConfigUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by ldy on 2017/2/15.
 */
public class BaiduUtil {

    private static final String redirectUri = ConfigUtil.getProperty("baidu.appRedirectUri");

    private static final String clientId = ConfigUtil.getProperty("baidu.appKey");

    private static final  String clientSecret = ConfigUtil.getProperty("baidu.appSecret");

    private static Log log = LogFactory.getLog(BaiduUtil.class);

    static Baidu baidu = null;

    public static void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    public static  void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BaiduStore store = new BaiduCookieStore(clientId, request, response);

        try {
            baidu = new Baidu(clientId, clientSecret, redirectUri, store, request);
            String state = baidu.getState();
            Map<String, String> params = new HashMap<String, String>();
            params.put("state", state);
            params.put("confirm_login","1");
            params.put("display","mobile");
            String authorizeUrl = baidu.getBaiduOAuth2Service().getAuthorizeUrl(params);
            response.sendRedirect(authorizeUrl);
            log.info("baiduToken:" + baidu.getAccessToken());

            log.info("authorizeurl"+authorizeUrl);
        } catch (BaiduOAuthException e) {
            log.info("BaiduApiException ", e);
        } catch (BaiduApiException e) {
            log.info("BaiduApiException ", e);
        }
    }


}

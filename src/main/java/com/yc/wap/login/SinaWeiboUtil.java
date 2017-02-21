package com.yc.wap.login;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import weibo4j.Oauth;
import weibo4j.model.WeiboException;
import weibo4j.util.BareBonesBrowserLaunch;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * Created by ldy on 2017/2/14.
 */
public class SinaWeiboUtil {
    private static Log log = LogFactory.getLog(SinaWeiboUtil.class);
    public static void doWeiboCode() throws IOException,WeiboException {

        Oauth oauth = new Oauth();
        BareBonesBrowserLaunch.openURL(oauth.authorize1("code","mobile"));
        System.out.println(oauth.authorize1("code","mobile"));
        System.out.print("Hit enter when it's done.[Enter]:");
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String code = br.readLine();
        log.info("code: " + code);
        try{
            System.out.println(oauth.getAccessTokenByCode(code));
        } catch (WeiboException e) {
            if(401 == e.getStatusCode()){
                log.info("Unable to get the access token.");
            }else{
                e.printStackTrace();
            }
        }
    }
}

package com.yc.wap.start;


import com.ai.opt.base.exception.BusinessException;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.utils.ConfigUtil;
import com.yc.wap.system.utils.HttpUtil;
import com.yc.wap.system.utils.HttpsUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.impl.client.CloseableHttpClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Created by ichen on 2016/11/2.
 */
@Controller
public class StartController extends BaseController {
//    public static String TRANSREQ = "https://translateport.yeekit.com/translate";

    private Log log = LogFactory.getLog(StartController.class);
    @RequestMapping(value = "index")
    public String start(HttpServletRequest request) {
        log.info("StartController-index invoked");

        return "start/start";
    }

    @RequestMapping(value = "translate")
    public
    @ResponseBody
    Object translate() {
        MsgBean result = new MsgBean();
        String srcl = request.getParameter("srcl");
        log.info("srcl: " + srcl);
        String tgtl = request.getParameter("tgtl");
        log.info("tgtl:" + tgtl);
        String text = request.getParameter("text");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("from", srcl);
        jsonObject.put("to", tgtl);
        jsonObject.put("app_kid", ConfigUtil.getProperty("yeekit.translate.appkid"));// 授权APP ID
        jsonObject.put("app_key", ConfigUtil.getProperty("yeekit.translate.appkey"));// 授权APP KEY
        jsonObject.put("text", text);

//        jsonObject.put("detoken", true);
//        jsonObject.put("align", true);

        log.info("jsonObject.toString`````<>" + jsonObject.toString());
        String resp = null;
        try {

//            resp = HttpsUtil.HttpsPost(ConfigUtil.getProperty("yeekit.translate.url"), jsonObject.toString(), "UTF-8");
            resp = HttpUtil.doPost(ConfigUtil.getProperty("yeekit.translate.url"), jsonObject);
        } catch (IOException e) {
            e.printStackTrace();
        }

        JSONObject json = JSONObject.fromObject(resp);
        JSONObject json2 = (JSONObject) json.getJSONArray("translation").get(0);
        JSONArray arrayList = json2.getJSONArray("translated");
        String target = "";
        for (Object obj : arrayList) {
            JSONObject j = JSONObject.fromObject(obj);
            target += j.get("text");
        }
        log.info("target=--------" + target);
        result.put("target", target);

        return result.returnMsg();

    }

    @RequestMapping(value = "/lanDetection")
    public
    @ResponseBody
    Object lanDetection() throws UnsupportedEncodingException {
        MsgBean result = new MsgBean();
        String finalLan = request.getParameter("text");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("text", URLEncoder.encode(finalLan, "UTF-8"));
        String detecUrl = ConfigUtil.getProperty("yee.detection.url");
        String resultStr = HttpUtil.doGet(detecUrl, params);
        JSONObject translated = JSONObject.fromObject(resultStr);
        //返回失败信息
        if (translated.getInt("errorCode") != 0) {
            log.error("detection text is error:" + resultStr);
            throw new BusinessException("The detection is fail.");
        }
        //获取语言
        String fintec = translated.getString("result");
        result.put("fintec", fintec);
        return result.returnMsg();
    }

    @RequestMapping(value = "/ttsSync")
    public void ttsSync(String languages, String beRead, HttpServletResponse response) throws Exception {

        String agent = request.getHeader("User-Agent").toLowerCase();
        HcicloudService hcicloudService = new HcicloudService();
        try {
            //写入文件
            byte[] audioByte = hcicloudService.text2audio(agent, languages, beRead);

            OutputStream os = response.getOutputStream();
            response.addHeader("Accept-Ranges", "bytes");
            response.addHeader("Content-Length", audioByte.length + "");
            response.addHeader("Content-Type", "audio/mpeg;charset=UTF-8");
            os.write(audioByte);
            os.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}

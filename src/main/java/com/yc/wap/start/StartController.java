package com.yc.wap.start;


import com.ai.opt.base.exception.BusinessException;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.utils.ConfigUtil;
import com.yc.wap.system.utils.HttpUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;


/**
 * Created by ichen on 2016/11/2.
 */
@Controller
public class StartController extends BaseController {
    private Log log = LogFactory.getLog(StartController.class);

    @RequestMapping(value = "index")
    public String start(HttpServletRequest request) {
        return "start/start";
    }

    @RequestMapping(value = "translate")
    @ResponseBody
    public Object translate() {
        MsgBean result = new MsgBean();
        String srcl = request.getParameter("srcl");
        String tgtl = request.getParameter("tgtl");
        String text = request.getParameter("text");
        Map<String, Object> jsonObject = new HashMap<String, Object>();
        jsonObject.put("from", srcl);
        jsonObject.put("to", tgtl);
        jsonObject.put("app_kid", ConfigUtil.getProperty("yeekit.translate.appkid"));// 授权APP ID
        jsonObject.put("app_key", ConfigUtil.getProperty("yeekit.translate.appkey"));// 授权APP KEY
        jsonObject.put("text", text);

//        jsonObject.put("detoken", true);
//        jsonObject.put("align", true);

        log.info("TranslateParams: " + jsonObject.toString());
        String resp = "";
        try {
//            resp = HttpsUtil.HttpsPost(ConfigUtil.getProperty("yeekit.translate.url"), jsonObject.toString(), "UTF-8");
            resp = HttpUtil.doPost(ConfigUtil.getProperty("yeekit.translate.url"), jsonObject);
            log.info("TranslateResult: " + resp);
            JSONObject json = JSON.parseObject(resp);
            JSONObject json2 = (JSONObject) json.getJSONArray("translation").get(0);
            JSONArray arrayList = json2.getJSONArray("translated");
            String target = "";
            for (Object obj : arrayList) {
                JSONObject j = (JSONObject) obj;
                target += j.get("text");
            }
            log.info("TranslateResultTarget: " + target);
            result.put("target", target);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("status","0");
        }

        return result.returnMsg();
    }

    @RequestMapping(value = "/lanDetection")
    @ResponseBody
    public Object lanDetection() throws UnsupportedEncodingException {
        MsgBean result = new MsgBean();
        String finalLan = request.getParameter("text");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("text", URLEncoder.encode(finalLan, "UTF-8"));
        String detecUrl = ConfigUtil.getProperty("yee.detection.url");
        String resultStr = HttpUtil.doGet(detecUrl, params);
        JSONObject translated = JSONObject.parseObject(resultStr);
        //返回失败信息
        if (translated.getInteger("errorCode") != 0) {
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

package com.yc.wap.start;


<<<<<<< HEAD
=======
import com.ai.opt.base.exception.BusinessException;
import com.alibaba.fastjson.JSON;
import com.yc.wap.home.HcicloudService;
>>>>>>> 6fceb0cebcb08645e70192e1fafec014f563b704
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;

import com.yc.wap.system.utils.HttpUtil;
import com.yc.wap.system.utils.HttpsUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
<<<<<<< HEAD
=======
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
>>>>>>> 6fceb0cebcb08645e70192e1fafec014f563b704
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
public class StartController extends BaseController{
    public static String TRANSREQ = "https://translateport.yeekit.com/translate";

    private Log log = LogFactory.getLog(StartController.class);

    @RequestMapping(value = "index")
    public  String start(HttpServletRequest request) {
        log.info("StartController-index invoked");
        List<String> pairs=new ArrayList<>();
        pairs.add("中文");
        pairs.add("英语");
        pairs.add("法语");
        pairs.add("俄语");
        pairs.add("葡萄牙语");
        request.setAttribute("languagepairs",pairs);

        return "start/start";
    }

    @RequestMapping(value="translate")
    public @ResponseBody Object translate(){
        MsgBean result=new MsgBean();
        String srcl = request.getParameter("srcl");
        log.info("srcl: " + srcl);
        String tgtl=request.getParameter("tgtl");
        log.info("tgtl:"+tgtl);
        String text=request.getParameter("text");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("srcl",srcl);
        jsonObject.put("tgtl",tgtl);
        jsonObject.put("text",text);

        jsonObject.put("detoken",true);
        jsonObject.put("align",true);

        log.info("jsonObject.toString`````<>"+jsonObject.toString());
        String resp = null;
        try {
            resp = HttpsUtil.HttpsPost(TRANSREQ, jsonObject.toString(), "UTF-8");
        } catch (NoSuchAlgorithmException | KeyManagementException | IOException e) {
            e.printStackTrace();
        }

        JSONObject json = JSONObject.fromObject(resp);
        JSONObject json2 = (JSONObject) json.getJSONArray("translation").get(0);
        JSONArray arrayList = json2.getJSONArray("translated");
        String target = "";
        for (Object obj: arrayList) {
            JSONObject j = JSONObject.fromObject(obj);
            target += j.get("text");
        }
        log.info("target=--------"+target);
        result.put("target",target);

        return result.returnMsg();

    }
    @RequestMapping(value="/lanDetection")
    public @ResponseBody Object lanDetection() throws UnsupportedEncodingException {
        MsgBean result=new MsgBean();
        String finalLan=request.getParameter("text");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("text", URLEncoder.encode(finalLan,"UTF-8"));
        String detecUrl="http://translateport.yeekit.com:9006/detection";
        String resultStr = HttpUtil.doGet(detecUrl,params);
//        ?text="+finalLan;
        log.info(resultStr);
        JSONObject translated = JSONObject.fromObject(resultStr);
        //返回失败信息
        if (translated.getInt("errorCode") != 0) {
            log.error("detection text is error:"+resultStr);
            throw new BusinessException("The detection is fail.");
        }
        //获取语言
        String fintec= translated.getString("result");
        result.put("fintec",fintec);
        return result.returnMsg();
    }

    @RequestMapping(value="/ttsSync")
    public void ttsSync(String languages ,String beRead,HttpServletResponse response) throws Exception{

        String agent = request.getHeader("User-Agent").toLowerCase();
        HcicloudService hcicloudService = new HcicloudService();
        try {
            //写入文件
            byte[] audioByte = hcicloudService.text2audio(agent,languages,beRead);

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

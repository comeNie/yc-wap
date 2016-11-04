package com.yc.wap.start;

import com.alibaba.fastjson.JSONObject;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.utils.HttpsUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;


/**
 * Created by ichen on 2016/11/2.
 */
@Controller
public class StartController extends BaseController{
    public static String FILE = "assets/TTS.mp3";
    public static String FILE1 = "assets/TTS1.txt";
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
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("srcl",srcl);
        jsonObject.put("tgtl",tgtl);
        jsonObject.put("text",text);

//        Set<String> keys=request.getParameterMap().keySet();
//        for (String key:keys){
//            jsonObject.put(key,request.getParameter(key)==null?"":request.getParameter(key));
//        }
        jsonObject.put("detoken",true);
        jsonObject.put("align",true);

        log.info("jsonObject.toString`````<>"+jsonObject.toString());
        String resp = null;
        try {
            resp = HttpsUtil.HttpsPost(TRANSREQ, jsonObject.toString(), "UTF-8");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (KeyManagementException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        log.info("resp-----"+resp);

        return result.returnMsg();
    }

}

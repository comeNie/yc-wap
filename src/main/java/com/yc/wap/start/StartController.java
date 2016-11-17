package com.yc.wap.start;

import com.alibaba.fastjson.JSONObject;
import com.yc.wap.home.HcicloudService;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.utils.FileUtil;
import com.yc.wap.system.utils.HttpUtil;
import com.yc.wap.system.utils.HttpsUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;


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
        JSONObject jsonObject=new JSONObject();
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

        JSONObject json = (JSONObject) JSONObject.parse(resp);
        JSONObject json2 = (JSONObject) json.getJSONArray("translation").get(0);
        JSONObject fin = (JSONObject) json2.getJSONArray("translated").get(0);
        log.info("fin.get--------"+fin.get("text"));
        String target=fin.getString("text");
        log.info("target=--------"+target);
        log.info("resp-----"+resp);
        result.put("target",target);

        return result.returnMsg();

    }
    @RequestMapping(value="/lanDetection")
    public @ResponseBody Object lanDetection(){
        MsgBean result=new MsgBean();
        String finalLan=request.getParameter("text");
        String detecUrl="http://translateport.yeekit.com:9006/detection?text="+finalLan;

        String respon=HttpUtil.httpGet(detecUrl);
        JSONObject json = (JSONObject) JSONObject.parse(respon);

        String fintec=json.getString("result");
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

//        MsgBean result=new MsgBean();
//        //根据目标语言语种选择调用灵云能力
//        String config="";
//        String audioformat=",audioformat=mp3_16";
//        if (languages.equals("zh")){
//            config+="capkey=tts.cloud.wangjing";
//        }else if (languages.equals("en")) {
//            config+="capkey=tts.cloud.serena";
//        }else if (languages.equals("fr")) {
//            // TODO: 2016/11/4  增加俄语 法语 葡萄牙语的capkey
//            config+="capkey=tts.cloud.thomas";
//        }else if (languages.equals("ru")){
//            config+="capkey=tts.cloud.narae";
//        }else if (languages.equals("pt")){
//            config+="capkey=tts.cloud.vera";
//        }
//
//        //得到带xml的语音块
//        byte[] lanresp = HttpUtil.TTShttpReq(beRead,config+audioformat);
//        //得到需要去掉的长度
//        String lanresponse= new String(lanresp);
//        String[] splits = lanresponse.split("</ResponseInfo>");
//        String xml = splits[0] + "</ResponseInfo>";
//        int offset = xml.getBytes().length;
//        log.info("offset----------"+offset);
//        //得到完整的语音块
//        byte[] audioBlock = FileUtil.ByteinfoFile(lanresp, offset);
//        log.info("audioBlock-------"+audioBlock);
//        result.put("audioBlock",audioBlock);
//        return result.returnMsg();
    }

}

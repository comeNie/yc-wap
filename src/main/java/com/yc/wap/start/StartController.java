package com.yc.wap.start;

import com.alibaba.fastjson.JSONObject;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by ichen on 2016/11/2.
 */
@Controller
public class StartController extends BaseController{
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


//        JSONObject jsonObject=new JSONObject();
//        Set<String> keys=request.getParameterMap().keySet();
//        for (String key:keys){
//            jsonObject.put(key,request.getParameter(key)==null?"":request.getParameter(key));
//        }
//        jsonObject.put("detoken",true);
//        jsonObject.put("align",true);
//
//        log.info("jsonObject.toString`````<>"+jsonObject.toString());

        String translate = "asdadsada";
        result.put("translate", translate);
        return result.returnMsg();
    }

}

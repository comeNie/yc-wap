package com.yc.wap.start;

import com.yc.wap.system.base.BaseController;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ichen on 2016/11/2.
 */
@Controller
public class StartController extends BaseController{
    private static Logger logger = Logger.getLogger(StartController.class);

    @RequestMapping(value = "index")
    public  String start(HttpServletRequest request) {
        logger.info("StartController-index invoked");
        System.out.println("StartController-index invoked");
        List<String> pairs=new ArrayList<>();
        pairs.add("中文");
        pairs.add("英语");
        pairs.add("法语");
        pairs.add("俄语");
        pairs.add("葡萄牙语");
        request.setAttribute("languagepairs",pairs);



        return "start/start";
    }

}

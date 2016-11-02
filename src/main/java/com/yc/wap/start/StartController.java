package com.yc.wap.start;

import com.yc.wap.system.base.BaseController;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by ichen on 2016/11/2.
 */
@Controller
public class StartController extends BaseController{
    private static Logger logger = Logger.getLogger(StartController.class);

    @RequestMapping(value = "index")
    public String start() {
        logger.info("StartController-index invoked");
        System.out.println("StartController-index invoked");
        return "start/start";
    }
}

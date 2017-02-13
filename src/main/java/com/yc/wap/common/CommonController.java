package com.yc.wap.common;

import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by Nozomi on 11/12/2016.
 */
@Controller
@RequestMapping(value = "/")
public class CommonController extends BaseController {
    private Log log = LogFactory.getLog(CommonController.class);

    @RequestMapping(value = "aboutus")
    public String aboutus() {
        return "common/aboutus";
    }

    @RequestMapping(value = "tident")
    public String tident() {
        return "common/tident";
    }

    @RequestMapping(value = "agreement")
    public String agreement() {
        return "common/agreement";
    }

    @RequestMapping(value = "feedback")
    public String feedback() {
        return "common/feedback";
    }


    @RequestMapping(value = "feedbacksuccess")
    public String feedbacksuccess() {
        return "common/feedbacksuccess";
    }

    @RequestMapping(value = "error")
    public String error() {
        log.info("------404------");
        return "common/404";
    }

    @RequestMapping(value = "feedback/submitfeedback")
    public @ResponseBody Object submitfeedback(){
        MsgBean result = new MsgBean();
        log.info("------submitfeedback------");
        String feedText =  request.getParameter("text");
        String phone =  request.getParameter("phone");
        String type =  request.getParameter("type");
        log.info("feedText:"+feedText + "----phone:" + phone + "----type:" + type);
        return result.returnMsg();
    }
}

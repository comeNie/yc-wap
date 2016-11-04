package com.yc.wap.written;

import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by Nozomi on 11/3/2016.
 */
@Controller
@RequestMapping(value = "written")
public class WrittenController extends BaseController{
    private Log log = LogFactory.getLog(WrittenController.class);

    @RequestMapping(value = "")
    public String content() {
        log.info("WrittenController-content invoked");
        return "written/content";
    }

    @RequestMapping(value = "onsubmit")
    @ResponseBody
    public Object onsubmit() {
        log.info(request.getParameter("test"));
        MsgBean result = new MsgBean();
        result.put("test", "a");
        return result.returnMsg();
    }

    @RequestMapping(value = "contact")
    public String contact() {
        log.info("WrittenController-contact invoked");
        return "written/contact";
    }

    @RequestMapping(value = "confirm")
    public String confirm() {
        log.info("WrittenController-confirm invoked");
        return "written/confirm";
    }

    @RequestMapping(value = "newcontact")
    public String newcontact() {
        log.info("WrittenController-newcontact invoked");
        return "written/newcontact";
    }
}

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
        return "written/content";
    }

    @RequestMapping(value = "oncontentsubmit")
    @ResponseBody
    public Object oncontentsubmit() {
        MsgBean result = new MsgBean();
        result.put("result", true);
        return result.returnMsg();
    }

    @RequestMapping(value = "contact")
    public String contact() {
        return "written/contact";
    }

    @RequestMapping(value = "confirm")
    public String confirm() {
        return "written/confirm";
    }

    @RequestMapping(value = "onconfirmsubmit")
    @ResponseBody
    public Object onconfirmsubmit() {
        MsgBean result = new MsgBean();
        result.put("result", true);
        return result.returnMsg();
    }

    @RequestMapping(value = "newcontact")
    public String newcontact() {
        return "written/newcontact";
    }

    @RequestMapping(value = "onnewcontactsubmit")
    @ResponseBody
    public Object onnewcontactsubmit() {
        MsgBean result = new MsgBean();
        result.put("result", true);
        return result.returnMsg();
    }

    @RequestMapping(value = "payment")
    public String paymen() {
        return "written/payment";
    }
}

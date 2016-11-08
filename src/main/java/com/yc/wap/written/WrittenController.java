package com.yc.wap.written;

import com.yc.wap.service.impl.SearchServiceImpl;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.constants.Constants;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Locale;

/**
 * Created by Nozomi on 11/3/2016.
 */
@Controller
@RequestMapping(value = "written")
public class WrittenController extends BaseController{
    private Log log = LogFactory.getLog(WrittenController.class);

    @Resource
    private SearchServiceImpl searchService;

    @RequestMapping(value = "")
    public String content() {
        log.info("WrittenControllerInvoked");
        Locale local = rb.getDefaultLocale();
        String country = local.getCountry();
        List DualList = searchService.GetDualList(country, Constants.OrderType.DOC);
        return "written/content";
    }

    @RequestMapping(value = "onContentSubmit")
    @ResponseBody
    public Object onContentSubmit() {
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

    @RequestMapping(value = "onConfirmSubmit")
    @ResponseBody
    public Object onConfirmSubmit() {
        MsgBean result = new MsgBean();
        result.put("result", true);
        return result.returnMsg();
    }

    @RequestMapping(value = "newContact")
    public String newContact() {
        return "written/newcontact";
    }

    @RequestMapping(value = "onNewContactSubmit")
    @ResponseBody
    public Object onNewContactSubmit() {
        MsgBean result = new MsgBean();
        result.put("result", true);
        return result.returnMsg();
    }

    @RequestMapping(value = "payment")
    public String payment() {
        return "written/payment";
    }
}

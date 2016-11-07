package com.yc.wap.written;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;
import com.ai.yc.ucenter.api.members.param.UcMembersResponse;
import com.ai.yc.ucenter.api.members.param.editmobile.UcMembersEditMobileRequest;
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

    private IUcMembersSV iUcMembersSV = DubboConsumerFactory.getService(IUcMembersSV.class);

    private Log log = LogFactory.getLog(WrittenController.class);

    @RequestMapping(value = "")
    public String content() {
        return "written/content";
    }

    @RequestMapping(value = "onContentSubmit")
    @ResponseBody
    public Object onContentSubmit() {
        MsgBean result = new MsgBean();
        String test = request.getParameter("test");
        log.info("test" + test);
        result.put("result", true);
        result.put("haha", 123456);
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

package com.yc.wap.login;

import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by ldy on 2016/11/8.
 */

@Controller
@RequestMapping(value = "login")
public class LoginController extends BaseController {
    private Log log = LogFactory.getLog(LoginController.class);

    @RequestMapping(value = "login")
    public String login() {
        MsgBean result = new MsgBean();
        return "login/login";
    }
    @RequestMapping(value = "register")
    public String register() {
        MsgBean result = new MsgBean();
        return "login/register";
    }
    @RequestMapping(value = "registersuccess")
    public String registersuccess() {
        MsgBean result = new MsgBean();
        return "login/registersuccess";
    }
    @RequestMapping(value = "findpsd")
    public String findpsd() {
        MsgBean result = new MsgBean();
        return "login/findpsd";
    }
    @RequestMapping(value = "findfail")
    public String findFail() {
        MsgBean result = new MsgBean();
        return "login/findfail";
    }

}

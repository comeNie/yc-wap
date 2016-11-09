package com.yc.wap.login;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;
import com.ai.yc.ucenter.api.members.param.login.UcMembersLoginRequest;
import com.ai.yc.ucenter.api.members.param.login.UcMembersLoginResponse;
import com.ai.yc.ucenter.api.members.param.register.UcMembersRegisterRequest;
import com.ai.yc.ucenter.api.members.param.register.UcMembersRegisterResponse;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.constants.Constants;
import com.yc.wap.system.utils.RegexUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import scala.util.parsing.combinator.testing.Str;

import java.util.Date;

/**
 * Created by ldy on 2016/11/8.
 */

@Controller
@RequestMapping(value = "login")
public class LoginController extends BaseController {
    private Log log = LogFactory.getLog(LoginController.class);
    private IUcMembersSV iUcMembersSV = DubboConsumerFactory.getService(IUcMembersSV.class);
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

    /**
     * 登录验证
     */
    @RequestMapping(value = "checklogin")
    public @ResponseBody Object checklogin() {
        MsgBean result = new MsgBean();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UcMembersLoginRequest res = new UcMembersLoginRequest();
        res.setTenantId(Constants.TenantID);
        res.setPassword(password);
        String loginmode;
        boolean isEmail = RegexUtils.checkIsEmail(username);
        boolean isPhone = RegexUtils.checkIsPhone(username);
        if (isEmail) {
            loginmode = "1";
        }
        else if (isPhone) {
            loginmode = "2";
        }else {
            loginmode = "4";
        }
        log.info(loginmode);
        res.setLoginmode(loginmode);
        try {
            UcMembersLoginResponse resp = iUcMembersSV.ucLoginMember(res);
            log.info(resp.getResponseHeader().getIsSuccess());
            log.info(resp.getEmail());
        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.setFailure(e.getMessage());
        }

        return result.returnMsg();
    }
    /**
     * 注册
     */
    @RequestMapping(value = "checkregister")
    public @ResponseBody Object checkregister() {
        MsgBean result = new MsgBean();

        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String code = request.getParameter("code");
        Date date = new Date();
        String createTime = date.toString();
        UcMembersRegisterRequest res = new UcMembersRegisterRequest();
        res.setTenantId(Constants.TenantID);
        res.setPassword(password);
        res.setMobilephone(phone);
        res.setLoginmode("0");
        res.setLoginway("3");
        res.setCreatetime(createTime);
        res.setOperationcode(code);
        try {
            UcMembersRegisterResponse resp = iUcMembersSV.ucRegisterMember(res);
            log.info(resp.getMessage().isSuccess());
        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.setFailure(e.getMessage());
        }
        return result.returnMsg();
    }
}

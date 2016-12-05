package com.yc.wap.login;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.RandomUtil;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;
import com.ai.yc.ucenter.api.members.param.UcMembersVo;
import com.ai.yc.ucenter.api.members.param.base.ResponseCode;
import com.ai.yc.ucenter.api.members.param.login.UcMembersLoginRequest;
import com.ai.yc.ucenter.api.members.param.login.UcMembersLoginResponse;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.InsertYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCInsertUserResponse;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.constants.Constants;
import com.yc.wap.system.utils.MD5Util;
import com.yc.wap.system.utils.RegexUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.Enumeration;
import java.util.Map;

/**
 * Created by ldy on 2016/11/8.
 */

@Controller
@RequestMapping(value = "login")
public class LoginController extends BaseController {
    private Log log = LogFactory.getLog(LoginController.class);
    private IUcMembersSV iUcMembersSV = DubboConsumerFactory.getService(IUcMembersSV.class);
    private IYCUserServiceSV iycUserServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
    @RequestMapping(value = "login")
    public String login() {
        MsgBean result = new MsgBean();
        String to = request.getParameter("to");
        request.setAttribute("to",to);
        return "login/login";
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
    public
    @ResponseBody
    Object checklogin() {
        MsgBean result = new MsgBean();
        String checkCode = request.getParameter("code");//图文验证码
        String sessionCode = (String) session.getAttribute("certCode");
        if (!checkCode.toUpperCase().equals(sessionCode.toUpperCase())){
            result.put("status","2");
            result.put("msg","验证码错误");
            return result.returnMsg();
        }
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UcMembersLoginRequest res = new UcMembersLoginRequest();
        res.setTenantId(Constants.TENANTID);
        password = MD5Util.md5(password);
        res.setPassword(password);
        res.setUsername(username);
        String loginmode;
        boolean isEmail = RegexUtils.checkIsEmail(username);
        boolean isPhone = RegexUtils.checkIsPhone(username);
        if (isEmail) {
            loginmode = Constants.LoginModel.MailModel;
        } else if (isPhone) {
            loginmode = Constants.LoginModel.PhonePsdModel;
        } else {
            loginmode = Constants.LoginModel.UsernamePsdModel;
        }
        log.info(loginmode);
        res.setLoginmode(loginmode);
        try {
            UcMembersLoginResponse resp = iUcMembersSV.ucLoginMember(res);

            ResponseCode code = resp.getCode();  //通过code进行捕获
            /*code:失败，未找到该用户信息-1 code:成功1    */
            log.info("--------code:"+ code.getCodeMessage() + code.getCodeNumber());
            if (code.getCodeNumber() == 1){
                Map m = resp.getDate();

                UcMembersVo vo = new UcMembersVo(m);
                session.setAttribute("isLogin","1");    //1登录  0未登录
                session.setAttribute("UID",m.get("uid")+"");
                session.setAttribute("email",m.get("email"));
                session.setAttribute("username",m.get("username"));
                log.info("passHav:"+ m.get("passHav"));
                session.setAttribute("password",m.get("passHav"));
                session.setAttribute("mobilePhone",m.get("mobilephone"));
                log.info(vo);
            }else {
                result.put("status","0");
                if (isEmail){
                    result.put("msg","邮箱或密码错误");
                }else if (isPhone){
                    result.put("msg","手机号或密码错误");
                }else {
                    result.put("msg","用户名或密码错误");
                }
            }
        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());

            result.put("status","0");
            if (isEmail){
                result.put("msg","邮箱或密码错误");
            }else if (isPhone){
                result.put("msg","手机号或密码错误");
            }else {
                result.put("msg","用户名或密码错误");
            }
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
        String password = request.getParameter("newpw");
        String personUid = request.getParameter("uid");
        String code = request.getParameter("code");
        password = MD5Util.md5(password);
        Date date = new Date();
        String createTime = date.toString();

        InsertYCUserRequest res = new InsertYCUserRequest();
//        res.setTenantId(Constants.TenantID);
        res.setPassword(password);
        res.setRegip("0");
//        domainname
        res.setMobilePhone(phone);
        res.setOperationcode(code);
        res.setLoginway(Constants.RegisterModel.PhonePsdModel);
        res.setUserId(personUid);
        res.setOperationcode(code);
//        res.setUserName("yiyun" + RandomUtil.randomNum(10));
//        res.setNickname("译粉_" + RandomUtil.randomNum(8));
        try {
            YCInsertUserResponse resp = iycUserServiceSV.insertYCUser(res);
            String  message = resp.getResponseHeader().getResultMessage();  //通过code进行捕获
            log.info("--------message:"+ message);
            if (!resp.getResponseHeader().getResultCode().equals("000000")){
                result.put("status","0");
                result.put("msg",resp.getResponseHeader().getResultMessage());

            }
            /*code:失败，未找到该用户信息-1 code:成功1    */
        } catch (Exception e) {
            result.put("status","0");
            result.put("msg","注册失败");
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
        }
        return result.returnMsg();
    }

    @RequestMapping(value = "Logout")
    @ResponseBody
    public Object Logout(HttpServletResponse response) {
        log.info("-----Logout-----");
        MsgBean result = new MsgBean();
        Enumeration em = request.getSession().getAttributeNames();
        while(em.hasMoreElements()){
            request.getSession().removeAttribute(em.nextElement().toString());
        }
        session.invalidate();
        return result.returnMsg();
    }
}

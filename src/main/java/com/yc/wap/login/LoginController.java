package com.yc.wap.login;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;

import com.ai.yc.ucenter.api.members.param.UcMembersVo;
import com.ai.yc.ucenter.api.members.param.base.ResponseCode;
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
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.Map;

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

        password = MD5Utils.md5(password);
        res.setPassword(password);
        res.setUsername(username);
        String loginmode;
        boolean isEmail = RegexUtils.checkIsEmail(username);
        boolean isPhone = RegexUtils.checkIsPhone(username);
        if (isEmail) {
            loginmode = Constants.LoginModel.MailModel;
        }
        else if (isPhone) {
            loginmode = Constants.LoginModel.PhonePsdModel;
        }else {
            loginmode = Constants.LoginModel.UsernamePsdModel;
        }
        log.info(loginmode);
        res.setLoginmode(loginmode);

        UcMembersLoginResponse resp = iUcMembersSV.ucLoginMember(res);

        ResponseCode code = resp.getCode();  //通过code进行捕获
        /*code:失败，未找到该用户信息-1 code:成功1    */
        log.info("--------code:"+ code.getCodeMessage() + code.getCodeNumber());
//        if (code.getCodeNumber() == -1 ){
//            result.put("status","0");
//            if (isEmail){
//                result.put("msg","邮箱未注册");
//            }else if (isPhone){
//                result.put("msg","手机号未注册");
//            }else {
//                result.put("msg","用户名不存在");
//            }
//            return result.returnMsg();
//        }
//        if (code.getCodeNumber() == 0 ){
//            result.put("status","0");
//            if (isEmail){
//                result.put("msg","邮箱");
//            }else if (isPhone){
//                result.put("msg","手机号未注册");
//            }else {
//                result.put("msg","用户名不存在");
//            }
//            return result.returnMsg();
//        }
        if (code.getCodeNumber() == 1){
            session.setAttribute("isLogin","1");    //1登录  0未登录
            Map m = resp.getDate();
            UcMembersVo vo = new UcMembersVo(m);
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
        return result.returnMsg();
    }

    /**
     * MD5加密
     */
    public static class MD5Utils {
        /**
         * 使用md5的算法进行加密
         */
        public static String md5(String plainText) {
            byte[] secretBytes = null;
            try {
                secretBytes = MessageDigest.getInstance("md5").digest(
                        plainText.getBytes());
            } catch (NoSuchAlgorithmException e) {
                throw new RuntimeException("没有md5这个算法！");
            }
            String md5code = new BigInteger(1, secretBytes).toString(16);
            for (int i = 0; i < 32 - md5code.length(); i++) {
                md5code = "0" + md5code;
            }
            return md5code;
        }



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
        password = MD5Utils.md5(password);
        Date date = new Date();
        String createTime = date.toString();
        UcMembersRegisterRequest res = new UcMembersRegisterRequest();
        res.setTenantId(Constants.TenantID);
        res.setPassword(password);
        res.setRegip("0");
//        domainname
        res.setMobilephone(phone);
        res.setLoginmode(Constants.AllowLoginModel.PhonePsdModel);
        res.setLoginway(Constants.RegisterModel.PhonePsdModel);
        res.setCreatetime(createTime);
        res.setOperationcode(code);
        res.setUsersource(Constants.UserSource.GTCOM); //用户来源
        try {
            UcMembersRegisterResponse resp = iUcMembersSV.ucRegisterMember(res);
            Map m = resp.getDate();
            UcMembersVo vo = new UcMembersVo(m);
            log.info(m);
            log.info("))))))))))))" + vo.getUsername());
            ResponseCode c = resp.getCode();  //通过code进行捕获
            /*code:失败，未找到该用户信息-1 code:成功1    */
            log.info("--------code:"+ c.getCodeMessage() + c.getCodeNumber());
        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.setFailure(e.getMessage());
        }
        return result.returnMsg();
    }
}

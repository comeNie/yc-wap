package com.yc.wap.safe;

import com.ai.opt.sdk.components.ccs.CCSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.paas.ipaas.ccs.IConfigClient;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.paas.ipaas.util.StringUtil;
import com.ai.slp.balance.api.accountmaintain.interfaces.IAccountMaintainSV;
import com.ai.yc.common.api.country.interfaces.IGnCountrySV;
import com.ai.yc.common.api.country.param.CountryRequest;
import com.ai.yc.common.api.country.param.CountryResponse;
import com.ai.yc.common.api.country.param.CountryVo;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersOperationSV;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;
import com.ai.yc.ucenter.api.members.param.UcMembersResponse;
import com.ai.yc.ucenter.api.members.param.UcMembersVo;
import com.ai.yc.ucenter.api.members.param.base.ResponseCode;
import com.ai.yc.ucenter.api.members.param.checke.UcMembersCheckEmailRequest;
import com.ai.yc.ucenter.api.members.param.checke.UcMembersCheckeMobileRequest;
import com.ai.yc.ucenter.api.members.param.editemail.UcMembersEditEmailRequest;
import com.ai.yc.ucenter.api.members.param.editmobile.UcMembersEditMobileRequest;
import com.ai.yc.ucenter.api.members.param.editpass.UcMembersEditPassRequest;
import com.ai.yc.ucenter.api.members.param.get.UcMembersGetRequest;
import com.ai.yc.ucenter.api.members.param.get.UcMembersGetResponse;
import com.ai.yc.ucenter.api.members.param.opera.UcMembersActiveRequest;
import com.ai.yc.ucenter.api.members.param.opera.UcMembersGetOperationcodeRequest;
import com.ai.yc.ucenter.api.members.param.opera.UcMembersGetOperationcodeResponse;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.constants.Constants;

import com.yc.wap.system.utils.AiPassUitl;
import com.yc.wap.system.utils.ImageCodeUtil;
import com.yc.wap.system.utils.MD5Util;
import com.yc.wap.system.utils.RegexUtils;

import com.yc.wap.system.utils.send.SendEmailRequest;
import com.yc.wap.system.utils.send.SmsSenderUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.MessageFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/**
 * Created by ldy on 2016/11/4.
 */
@Controller
@RequestMapping(value = "safe")
public class SafeController extends BaseController {
    private Log log = LogFactory.getLog(SafeController.class);
    private IUcMembersSV iUcMembersSV = DubboConsumerFactory.getService(IUcMembersSV.class);
    private IGnCountrySV iGnCountrySV = DubboConsumerFactory.getService(IGnCountrySV.class);
    private IUcMembersOperationSV iUcMembersOperationSV = DubboConsumerFactory.getService(IUcMembersOperationSV.class);
    private IAccountMaintainSV iAccountMaintainSV = DubboConsumerFactory.getService(IAccountMaintainSV.class);
    /**
     * 安全设置界面
     * @return
     */
    @RequestMapping(value = "safe")
    public String safe() {
        MsgBean result = new MsgBean();
        String isLogin = (String) session.getAttribute("isLogin");
        if (isLogin == null || isLogin.equals("") || isLogin.equals("0")) {
            log.info("UserNotLogin");
            request.setAttribute("to", "login");
            return "login/login";
        }
        String uidStr = (String) session.getAttribute("UID");
        String email1 = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        String mobilePhone = (String) session.getAttribute("mobilePhone");
        request.setAttribute("UID",uidStr);
        request.setAttribute("email",email1);
        request.setAttribute("password",password);
        request.setAttribute("mobilePhone",mobilePhone);
        log.info("safe-safe invoked");
        log.info("----------密码"+password);
        return "safe/safe";
    }


    /**
     * 修改密码界面
     * @return
     */
    @RequestMapping(value = "changepsd")
    public String changepsd() {
        String isLogin = (String) session.getAttribute("isLogin");
        if (isLogin == null || isLogin.equals("") || isLogin.equals("0")) {
            log.info("UserNotLogin");
            request.setAttribute("to", "login");
            return "login/login";
        }
        log.info("safe-changepsd invoked");

        String uid = request.getParameter("uid");
        request.setAttribute("uid",uid);
        return "safe/changepsd";
    }

    /**
     * 修改手机号界面
     * @return
     */
    @RequestMapping(value = "changephone")
    public String changephone() {
        String isLogin = (String) session.getAttribute("isLogin");
        if (isLogin == null || isLogin.equals("") || isLogin.equals("0")) {
            log.info("UserNotLogin");
            request.setAttribute("to", "login");
            return "login/login";
        }
        log.info("safe-changephone invoked");
        String uidStr = (String) session.getAttribute("UID");
        request.setAttribute("UID",uidStr);
        String phoneTitle = request.getParameter("phoneTitle");
        request.setAttribute("phoneTitle",phoneTitle);
        return "safe/changephone";
    }

    /**
     * 修改邮箱界面
     * @return
     */
    @RequestMapping(value = "changemail")
    public String changemail() {
        String isLogin = (String) session.getAttribute("isLogin");
        if (isLogin == null || isLogin.equals("") || isLogin.equals("0")) {
            log.info("UserNotLogin");
            request.setAttribute("to", "login");
            return "login/login";
        }
        log.info("safe-changemail invoked");
        String uidStr = (String) session.getAttribute("UID");
        request.setAttribute("UID",uidStr);

        String mailTitle = request.getParameter("mailTitle");
        request.setAttribute("mailTitle",mailTitle);
        return "safe/changemail";
    }

    /**
     * 修改成功界面
     * @return
     */
    @RequestMapping(value = "safesuccess")
    public String safesuccess() {
        String isLogin = (String) session.getAttribute("isLogin");
        if (isLogin == null || isLogin.equals("") || isLogin.equals("0")) {
            log.info("UserNotLogin");
            request.setAttribute("to", "login");
            return "login/login";
        }
        MsgBean result = new MsgBean();
        log.info("safe-safesuccess invoked");
        String nameStr = request.getParameter("name");
        request.setAttribute("name",nameStr);
        return "safe/safesuccess";
    }

    /**
     * 设置密码界面
     * @return
     */
    @RequestMapping(value = "installpsd")
    public String installpsd() {
        String isLogin = (String) session.getAttribute("isLogin");
        if (isLogin == null || isLogin.equals("") || isLogin.equals("0")) {
            log.info("UserNotLogin");
            request.setAttribute("to", "login");
            return "login/login";
        }
        log.info("safe-installpsd invoked");
        return "safe/installpsd";
    }

    /**
     * 验证手机号界面
     * @return
     */
    @RequestMapping(value = "checkphone")
    public String checkphone() {
        String isLogin = (String) session.getAttribute("isLogin");
        if (isLogin == null || isLogin.equals("") || isLogin.equals("0")) {
            log.info("UserNotLogin");
            request.setAttribute("to", "login");
            return "login/login";
        }
        log.info("safe-checkphone invoked");
        String uidStr = (String) session.getAttribute("UID");
        request.setAttribute("UID",uidStr);

        String jump = request.getParameter("jump");
        request.setAttribute("jump",jump);
        String phone = request.getParameter("phone");
        request.setAttribute("phone",phone);

        return "safe/checkphone";
    }

    /**
     * 获取用户信息接口
     */
    @RequestMapping(value = "userinfo")
    public @ResponseBody Object userinfo() {
        MsgBean result = new MsgBean();
        String checkCode = request.getParameter("code");//图文验证码
        if (checkCode != null){

            String sessionCode = (String) session.getAttribute("certCode");
            if (!checkCode.toUpperCase().equals(sessionCode.toUpperCase())){
                result.put("status","2");
                result.put("msg",rb.getMessage("loginCtrl.checkCode"));
                return result.returnMsg();
            }
        }

        String username = request.getParameter("username");
        String uid = request.getParameter("uid");

        String mode;
        boolean isEmail = RegexUtils.checkIsEmail(username);
        boolean isPhone = RegexUtils.checkIsPhone(username);
        if (isEmail) {
            mode = Constants.GetUserMode.Mail; //2
        }
        else if (isPhone) {
            mode = Constants.GetUserMode.Phone; //3
        }else {
            mode = Constants.GetUserMode.UserName; //4
        }
        if (uid != null){
            username = uid;
            mode = Constants.GetUserMode.UserID;
        }
        log.info(mode);

        UcMembersGetRequest res = new UcMembersGetRequest();
        res.setTenantId(Constants.TENANTID);
        res.setGetmode(mode);
        res.setUsername(username);
        try {

            UcMembersGetResponse resp = iUcMembersSV.ucGetMember(res);
            ResponseCode code = resp.getCode();  //通过code进行捕获
            log.info("--------code:"+ code.getCodeMessage() + code.getCodeNumber());

            if (code.getCodeNumber() == 1){
                Map m = resp.getDate();
                UcMembersVo vo = new UcMembersVo(m);
                log.info(m);
                result.put("userPhone",vo.getMobilephone());
                result.put("uids",m.get("uid")+"");
                result.put("countryCode",m.get("domainName"));
                log.info("uid:"+vo.getUid());
            }else {
                result.put("status","0");
                result.put("msg",rb.getMessage("safeCtrl.userisExit"));
            }
            /*code:失败，未找到该用户信息-1 code:成功1    */

        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.setFailure(e.getMessage());
            result.put("status","0");
            result.put("msg",rb.getMessage("safeCtrl.getUserInfoError"));
            return result;
        }


        return  result.returnMsg();
    }

    /**
     * 获取国家区号接口
     */
    @RequestMapping(value = "countryid")
    public @ResponseBody Object countryid() {
        MsgBean result = new MsgBean();
        CountryRequest res = new CountryRequest();
        res.setTenantId(Constants.TENANTID);
        try {
            CountryResponse resp = iGnCountrySV.queryCountry(res);
            List<CountryVo> lists = resp.getResult();
            if (lists == null){
                result.put("status","0");
            }else {
                result.put("list",lists);
            }
        }catch (Exception e) {
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.put("status","0");
            result.setFailure(e.getMessage());
        }

        return  result.returnMsg();
    }

    /**
     * 修改用户密码接口
     */
    @RequestMapping(value = "editpssword")
    public @ResponseBody Object editpssword() {
        MsgBean result = new MsgBean();
        String check_code = request.getParameter("code");  //旧密码或验证码
        String newpw = request.getParameter("newpw");
        newpw = MD5Util.md5(newpw);
        String uid = request.getParameter("uid");
        Integer u = Integer.parseInt(uid);
        String checke_mode = request.getParameter("mode");  // 1：旧密码 2：验证码（密码操作验证码）
        if (checke_mode.equals(Constants.PsdOpreation.OldPsd)){
            check_code = MD5Util.md5(check_code);
        }
        UcMembersEditPassRequest res = new UcMembersEditPassRequest();
        res.setTenantId(Constants.TENANTID);
        res.setChecke_code(check_code);
        res.setChecke_mode(checke_mode);
        res.setNewpw(newpw);
        res.setUid(u);
        try {
            UcMembersResponse resp = iUcMembersSV.ucEditPassword(res);
            ResponseCode responseCode = resp.getCode();
            log.info("--------code:"+ responseCode.getCodeMessage() + responseCode.getCodeNumber());
            if (responseCode.getCodeNumber() == 1){
                Map m = resp.getDate();
                log.info(m);
                UcMembersVo vo = new UcMembersVo(m);
                log.info(vo);
                session.setAttribute("password","true");
            }else{
                result.put("status","0");
                result.put("msg",responseCode.getCodeMessage());
            }
        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.put("status","0");
            result.put("msg",rb.getMessage("safeCtrl.changeFail"));
        }
        return  result.returnMsg();
    }

    /**
     * 修改/绑定手机接口
     */
    @RequestMapping(value = "editphone")
    public @ResponseBody Object editphone() {
        MsgBean result = new MsgBean();
        String code = request.getParameter("code");
        String phone = request.getParameter("phone");
        String uid = request.getParameter("uid");
        String domainvalue = request.getParameter("domainvalue");
        UcMembersEditMobileRequest res = new UcMembersEditMobileRequest();
        res.setTenantId(Constants.TENANTID);
        res.setOperationcode(code);
        res.setMobilephone(phone);
        res.setDomainname(domainvalue);
        if (uid != null){

            Integer u = Integer.parseInt(uid);
            res.setUid(u);
        }
        try {
            UcMembersResponse resp = iUcMembersSV.ucEditMobilephone(res);
            ResponseCode responseCode = resp.getCode();
            log.info("--------code:"+ responseCode.getCodeMessage() + responseCode.getCodeNumber());
            if (responseCode.getCodeNumber() == 1){
                Map m = resp.getDate();
                log.info(m);
                UcMembersVo vo = new UcMembersVo(m);
                log.info(vo);
                session.setAttribute("mobilePhone",phone);
                session.setAttribute("domainname",domainvalue);
            }else{
                result.put("status","0");
                result.put("msg",responseCode.getCodeMessage());
            }
        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.put("status","0");
            result.put("msg",rb.getMessage("safeCtrl.bindPhoneFail"));
        }

        return  result.returnMsg();
    }

    /**
     * 校验邮箱或手机
     */
    @RequestMapping("/checkPhoneOrEmail")
    public @ResponseBody Object checkPhoneOrEmail() {
        MsgBean result = new MsgBean();
        try {
            String checkType = request.getParameter("checkType");
            String checkVal = request.getParameter("checkVal");
            Object[] objects = checkPhoneOrEmail(checkType, checkVal);
            String canUse = (String) objects[0];
            String msg =  (String) objects[1];
            result.put("status",canUse);
            result.put("msg",msg);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return  result.returnMsg();
    }
    /***
     * 校验手机号邮箱是否可用
     * @param checkType
     * @param checkVal
     * @return
     */
    private Object[] checkPhoneOrEmail(String checkType, String checkVal) {
        UcMembersResponse resp = null;
        String msg = "ok";
        try {
            if (Constants.PhoneOrMail.Mail.equals(checkType)) {// 邮箱校验
                UcMembersCheckEmailRequest emailReq = new UcMembersCheckEmailRequest();
                emailReq.setEmail(checkVal);
                emailReq.setTenantId(Constants.TENANTID);
                resp = iUcMembersSV.ucCheckeEmail(emailReq);
                msg = rb.getMessage("safeCtrl.mailHadBind");
                log.info("校验邮箱返回：" + JSON.toJSONString(resp));
            }
            if (Constants.PhoneOrMail.Phone.equals(checkType)) {// 手机校验
                UcMembersCheckeMobileRequest phoneReq = new UcMembersCheckeMobileRequest();
                phoneReq.setTenantId(Constants.TENANTID);
                phoneReq.setMobilephone(checkVal);
                msg = rb.getMessage("safeCtrl.phoneHadBin");
                resp = iUcMembersSV.ucCheckeMobilephone(phoneReq);
                log.info("校验手机返回：" + JSON.toJSONString(resp));
            }
            if (Constants.PhoneOrMail.Register.equals(checkType)) {// 注册界面
                UcMembersCheckeMobileRequest phoneReq = new UcMembersCheckeMobileRequest();
                phoneReq.setTenantId(Constants.TENANTID);
                phoneReq.setMobilephone(checkVal);
                msg = rb.getMessage("safeCtrl.phoneHadRegister");
                resp = iUcMembersSV.ucCheckeMobilephone(phoneReq);
                log.info("校验手机返回：" + JSON.toJSONString(resp));
            }
        } catch (Exception e) {
            log.info(e.getMessage(), e);
        }
        ResponseCode responseCode = resp == null ? null : resp.getCode();
        Integer codeNumber = responseCode == null ? null : responseCode
                .getCodeNumber();
        String falg = "0";

        if (codeNumber != null && codeNumber == 1) {
            falg = "1";
            msg = "ok";
        } else {
            falg = "0";
        }
        return new Object[]{falg,msg};
    }

    /**
     * 修改/绑定邮箱接口
     */
    @RequestMapping(value = "editmail")
    public @ResponseBody Object editmail() {
        MsgBean result = new MsgBean();
        String code = request.getParameter("code");
        String mail = request.getParameter("mail");
        String uid = request.getParameter("uid");
        Integer u = Integer.parseInt(uid);
        UcMembersEditEmailRequest res = new UcMembersEditEmailRequest();
        res.setTenantId(Constants.TENANTID);
        res.setOperationcode(code);
        res.setEmail(mail);
        res.setUid(u);
        try {
            UcMembersResponse resp = iUcMembersSV.ucEditEmail(res);
            ResponseCode responseCode = resp.getCode();
            log.info("--------code:"+ responseCode.getCodeMessage() + responseCode.getCodeNumber());
            if (responseCode.getCodeNumber() == 1){
                Map m = resp.getDate();
                log.info(m);
                UcMembersVo vo = new UcMembersVo(m);
                session.setAttribute("email",mail);
                log.info(vo);
            }else{
                result.put("status","0");
                result.put("msg",responseCode.getCodeMessage());
            }
        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.put("status","0");
            result.put("msg",rb.getMessage("safeCtrl.bindMailFail"));
        }

        return  result.returnMsg();
    }
    /**
     * 发送验证码
     * 激活码:注册时发的    验证码:修改邮箱手机等
     *操作类型 1：手机激活码 2：手机验证码 3：手机动态密码 4：邮箱激活码 5：邮箱验证码 6：密码操作验证码
     */
    @RequestMapping(value = "sendTestCode" )
    public @ResponseBody Object sendTestCode() {
        MsgBean result = new MsgBean();
        String info = request.getParameter("info");
        String isRegister = request.getParameter("isRegister");
        long addTime = Constants.CodeTime.OtherTime;
        if(isRegister != "" && isRegister != null){
            addTime = Constants.CodeTime.RegisterTime;
        }
        //发送验证码时间
        String lastInfo = (String) session.getAttribute("lastInfo");
        if (lastInfo == "" || lastInfo == null){
            //判断请求时间间隔是否小于60s
            String oldTime = (String) session.getAttribute("isSpace");
            long newTime = new Date().getTime();
            if (oldTime != "" && oldTime != null){
                long time = Long.parseLong(oldTime);
                if (newTime < time+addTime){
                    result.put("status","0");
                    result.put("msg",rb.getMessage("safeCtrl.codeHadSoMuch"));
                    return result.returnMsg();
                }
            }
        }else {
            if (info.equals(lastInfo)){
                //判断请求时间间隔是否小于60s
                String oldTime = (String) session.getAttribute("isSpace");
                long newTime = new Date().getTime();
                if (oldTime != "" && oldTime != null){
                    long time = Long.parseLong(oldTime);
                    if (newTime < time+addTime){
                        result.put("status","0");
                        result.put("msg",rb.getMessage("safeCtrl.codeHadSoMuch"));
                        return result.returnMsg();
                    }
                }
            }
        }
        session.setAttribute("lastInfo",info);

        //发送短信验证码次数
        String type = request.getParameter("type");
        SmsRequest smsRequest = new SmsRequest();
        //现在发送次数
        Integer nowCount = 0;
        //获取ipass平台配置
        JSONObject config = AiPassUitl.getVerificationCodeConfig();
        ICacheClient iCacheClient = AiPassUitl.getCacheClient();
        //短信验证码进入判断
        if (!type.equals("4") && !type.equals("5")){
            Object[] objects = smsPhone(smsRequest,info,type,iCacheClient,config);
            nowCount = (Integer) objects[1];
            boolean isFail = (boolean) objects[0];
            if(!isFail){
                result.put("status","0");
                result.put("msg","验证码发送次数达到当天限制");
                return result.returnMsg();
            }
        }

        String uid = request.getParameter("uid");
        String domainName = request.getParameter("domain");
        UcMembersGetOperationcodeRequest res = new UcMembersGetOperationcodeRequest();
        res.setTenantId(Constants.TENANTID);
        res.setOperationtype(type);
        res.setUserinfo(info);
        String domainvalue="";
        if (domainName != null){
            CountryRequest countryRequest = new CountryRequest();
            countryRequest.setTenantId(Constants.TENANTID);
            CountryResponse countryResponse = iGnCountrySV.queryCountry(countryRequest);
            List<CountryVo> lists = countryResponse.getResult();
            for (CountryVo vo:lists) {
                if (domainName.equals(vo.getCountryValue())){
                    domainvalue = vo.getCountryCode();
                }
            }
            res.setDomainname(domainName);
//            if (domainvalue.equals("86")){
//                domainvalue = "";
//            }
        }
        if (uid != null){
            Integer u = Integer.parseInt(uid);
            res.setUid(u);
        }
        try {
            UcMembersGetOperationcodeResponse resp = iUcMembersOperationSV.ucGetOperationcode(res);
            ResponseCode responseCode = resp.getCode();
            if (responseCode.getCodeNumber() == 1){
                Map m = resp.getDate();
                result.put("uid",m.get("uid")+"");
                UcMembersVo vo = new UcMembersVo(m);
                log.info("uid:-----"+m.get("uid"));
                log.info("验证码是:" +vo.getOperationcode());
                //发邮件
                if (type.equals("4") || type.equals("5")){
                    SendEmailRequest emailRequest = new SendEmailRequest();
                    emailRequest.setTomails(new String[] { info });

                    String subject = Constants.MailVerify.EMAIL_VERIFY_ZH_CN_SUBJECT;
                    String userName = (String) session.getAttribute("username");
                    if (userName == "" || userName == null){
                        userName = "用户";
                    }
                    IConfigClient defaultConfigClient = CCSClientFactory
                            .getDefaultConfigClient();
                    String baseUrl = defaultConfigClient
                            .get(Constants.MailVerify.MailVerifyBase_URL);
                    log.info("邮件根路径:"+baseUrl);
                    String logoUrl = baseUrl+"/ui/images/logo.jpg";
                    String phoneUrl = baseUrl+"/ui/images/phone.jpg";
                    String ermaUrl = baseUrl+"/ui/images/erma.jpg";
                    emailRequest.setData(new String[] {subject,userName,vo.getOperationcode(),logoUrl,phoneUrl,ermaUrl});
                    Locale locale = rb.getDefaultLocale();
                    String _template = "";
                    if (Locale.SIMPLIFIED_CHINESE.toString().equals(locale.toString())) {
                        _template = Constants.MailVerify.VERIFY_EMAIL_ZH_CN_TEMPLATE;
                    } else if (Locale.US.toString().equals(locale.toString())) {
                        _template = Constants.MailVerify.VERIFY_EMAIL_EN_US_TEMPLATE;
                    }

                    emailRequest.setTemplateURL(_template);
                    emailRequest.setSubject(subject);

                    if(!SmsSenderUtil.sendEmail(emailRequest)){
                        result.put("status","0");
                        result.put("msg",rb.getMessage("safeCtrl.codeSendFail"));
                    }else {
                        long t = new Date().getTime();
                        session.setAttribute("isSpace",Long.toString(t));
                    }
                    //发短信
                }else {
                    //默认中文模版
                    String _template = Constants.PhoneVerify.SMS_CODE_TEMPLATE_ZH_CN;
                    Locale locale = rb.getDefaultLocale();
                    if (Locale.US.toString().equals(locale.toString())) {
                        _template =  Constants.PhoneVerify.SMS_CODE_TEMPLATE_EN_US;
                    }
                    String content = MessageFormat.format(_template,vo.getOperationcode());
                    if(!SmsSenderUtil.sendMessage("+"+domainvalue+info,content)){
                        result.put("status","0");
                        result.put("msg",rb.getMessage("safeCtrl.codeSendFail"));
                    }else {
                        // 获取最多发送次数超时时间
                        int maxOverTimeCount = config.getIntValue(smsRequest
                                .getMaxCountOverTimeKey());
                        nowCount = nowCount + 1;
                        //把当前发送次数存入缓存
                        iCacheClient.setex(smsRequest.getNowCountKey(), maxOverTimeCount,
                                String.valueOf(nowCount));
                        // 手机验证码超时时间
                        int overTime = config.getIntValue(smsRequest.getCodeOverTimeKey());
                        iCacheClient.setex(smsRequest.getCodeKey(), overTime, vo.getOperationcode());
                        //验证码发送间隔
                        long t = new Date().getTime();
                        session.setAttribute("isSpace",Long.toString(t));
                    }
                }
            }else{
                result.put("status","0");
                if (responseCode.getCodeNumber() == -11){
                    result.put("msg",rb.getMessage("safeCtrl.hadPhone"));
                }else if (responseCode.getCodeNumber() == -10){
                    result.put("msg",rb.getMessage("safeCtrl.phoneError"));
                }else {
                    result.put("msg",rb.getMessage("safeCtrl.codeSendFail"));

                }
            }
        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.put("status","0");
            result.put("msg",rb.getMessage("safeCtrl.codeSendFail"));
        }

        return  result.returnMsg();
    }

    /**
     * 判断发送短信次数
     * @param smsRequest
     * @param info
     * @param type
     * @param iCacheClient
     * @param config
     * @return
     */
    public Object[] smsPhone(SmsRequest smsRequest,String info,String type,ICacheClient iCacheClient,JSONObject config){
        smsRequest.setPhone(info);
        /** 手机验证码key **/
        String codeKey = null;
        /** 手机验证码超时时间 **/
        String codeOverTimeKey = null;
        /** 最多发送次数key **/
        String maxCountKey = null;
        /** 最多发送次数超时时间key **/
        String maxCountOverTimeKey = null;
        /** 当前发送次数key **/
        String nowCountKey = null;
        if (Constants.CheckOpreation.PhoneActivate.equals(type)) {// 注册手机激活码
            codeKey = Constants.PhoneVerify.REGISTER_PHONE_CODE + info;
            codeOverTimeKey = Constants.PhoneVerify.REGISTER_PHONE_CODE_OVERTIME;
            nowCountKey = Constants.PhoneVerify.REGISTER_PHONE_CODE_COUNT + info;
            maxCountKey = Constants.PhoneVerify.REGISTER_PHONE_CODE_MAX_COUNT;
            maxCountOverTimeKey = Constants.PhoneVerify.REGISTER_PHONE_CODE_MAX_COUNT_OVERTIME;
        } else if (Constants.CheckOpreation.PhoneCheck.equals(type) || Constants.CheckOpreation.PasswordOperation.equals(type)) {// 手机验证码
            codeKey = Constants.PhoneVerify.UPDATE_DATA_PHONE_CODE + info;
            codeOverTimeKey = Constants.PhoneVerify.UPDATE_DATA_PHONE_CODE_OVERTIME;
            nowCountKey = Constants.PhoneVerify.UPDATE_DATA_PHONE_CODE_COUNT + info;
            maxCountKey = Constants.PhoneVerify.UPDATE_DATA_PHONE_CODE_MAX_COUNT;
            maxCountOverTimeKey = Constants.PhoneVerify.UPDATE_DATA_PHONE_CODE_MAX_COUNT_OVERTIME;
        }
        smsRequest.setCodeKey(codeKey);
        smsRequest.setCodeOverTimeKey(codeOverTimeKey);
        smsRequest.setMaxCountKey(maxCountKey);
        smsRequest.setMaxCountOverTimeKey(maxCountOverTimeKey);
        smsRequest.setNowCountKey(nowCountKey);
        // 最多发送次数 key
        int maxCount = config.getIntValue(smsRequest.getMaxCountKey());
        // 当前发送次数
        Integer nowCount = 0;
        String sendCount = iCacheClient.get(smsRequest.getNowCountKey());
        if (!StringUtil.isBlank(sendCount)) {
            nowCount = Integer.parseInt(sendCount);
            log.info(info+"发送验证码的次数:"+nowCount);
        }
        if (nowCount >= maxCount) {

            Object[] objects = {false,nowCount};
            return objects;
        }else {
            Object[] objects = {true,nowCount};
            return objects;
        }
    }

    /**
     * 校验验证码接口
     */
    @RequestMapping(value = "checkTestCode")
    public @ResponseBody Object checkTestCode() {
        MsgBean result = new MsgBean();
        String uid = request.getParameter("uid");
        Integer u = Integer.parseInt(uid);
        String type = request.getParameter("type");
        String code = request.getParameter("code");
        String userinfo = request.getParameter("userinfo");
        UcMembersActiveRequest res = new UcMembersActiveRequest();
        res.setTenantId(Constants.TENANTID);
        res.setOperationtype(type);
        res.setOperationcode(code);
        res.setUserinfo(userinfo);
        res.setUid(u);
        log.info("uid:"+u);
        try {
            UcMembersResponse resp = iUcMembersOperationSV.ucActiveMember(res);
            ResponseCode responseCode = resp.getCode();
            log.info("--------code:"+ responseCode.getCodeMessage() + responseCode.getCodeNumber());
            if (responseCode.getCodeNumber() == 1){
                Map m = resp.getDate();
                log.info(m);
                UcMembersVo vo = new UcMembersVo(m);
                log.info(vo);
            }else{
                result.put("status","0");
                if (responseCode.getCodeNumber() == -1 || responseCode.getCodeNumber() == -14){
                    result.put("msg",rb.getMessage("loginCtrl.checkCode"));
                }else if (responseCode.getCodeNumber() == -13){
                    result.put("msg",rb.getMessage("safeCtrl.chaoshicode"));
                }
            }


        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.put("status","0");
            result.put("msg",rb.getMessage("loginCtrl.checkCode"));
        }

        return  result.returnMsg();
    }

    /**
     * 图文验证码
     * @param response
     * @return
     * @throws IOException
     */
    @RequestMapping (value = "getpiccode")
    public @ResponseBody Object getpiccode(HttpServletResponse response) throws IOException {
        ImageCodeUtil util = new ImageCodeUtil();
        String str= util.creatCode(120,41,5,20,response.getOutputStream());
        // 将认证码存入SESSION
        log.info("===========code:" + str);
        session.setAttribute("certCode", str);
        return "";
    }
}

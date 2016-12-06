package com.yc.wap.safe;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
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
import com.ai.yc.ucenter.api.members.param.editemail.UcMembersEditEmailRequest;
import com.ai.yc.ucenter.api.members.param.editmobile.UcMembersEditMobileRequest;
import com.ai.yc.ucenter.api.members.param.editpass.UcMembersEditPassRequest;
import com.ai.yc.ucenter.api.members.param.get.UcMembersGetRequest;
import com.ai.yc.ucenter.api.members.param.get.UcMembersGetResponse;
import com.ai.yc.ucenter.api.members.param.opera.UcMembersActiveRequest;
import com.ai.yc.ucenter.api.members.param.opera.UcMembersGetOperationcodeRequest;
import com.ai.yc.ucenter.api.members.param.opera.UcMembersGetOperationcodeResponse;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.constants.Constants;

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
import java.io.File;
import java.io.IOException;
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

        System.out.println("测试");
        return "safe/safe";
    }


    /**
     * 修改密码界面
     * @return
     */
    @RequestMapping(value = "changepsd")
    public String changepsd() {

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
        log.info("safe-installpsd invoked");
        return "safe/installpsd";
    }

    /**
     * 验证手机号界面
     * @return
     */
    @RequestMapping(value = "checkphone")
    public String checkphone() {
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
                result.put("msg","验证码错误");
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
                log.info(m);
                UcMembersVo vo = new UcMembersVo(m);
                result.put("userPhone",vo.getMobilephone());
                result.put("uids",m.get("uid")+"");
                result.put("username",vo.getUsername());
                result.put("email",vo.getEmail());
                result.put("password",vo.getPassword());
                log.info(vo.getUid());
            }else {
                result.put("status","0");
                result.put("msg",code.getCodeMessage());
            }
            /*code:失败，未找到该用户信息-1 code:成功1    */

        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.setFailure(e.getMessage());
            result.put("status","0");
            result.put("msg","获取用户信息失败");
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

            result.put("list",lists);
        }catch (Exception e) {
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
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
            result.put("msg","修改失败");
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
            result.put("msg","绑定/修改手机失败");
        }

        return  result.returnMsg();
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
            result.put("msg","绑定/修改邮箱失败");
        }

        return  result.returnMsg();
    }
    /**
     * 发送验证码
     * 激活码:注册时发的    验证码:修改邮箱手机等
     *操作类型 1：手机激活码 2：手机验证码 3：手机动态密码 4：邮箱激活码 5：邮箱验证码 6：密码操作验证码
     */
    @RequestMapping(value = "sendTestCode")
    public @ResponseBody Object sendTestCode() {
        MsgBean result = new MsgBean();
        String type = request.getParameter("type");
        String info = request.getParameter("info");
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
            if (domainvalue.equals("86")){
                domainvalue = "";
            }
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
                log.info(vo);
                log.info("验证码是:" +vo.getOperationcode());
                SafeController ctrl = new SafeController();
                if (type.equals("4") || type.equals("5")){
                    String time = Constants.Register.REGISTER_COUNTRY_LIST_KEY_OVERTIME;
                    SendEmailRequest emailRequest = new SendEmailRequest();
                    emailRequest.setTomails(new String[] { info });
                    int index = info.indexOf("@");
                    String name = info.substring(0,index);
                    emailRequest.setData(new String[] { name, vo.getOperationcode() ,time});
                    Locale locale = rb.getDefaultLocale();
                    String _template = "";
                    String _subject = "";
                    if (Locale.SIMPLIFIED_CHINESE.toString().equals(locale.toString())) {
                        _template = Constants.Register.REGISTER_EMAIL_ZH_CN_TEMPLATE;
                        _subject = "中文主题";
                    } else if (Locale.US.toString().equals(locale.toString())) {
                        _template = Constants.Register.REGISTER_EMAIL_EN_US_TEMPLATE;
                        _subject = "英文主题";
                    }
                    emailRequest.setTemplateURL(_template);
                    emailRequest.setSubject(_subject);
                    if(!SmsSenderUtil.sendEmail(emailRequest)){
                        result.put("status","0");
                        result.put("msg","验证码发送失败");
                    }
                }else {

                    if(!SmsSenderUtil.sendMessage("+"+domainvalue+info,"验证码是:"+vo.getOperationcode())){
                        result.put("status","0");
                        result.put("msg","验证码发送失败");
                    }
                }
            }else{
                result.put("status","0");
                result.put("msg",responseCode.getCodeMessage());
            }
        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.put("status","0");
            result.put("msg","获取验证码失败");
        }

        return  result.returnMsg();
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
        UcMembersActiveRequest res = new UcMembersActiveRequest();
        res.setTenantId(Constants.TENANTID);
        res.setOperationtype(type);
        res.setOperationcode(code);
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
                result.put("msg",responseCode.getCodeMessage());
            }


        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.put("status","0");
            result.put("msg","验证码错误");
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

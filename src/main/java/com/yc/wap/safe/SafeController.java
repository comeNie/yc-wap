package com.yc.wap.safe;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
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
import scala.util.parsing.combinator.testing.Str;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
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
    /**
     * 安全设置界面
     * @return
     */
    @RequestMapping(value = "safe")
    public String safe() {
        MsgBean result = new MsgBean();
        String uidStr = (String) session.getAttribute("UID");
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        String mobilePhone = (String) session.getAttribute("mobilePhone");
        request.setAttribute("UID",uidStr);
        request.setAttribute("email",email);
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
        res.setTenantId(Constants.TenantID);
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
                result.put("uids",vo.getUid()+"");
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
        res.setTenantId(Constants.TenantID);
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
        res.setTenantId(Constants.TenantID);
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
        UcMembersEditMobileRequest res = new UcMembersEditMobileRequest();
        res.setTenantId(Constants.TenantID);
        res.setOperationcode(code);
        res.setMobilephone(phone);
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
            }else{
                result.put("status","0");
//                result.put("msg","绑定/修改手机失败");
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
        res.setTenantId(Constants.TenantID);
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
        UcMembersGetOperationcodeRequest res = new UcMembersGetOperationcodeRequest();
        res.setTenantId(Constants.TenantID);
        res.setOperationtype(type);
        res.setUserinfo(info);
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
            }else{
                result.put("status","0");
//                result.put("msg","获取验证码失败");
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
        res.setTenantId(Constants.TenantID);
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


}

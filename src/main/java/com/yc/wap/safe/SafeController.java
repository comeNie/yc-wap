package com.yc.wap.safe;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.common.api.country.interfaces.IGnCountrySV;
import com.ai.yc.common.api.country.param.CountryRequest;
import com.ai.yc.common.api.country.param.CountryResponse;
import com.ai.yc.common.api.country.param.CountryVo;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersOperationSV;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;
import com.ai.yc.ucenter.api.members.param.UcMembersResponse;
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
import com.yc.wap.system.utils.RegexUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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


        try {


        } catch (Exception e) {
            log.info("~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.setFailure(e.getMessage());
        }
        log.info("safe-safe invoked");
        return "safe/safe";
    }

    /**
     * 修改密码界面
     * @return
     */
    @RequestMapping(value = "changepsd")
    public String changepsd() {

        log.info("safe-changepsd invoked");
        return "safe/changepsd";
    }

    /**
     * 修改手机号界面
     * @return
     */
    @RequestMapping(value = "changephone")
    public String changephone() {
        log.info("safe-changephone invoked");
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
        String jump = request.getParameter("jump");
        request.setAttribute("jump",jump);
        return "safe/checkphone";
    }

    /**
     * 获取用户信息接口
     */
    @RequestMapping(value = "userinfo")
    public @ResponseBody Object userinfo() {
        MsgBean result = new MsgBean();
        String username = request.getParameter("username");
        String mode;
        boolean isEmail = RegexUtils.checkIsEmail(username);
        boolean isPhone = RegexUtils.checkIsPhone(username);
        if (isEmail) {
            mode = "2";
        }
        else if (isPhone) {
            mode = "3";
        }else {
            mode = "4";
        }
        log.info(mode);

        UcMembersGetRequest res = new UcMembersGetRequest();
        res.setTenantId("yeecloud");

        res.setGetmode(mode);
        res.setUsername(username);
        try {
            UcMembersGetResponse resp = iUcMembersSV.ucGetMember(res);
            UcMembersGetResponse.UcMembersGetDate date = resp.getDate();
            log.info(date.getLoginmode());

        }catch (Exception e) {
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.setFailure(e.getMessage());
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
        String checke_code = request.getParameter("code");  //旧密码或验证码
        String newpw = request.getParameter("newpw");
        String checke_mode = request.getParameter("mode");  // 1：旧密码 2：验证码（密码操作验证码）
        UcMembersEditPassRequest res = new UcMembersEditPassRequest();
        res.setTenantId(Constants.TenantID);
        res.setChecke_code(checke_code);
        res.setChecke_mode(checke_mode);
        res.setNewpw(newpw);
        try {
            UcMembersResponse resp = iUcMembersSV.ucEditPassword(res);
            log.info(resp.getMessage().isSuccess());
        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.setFailure(e.getMessage());
        }

        return  result.returnMsg();
    }
    /**
     * 查询手机号的合法性
     */
    @RequestMapping(value = "phoneenable")
    public @ResponseBody Object phoneenable() {
        MsgBean result = new MsgBean();

        String phone = request.getParameter("phone");

        UcMembersCheckeMobileRequest res = new UcMembersCheckeMobileRequest();
        res.setTenantId(Constants.TenantID);
//        res.setUid(0);
        res.setMobilephone(phone);

        try {
            UcMembersResponse resp = iUcMembersSV.ucCheckeMobilephone(res);
            log.info(resp.getMessage().isSuccess());
        }catch (Exception e) {
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.setFailure(e.getMessage());
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

        UcMembersEditMobileRequest res = new UcMembersEditMobileRequest();
        res.setTenantId(Constants.TenantID);
        res.setOperationcode(code);
        res.setMobilephone(phone);
        try {
            UcMembersResponse resp = iUcMembersSV.ucEditMobilephone(res);
            log.info(resp.getMessage().isSuccess());
        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.setFailure(e.getMessage());
        }

        return  result.returnMsg();
    }
    /**
     * 查询邮箱的合法性
     */
    @RequestMapping(value = "mailenable")
    public @ResponseBody Object mailenable() {
        MsgBean result = new MsgBean();

        String mail = request.getParameter("mail");

        UcMembersCheckEmailRequest res = new UcMembersCheckEmailRequest();
        res.setTenantId(Constants.TenantID);
        res.setEmail(mail);
        res.setUid(0);
        try {
            UcMembersResponse resp = iUcMembersSV.ucCheckeEmail(res);

            log.info(resp.getMessage());
            log.info(resp.getDate());
        }catch (Exception e) {
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.setFailure(e.getMessage());
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

        UcMembersEditEmailRequest res = new UcMembersEditEmailRequest();
        res.setTenantId(Constants.TenantID);
        res.setOperationcode(code);
        res.setEmail(mail);
        try {
            UcMembersResponse resp = iUcMembersSV.ucEditEmail(res);
            log.info(resp.getMessage().isSuccess());
        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.setFailure(e.getMessage());
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
        UcMembersGetOperationcodeRequest res = new UcMembersGetOperationcodeRequest();
        res.setTenantId(Constants.TenantID);
        res.setOperationtype(type);
        res.setUserinfo(info);
        try {
            UcMembersGetOperationcodeResponse resp = iUcMembersOperationSV.ucGetOperationcode(res);
            log.info(resp.getOperationcode());
        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.setFailure(e.getMessage());
        }

        return  result.returnMsg();
    }
    /**
     * 校验验证码接口
     * 操作类型 1：手机激活码 2：手机验证码 3：手机动态密码 4：邮箱激活码 5：邮箱验证码 6：密码操作验证码
     */
    @RequestMapping(value = "checkTestCode")
    public @ResponseBody Object checkTestCode() {
        MsgBean result = new MsgBean();
        String type = request.getParameter("type");
        String code = request.getParameter("code");
        UcMembersActiveRequest res = new UcMembersActiveRequest();
        res.setTenantId(Constants.TenantID);
        res.setOperationtype(type);
        res.setOperationcode(code);
        try {
            UcMembersResponse resp = iUcMembersOperationSV.ucActiveMember(res);
            log.info(resp.getMessage().isSuccess());
        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.setFailure(e.getMessage());
        }

        return  result.returnMsg();
    }


}

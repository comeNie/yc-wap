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
import com.ai.yc.ucenter.api.members.param.get.UcMembersGetRequest;
import com.ai.yc.ucenter.api.members.param.get.UcMembersGetResponse;
import com.ai.yc.ucenter.api.members.param.opera.UcMembersGetOperationcodeRequest;
import com.ai.yc.ucenter.api.members.param.opera.UcMembersGetOperationcodeResponse;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
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


        }catch (Exception e) {
            log.info("~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.setFailure(e.getMessage());
        }
        log.info("safe-safe invoked");
        return "safe/safe";
    }
    /**
     * 获取用户信息
     */
    @RequestMapping(value = "userinfo")
    public @ResponseBody Object userinfo() {
        MsgBean result = new MsgBean();

        String mode = request.getParameter("mode");
        UcMembersGetRequest res = new UcMembersGetRequest();
        res.setTenantId("yeecloud");
        res.setGetmode(mode);
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
     * 获取国家区号
     */
    @RequestMapping(value = "countryid")
    public @ResponseBody Object countryid() {
        MsgBean result = new MsgBean();
        CountryRequest res = new CountryRequest();
        res.setTenantId("yeecloud");
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
     * 查询手机号的合法性
     */
    @RequestMapping(value = "phoneenable")
    public @ResponseBody Object phoneenable() {
        MsgBean result = new MsgBean();

        String phone = request.getParameter("phone");

        UcMembersCheckeMobileRequest res = new UcMembersCheckeMobileRequest();
        res.setTenantId("yeecloud");
//        res.setUid(0);
        res.setMobilephone(phone);

        try {
            UcMembersResponse resp = iUcMembersSV.ucCheckeMobilephone(res);
            log.info(resp.getDate());
        }catch (Exception e) {
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
        res.setTenantId("yeecloud");
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
     * 发送验证码
     */
    @RequestMapping(value = "sendTestCode")
    public @ResponseBody Object sendTestCode() {
        MsgBean result = new MsgBean();
        String type = request.getParameter("type");
        String info = request.getParameter("info");
        UcMembersGetOperationcodeRequest res = new UcMembersGetOperationcodeRequest();
        res.setTenantId("yeecloud");
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
}

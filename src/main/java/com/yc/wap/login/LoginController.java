package com.yc.wap.login;

import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.ai.slp.balance.api.accountquery.interfaces.IAccountQuerySV;
import com.ai.slp.balance.api.accountquery.param.AccountIdParam;
import com.ai.slp.balance.api.accountquery.param.AccountInfoVo;
import com.ai.yc.user.api.userservice.param.*;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;
import com.ai.yc.ucenter.api.members.param.UcMembersVo;
import com.ai.yc.ucenter.api.members.param.base.ResponseCode;
import com.ai.yc.ucenter.api.members.param.login.UcMembersLoginRequest;
import com.ai.yc.ucenter.api.members.param.login.UcMembersLoginResponse;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.constants.Constants;
import com.yc.wap.system.utils.MD5Util;

/**
 * Created by ldy on 2016/11/8.
 */

@Controller
@RequestMapping(value = "login")
public class LoginController extends BaseController {
    private Log log = LogFactory.getLog(LoginController.class);
    private IUcMembersSV iUcMembersSV = DubboConsumerFactory.getService(IUcMembersSV.class);
    private IYCUserServiceSV iycUserServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
    private IAccountQuerySV iAccountQuerySV = DubboConsumerFactory.getService(IAccountQuerySV.class);

    @RequestMapping(value = "login")
    public String login() {
        MsgBean result = new MsgBean();
        String to = request.getParameter("to");
        String success = request.getParameter("success");
        request.setAttribute("to",to);
        request.setAttribute("success",success);
        return "login/login";
    }

    @RequestMapping(value = "registersuccess")
    public String registersuccess() {
        MsgBean result = new MsgBean();
        return "login/registersuccess";
    }
    @RequestMapping(value = "kinglogin")
    public String kinglogin() {
        MsgBean result = new MsgBean();
        return "login/kinglogin";
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
     * 金山登录
     */
    @RequestMapping(value = "kingchecklogin")
    public @ResponseBody Object kingchecklogin(){
        MsgBean result = new MsgBean();
        String checkCode = request.getParameter("code");//图文验证码
        if (checkCode != null && checkCode != ""){

            String sessionCode = (String) session.getAttribute("certCode");
            if (!checkCode.toUpperCase().equals(sessionCode.toUpperCase())){
                result.put("status","2");
                result.put("msg",rb.getMessage("loginCtrl.checkCode"));
                return result.returnMsg();
            }
        }
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        log.info("----------------------开始金山登录----------------------");
        //调用金山接口
        JSONObject kingObject = KingHttpUtil.loginToKing(username,password);

        String errorCode;//错误编码
        String msg;//错误提示语
        String ssourl;//Sso 登录地址
        if(kingObject!=null && kingObject.get("error_code")!=null){
            errorCode = kingObject.getString("error_code");
            if(errorCode.equals("10006")){
                msg = rb.getMessage("loginCtrl.kinguserNotExit");
            }else if(errorCode.equals("100010")){
                msg = rb.getMessage("loginCtrl.kingpsdError");
            }else{
                msg = rb.getMessage("loginCtrl.kingpsdOrUserError");
            }
            result.put("msg",msg);
            result.put("status","0");
            log.info("----------------------金山登录失败----------------------");
        }else{
            log.info("金山登录返回参数"+kingObject);
           log.info("----------------------金山登录成功----------------------");
        }
        return result.returnMsg();
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
        if (checkCode != null && checkCode != ""){

            String sessionCode = (String) session.getAttribute("certCode");
            if (!checkCode.toUpperCase().equals(sessionCode.toUpperCase())){
                result.put("status","2");
                result.put("msg",rb.getMessage("loginCtrl.checkCode"));
                return result.returnMsg();
            }
        }
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UcMembersLoginRequest res = new UcMembersLoginRequest();
        res.setTenantId(Constants.TENANTID);
        password = MD5Util.md5(password);
        res.setPassword(password);
        res.setUsername(username);
        res.setLoginmode(Constants.LoginModel.ALLModel);
        try {
            UcMembersLoginResponse resp = iUcMembersSV.ucLoginMember(res);

            ResponseCode code = resp.getCode();  //通过code进行捕获
            /*code:失败，未找到该用户信息-1 code:成功1    */
            log.info("--------code:"+ code.getCodeMessage() + code.getCodeNumber());
            if (code.getCodeNumber() == 1){
                Map m = resp.getDate();
                //获取是否有支付密码
                if(!isPaypsd(m.get("uid")+"")){
                    result.put("status","0");
                    result.put("msg",rb.getMessage("loginCtrl.loginFail"));
                    return result.returnMsg();
                }
                UcMembersVo vo = new UcMembersVo(m);
                session.setAttribute("isLogin","1");    //1登录  0未登录
                session.setAttribute("UID",m.get("uid")+"");
                session.setAttribute("email",m.get("email"));
                session.setAttribute("username",m.get("username"));
                log.info("passHav:"+ m.get("passHav"));
                session.setAttribute("password",m.get("passHav"));
                session.setAttribute("domainname",m.get("domainname"));
                session.setAttribute("mobilePhone",m.get("mobilephone"));
                log.info(vo);
                //补全用户信息
                populateUsrUserInfo(m);
            }else {
                result.put("status","0");
                result.put("msg",code.getCodeMessage());
                if (code.getCodeNumber() == -101){
                    result.put("msg",rb.getMessage("loginCtrl.userNotExit"));
                }else if (code.getCodeNumber() == -102){
                    result.put("msg",rb.getMessage("loginCtrl.userNotAble"));
                }else if (code.getCodeNumber() == -103){
                    result.put("msg",rb.getMessage("loginCtrl.userOrPsdError"));
                }else {
                    result.put("msg",rb.getMessage("loginCtrl.loginFail"));
                }
            }
        }catch (Exception e){
            log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
            result.put("status","0");
            result.put("msg",rb.getMessage("loginCtrl.loginFail"));
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

        InsertYCUserRequest res = new InsertYCUserRequest();
//        res.setTenantId(Constants.TenantID);
        res.setPassword(password);
        res.setRegip("0");
        res.setMobilePhone(phone);
        res.setOperationcode(code);
        res.setLoginway(Constants.RegisterModel.PhonePsdModel);
        res.setUserId(personUid);
        res.setOperationcode(code);
        try {
            YCInsertUserResponse resp = iycUserServiceSV.insertYCUser(res);
            String  message = resp.getResponseHeader().getResultMessage();  //通过code进行捕获
            log.info("--------message:"+ message);
            if (!resp.getResponseHeader().getResultCode().equals("000000")){
                result.put("status","0");
                if (resp.getResponseHeader().getResultCode().equals("-1")){
                    result.put("msg",rb.getMessage("safeCtrl.codeError"));
                }else if (resp.getResponseHeader().getResultCode().equals("0")){
                    result.put("msg",rb.getMessage("safeCtrl.codeLoseTime"));
                }else {
                    result.put("msg",rb.getMessage("loginCtrl.registerFail"));
                }

            }
            /*code:失败，未找到该用户信息-1 code:成功1    */
        } catch (Exception e) {
            result.put("status","0");
            result.put("msg",rb.getMessage("loginCtrl.registerFail"));
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

    /**
     * 判断是否有支付密码
     */
    private boolean isPaypsd(String uid){
        boolean isSuccess;
        SearchYCUserRequest userRequest = new SearchYCUserRequest();
        userRequest.setUserId(uid);
        YCUserInfoResponse infoResponse = iycUserServiceSV.searchYCUserInfo(userRequest);
        Long AccountId = infoResponse.getAccountId();

        AccountIdParam req = new AccountIdParam();
        req.setTenantId(Constants.TENANTID);
        req.setAccountId(AccountId);
        try {
            AccountInfoVo resp = iAccountQuerySV.queryAccontById(req);
            String payPassword = resp.getPayPassword();
            log.info("支付密码"+payPassword);
            session.setAttribute("payPsd",payPassword==null || payPassword=="" ? 0 : 1);
            isSuccess = true;
        }catch (Exception e){
            isSuccess = false;
            e.printStackTrace();
        }
        return isSuccess;
    }
  //如果客户表中不存在客户信息，则依据登录信息创建默认的客户信息
    private void populateUsrUserInfo(Map m) {
    	long startTime = System.currentTimeMillis();
    	log.info("=====开始populateUsrUserInfo,当前时间戳:"+startTime);
    	SearchYCUserRequest userReq=new SearchYCUserRequest();
    	userReq.setUserId(m.get("uid")+"");
    	//long startTimeQryUser = System.currentTimeMillis();
    	//log.info("开始查询客户信息,当前时间戳:"+startTimeQryUser);
    	IYCUserServiceSV userSv=DubboConsumerFactory.getService(IYCUserServiceSV.class);
    	//YCUserInfoResponse userResp= userSv.searchYCUserInfo(userReq);
    	//long endTimeQryUser = System.currentTimeMillis();
    	//log.info("结束查询客户信息,当前时间戳:"+endTimeQryUser+"，耗时:"+(endTimeQryUser-startTimeQryUser)+"毫秒");
    	
    	//if(userResp==null||StringUtil.isBlank(userResp.getUserId())){
    		long startTimeCompleteUser = System.currentTimeMillis();
    		log.info("开始更新或补全客户信息,当前时间戳:"+startTimeCompleteUser);
    		//说明客户信息不存在，需要依据登录信息创建默认的客户信息
    		CompleteUserInfoRequest cmpUser=new CompleteUserInfoRequest();
    		cmpUser.setUserId(m.get("uid")+"");
    		cmpUser.setLoginName(m.get("username")==null?"":m.get("username")+"");
    		cmpUser.setMobilePhone(m.get("mobilephone")==null?"":m.get("mobilephone")+"");
    		//避免网络瞬间中断异常，尝试三次补全
    		boolean flag=false;
    		for(int i=0;i<3;i++){
    			BaseResponse resp=userSv.completeUserInfo(cmpUser);
    			if(resp.getResponseHeader().getIsSuccess()){
    				flag = true;
    				long endTimeCompleteUser = System.currentTimeMillis();
    		    	log.info("结束更新或补全客户信息,当前时间戳:"+endTimeCompleteUser+"，耗时:"+(endTimeCompleteUser-startTimeCompleteUser)+"毫秒");
    				break;
    			}
    		}
    		if(flag){
    			log.info("结束更新或补全客户信息OK");
    		}
    		else{
    			log.info("结束更新或补全客户信息FAILURE");
    		}
    		
//    	}
//    	else{
//    		log.info("客户存在，不需补全");
//    	}
    	
     	long endTime = System.currentTimeMillis();
        log.info("=====结束populateUsrUserInfo,客户信息补全,当前时间戳:"+endTime+"，耗时:"+(endTime-startTime)+"毫秒");
	}
}

package com.yc.wap.center;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCUserInfoResponse;
import com.yc.wap.system.base.BaseController;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by ldy on 2016/11/9.
 */
@Controller
@RequestMapping(value = "center")
public class CenterController extends BaseController {
    private Log log = LogFactory.getLog(CenterController.class);
    private IYCUserServiceSV iycUserServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
    @RequestMapping(value = "center")
    public String center() {
        log.info("account-center invoked");
        String isLogin = (String) session.getAttribute("isLogin");
        if (isLogin == null || isLogin.equals("") || isLogin.equals("0")) {
            log.info("UserNotLogin");
            request.setAttribute("to", "login");
            return "login/login";
        }
        String uid = (String) session.getAttribute("UID");
        //查询用户信息
        SearchYCUserRequest userRequest = new SearchYCUserRequest();
        userRequest.setUserId(uid);
        YCUserInfoResponse infoResponse = iycUserServiceSV.searchYCUserInfo(userRequest);
        log.info("message"+infoResponse.getResponseHeader().getResultMessage());
        log.info("url:"+ infoResponse.getUrl());
        log.info("info:"+ infoResponse);

//        request.setAttribute("username",infoResponse.getUsername());
        request.setAttribute("userurl",infoResponse.getUrl());
        return "center/center";
    }
}

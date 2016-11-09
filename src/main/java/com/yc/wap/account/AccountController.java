package com.yc.wap.account;

import com.yc.wap.system.base.BaseController;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by ldy on 2016/11/9.
 */
@Controller
@RequestMapping(value = "account")
public class AccountController extends BaseController {
    private Log log = LogFactory.getLog(AccountController.class);


    @RequestMapping(value = "recharge")
    public String recharge() {
        log.info("account-recharge invoked");

        return "account/recharge";
    }
    @RequestMapping(value = "rechargesuccess")
    public String rechargesuccess() {
        log.info("account-rechargesuccess invoked");

        return "account/rechargesuccess";
    }
    @RequestMapping(value = "balance")
    public String balance() {
        log.info("account-balance invoked");

        return "account/balance";
    }
}

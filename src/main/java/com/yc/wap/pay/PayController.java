package com.yc.wap.pay;

import com.yc.wap.system.base.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Nozomi on 11/14/2016.
 */
@Controller
@RequestMapping(value = "pay")
public class PayController extends BaseController{
    @RequestMapping(value = "/gotoPayByOrg")
    public void gotoPayByOrg(HttpServletRequest request, HttpServletResponse response) throws Exception {

    }
}

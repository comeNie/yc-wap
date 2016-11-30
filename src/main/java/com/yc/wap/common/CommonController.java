package com.yc.wap.common;

import com.yc.wap.system.base.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Nozomi on 11/12/2016.
 */
@Controller
@RequestMapping(value = "common")
public class CommonController extends BaseController {

    @RequestMapping(value = "aboutus")
    public String aboutus() {
        return "common/aboutus";
    }

    @RequestMapping(value = "recruit")
    public String recruit() {
        return "common/recruit";
    }

    @RequestMapping(value = "agreement")
    public String agreement() {
        return "common/agreement";
    }
}

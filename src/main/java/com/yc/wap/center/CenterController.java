package com.yc.wap.center;

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

    @RequestMapping(value = "center")
    public String center() {
        log.info("account-center invoked");

        return "center/center";
    }
}

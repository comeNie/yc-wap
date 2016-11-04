package com.yc.wap.safe;

import com.yc.wap.system.base.BaseController;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by ldy on 2016/11/4.
 */
@Controller
@RequestMapping(value = "safe")
public class SafeController extends BaseController {
    private Log log = LogFactory.getLog(SafeController.class);

    @RequestMapping(value = "safe")
    public String safe(HttpServletRequest request) {
        log.info("safe-safe invoked");
        return "safe/safe";
    }

}

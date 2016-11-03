package com.yc.wap.written;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Nozomi on 11/3/2016.
 */
@Controller
@RequestMapping(value = "written")
public class WrittenController {
    private Log log = LogFactory.getLog(WrittenController.class);

    @RequestMapping(value = "")
    public String content() {
        log.info("WrittenController-content invoked");
        return "written/content";
    }

}

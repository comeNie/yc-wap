package com.yc.wap.order;

import com.yc.wap.system.base.BaseController;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Nozomi on 11/10/2016.
 */
@Controller
@RequestMapping(value = "order")
public class OrderController extends BaseController{
    private Log log = LogFactory.getLog(OrderController.class);

    @RequestMapping(value = "")
    public String order() {
        return "order/order";
    }

    @RequestMapping(value = "OrderDetail")
    public String OrderDetail() {
        return "order/orderdetail";
    }

    @RequestMapping(value = "OrderError")
    public String OrderError() {
        return "order/ordererror";
    }

    @RequestMapping(value = "OrderTrack")
    public String OrderTrack() {
        return "order/ordertrack";
    }
}

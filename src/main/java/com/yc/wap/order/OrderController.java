package com.yc.wap.order;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.exception.SystemException;
import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.order.api.orderclose.interfaces.IOrderCancelSV;
import com.ai.yc.order.api.orderclose.param.OrderCancelRequest;
import com.ai.yc.order.api.orderdetails.interfaces.IQueryOrderDetailsSV;
import com.ai.yc.order.api.orderdetails.param.*;
import com.ai.yc.order.api.orderquery.interfaces.IOrderQuerySV;
import com.ai.yc.order.api.orderquery.param.OrdOrderVo;
import com.ai.yc.order.api.orderquery.param.QueryOrderRequest;
import com.ai.yc.order.api.orderquery.param.QueryOrderRsponse;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.constants.Constants;
import com.yc.wap.system.constants.ConstantsResultCode;
import net.sf.json.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Created by Nozomi on 11/10/2016.
 */
@Controller
@RequestMapping(value = "order")
public class OrderController extends BaseController {
    private Log log = LogFactory.getLog(OrderController.class);

    private IOrderQuerySV iOrderQuerySV = DubboConsumerFactory.getService(IOrderQuerySV.class);
    private IQueryOrderDetailsSV iQueryOrderDetailsSV = DubboConsumerFactory.getService(IQueryOrderDetailsSV.class);
    private IOrderCancelSV iOrderCancelSV = DubboConsumerFactory.getService(IOrderCancelSV.class);

    @RequestMapping(value = "")
    public String order() {
        String isUnPaid = request.getParameter("UnPaid");
        String isUnConfirm = request.getParameter("UnConfirm");

        return "order/order";
    }

    @RequestMapping(value = "GetOrderShowNumber")
    @ResponseBody
    public Object GetOrderShowNumber() {
        MsgBean result = new MsgBean();
        QueryOrderRequest reqUnPaid = new QueryOrderRequest();
        QueryOrderRequest reqUnConfirm = new QueryOrderRequest();
        reqUnPaid.setPageNo(1);
        reqUnPaid.setPageSize(1);
        reqUnPaid.setUserId((String) session.getAttribute("UID"));
        reqUnPaid.setDisplayFlag(Constants.Order.UNPAID);
        reqUnConfirm.setPageNo(1);
        reqUnConfirm.setPageSize(1);
        reqUnConfirm.setUserId((String) session.getAttribute("UID"));
        reqUnConfirm.setDisplayFlag(Constants.Order.UNCONFIRM);
        log.info("GetOrderShowNumber1Params: " + com.alibaba.fastjson.JSONArray.toJSONString(reqUnPaid));
        log.info("GetOrderShowNumber2params: " + com.alibaba.fastjson.JSONArray.toJSONString(reqUnConfirm));
        try {
            QueryOrderRsponse respUnPaid = iOrderQuerySV.queryOrder(reqUnPaid);
            QueryOrderRsponse respUnConfirm = iOrderQuerySV.queryOrder(reqUnConfirm);
            PageInfo<OrdOrderVo> orderUnPaid = respUnPaid.getPageInfo();
            PageInfo<OrdOrderVo> orderUnConfirm = respUnConfirm.getPageInfo();
            log.info("GetOrderShowNumber1Return: " + com.alibaba.fastjson.JSONArray.toJSONString(orderUnPaid));
            log.info("GetOrderShowNumber2Return: " + com.alibaba.fastjson.JSONArray.toJSONString(orderUnConfirm));
            int UnPaid = orderUnPaid.getCount();
            int UnConfirm = orderUnConfirm.getCount();
            result.put("unpaid", UnPaid);
            result.put("unconfirm", UnConfirm);
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("GetAllOrderFailed");
        }
        return result.returnMsg();
    }

    @RequestMapping(value = "GetOrder")
    @ResponseBody
    public Object GetOrder() {
        MsgBean result = new MsgBean();
        int Page = Integer.parseInt(request.getParameter("Page"));
        QueryOrderRequest req = new QueryOrderRequest();
        req.setPageNo(Page);
        req.setPageSize(4);
        req.setUserId((String) session.getAttribute("UID"));
        log.info("GetOrderParams: " + com.alibaba.fastjson.JSONArray.toJSONString(req));
        try {
            QueryOrderRsponse resp = iOrderQuerySV.queryOrder(req);
            PageInfo<OrdOrderVo> order = resp.getPageInfo();
            log.info("GetOrderReturn: " + com.alibaba.fastjson.JSONArray.toJSONString(order));
            int Count = order.getCount();
            int PageCount = order.getPageCount();
            int PageNo = order.getPageNo();
            List<OrdOrderVo> OrderList = order.getResult();
            result.put("Count", Count);
            result.put("PageCount", PageCount);
            result.put("PageNo", PageNo);
            result.put("OrderList", OrderList);
            return result.returnMsg();
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("GetAllOrderFailed");
        }
    }

    @RequestMapping(value = "OrderCancel")
    @ResponseBody
    public Object OrderCancel() {
        MsgBean result = new MsgBean();
        String OrderId = request.getParameter("OrderId");
        String reasonDesc = "Wap取消订单";
        String operId = (String) session.getAttribute("UID");

        OrderCancelRequest req = new OrderCancelRequest();
        req.setOperId(operId);
        req.setReasonDesc(reasonDesc);
        req.setOrderId(Long.parseLong(OrderId));
        log.info("OrderCancelParams: " + com.alibaba.fastjson.JSONArray.toJSONString(req));
        try {
            BaseResponse resp = iOrderCancelSV.handCancelNoPayOrder(req);
            if (resp.getResponseHeader().getResultCode().equals(ConstantsResultCode.SUCCESS)) {
                log.info("OrderCancelSuccess");
                return result.returnMsg();
            } else {
                throw new RuntimeException("OrderCancelFailed");
            }
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("OrderCancelFailed");
        }
    }

    @RequestMapping(value = "OrderConfirm")
    @ResponseBody
    public Object OrderConfirm() {
        MsgBean result = new MsgBean();

        return result.returnMsg();
    }

    @RequestMapping(value = "OrderDetail")
    public String OrderDetail() {
        String OrderId = request.getParameter("OrderId");
        try {
            log.info("QueryOrderDetailsOrderId: " + OrderId);
            QueryOrderDetailsResponse resp = iQueryOrderDetailsSV.queryOrderDetails(Long.parseLong(OrderId));
            log.info("QueryOrderDetailsReturn: " + com.alibaba.fastjson.JSONArray.toJSONString(resp));

            ProdVo ProdList = resp.getProd();
            OrderFeeVo OrderFee = resp.getOrderFee();
            ProdExtendVo prodExtends = resp.getProdExtends().get(0);
            ProdLevelVo prodLevels = resp.getProdLevels().get(0);
            ContactsVo Contacts = resp.getContacts();

            Timestamp Time = resp.getOrderTime();
            DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

            String OrderPrice = OrderFee.getTotalFee() / 1000 + "";
            DecimalFormat df = new DecimalFormat("######0.00");

            String TransLV = prodLevels.getTranslateLevel();
            String TranslateLevel = "其他";
            if (TransLV.equals(Constants.TranslateLevel.Normal)) {
                TranslateLevel = "标准级";
            } else if (TransLV.equals(Constants.TranslateLevel.Professional)) {
                TranslateLevel = "专业级";
            } else if (TransLV.equals(Constants.TranslateLevel.Publish)) {
                TranslateLevel = "出版级";
            }

            String discountSum = OrderFee.getDiscountSum();
            if (discountSum == null || discountSum.equals("")) {
                discountSum = "";
            } else {
                discountSum = discountSum + "折";
            }

            List<OrderStateChgVo> orderStateChange = resp.getOrderStateChgs();
            for(OrderStateChgVo Vo : orderStateChange) {
                log.info("Vo: " + Vo.getChgDesc());
            }

            String translateType = resp.getTranslateType();
            String translateName = resp.getTranslateName();
            String displayFlag  = resp.getDisplayFlag();

            String PriceDisplay = df.format(Double.parseDouble(OrderPrice));
            String OrderTime = sdf.format(Time);
            String TransLang = prodExtends.getLangungePairName();
            String useCn = ProdList.getUseCn();
            String fieldCn = ProdList.getFieldCn();
            String takeTime = ProdList.getTakeTime();
            String Remark = resp.getRemark();
            String isUrgent = ProdList.getIsUrgent();
            String contactName = Contacts.getContactName();
            String contactTel = Contacts.getContactTel();
            String contactEmail = Contacts.getContactEmail();

            String needTranslateInfo = ProdList.getNeedTranslateInfo();
            String translateInfo = ProdList.getTranslateInfo();

            JSONObject ParamJson = new JSONObject();
            ParamJson.put("translateType", translateType);
            ParamJson.put("translateName", translateName);
            ParamJson.put("displayFlag", displayFlag);

            ParamJson.put("OrderId", OrderId);
            ParamJson.put("PriceDisplay", PriceDisplay);
            ParamJson.put("OrderTime", OrderTime);
            ParamJson.put("TransLang", TransLang);
            ParamJson.put("TranslateLevel", TranslateLevel);
            ParamJson.put("useCn", useCn);
            ParamJson.put("fieldCn", fieldCn);
            ParamJson.put("takeTime", takeTime);
            ParamJson.put("Remark", Remark);
            ParamJson.put("discountSum", discountSum);
            ParamJson.put("contactName", contactName);
            ParamJson.put("contactTel", contactTel);
            ParamJson.put("contactEmail", contactEmail);
            ParamJson.put("orderStateChange", orderStateChange);

            ParamJson.put("needTranslateInfo", needTranslateInfo);
            ParamJson.put("translateInfo", translateInfo);
            if (isUrgent.equals("Y")) {
                ParamJson.put("Urgent", "加急");
            }

            log.info("OrderDetailParamJson.." + ParamJson.toString());

            request.setAttribute("Params", ParamJson);
        } catch (BusinessException | SystemException | NumberFormatException e) {
            e.printStackTrace();
        }
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

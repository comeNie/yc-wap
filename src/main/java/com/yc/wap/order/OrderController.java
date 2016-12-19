package com.yc.wap.order;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.exception.SystemException;
import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.sdk.components.dss.DSSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.paas.ipaas.dss.base.interfaces.IDSSClient;
import com.ai.paas.ipaas.i18n.ZoneContextHolder;
import com.ai.yc.order.api.orderclose.interfaces.IOrderCancelSV;
import com.ai.yc.order.api.orderclose.param.OrderCancelRequest;
import com.ai.yc.order.api.orderdetails.interfaces.IQueryOrderDetailsSV;
import com.ai.yc.order.api.orderdetails.param.*;
import com.ai.yc.order.api.orderquery.interfaces.IOrderQuerySV;
import com.ai.yc.order.api.orderquery.param.OrdOrderVo;
import com.ai.yc.order.api.orderquery.param.QueryOrderRequest;
import com.ai.yc.order.api.orderquery.param.QueryOrderRsponse;
import com.ai.yc.order.api.orderstate.interfaces.IOrderStateUpdateSV;
import com.ai.yc.order.api.orderstate.param.OrderStateUpdateRequest;
import com.ai.yc.order.api.orderstate.param.OrderStateUpdateResponse;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.constants.Constants;
import com.yc.wap.system.constants.ConstantsResultCode;
import com.yc.wap.system.utils.MapSortUtil;
import net.sf.json.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

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
    private IOrderStateUpdateSV iOrderStateUpdateSV = DubboConsumerFactory.getService(IOrderStateUpdateSV.class);

    @RequestMapping(value = "")
    public String order() {
        String isUnPaid = request.getParameter("UnPaid");
        String isUnConfirm = request.getParameter("UnConfirm");
        String isLogin = (String) session.getAttribute("isLogin");
        if (isLogin == null || isLogin.equals("") || isLogin.equals("0")) {
            log.info("UserNotLogin");
            request.setAttribute("to", "login");
            return "login/login";
        }
        request.setAttribute("isUnPaid", isUnPaid);
        request.setAttribute("isUnConfirm", isUnConfirm);
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
        String isUnPaid = request.getParameter("isUnPaid");
        String isUnConfirm = request.getParameter("isUnConfirm");

        int Page = Integer.parseInt(request.getParameter("Page"));
        QueryOrderRequest req = new QueryOrderRequest();
        req.setPageNo(Page);
        req.setPageSize(4);
        req.setUserId((String) session.getAttribute("UID"));
        if (isUnPaid.equals("1")) {
            req.setDisplayFlag(Constants.Order.UNPAID);
        }
        if (isUnConfirm.equals("1")) {
            req.setDisplayFlag(Constants.Order.UNCONFIRM);
        }
        log.info("GetOrderParams: " + com.alibaba.fastjson.JSONArray.toJSONString(req));
        try {
            QueryOrderRsponse resp = iOrderQuerySV.queryOrder(req);
            PageInfo<OrdOrderVo> order = resp.getPageInfo();
            log.info("GetOrderReturn: " + com.alibaba.fastjson.JSONArray.toJSONString(order));

            List<OrdOrderVo> OrderList = order.getResult();
//            DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//            TimeZone tz = TimeZone.getTimeZone(ZoneContextHolder.getZone());
//            sdf.setTimeZone(tz);
//            if (OrderList != null) {
//                for (OrdOrderVo k : OrderList) {
//                    Timestamp OrderTime = k.getOrderTime();
//                    String Time = sdf.format(OrderTime);
//                    log.info(Time);
//                    k.setOrderTime(Timestamp.valueOf(Time));
//                }
//            }

            int Count = order.getCount();
            int PageCount = order.getPageCount();
            int PageNo = order.getPageNo();

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
        String OrderId = request.getParameter("OrderId");
        OrderStateUpdateRequest req = new OrderStateUpdateRequest();
        req.setOrderId(Long.parseLong(OrderId));
        req.setDisplayFlag(Constants.Order.FINISH);
        req.setState(Constants.Order.FINISH);

        try {
            OrderStateUpdateResponse resp = iOrderStateUpdateSV.updateState(req);
            if (resp.getResponseHeader().getResultCode().equals(ConstantsResultCode.SUCCESS)) {
                return result.returnMsg();
            } else {
                throw new RuntimeException("OrderConfirmFailed: " + resp.getResponseHeader().getResultMessage());
            }
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("OrderConfirmFailed");
        }
    }

    @RequestMapping(value = "OrderDetail")
    public String OrderDetail() {
        String OrderId = request.getParameter("OrderId");
        String isLogin = (String) session.getAttribute("isLogin");
        String FromRes = request.getParameter("FromRes");
        if (isLogin == null || isLogin.equals("") || isLogin.equals("0")) {
            log.info("UserNotLogin");
            request.setAttribute("to", "login");
            return "login/login";
        }
        QueryOrderDetailsRequest req = new QueryOrderDetailsRequest();
        req.setChgStateFlag("0");
        req.setOrderId(Long.parseLong(OrderId));
        try {
            log.info("QueryOrderDetailsOrderId: " + OrderId);
            QueryOrderDetailsResponse resp = iQueryOrderDetailsSV.queryOrderDetails(req);
            if (!resp.getResponseHeader().getResultCode().equals(ConstantsResultCode.SUCCESS)) {
                log.info("QueryOrderDetailsFailed: " + com.alibaba.fastjson.JSONArray.toJSONString(resp.getResponseHeader().getResultMessage()));
                throw new BusinessException("QueryOrderDetailsFailed");
            }
            log.info("QueryOrderDetailsReturn: " + com.alibaba.fastjson.JSONArray.toJSONString(resp));


            ///// Information Get /////
            ProdVo ProdList = resp.getProd();
            OrderFeeVo OrderFee = resp.getOrderFee();
            List<ProdExtendVo> prodExtends = resp.getProdExtends();
            List<ProdLevelVo> prodLevels = resp.getProdLevels();
            ContactsVo Contacts = resp.getContacts();

            ///// Time & TimeZone /////
            Timestamp Time = resp.getOrderTime();
            Timestamp sTime = ProdList.getStateTime();
            Timestamp eTime = ProdList.getEndTime();
            DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            TimeZone tz = TimeZone.getTimeZone(ZoneContextHolder.getZone());
            sdf.setTimeZone(tz);

            ///// Level & TranslateType /////
            for (ProdLevelVo k : prodLevels) {
                String TransLV = k.getTranslateLevel();
                String TranslateLevel = "其他";
                if (TransLV.equals(Constants.TranslateLevel.Normal)) {
                    TranslateLevel = "标准级";
                } else if (TransLV.equals(Constants.TranslateLevel.Professional)) {
                    TranslateLevel = "专业级";
                } else if (TransLV.equals(Constants.TranslateLevel.Publish)) {
                    TranslateLevel = "出版级";
                } else if (TransLV.equals(Constants.TranslateLevel.Together)) {
                    TranslateLevel = "陪同翻译";
                } else if (TransLV.equals(Constants.TranslateLevel.Simulate)) {
                    TranslateLevel = "同声传译";
                } else if (TransLV.equals(Constants.TranslateLevel.Alter)) {
                    TranslateLevel = "交替翻译";
                }
                k.setTranslateLevel(TranslateLevel);
            }

            ///// Sex /////
            String interperGen = ProdList.getInterperGen();
            String Sex = "";
            if (interperGen != null) {
                if (interperGen.equals(Constants.Sex.MALE)) {
                    Sex = "男";
                } else if (interperGen.equals(Constants.Sex.FEMALE)) {
                    Sex = "女";
                } else if (interperGen.equals(Constants.Sex.ALL)) {
                    Sex = "不限";
                }
            }

            ///// Discount /////
            String discountSum = OrderFee.getDiscountSum();
            if (discountSum == null || discountSum.equals("")) {
                discountSum = "";
            } else {
                discountSum = discountSum + "折";
            }

            ///// OrderPrice /////
            Double OrderPrice = Double.valueOf(OrderFee.getTotalFee()) / 1000;
            DecimalFormat df = new DecimalFormat("######0.00");
            String displayFlag = resp.getDisplayFlag();
            String PriceDisplay = "请等待报价";
            if (!displayFlag.equals("13")) {
                PriceDisplay = df.format(OrderPrice) + "元";
            }

            ///// OrderStateTrack /////
            // get
            List<OrderStateChgVo> orderStateChange = resp.getOrderStateChgs();
            // put
            Map<String, String> _OrderTrackCn = new HashMap<String, String>();
            Map<String, String> _OrderTrackEn = new HashMap<String, String>();
            for (OrderStateChgVo k : orderStateChange) {
                Timestamp ts = k.getStateChgTime();
                String ChangeTime = sdf.format(ts);
                _OrderTrackCn.put(ChangeTime, k.getChgDescD());
                _OrderTrackEn.put(ChangeTime, k.getChgDescUEn());
            }
            // sort
            Map<String, String> OrderTrackCn = MapSortUtil.sortMapByKey(_OrderTrackCn);
            Map<String, String> OrderTrackEn = MapSortUtil.sortMapByKey(_OrderTrackEn);

            ///// Files /////
            String translateName = resp.getTranslateName();
            List<String> needTranslateFiles = new ArrayList<String>();
            if (resp.getTranslateType().equals(Constants.OrderType.DOC)) {
                List<ProdFileVo> ProdFiles = resp.getProdFiles();
                translateName = ProdFiles.get(0).getFileName();
//                needTranslateFiles.addAll(ProdFiles.stream().map(ProdFileVo::getFileName).collect(Collectors.toList()));
                for (ProdFileVo k : ProdFiles) {
                    needTranslateFiles.add(k.getFileName());
                }
            }

            ///// Normal Data /////
            String translateType = resp.getTranslateType();
            String OrderTime = sdf.format(Time);
            String useCn = ProdList.getUseCn();
            String fieldCn = ProdList.getFieldCn();
            String takeTime = ProdList.getTakeTime();
            String Remark = Contacts.getRemark();
            String isUrgent = ProdList.getIsUrgent();
            String contactName = Contacts.getContactName();
            String contactTel = Contacts.getContactTel();
            String contactEmail = Contacts.getContactEmail();
            String needTranslateInfo = ProdList.getNeedTranslateInfo();
            String translateInfo = ProdList.getTranslateInfo();
            String meetingAddress = ProdList.getMeetingAddress();
            Long meetingSum = ProdList.getMeetingSum();
            Long interperSum = ProdList.getInterperSum();

            ///// Params Put /////
            JSONObject ParamJson = new JSONObject();
            ParamJson.put("interperGen", Sex);
            ParamJson.put("meetingAddress", meetingAddress);
            ParamJson.put("meetingSum", meetingSum);
            ParamJson.put("interperSum", interperSum);
            if (sTime != null && eTime != null) {
                ParamJson.put("stateTime", sdf.format(sTime));
                ParamJson.put("endTime", sdf.format(eTime));
            }

            ParamJson.put("translateType", translateType);
            ParamJson.put("translateName", translateName);
            ParamJson.put("needTranslateFiles", needTranslateFiles);
            ParamJson.put("displayFlag", displayFlag);

            ParamJson.put("OrderId", OrderId);
            ParamJson.put("PriceDisplay", PriceDisplay);
            ParamJson.put("OrderPrice", OrderPrice);
            ParamJson.put("OrderTime", OrderTime);
            ParamJson.put("TransLang", prodExtends);
            ParamJson.put("TranslateLevel", prodLevels);
            ParamJson.put("useCn", useCn);
            ParamJson.put("fieldCn", fieldCn);
            ParamJson.put("takeTime", takeTime);
            ParamJson.put("Remark", Remark);
            ParamJson.put("discountSum", discountSum);
            ParamJson.put("contactName", contactName);
            ParamJson.put("contactTel", contactTel);
            ParamJson.put("contactEmail", contactEmail);

            ParamJson.put("needTranslateInfo", needTranslateInfo);
            ParamJson.put("translateInfo", translateInfo);
            if (isUrgent != null && isUrgent.equals("Y")) {
                ParamJson.put("Urgent", "加急");
            }

            log.info("OrderDetailParamJson.." + ParamJson.toString());
            if (OrderTrackCn != null && OrderTrackEn != null) {
                log.info("OrderStateChangeCn.." + OrderTrackCn.toString());
                log.info("OrderStateChangeEn.." + OrderTrackEn.toString());
            } else {
                log.info("OrderStateChangeIsNull");
            }

            request.setAttribute("Params", ParamJson);
            request.setAttribute("OrderTrackCn", OrderTrackCn);
            request.setAttribute("OrderTrackEn", OrderTrackEn);
            request.setAttribute("FromRes", FromRes);
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

    @RequestMapping(value = "OrderText")
    public String OrderText() {
        return "order/ordertext";
    }

    /**
     * 下载文件
     *
     * @param fileId
     * @param fileName
     * @param response
     * @author mimw
     */
    @RequestMapping("/download")
    public void download(String fileId, String fileName, HttpServletResponse response) {
        IDSSClient client = DSSClientFactory.getDSSClient("order-file-dss");
        byte[] b = client.read(fileId);
        try {
            OutputStream os = response.getOutputStream();
            response.setCharacterEncoding("utf-8");
            response.setContentType("multipart/form-data");
            response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
            response.setHeader("Content-Length", b.length + "");
            os.write(b);
            os.close();
        } catch (Exception e) {
            log.info("下载文件异常：", e);
        }
    }
}

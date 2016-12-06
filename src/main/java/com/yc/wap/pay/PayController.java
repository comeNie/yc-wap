package com.yc.wap.pay;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.exception.SystemException;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.slp.balance.api.deduct.interfaces.IDeductSV;
import com.ai.slp.balance.api.deduct.param.DeductParam;
import com.ai.slp.balance.api.deduct.param.DeductResponse;
import com.ai.slp.balance.api.deposit.interfaces.IDepositSV;
import com.ai.slp.balance.api.deposit.param.DepositParam;
import com.ai.slp.balance.api.deposit.param.TransSummary;
import com.ai.yc.order.api.orderpay.interfaces.IOrderPayProcessedResultSV;
import com.ai.yc.order.api.orderpay.param.*;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCUserInfoResponse;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.constants.Constants;
import com.yc.wap.system.constants.ConstantsResultCode;
import com.yc.wap.system.utils.ConfigUtil;
import com.yc.wap.system.utils.PaymentUtil;
import com.yc.wap.system.utils.VerifyUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Nozomi on 11/14/2016.
 */
@Controller
@RequestMapping(value = "pay")
public class PayController extends BaseController {
    private Log log = LogFactory.getLog(PayController.class);
    private IDepositSV iDepositSV = DubboConsumerFactory.getService(IDepositSV.class);
    private IYCUserServiceSV iycUserServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
    private IDeductSV iDeductSV = DubboConsumerFactory.getService(IDeductSV.class);
    private IOrderPayProcessedResultSV iOrderPayProcessedResultSV = DubboConsumerFactory.getService(IOrderPayProcessedResultSV.class);

    private String TENANTID = ConfigUtil.getProperty("TENANT_ID");

    //买家账号
    //hhmxwt9319@sandbox.com
    //登录密码
    //111111
    //支付密码
    //111111

    @RequestMapping(value = "/gotoPay")
    public void gotoPayByOrg(String orderId, String orderAmount, String currencyUnit, String merchantUrl, String payOrgCode,
                             HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        Enumeration<?> enumeration = session.getAttributeNames();
        log.info("-----Sessions-----");
        while (enumeration.hasMoreElements()) {
            String name = enumeration.nextElement().toString();
            Object value = session.getAttribute(name);
            log.info("SessionName: " + name + ", SessionValue: " + value);
        }
        log.info("-----Sessions-----");

        String notifyUrl = ConfigUtil.getProperty("NOTIFY_URL") + "?uid=" + session.getAttribute("UID");
        String returnUrl = ConfigUtil.getProperty("RETURN_URL") + "?uid=" + session.getAttribute("UID");

        String infoStr = orderId + VerifyUtil.SEPARATOR + orderAmount + VerifyUtil.SEPARATOR + notifyUrl + VerifyUtil.SEPARATOR + TENANTID;
        String infoMd5 = VerifyUtil.encodeParam(infoStr, ConfigUtil.getProperty("REQUEST_KEY"));

        Map<String, String> map = new HashMap<String, String>();
        map.put("tenantId", TENANTID);
        map.put("orderId", orderId);
        map.put("returnUrl", returnUrl);
        map.put("notifyUrl", notifyUrl);
        map.put("merchantUrl", merchantUrl);
        map.put("requestSource", "2");
        map.put("orderAmount", orderAmount);
        map.put("currencyUnit", currencyUnit);
        map.put("subject", orderId); //订单名字
        map.put("payOrgCode", payOrgCode);
        map.put("infoMd5", infoMd5);

        log.info("PaymentParams: " + map);
        String htmlStr = PaymentUtil.generateAutoSubmitForm(ConfigUtil.getProperty("ACTION_URL"), map);
        log.info("SendPayment: " + htmlStr);

        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write(htmlStr);
        response.getWriter().flush();
    }

    @RequestMapping(value = "payResult")
    public void payResult(String uid) throws ParseException {
        log.info("PayResult-NOTIFY_URL-Callback");
        String orderId = request.getParameter("orderId");
        String payStates = request.getParameter("payStates");
        String orderAmount = request.getParameter("orderAmount");
        String payOrgCode = request.getParameter("payOrgCode");
        String outOrderId = request.getParameter("outOrderId");
        String notifyTime = request.getParameter("notifyTime");

        Double _Amount = Double.valueOf(orderAmount) * 1000;

        log.info("-----PayResult-----");
        log.info("orderId: " + orderId);
        log.info("payStates: " + payStates);
        log.info("orderAmount: " + orderAmount);
        log.info("payOrgCode: " + payOrgCode);
        log.info("outOrderId: " + outOrderId);
        log.info("notifyTime: " + notifyTime);
        log.info("uid: " + uid);
        log.info("-----PayResult-----");

        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddhhmmss");
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Timestamp ts = Timestamp.valueOf(sdf2.format(sdf1.parse(notifyTime)));

        if (payStates.equals("00")) {
            String orderIndex = orderId.substring(0, 3);
            if (orderIndex.equals("901")) {
                BalanceRecharge(orderId, orderAmount, payOrgCode, uid);
            } else {
                OrderPayFinished(orderId, payOrgCode, _Amount.longValue(), outOrderId, ts, uid);
            }
        }
    }

    @RequestMapping(value = "payResultView")
    public String payResultView(String uid) {
        log.info("PayResult-RETURN_URL-Callback");
        String orderId = request.getParameter("orderId");
        String payStates = request.getParameter("payStates");

        log.info("-----PayResult-----");
        log.info("orderId: " + orderId + ", payStates: " + payStates + ", uid: " + uid);
        log.info("-----PayResult-----");

        if (payStates.equals("00")) {
            request.setAttribute("result", "success");
        } else if (payStates.equals("01")) {
            request.setAttribute("result", "fail");
        }
        request.setAttribute("OrderId", orderId);
        return "written/payresult";
    }

    private boolean BalanceRecharge(String orderId, String Amount, String payOrgCode, String uid) {
        Double _Amount = Double.valueOf(Amount) * 1000;

        SearchYCUserRequest req = new SearchYCUserRequest();
        req.setUserId(uid);
        YCUserInfoResponse resp = iycUserServiceSV.searchYCUserInfo(req);
        Long AccountId = resp.getAccountId();

        log.info("----------BalanceRecharge----------");
        log.info("UID: " + uid);
        log.info("AccountId: " + AccountId);
        log.info("OrderId: " + orderId);
        log.info("Amount: " + _Amount.longValue());
        log.info("PayOrgCode: " + payOrgCode);
        log.info("----------BalanceRecharge----------");

        TransSummary summary = new TransSummary();
        summary.setAmount(_Amount.longValue());
        summary.setSubjectId(100000);

        List<TransSummary> transSummaryList = new ArrayList<TransSummary>();
        transSummaryList.add(summary);

        DepositParam param = new DepositParam();
        param.setAccountId(AccountId);
        param.setBusiDesc("余额");
        param.setBusiSerialNo(orderId);
        param.setTransSummary(transSummaryList);
        param.setCurrencyUnit("RMB");
        param.setBusiOperCode(Constants.BusinessOperCode);
        param.setTenantId(Constants.TENANTID);
        param.setSystemId(Constants.SystemId);

        if (payOrgCode.equals("ZFB")) {
            param.setPayStyle(Constants.PayType.ZFB);
        } else if (payOrgCode.equals("YL")) {
            param.setPayStyle(Constants.PayType.YL);
        }

        log.info("BalanceRechargeParam: " + com.alibaba.fastjson.JSONArray.toJSONString(param));
        try {
            String serialCode = iDepositSV.depositFund(param);
            log.info("BalanceRecharge SerialCode: " + serialCode);
            return true;
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("BalanceRechargeFail");
        }
    }

    @RequestMapping(value = "OrderPay")
    public String OrderPay() {
        log.info("-----pay-OrderPay-----");
        String OrderId = request.getParameter("OrderId");
        String Amount = request.getParameter("OrderAmount");
        log.info("OrderId: " + OrderId + ", Amount: " + Amount);

        request.setAttribute("OrderId", OrderId);
        request.setAttribute("PriceDisplay", Amount);
        return "written/payment";
    }

    @RequestMapping(value = "BalancePayment")
    public String BalancePayment() {
        String OrderId = request.getParameter("orderId");
        String Amount = request.getParameter("orderAmount");
        Double _Amount = Double.valueOf(Amount) * 1000;

        log.info("-----BalancePayment-----");
        log.info("OrderId: " + OrderId + ", Amount: " + Amount);

        String UID = (String) session.getAttribute("UID");

        SearchYCUserRequest req = new SearchYCUserRequest();
        req.setUserId(UID);
        YCUserInfoResponse resp = iycUserServiceSV.searchYCUserInfo(req);
        Long AccountId = resp.getAccountId();

        com.ai.slp.balance.api.deduct.param.TransSummary Summary = new com.ai.slp.balance.api.deduct.param.TransSummary();
        Summary.setSubjectId(Constants.SubjectID);
        List<com.ai.slp.balance.api.deduct.param.TransSummary> TransSummary = new ArrayList<com.ai.slp.balance.api.deduct.param.TransSummary>();
        TransSummary.add(Summary);

        DeductParam Param = new DeductParam();
        Param.setTenantId(TENANTID);
        Param.setSystemId(Constants.SystemId);
        Param.setExternalId(OrderId);
        Param.setBusinessCode(Constants.BusinessCode);
        Param.setAccountId(AccountId);
        Param.setCheckPwd(0);
        Param.setTotalAmount(_Amount.longValue());
        Param.setCurrencyUnit("1"); //1-RMB 2-USD
        Param.setChannel(Constants.COMPANY);
        Param.setTransSummary(TransSummary);

        log.info("BalancePaymentParam: " + com.alibaba.fastjson.JSONArray.toJSONString(Param));
        try {
            DeductResponse response = iDeductSV.deductFund(Param);
            if (response.getResponseHeader().getResultCode().equals(ConstantsResultCode.FUNDSUCCESS1)) {
                String serialNo = response.getSerialNo();
                log.info("BalancePaySuccess: " + serialNo);

                Timestamp ts = new Timestamp(new Date().getTime());
                OrderPayFinished(OrderId, "YE", _Amount.longValue(), serialNo, ts, UID);
                request.setAttribute("result", "success");
            } else {
                log.info("BalancePayFail: " + response.getResponseHeader().getResultCode() + response.getResponseHeader().getResultMessage());
                request.setAttribute("result", "fail");
            }
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("BalancePaymentFail");
        }
        request.setAttribute("OrderId", OrderId);
        return "written/payresult";
    }

    private boolean OrderPayFinished(String OrderId, String PayType, long Amount, String outOrderId, Timestamp FinishTime, String uid) {
        SearchYCUserRequest request = new SearchYCUserRequest();
        request.setUserId(uid);
        YCUserInfoResponse response = iycUserServiceSV.searchYCUserInfo(request);
        Long AccountId = response.getAccountId();

        OrderPayProcessedResultRequest req = new OrderPayProcessedResultRequest();
        OrderPayProcessedResultBaseInfo BaseInfo = new OrderPayProcessedResultBaseInfo();
        OrderPayProcessedResultFeeInfo FeeInfo = new OrderPayProcessedResultFeeInfo();
        OrderPayProcessedResultProdInfo ProdInfo = new OrderPayProcessedResultProdInfo();

        BaseInfo.setOrderId(Long.parseLong(OrderId));
        BaseInfo.setOrderType(Constants.OrderType2.PERSIONAL);
        BaseInfo.setUserType(Constants.UserType.PERSON);
        BaseInfo.setUserId(uid);
        BaseInfo.setAccountId(AccountId);
        BaseInfo.setState(Constants.Order.UNRECEIVE);
        BaseInfo.setDisplayFlag(Constants.Order.TRANSING);

        FeeInfo.setPayStyle(PayType);
        FeeInfo.setTotalFee(Amount);
        FeeInfo.setAdjustFee(Amount);
        FeeInfo.setPaidFee(Amount);
        FeeInfo.setPayTime(FinishTime);
        FeeInfo.setExternalId(outOrderId);

        ProdInfo.setStateTime(FinishTime);

        req.setBaseInfo(BaseInfo);
        req.setFeeInfo(FeeInfo);
        req.setProdInfo(ProdInfo);

        log.info("OrderPayFinishedProcessedParams: " + com.alibaba.fastjson.JSONArray.toJSONString(req));
        try {
            OrderPayProcessedResultResponse resp = iOrderPayProcessedResultSV.orderPayProcessedResult(req);
            if (resp.getResponseHeader().getResultCode().equals(ConstantsResultCode.SUCCESS)) {
                log.info("OrderPayFinishedProcessedSuccess: " + resp.getOrderId() + resp.getResponseHeader().getResultMessage());
                return true;
            } else {
                log.info("OrderPayFinishedProcessedFail: " + resp.getResponseHeader().getResultCode() + resp.getResponseHeader().getResultMessage());
                throw new RuntimeException("OrderPayFinishedProcessedFail");
            }
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("OrderPayFinishedProcessedFail");
        }
    }
}

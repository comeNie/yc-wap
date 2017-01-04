package com.yc.wap.written;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.exception.SystemException;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.common.api.sysdomain.interfaces.IQuerySysDomainSV;
import com.ai.yc.common.api.sysdomain.param.QuerySysDomainListReq;
import com.ai.yc.common.api.sysdomain.param.QuerySysDomainListRes;
import com.ai.yc.common.api.sysdomain.param.SysDomainVo;
import com.ai.yc.common.api.sysduad.interfaces.IQuerySysDuadSV;
import com.ai.yc.common.api.sysduad.param.QuerySysDuadListReq;
import com.ai.yc.common.api.sysduad.param.QuerySysDuadListRes;
import com.ai.yc.common.api.sysduad.param.SysDuadVo;
import com.ai.yc.common.api.syspurpose.interfaces.IQuerySysPurposeSV;
import com.ai.yc.common.api.syspurpose.param.QuerySysPurposeListReq;
import com.ai.yc.common.api.syspurpose.param.QuerySysPurposeListRes;
import com.ai.yc.common.api.syspurpose.param.SysPurposeVo;
import com.ai.yc.order.api.autooffer.interfaces.IQueryAutoOfferSV;
import com.ai.yc.order.api.autooffer.param.QueryAutoOfferReq;
import com.ai.yc.order.api.autooffer.param.QueryAutoOfferRes;
import com.ai.yc.order.api.ordersubmission.interfaces.IOrderSubmissionSV;
import com.ai.yc.order.api.ordersubmission.param.*;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.constants.Constants;
import com.yc.wap.system.constants.ConstantsResultCode;
import com.yc.wap.system.utils.ListSortUtil;
import com.yc.wap.system.utils.MapSortUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.*;


/**
 * Created by Nozomi on 11/3/2016.
 */
@Controller
@RequestMapping(value = "written")
public class WrittenController extends BaseController {
    private Log log = LogFactory.getLog(WrittenController.class);

    private IQuerySysDuadSV iQuerySysDuadSV = DubboConsumerFactory.getService(IQuerySysDuadSV.class);
    private IQuerySysPurposeSV iQuerySysPurposeSV = DubboConsumerFactory.getService(IQuerySysPurposeSV.class);
    private IQuerySysDomainSV iQuerySysDomainSV = DubboConsumerFactory.getService(IQuerySysDomainSV.class);
    private IQueryAutoOfferSV iQueryAutoOfferSV = DubboConsumerFactory.getService(IQueryAutoOfferSV.class);
    private IOrderSubmissionSV iOrderSubmissionSV = DubboConsumerFactory.getService(IOrderSubmissionSV.class);

    @RequestMapping(value = "")
    public String content() {
        String Language = rb.getDefaultLocale().toString();

        List<SysDuadVo> DualList = GetDualList(Constants.OrderType.DOC, Language);
        List<SysPurposeVo> PurposeList = GetPurposeList(Language);
        List<SysDomainVo> DomainList = GetDomainList(Language);

        log.info("GetDualListReturn: " + com.alibaba.fastjson.JSONArray.toJSONString(DualList));
        log.info("GetPurposeListReturn: " + com.alibaba.fastjson.JSONArray.toJSONString(PurposeList));
        log.info("GetDomainListReturn: " + com.alibaba.fastjson.JSONArray.toJSONString(DomainList));

        ListSortUtil<SysDuadVo> sortList = new ListSortUtil<>();
        sortList.sort(DualList, "duadId", "asc");
        log.info("GetDualListReturnSorted: " + com.alibaba.fastjson.JSONArray.toJSONString(DualList));

        JSONArray DualArray = JSONArray.fromObject(DualList);
        Map<String, Map<String, String>> DualMap = new HashMap<String, Map<String, String>>();
        Map<String, Map<String, String>> DualMapEn = new HashMap<String, Map<String, String>>();
        Map<String, String> TargetMap = new HashMap<String, String>();

        String SourceFlag = "";
        for (Object k : DualArray) {
            JSONObject v = JSONObject.fromObject(k);
            String sourceCn = v.getString("sourceCn");
            String targetCn = v.getString("targetCn");
            String Id = v.getString("duadId");

            if (SourceFlag.equals(sourceCn)) {
                TargetMap.put(targetCn, Id);
            } else {
                if (!TargetMap.isEmpty()) {
                    DualMap.put(SourceFlag, MapSortUtil.sortMapByValue(TargetMap));
                    TargetMap.clear();
                }

                for (String key : DualMap.keySet()) {
                    if (sourceCn.equals(key)) {
                        TargetMap = DualMap.get(key);
                    }
                }

                SourceFlag = sourceCn;
                TargetMap.put(targetCn, Id);
            }
        }
        DualMap.put(SourceFlag, MapSortUtil.sortMapByValue(TargetMap));
        JSONObject DualJson = JSONObject.fromObject(DualMap);
        TargetMap.clear();
        SourceFlag = "";

        for (Object k : DualArray) {
            JSONObject v = JSONObject.fromObject(k);
            String sourceEn = v.getString("sourceEn");
            String targetEn = v.getString("targetEn");
            String Id = v.getString("duadId");

            if (SourceFlag.equals(sourceEn)) {
                TargetMap.put(targetEn, Id);
            } else {
                if (!TargetMap.isEmpty()) {
                    DualMapEn.put(SourceFlag, MapSortUtil.sortMapByValue(TargetMap));
                    TargetMap.clear();
                }

                for (String key : DualMapEn.keySet()) {
                    if (sourceEn.equals(key)) {
                        TargetMap = DualMapEn.get(key);
                    }
                }

                SourceFlag = sourceEn;
                TargetMap.put(targetEn, Id);
            }
        }
        DualMapEn.put(SourceFlag, MapSortUtil.sortMapByValue(TargetMap));
        JSONObject DualJsonEn = JSONObject.fromObject(DualMapEn);

        log.info("-------DualMap&JSON-------");
        log.info(DualJson);
        log.info(DualJsonEn);
        log.info("-------DualMap&JSON-------");

        JSONObject contentJson = JSONObject.fromObject(session.getAttribute("WrittenContextJSON"));
        log.info("savedContentJson: " + contentJson.toString());

        request.setAttribute("DualMap", DualMap);
        request.setAttribute("DualJson", DualJson);
        request.setAttribute("DualMapEn", DualMapEn);
        request.setAttribute("DualJsonEn", DualJsonEn);
        request.setAttribute("DualList", com.alibaba.fastjson.JSONArray.toJSONString(DualList));
        request.setAttribute("PurposeList", PurposeList);
        request.setAttribute("DomainList", DomainList);

        request.setAttribute("contentJson", contentJson);

        return "written/content";
    }

    private List<SysDuadVo> GetDualList(String OrderType, String Language) {
        try {
            QuerySysDuadListReq req = new QuerySysDuadListReq();
//            req.setLanguage(Language);
            req.setOrderType(OrderType);
            QuerySysDuadListRes resp = iQuerySysDuadSV.querySysDuadList(req);
            if (!resp.getResponseHeader().getResultCode().equals(ConstantsResultCode.SUCCESS)) {
                log.info("GetDualListFailed: " + resp.getResponseHeader().getResultMessage());
                throw new RuntimeException("GetDualListFailed");
            }
            return resp.getDuads();
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("GetDualListFailed");
        }
    }

    private List<SysPurposeVo> GetPurposeList(String Language) {
        try {
            QuerySysPurposeListReq req = new QuerySysPurposeListReq();
            req.setLanguage(Language);
            QuerySysPurposeListRes resp = iQuerySysPurposeSV.querySysPurposeList(req);
            if (!resp.getResponseHeader().getResultCode().equals(ConstantsResultCode.SUCCESS)) {
                log.info("GetPurposeListFailed: " + resp.getResponseHeader().getResultMessage());
                throw new RuntimeException("GetPurposeListFailed");
            }
            return resp.getPurposes();
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("GetPurposeListFailed");
        }
    }

    private List<SysDomainVo> GetDomainList(String Language) {
        try {
            QuerySysDomainListReq req = new QuerySysDomainListReq();
            req.setLanguage(Language);
            QuerySysDomainListRes resp = iQuerySysDomainSV.querySysDomainList(req);
            if (!resp.getResponseHeader().getResultCode().equals(ConstantsResultCode.SUCCESS)) {
                log.info("GetDomainListFailed: " + resp.getResponseHeader().getResultMessage());
                throw new RuntimeException("GetDomainListFailed");
            }
            return resp.getDomainVos();
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("GetDomainListFailed");
        }
    }

    @RequestMapping(value = "onSaveContent")
    @ResponseBody
    public Object onSaveContent() {
        MsgBean result = new MsgBean();
        String Content = request.getParameter("Content");
        String ContentLength = request.getParameter("ContentLength");
        String DualId = request.getParameter("DualId");
        String PurposeId = request.getParameter("PurposeId");
        String TransLvId = request.getParameter("TransLvId");
        String Express = request.getParameter("Express");
        String DomainId = request.getParameter("DomainId");

        String DualVal = request.getParameter("DualVal");
        String DualValEn = request.getParameter("DualValEn");
        String PurposeVal = request.getParameter("PurposeVal");
        String DomainVal = request.getParameter("DomainVal");
        String TransLvVal = request.getParameter("TransLvVal");
        String Detail = request.getParameter("Detail");
        boolean isExpress = false;
        if (Express.equals("Y")) {
            isExpress = true;
        }
        try {
            QueryAutoOfferReq req = new QueryAutoOfferReq();
            req.setWordNum(Integer.parseInt(ContentLength));
            req.setDuadId(DualId);
            req.setPurposeId(PurposeId);
            req.setTranslateLevel(TransLvId);
            req.setUrgent(isExpress);
            req.setLanguage(QueryAutoOfferReq.LANGUAGE_ZH_CN);
            log.info("AutoOfferPriceParams: " + com.alibaba.fastjson.JSONArray.toJSONString(req));
            QueryAutoOfferRes resp = iQueryAutoOfferSV.queryAutoOffer(req);
            if (resp.getResponseHeader().getResultCode().equals(ConstantsResultCode.SUCCESS)) {
                String Price = resp.getPrice().toString();
                String valuationWay = resp.getValuationWay();
                String currencyUnit = resp.getCurrencyUnit();
                log.info("AutoOfferPriceReturn: Price: " + Price + ", valuationWay: " + valuationWay + ", currencyUnit: " + currencyUnit);

                JSONObject WrittenContextJSON = new JSONObject();
                WrittenContextJSON.put("Content", Content);
                WrittenContextJSON.put("ContentLength", ContentLength);
                WrittenContextJSON.put("DualId", DualId);
                WrittenContextJSON.put("PurposeId", PurposeId);
                WrittenContextJSON.put("DomainId", DomainId);
                WrittenContextJSON.put("TransLvId", TransLvId);
                WrittenContextJSON.put("Express", Express);
                WrittenContextJSON.put("Price", Price);
                WrittenContextJSON.put("valuationWay", valuationWay);
                WrittenContextJSON.put("currencyUnit", currencyUnit);
                WrittenContextJSON.put("Detail", Detail);
                session.setAttribute("WrittenContextJSON", WrittenContextJSON);

                JSONObject WrittenShowJSON = new JSONObject();
                WrittenShowJSON.put("DualVal", DualVal);
                WrittenShowJSON.put("DualValEn", DualValEn);
                WrittenShowJSON.put("PurposeVal", PurposeVal);
                WrittenShowJSON.put("DomainVal", DomainVal);
                WrittenShowJSON.put("TransLvVal", TransLvVal);
                WrittenShowJSON.put("Detail", Detail);
                WrittenShowJSON.put("Price", Price);
                session.setAttribute("WrittenShowJSON", WrittenShowJSON);

                return result.returnMsg();
            } else {
                log.info("AutoOfferPriceFailed: " + resp.getResponseHeader().getResultCode());
                throw new RuntimeException("AutoOfferPriceFailed");
            }
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("AutoOfferPriceFailed");
        }
    }

    @RequestMapping(value = "onSaveToUrl")
    @ResponseBody
    public Object onSaveToUrl() {
        MsgBean result = new MsgBean();
        session.setAttribute("ToUrl", request.getParameter("ToUrl"));
        return result.returnMsg();
    }

    @RequestMapping(value = "onContentSubmit")
    public String onContentSubmit() {
        JSONObject WrittenShowJSON = JSONObject.fromObject(session.getAttribute("WrittenShowJSON"));

        String Price = WrittenShowJSON.getString("Price");
        DecimalFormat df = new DecimalFormat("######0.00");
        String PriceDisplay = "总价：" + df.format(Double.parseDouble(Price) / 1000) + "元";

        request.setAttribute("PurposeVal", WrittenShowJSON.get("PurposeVal"));
        request.setAttribute("DualVal", WrittenShowJSON.get("DualVal"));
        request.setAttribute("DomainVal", WrittenShowJSON.get("DomainVal"));
        request.setAttribute("TransLvVal", WrittenShowJSON.get("TransLvVal"));
        request.setAttribute("Detail", WrittenShowJSON.get("Detail"));
        request.setAttribute("Price", PriceDisplay);
        return "written/confirm";
    }

    @RequestMapping(value = "onConfirmSubmit")
    @ResponseBody
    public Object onConfirmSubmit() {
        MsgBean result = new MsgBean();
        String msg = request.getParameter("msg");
        JSONObject WrittenContextJSON = JSONObject.fromObject(session.getAttribute("WrittenContextJSON"));
        WrittenContextJSON.put("Message", msg);
        session.setAttribute("WrittenContextJSON", WrittenContextJSON);
        return result.returnMsg();
    }

    @RequestMapping(value = "newContact")
    public String newContact() {
        return "written/newcontact";
    }

    @RequestMapping(value = "onNewContactSubmit")
    @ResponseBody
    public Object onNewContactSubmit() {
        MsgBean result = new MsgBean();
        String Phone = request.getParameter("phone");
        String Name = request.getParameter("name");
        String Email = request.getParameter("email");
        int TimeZoneOffset = Integer.parseInt(request.getParameter("TimeZoneOffset"));
        String TimeZone = "";
        if (TimeZoneOffset > 0) {
            TimeZone = "GMT" + -TimeZoneOffset / 60;
        } else {
            TimeZone = "GMT+" + -TimeZoneOffset / 60;
        }

        JSONObject WrittenContextJSON = JSONObject.fromObject(session.getAttribute("WrittenContextJSON"));
        WrittenContextJSON.put("Phone", Phone);
        WrittenContextJSON.put("Name", Name);
        WrittenContextJSON.put("Email", Email);
        WrittenContextJSON.put("TimeZone", TimeZone);
        session.setAttribute("WrittenContextJSON", WrittenContextJSON);

        JSONObject WrittenShowJSON = JSONObject.fromObject(session.getAttribute("WrittenShowJSON"));

        String OrderId = OrderSubmit(WrittenContextJSON, WrittenShowJSON).toString();
        result.put("OrderId", OrderId);
        return result.returnMsg();
    }

    private Long OrderSubmit(JSONObject WrittenContextJSON, JSONObject WrittenShowJSON) {
        Timestamp Time = new Timestamp(System.currentTimeMillis());
        String UserId = (String) session.getAttribute("UID");

        LanguagePairInfo languagePairInfo = new LanguagePairInfo();
        languagePairInfo.setLanguagePairId(WrittenContextJSON.getString("DualId"));
        languagePairInfo.setLanguagePairName(WrittenShowJSON.getString("DualVal"));
        languagePairInfo.setLanguageNameEn(WrittenShowJSON.getString("DualValEn"));
        List<LanguagePairInfo> LanguagePair = new ArrayList<LanguagePairInfo>();
        LanguagePair.add(languagePairInfo);

        TranslateLevelInfo translateLevelInfo = new TranslateLevelInfo();
        translateLevelInfo.setTranslateLevel(WrittenContextJSON.getString("TransLvId"));
        List<TranslateLevelInfo> TranslateLevel = new ArrayList<TranslateLevelInfo>();
        TranslateLevel.add(translateLevelInfo);

        OrderSubmissionRequest req = new OrderSubmissionRequest();
        BaseInfo reqBaseInfo = new BaseInfo();
        reqBaseInfo.setFlag(Constants.OrderSubmission.INTERNAL);
        reqBaseInfo.setChlId(Constants.OrderSubmission.WAPCN);
        reqBaseInfo.setOrderType(Constants.OrderSubmission.PERSONAL);
        reqBaseInfo.setBusiType(Constants.OrderSubmission.NROMAL);
        reqBaseInfo.setTranslateName(WrittenContextJSON.getString("Detail"));
        reqBaseInfo.setTranslateType(Constants.OrderSubmission.QUICK);
        reqBaseInfo.setSubFlag(Constants.OrderSubmission.AUTO);
        reqBaseInfo.setUserType(Constants.OrderSubmission.USER);
        reqBaseInfo.setUserId(UserId);
        reqBaseInfo.setOrderTime(Time);
        reqBaseInfo.setTimeZone(WrittenContextJSON.getString("TimeZone"));
        reqBaseInfo.setOrderLevel("1");

        ProductInfo reqProductInfo = new ProductInfo();
        reqProductInfo.setTranslateSum(WrittenContextJSON.getLong("ContentLength"));
        reqProductInfo.setUseCode(WrittenContextJSON.getString("PurposeId"));
        reqProductInfo.setFieldCode(WrittenContextJSON.getString("DomainId"));
        reqProductInfo.setIsSetType("N");
        reqProductInfo.setIsUrgent(WrittenContextJSON.getString("Express"));
        reqProductInfo.setNeedTranslateInfo(WrittenContextJSON.getString("Content"));
        reqProductInfo.setStartTime(Time);
        reqProductInfo.setEndTime(Time);
        reqProductInfo.setLanguagePairInfoList(LanguagePair);
        reqProductInfo.setTranslateLevelInfoList(TranslateLevel);

        FeeInfo reqFeeInfo = new FeeInfo();
        reqFeeInfo.setCurrencyUnit("1");
        reqFeeInfo.setTotalFee(WrittenContextJSON.getLong("Price"));
        reqFeeInfo.setAdjustFee(WrittenContextJSON.getLong("Price"));

        ContactInfo reqContactInfo = new ContactInfo();
        reqContactInfo.setContactTel(WrittenContextJSON.getString("Phone"));
        reqContactInfo.setContactName(WrittenContextJSON.getString("Name"));
        reqContactInfo.setContactEmail(WrittenContextJSON.getString("Email"));
        reqContactInfo.setRemark(WrittenContextJSON.getString("Message"));

        req.setBaseInfo(reqBaseInfo);
        req.setProductInfo(reqProductInfo);
        req.setFeeInfo(reqFeeInfo);
        req.setContactInfo(reqContactInfo);

        log.info("OrderSubmissionInputParams: " + com.alibaba.fastjson.JSONArray.toJSONString(req));
        try {
            OrderSubmissionResponse resp = iOrderSubmissionSV.orderSubmission(req);
            if (resp.getResponseHeader().getResultCode().equals(ConstantsResultCode.SUCCESS)) {
                Long OrderId = resp.getOrderId();
                log.info("orderSubmissionSuccess");
                log.info("OrderId: " + OrderId);
                return OrderId;
            } else {
                log.info("orderSubmissionFailed: " + resp.getResponseHeader().getResultMessage());
                log.info("orderSubmissionFailed: " + resp.getResponseHeader().getResultCode());
                throw new RuntimeException("orderSubmissionFailed");
            }
        } catch (BusinessException | SystemException e) {
            e.printStackTrace();
            throw new RuntimeException("orderSubmissionFailed");
        }
    }

    @RequestMapping(value = "payment")
    public String payment() {
        JSONObject WrittenContextJSON = JSONObject.fromObject(session.getAttribute("WrittenContextJSON"));
        String Price = WrittenContextJSON.getString("Price");
        DecimalFormat df = new DecimalFormat("######0.00");
        String PriceDisplay = df.format(Double.parseDouble(Price) / 1000);
        String currencyUnit = WrittenContextJSON.getString("currencyUnit");
        String OrderId = request.getParameter("orderid");
        request.setAttribute("currencyUnit", currencyUnit);
        request.setAttribute("Price", Price);
        request.setAttribute("PriceDisplay", PriceDisplay);
        request.setAttribute("OrderId", OrderId);
        return "written/payment";
    }

    @RequestMapping(value = "PayResult")
    public String PayResult() {
        return "written/payresult";
    }

}

package com.yc.wap.written;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.common.api.sysdomain.interfaces.IQuerySysDomainSV;
import com.ai.yc.common.api.sysdomain.param.QuerySysDomainListRes;
import com.ai.yc.common.api.sysduad.interfaces.IQuerySysDuadSV;
import com.ai.yc.common.api.sysduad.param.QuerySysDuadListReq;
import com.ai.yc.common.api.sysduad.param.QuerySysDuadListRes;
import com.ai.yc.common.api.syspurpose.interfaces.IQuerySysPurposeSV;
import com.ai.yc.common.api.syspurpose.param.QuerySysPurposeListRes;
import com.ai.yc.order.api.autooffer.interfaces.IQueryAutoOfferSV;
import com.ai.yc.order.api.autooffer.param.QueryAutoOfferReq;
import com.ai.yc.order.api.autooffer.param.QueryAutoOfferRes;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.constants.Constants;
import com.yc.wap.system.constants.ConstantsResultCode;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Locale;


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

    @RequestMapping(value = "")
    public String content() {
        Locale local = rb.getDefaultLocale();
        String country = local.getCountry();
        String language = local.getLanguage();
        log.info("local country: " + country + ", language: " + language + ", local: " + local.toString());

        List DualList = GetDualList(local.toString(), Constants.OrderType.DOC);
        List PurposeList = GetPurposeList(local.toString());
        List DomainList = GetDomainList(local.toString());

        log.info("GetDualListReturn: " + com.alibaba.fastjson.JSONArray.toJSONString(DualList));
        log.info("GetPurposeListReturn: " + com.alibaba.fastjson.JSONArray.toJSONString(PurposeList));
        log.info("GetDomainListReturn: " + com.alibaba.fastjson.JSONArray.toJSONString(DomainList));

        request.setAttribute("DualList", DualList);
        request.setAttribute("PurposeList", PurposeList);
        request.setAttribute("DomainList", DomainList);
        return "written/content";
    }

    private List GetDualList(String Language, String OrderType) {
        QuerySysDuadListReq req = new QuerySysDuadListReq();
        req.setLanguage(Language);
        req.setOrderType(OrderType);
        QuerySysDuadListRes resp = iQuerySysDuadSV.querySysDuadList(req);
        if (!resp.getResponseHeader().getResultCode().equals(ConstantsResultCode.SUCCESS)) {
            throw new RuntimeException("GetDualListFailed");
        }
        return resp.getDuads();
    }

    private List GetPurposeList(String Language) {
        QuerySysPurposeListRes resp = iQuerySysPurposeSV.querySysPurposeList(Language);
        if (!resp.getResponseHeader().getResultCode().equals(ConstantsResultCode.SUCCESS)) {
            throw new RuntimeException("GetPurposeListFailed");
        }
        return resp.getPurposes();
    }

    private List GetDomainList(String Language) {
        QuerySysDomainListRes resp = iQuerySysDomainSV.querySysDomainList(Language);
        if (!resp.getResponseHeader().getResultCode().equals(ConstantsResultCode.SUCCESS)) {
            throw new RuntimeException("GetDomainListFailed");
        }
        return resp.getDomainVos();
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
        boolean isExpress = false;
        if (Express.equals("Y")) {
            isExpress = true;
        }
        QueryAutoOfferReq req = new QueryAutoOfferReq();
        req.setWordNum(Integer.parseInt(ContentLength));
        req.setDuadId(DualId);
        req.setPurposeId(PurposeId);
        req.setTranslateLevel(TransLvId);
        req.setUrgent(isExpress);
        QueryAutoOfferRes resp = iQueryAutoOfferSV.queryAutoOffer(req);
        if (resp.getResponseHeader().getResultCode().equals(ConstantsResultCode.SUCCESS)) {
            String Price = resp.getPrice().toString();
            String valuationWay = resp.getValuationWay();
            String currencyUnit = resp.getCurrencyUnit();
            log.info("AutoOfferPriceReturn: Price: " + Price + ", valuationWay: " + valuationWay + ", currencyUnit: " + currencyUnit);

            session.setAttribute("Content", Content);
            session.setAttribute("ContentLength", ContentLength);

            result.put("Price", Price);
            result.put("valuationWay", valuationWay);
            result.put("currencyUnit", currencyUnit);
            return result.returnMsg();
        } else {
            log.info("iQueryAutoOfferSV Return: " + resp.getResponseHeader().getResultCode());
            throw new RuntimeException("AutoOfferPriceFailed");
        }
    }

    @RequestMapping(value = "onSaveToUrl")
    @ResponseBody
    public Object onSaveToUrl() {
        MsgBean result = new MsgBean();
        session.setAttribute("ToUrl", request.getParameter("ToUrl"));
        session.setAttribute("Param", request.getParameter("Param"));
        return result.returnMsg();
    }

    @RequestMapping(value = "onContentSubmit")
    public String onContentSubmit() {
        return "written/confirm";
    }

    @RequestMapping(value = "onConfirmSubmit")
    @ResponseBody
    public Object onConfirmSubmit() {
        MsgBean result = new MsgBean();
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
        return result.returnMsg();
    }

    @RequestMapping(value = "payment")
    public String payment() {
        return "written/payment";
    }

    @RequestMapping(value = "PayResult")
    public String PayResult() {
        request.setAttribute("result", "success");
        return "written/payresult";
    }

}

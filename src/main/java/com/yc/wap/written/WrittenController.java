package com.yc.wap.written;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.common.api.sysdomain.interfaces.IQuerySysDomainSV;
import com.ai.yc.common.api.sysdomain.param.QuerySysDomainListRes;
import com.ai.yc.common.api.sysdomain.param.SysDomainVo;
import com.ai.yc.common.api.sysduad.interfaces.IQuerySysDuadSV;
import com.ai.yc.common.api.sysduad.param.QuerySysDuadListReq;
import com.ai.yc.common.api.sysduad.param.QuerySysDuadListRes;
import com.ai.yc.common.api.sysduad.param.SysDuadVo;
import com.ai.yc.common.api.syspurpose.interfaces.IQuerySysPurposeSV;
import com.ai.yc.common.api.syspurpose.param.QuerySysPurposeListRes;
import com.ai.yc.common.api.syspurpose.param.SysPurposeVo;
import com.yc.wap.system.base.BaseController;
import com.yc.wap.system.base.MsgBean;
import com.yc.wap.system.constants.Constants;
import com.yc.wap.system.constants.ConstantsResultCode;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

    @RequestMapping(value = "")
    public String content() {
        Locale local = rb.getDefaultLocale();
        String country = local.getCountry();
        String language = local.getLanguage();
        log.info("local country: " + country + ", language: " + language + ", local: " + local.toString());

        List<SysDuadVo> DualList = GetDualList(local.toString(), Constants.OrderType.DOC);
        List<SysPurposeVo> PurposeList = GetPurposeList(local.toString());
        List<SysDomainVo> DomainList = GetDomainList(local.toString());

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
        session.setAttribute("Content", Content);
        session.setAttribute("ContentLength", ContentLength);
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
        result.put("result", true);
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

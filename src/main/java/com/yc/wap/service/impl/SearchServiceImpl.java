package com.yc.wap.service.impl;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.common.api.sysduad.interfaces.IQuerySysDuadSV;
import com.ai.yc.common.api.sysduad.param.QuerySysDuadListReq;
import com.ai.yc.common.api.sysduad.param.QuerySysDuadListRes;
import com.ai.yc.common.api.syspurpose.interfaces.IQuerySysPurposeSV;
import com.yc.wap.service.interfaces.InterfaceSearchService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.List;

/**
 * Created by Nozomi on 11/8/2016.
 */
public class SearchServiceImpl implements InterfaceSearchService{
    Log log = LogFactory.getLog(SearchServiceImpl.class);

    private IQuerySysDuadSV iQuerySysDuadSV = DubboConsumerFactory.getService(IQuerySysDuadSV.class);
    private IQuerySysPurposeSV iQuerySysPurposeSV = DubboConsumerFactory.getService(IQuerySysPurposeSV.class);

    @Override
    public List GetDualList(String country, String OrderType) {
        QuerySysDuadListReq req = new QuerySysDuadListReq();
        req.setLanguage(country);
        req.setOrderType(OrderType);
        QuerySysDuadListRes resp = iQuerySysDuadSV.querySysDuadList(req);
        log.info("Get DualList Return: " + resp.getDuads().toString());
        return resp.getDuads();
    }
}

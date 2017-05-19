package com.yc.wap.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import com.yc.wap.system.utils.AiPassUitl;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.yc.common.api.cachekey.key.CacheKey;
import com.ai.yc.common.api.cachekey.model.SysDomain;
import com.ai.yc.common.api.cachekey.model.SysDuad;
import com.ai.yc.common.api.cachekey.model.SysPurpose;
import com.ai.yc.common.api.country.param.CountryVo;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

/**
 * 缓存操作服务
 * Created by liutong on 16/11/15.
 */
@Service
public class CacheServcie {

    /**
     * 获取指定语言下订单的语言对
     * @param locale
     * @return
     */
    public List<SysDuad> getAllDuad(Locale locale,String orderType){
        List<SysDuad> duadList = new ArrayList<SysDuad>();

        ICacheClient iCacheClient = AiPassUitl.getCommonCacheClient();
        String duadStr="";
        duadStr = iCacheClient.hget(CacheKey.DUAD_L_KEY,orderType);

        if(StringUtils.isNotBlank(duadStr)) {
            duadList = JSONObject.parseArray(duadStr, SysDuad.class);
        }
        return duadList;
    }

    /**
     * 查询指定语言下的领域信息集合
     * @return
     */
    public List<SysDomain> getAllDomain(Locale locale){
        ICacheClient iCacheClient = AiPassUitl.getCommonCacheClient();
        String domainStr;
        //目前全部为中文数据
        domainStr = iCacheClient.hget(CacheKey.DOMAIN_L_KEY,CacheKey.DOMAIN_L_KEY);
        return JSON.parseArray(domainStr,SysDomain.class);
//        List<SysDomain> domainList = new ArrayList<SysDomain>();
//        //领域 TODO... 模拟数据
//        SysDomain sysDomain = new SysDomain();
//        sysDomain.setDomainId("1");
//        sysDomain.setDomainCn("医学");
//        sysDomain.setDomainEn("yixue");
//        sysDomain.setLanguage("zh");
//        domainList.add(sysDomain);
//        domainList.add(sysDomain);
//        return domainList;
    }

    /**
     * 查询指定语言下的用途集合
     * @return
     */
    public List<SysPurpose> getAllPurpose(Locale locale){
        ICacheClient iCacheClient = AiPassUitl.getCommonCacheClient();
        //目前全部为中文数据
        String purposeStr = iCacheClient.hget(CacheKey.PURPOSE_L_KEY,CacheKey.PURPOSE_L_KEY);
        return JSON.parseArray(purposeStr,SysPurpose.class);
//        List<SysPurpose> purposeList = new ArrayList<SysPurpose>();
        //TODO... 模拟数据
        //用途
//        SysPurpose sysPurpose = new SysPurpose();
//        sysPurpose.setPurposeId("1");
//        sysPurpose.setLanguage("zh");
//        sysPurpose.setPurposeCn("专业论文");
//        sysPurpose.setPurposeEn("zhuanYeLunWen");
//        purposeList.add(sysPurpose);
//
//        SysPurpose sysPurpose1 = new SysPurpose();
//        sysPurpose1.setPurposeId("2");
//        sysPurpose1.setLanguage("zh");
//        sysPurpose1.setPurposeCn("简历");
//        sysPurpose1.setPurposeEn("zhuanYeLunWen");
//        purposeList.add(sysPurpose1);
//
//        SysPurpose sysPurpose3 = new SysPurpose();
//        sysPurpose3.setPurposeId("3");
//        sysPurpose3.setLanguage("zh");
//        sysPurpose3.setPurposeCn("产品说明");
//        sysPurpose3.setPurposeEn("zhuanYeLunWen");
//        purposeList.add(sysPurpose3);

//        return purposeList;
    }
    /**
     * 获取国家代码列表
     * @return
     */
    public List<CountryVo> getAllCountry(){
    	List<CountryVo> list = new ArrayList<>();
        ICacheClient iCacheClient = AiPassUitl.getCommonCacheClient();
        String str = iCacheClient.hget(CacheKey.COUNTRY_L_KEY,CacheKey.COUNTRY_L_KEY);
        if(StringUtils.isNotBlank(str)) {
        	list = JSONObject.parseArray(str, CountryVo.class);
        }
        return list;
    }
    /**
     * 获取国家代码列表
     * @param key [支持id,country_value]
     * @return
     */
    public CountryVo getCountryByKey(String key){
    	CountryVo country = null;
        ICacheClient iCacheClient = AiPassUitl.getCommonCacheClient();
        String str = iCacheClient.hget(CacheKey.COUNTRY_D_KEY,key);
        if(StringUtils.isNotBlank(str)) {
        	country = JSONObject.parseObject(str, CountryVo.class);
        }
        return country;
    }
}

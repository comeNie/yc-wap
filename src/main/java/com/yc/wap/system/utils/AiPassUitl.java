package com.yc.wap.system.utils;

import com.ai.opt.sdk.components.ccs.CCSClientFactory;
import com.ai.opt.sdk.components.mcs.MCSClientFactory;
import com.ai.paas.ipaas.ccs.IConfigClient;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.paas.ipaas.util.StringUtil;
import com.alibaba.fastjson.JSONObject;
import com.yc.wap.system.constants.Constants;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class AiPassUitl {
	private static Log log = LogFactory.getLog(AiPassUitl.class);
	/**
	 * 获取缓存客户端 TODO 区分国内、国外
	 * 
	 * @return
	 */
	public static ICacheClient getCacheClient() {
		// 获取cache客户端
		ICacheClient iCacheClient = MCSClientFactory
				.getCacheClient(Constants.DEFAULT_YC_CACHE_NAMESPACE);
		return iCacheClient;
	}

	/**
	 * 获取公共缓存
	 * @return
     */
	public static ICacheClient getCommonCacheClient(){
		return MCSClientFactory.getCacheClient(Constants.DEFAULT_COMMON_CACHE_NAMESPACE);
	}
	/**
	 * 获取验证码配置
	 * @return
	 */
	public static JSONObject getVerificationCodeConfig() {
		try {
			IConfigClient defaultConfigClient = CCSClientFactory
					.getDefaultConfigClient();
			String info = defaultConfigClient
					.get(Constants.VERIFICATION_CCS_NAMESPACE);
			if (!StringUtil.isBlank(info)) {
				JSONObject json = JSONObject.parseObject(info);
				return json;
			}
		} catch (Exception e) {
			log.info("我要看异常~~~~~~~~~~~~~~~~~~~" + e + e.getMessage());
		}
		return null;
	}
}

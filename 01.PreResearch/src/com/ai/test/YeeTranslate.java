package com.ai.test;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;

import net.sf.json.JSONObject;

public class YeeTranslate {
	public static String TRANSREQ = "https://translateport.yeekit.com/translate";
	
	public static void main(String[] args) throws KeyManagementException, NoSuchAlgorithmException, IOException{
//		String paramter = "{\"srcl\":zh,\"tgtl\":en,\"text\":%E4%B8%AD%E5%9B%BD,\"detoken\":true,\"align\":true}";
		
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("srcl", "zh");
		jsonObject.put("tgtl", "en");
		jsonObject.put("text", "你很漂亮");
		jsonObject.put("detoken", true);
		jsonObject.put("align", true);
		
		String resp = HttpsUtil.HttpsPost(TRANSREQ, jsonObject.toString(), "UTF-8");
		System.out.println(resp);
	}
}

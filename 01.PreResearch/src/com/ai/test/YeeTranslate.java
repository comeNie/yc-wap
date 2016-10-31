package com.ai.test;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;

public class YeeTranslate {
	public static String TRANSREQ = "https://translateport.yeekit.com/translate";
	
	public static void main(String[] args) throws KeyManagementException, NoSuchAlgorithmException, IOException{
		String paramter = "{\"srcl\":en,\"tgtl\":zn,\"text\":China,\"detoken\":true,\"align\":true}";
		String resp = HttpsUtil.HttpsPost(TRANSREQ, paramter, "UTF-8");
		System.out.println(resp);
	}
}

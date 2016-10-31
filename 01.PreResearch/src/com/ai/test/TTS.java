package com.ai.test;

public class TTS {
	public static String FILE = "assets/TTS.mp3";
	public static String FILE1 = "assets/TTS1.txt";
	
	public static void main(String[] args){
		long begintime = System.currentTimeMillis();
		
		byte[] resp = HttpUtil.TTShttpReq("吃葡萄不吐葡萄皮不吃葡萄到吐葡萄皮");
		
		String result = new String(resp);
		String[] splits = result.split("</ResponseInfo>");
		String xml = splits[0] + "</ResponseInfo>";
		int offset = xml.getBytes().length;
		
		FileUtils.ByteinfoFile(resp, FILE, offset);
		
		long endtime = System.currentTimeMillis();
		System.out.println("Time used: " + (endtime - begintime) + "ms");		
	}
}



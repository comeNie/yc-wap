package com.ai.test;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;

public class HttpUtil {
	public static String APPKEY = "cd5d5472";
	public static String DEVKEY = "2f4f930a5acae2e86f5c313cccefb856";
	public static String REQURL = "http://test.api.hcicloud.com:8880/tts/SynthText";
	
	public static byte[] httpReq(String parameter) {
		Date now = new Date();
		SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = d.format(now);
		
		try {
			URL url = new URL(REQURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("x-app-key", "cd5d5472");
			con.setRequestProperty("x-sdk-version", "3.6");
			con.setRequestProperty("x-request-date", date);
			con.setRequestProperty("x-task-config", "capkey=tts.cloud.wangjing,audioformat=mp3_16");
			con.setRequestProperty("x-session-key", MD5Utils.encodePassword(date+DEVKEY));
			con.setRequestProperty("x-udid", "101:1234567890");
			con.setDoOutput(true);
			OutputStream os = con.getOutputStream();
			os.write(parameter.getBytes("UTF-8"));
			os.close();

			String encoding = con.getContentEncoding();
			InputStream is = con.getInputStream();
			int read = -1;
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			while ((read = is.read()) != -1) {
				baos.write(read);
			}
			byte[] data = baos.toByteArray();
			baos.close();
			String content = null;
			if (encoding != null) {
				content = new String(data, encoding);
			} else {
				content = new String(data);
			}
			con.disconnect();
			return data;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}

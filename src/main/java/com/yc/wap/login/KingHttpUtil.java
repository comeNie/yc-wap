package com.yc.wap.login;

import com.alibaba.fastjson.JSONObject;
import com.yc.wap.system.utils.ConfigUtil;
import com.yc.wap.system.utils.MD5Util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.util.Date;
import java.util.UUID;

public class KingHttpUtil {

	private static Log log = LogFactory.getLog(KingHttpUtil.class);
	static String kingKey = ConfigUtil.getProperty("king.login.key");
	static String kingSecret = ConfigUtil.getProperty("king.login.secret");
	//金山登录接口
	private static String loginInterface = "http://my.iciba.com/index.php?c=sso&m=login";
	//金山校验用户名接口
	private static String userCheckInterface = "http://my.iciba.com/index.php?c=sso&m=username_check";
	//金山登录验证接口(获取用户登录信息)
	private static String loginCheckInterface = "http://my.iciba.com/index.php?c=sso&m=check_ck";
	
	public static JSONObject loginToKing(String username, String password){
		String param = getCommonParam()+"&username="+username+"&password="+ MD5Util.md5(password);
		JSONObject jsonObj = JSONObject.parseObject(sendPost(loginInterface, param));
		return jsonObj;
	}
	
	public static JSONObject loginCheckToKing(String ck){
		String param = "ck="+ck;
		JSONObject jsonObj = JSONObject.parseObject(sendPost(loginCheckInterface, param));
		return jsonObj;
	}
	
	public static String getCommonParam(){
		Long auth_timestamp = new Date().getTime();
		String auth_nonce = getUUID();
		String auth_signature = MD5Util.md5(kingKey+auth_nonce+auth_timestamp+kingSecret);
		StringBuffer sb = new StringBuffer();
		sb.append("auth_key=");
		sb.append(kingKey);
		sb.append("&auth_signature=");
		sb.append(auth_signature);
		sb.append("&auth_timestamp=");
		sb.append(auth_timestamp);
		sb.append("&auth_nonce=");
		sb.append(auth_nonce);
		return sb.toString();
	}

	public static String sendPost(String url, String param) {
		PrintWriter out = null;
		BufferedReader in = null;
		String result = "";
		try {
			URL realUrl = new URL(url);
			// 打开和URL之间的连接
			URLConnection conn = realUrl.openConnection();
			// 设置通用的请求属性
			conn.setRequestProperty("accept", "*/*");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent",
					"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			// 获取URLConnection对象对应的输出流
			out = new PrintWriter(conn.getOutputStream());
			// 发送请求参数
			out.print(param);
			// flush输出流的缓冲
			out.flush();
			// 定义BufferedReader输入流来读取URL的响应
			in = new BufferedReader(
					new InputStreamReader(conn.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			System.out.println("发送 POST 请求出现异常！" + e);
			log.error("发送 POST 请求出现异常!" + e);
			e.printStackTrace();
		}
		// 使用finally块来关闭输出流、输入流
		finally {
			try {
				if (out != null) {
					out.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return result;
	}
	
	public static String getUUID(){ 
        String s = UUID.randomUUID().toString();
        //去掉“-”符号 
        return s.substring(0,8)+s.substring(9,13)+s.substring(14,18)+s.substring(19,23)+s.substring(24); 
    }
}

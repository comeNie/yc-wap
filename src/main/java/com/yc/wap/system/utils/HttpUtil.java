package com.yc.wap.system.utils;

import org.apache.commons.io.IOUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * Created by Nozomi on 11/3/2016.
 */
public class HttpUtil {
    public static String APPKEY = "cd5d5472";
    public static String DEVKEY = "2f4f930a5acae2e86f5c313cccefb856";
    public static String REQURL = "http://test.api.hcicloud.com:8880/tts/SynthText";

    public static byte[] TTShttpReq(String parameter,String config) {
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
            con.setRequestProperty("x-task-config", config);
            con.setRequestProperty("x-session-key", MD5Util.encodePassword(date+DEVKEY));
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

    public static String httpGet(String Url){
            StringBuffer buffer = new StringBuffer();
            try {
                URL url = new URL(Url);
                HttpURLConnection con = (HttpURLConnection) url.openConnection();
                con.setRequestMethod("GET");
                if(con.getResponseCode()==200){
                    // 将返回的输入流转换成字符串    
                    InputStream inputStream = con.getInputStream();
                    InputStreamReader inputStreamReader = new InputStreamReader(inputStream,"utf-8");
                    BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
                    String str = null;
                        while ((str = bufferedReader.readLine())!= null){
                            buffer.append(str);
                        }
                        bufferedReader.close();
                        inputStreamReader.close();
                        // 释放资源    
                        inputStream.close();
                        inputStream = null;
                        con.disconnect();
                }

            }catch (Exception e){
                e.printStackTrace();
            }finally {
                return  buffer.toString();
            }
    }
}

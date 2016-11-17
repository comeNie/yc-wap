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
    /**
     * 发送 POST 请求（HTTP），JSON形式
     * @param apiUrl
     * @param json json对象
     * @return
     */
    public static String doPost(String apiUrl, Object json) {
        String httpStr = null;
        HttpPost httpPost = new HttpPost(apiUrl);
        CloseableHttpResponse response = null;
        CloseableHttpClient httpClient = HttpClients.createDefault();
        try {
//            httpPost.setConfig(requestConfig);
            StringEntity stringEntity = new StringEntity(json.toString(),"UTF-8");//解决中文乱码问题
            stringEntity.setContentEncoding("UTF-8");
            stringEntity.setContentType("application/json");
            httpPost.setEntity(stringEntity);
            response = httpClient.execute(httpPost);
            HttpEntity entity = response.getEntity();
            System.out.println(response.getStatusLine().getStatusCode());
            httpStr = EntityUtils.toString(entity, "UTF-8");
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (response != null) {
                try {
                    EntityUtils.consume(response.getEntity());
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return httpStr;
    }

    /**
     * 发送 GET 请求（HTTP），K-V形式
     * @param url
     * @param params
     * @return
     */
    public static String doGet(String url, Map<String, Object> params) {
        String apiUrl = url;
        StringBuffer param = new StringBuffer();
        int i = 0;
        for (String key : params.keySet()) {
            if (i == 0)
                param.append("?");
            else
                param.append("&");
            param.append(key).append("=").append(params.get(key));
            i++;
        }
        apiUrl += param;
        String result = null;
        CloseableHttpClient httpClient = HttpClients.createDefault();
        try {
            HttpGet httpPost = new HttpGet(apiUrl);
            HttpResponse response = httpClient.execute(httpPost);
            int statusCode = response.getStatusLine().getStatusCode();

            System.out.println("执行状态码 : " + statusCode);

            HttpEntity entity = response.getEntity();
            if (entity != null) {
                InputStream instream = entity.getContent();
                result = IOUtils.toString(instream, "UTF-8");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }
}

package com.yc.wap.system.base;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 * Created by Nozomi on 11/2/2016.
 */
public class BaseController {
    private Logger logger = Logger.getLogger(BaseController.class);

    @Autowired
    protected HttpServletRequest request;

    @Autowired
    protected HttpSession session;

    /**
     * 响应客户端结果 成功、失败、错误
     */
    private static final String RES_RESULT = "RES_RESULT";

    /**
     * 响应客户端结果描述
     */
    private static final String RES_MSG = "RES_MSG";

    /**
     * 响应客户端数据
     */
    private static final String RES_DATA = "RES_DATA";

    /**
     * 响应客户端结果 成功
     */
    private static final String SUCCESS = "SUCCESS";

    /**
     * 响应客户端结果 失败
     */
    private static final String FAILED = "FAILED";

    private static final String CODE = "CODE";

    /**
     * json响应客户端成功
     */
    protected void responseSuccess(HttpServletResponse response, String msg, String _code, JSONObject data) {
        PrintWriter printWriter = null;
        try {
            response.setContentType("text/html;charset=utf-8");
            printWriter = response.getWriter();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put(RES_RESULT, SUCCESS);
            jsonObject.put(RES_MSG, msg);
            jsonObject.put(CODE, _code);
            jsonObject.put(RES_DATA, data);
            printWriter.write(jsonObject.toString());
            printWriter.flush();

        } catch (Exception e) {
            logger.error("BaseController.responseSuccess错误>>>>>>>>>>>>>", e);
            throw new RuntimeException(e.getMessage());
        } finally {
            printWriter.close();
        }
    }

    /**
     * json响应客户端失败
     */
    protected void responseFailed(HttpServletResponse response, String msg, String _code, JSONObject data) {
        PrintWriter printWriter = null;
        try {
            response.setContentType("text/html;charset=utf-8");
            printWriter = response.getWriter();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put(RES_RESULT, FAILED);
            jsonObject.put(RES_MSG, msg);
            jsonObject.put(CODE, _code);
            jsonObject.put(RES_DATA, data);
            printWriter.write(jsonObject.toString());
            printWriter.flush();
            printWriter.close();
        } catch (Exception e) {
            logger.error("BaseController.responseSuccess错误>>>>>>>>>>>>>", e);
            throw new RuntimeException(e.getMessage());
        } finally {
            printWriter.close();
        }
    }
}

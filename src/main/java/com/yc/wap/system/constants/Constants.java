package com.yc.wap.system.constants;

/**
 * Created by Nozomi on 11/2/2016.
 */
public class Constants {

    /**
     * ajax返回状态
     */
    public static class AjaxStatus{
        // 处理成功，表示没有捕捉到任何异常
        public static final String STATUS_SUCCESS = "1";
        // 处理失败,标识捕捉到异常信息
        public static final String STATUS_FAILURE = "2";
        // session异常报错
        public static final String SESSION_EXCEPTION = "-1";
    }

    /**
     * ajax返回的参数
     */
    public static class AjaxReturn {
        // AJAX返回的成功标志值
        public static final String SUCCESS = "success";
        // AJAX返回的状态码KEY值
        public static final String STATUS_CODE = "status";
        // AJAX返回的状态的信息
        public static final String STATUS_INFO = "msg";
        // AJAX返回的列表数据
        public static final String RETURN_ROWS = "rows";
        // AJAX返回的列表数据总数
        public static final String RETURN_TOTAL_COUNT = "totalCount";
        //返回的form
        public static final String RETURN_DATA="data";
    }

    /**
     * 订单类型
     */
    public static class OrderType {
        // 快速翻译
        public static final String QUICK = "0";
        // 文档翻译
        public static final String DOC = "1";
        // 口译
        public static final String INTER = "2";
    }
}

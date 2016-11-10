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

    /**
     * 翻译级别
     */
    public static class TranslateLevel {
        // 标准级
        public static final String Normal = "100210";
        // 专业级
        public static final String Professional = "100220";
        // 出版级
        public static final String Publish = "100230";
    }

    /**
     * 增值服务
     */
    public static class OtherService {
        //排版
        public static final String Comp = "Y";
        public static final String NoComp = "N";
        //加急
        public static final String Quick = "Y";
        public static final String NoQuick = "N";

    }

    /**
     * 租户ID
     */
    public static final String TenantID = "yeecloud";

    /**
     * 登录方式
     */
    public static class LoginModel {
        //1：邮箱密码
        public static final String MailModel = "1";
        //2：手机密码
        public static final String PhonePsdModel = "2";
        //3：手机动态密码
        public static final String PhoneCodeModel = "3";
        //4：用户名密码
        public static final String UsernamePsdModel = "4";

    }
    /**
     * 获取用户信息方式
     */
    public static class GetUserMode {
        //1：用户id
        public static final String UserID = "1";
        //2：邮箱
        public static final String Mail = "2";
        //3：手机
        public static final String Phone = "3";
        //4：用户名
        public static final String UserName = "4";

    }
    /**
     * 许可登录方式
     */
    public static class AllowLoginModel {
        //0.全部
        public static final String AllModel = "0";
        //1：邮箱密码
        public static final String MailModel = "1";
        //2：手机密码
        public static final String PhonePsdModel = "2";
        //3：手机动态密码
        public static final String PhoneCodeModel = "3";
        //4：用户名密码
        public static final String UsernamePsdModel = "4";

    }
    /**
     * 注册方式
     */
    public static class RegisterModel {
        //1：邮箱密码
        public static final String MailModel = "1";
        //2：手机密码
        public static final String PhonePsdModel = "2";
        //3：手机动态密码
        public static final String PhoneCodeModel = "3";
        //4：用户名密码
        public static final String UsernamePsdModel = "4";

    }
    /**
     * 用户来源系统
     */
    public static class UserSource {
        //0：内部系统 gtcom
        public static final String GTCOM = "0";
        //1：金山 jinshan
        public static final String JINSHAN = "1";
        //2：百度用户baidu
        public static final String BAIDU = "2";
        //3：微信 weixin
        public static final String WEIXIN = "3";
        //4：腾讯用户qq
        public static final String QQ = "4";
        //5：新浪用户sina
        public static final String SINA  = "5";

    }
    /**
     * 验证码操作类型
     */
    public static class CheckOpreation {
        //1：手机激活码
        public static final String PhoneActivate = "1";
        //2：手机验证码
        public static final String PhoneCheck = "2";
        //3：手机动态密码
        public static final String PhoneDynamic = "3";
        // 4：邮箱激活码
        public static final String MailActivate = "4";
        //5：邮箱验证码
        public static final String MailCheck = "5";
        //6：密码操作验证码
        public static final String PasswordOperation  = "6";

    }
}

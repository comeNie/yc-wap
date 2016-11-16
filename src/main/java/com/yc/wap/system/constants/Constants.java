package com.yc.wap.system.constants;

/**
 * Created by Nozomi on 11/2/2016.
 */
public class Constants {

    /**
     * ajax返回状态
     */
    public static class AjaxStatus {
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
        public static final String RETURN_DATA = "data";
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
        public static final String SINA = "5";

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
        public static final String PasswordOperation = "6";

    }

    /**
     * 密码操作验证码
     */
    public static class PsdOpreation {
        //1：旧密码
        public static final String OldPsd = "1";
        //2：验证码
        public static final String CheckCode = "2";


    }

    public static final class Register {
        private Register() {
        }

        /** 验证码ccs配置路径 */
//        public static final String VERIFICATION_CCS_NAMESPACE = "/com/ai/opt/verification-code-config";
        /** 缓存命名空间 */
//        public static final String CACHE_NAMESPACE = "com.ai.yc.protal.web.register.cache";
        /**
         * 注册邮件中文模版
         */
        public static final String REGISTER_EMAIL_ZH_CN_TEMPLATE = "email/template/yc-register_zh_cn-mail.xml";
        /**
         * 注册邮件英文模版
         */
        public static final String REGISTER_EMAIL_EN_US_TEMPLATE = "email/template/yc-register_en_us-mail.xml";
        /** 邮箱校验 */
//        public static final String CHECK_TYPE_EMAIL = "email";
        /** 手机校验 */
//        public static final String CHECK_TYPE_PHONE = "phone";
        /** 校验通过 */
//        public static final String CHECK_TYPE_SUCCESS = "1";
        /** 注册国家缓存key */
//        public static final String REGISTER_COUNTRY_LIST_KEY = "register_country_list_key";
        /**
         * 注册国家缓存超时时间
         */
        public static final String REGISTER_COUNTRY_LIST_KEY_OVERTIME = "300";

    }

    /**
     * 订单提交
     */
    public static final class OrderSubmission {
        // 业务标识
        public static final String INTERNAL = "0";
        public static final String INTERNATIONAL = "1";

        // 订单来源
        public static final String WAPCN = "5";
        public static final String WAPEN = "6";

        // 订单类型
        public static final String PERSONAL = "1";
        public static final String ENTERPRISE = "2";

        // 业务类型
        public static final String NROMAL = "1";
        public static final String BACKFEE = "2";

        // 翻译类型
        public static final String QUICK = "0";
        public static final String DOCUMENT = "1";
        public static final String INTERPRET = "2";

        // 报价标识
        public static final String AUTO = "0";
        public static final String MANUAL = "1";

        // 用户类型
        public static final String USER = "10";
        public static final String ENTER = "11";
        public static final String AGENT = "12";

    }

    /**
     * 订单查询
     */
    public static final class Order {
        // 客户端显示状态
        public static final String UNPAID = "11";
        public static final String UNCONFIRM = "50";
    }

}

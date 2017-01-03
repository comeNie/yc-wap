package com.yc.wap.system.constants;

/**
 * Created by Nozomi on 11/2/2016.
 */
public class Constants {
    /**
     * 租户ID
     */
    public static final String TENANTID = "yeecloud";

    /** 默认缓存命名空间 */
    public static final String DEFAULT_YC_CACHE_NAMESPACE = "com.ai.yc.wap.web.default.cache";
    /** 公共缓存命名空间*/
    public static final String DEFAULT_COMMON_CACHE_NAMESPACE = "com.ai.yc.common.default.cache";

    /** 验证码ccs配置路径 */
    public static final String VERIFICATION_CCS_NAMESPACE = "/com/ai/opt/verification-code-config";
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
     * 订单类型
     */
    public static class OrderType2 {
        // 个人订单
        public static final String PERSIONAL = "1";
        // 企业订单
        public static final String ENTERPRISE = "2";
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
        // 陪同翻译
        public static final String Together = "100110";
        // 交替翻译
        public static final String Alter = "100120";
        // 同声传译
        public static final String Simulate = "100130";
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
        //5:都行
        public static final String ALLModel = "5";

    }
    /**
     * 邮箱手机号
     */
    public static class PhoneOrMail {
        //1：邮箱
        public static final String Mail = "mail";
        //2：手机
        public static final String Phone = "phone";
        //3:注册界面
        public static final String Register = "register";
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

    public static final class MailVerify {

        /** 发送邮件根路径配置路径 */
        public static final String MailVerifyBase_URL = "/com/ai/opt/base_url";
        /**
         * 注册邮件中文模版
         */
        public static final String VERIFY_EMAIL_ZH_CN_TEMPLATE = "email/template/yc-verification_zh_cn-mail.xml";
        /**
         * 注册邮件英文模版
         */
        public static final String VERIFY_EMAIL_EN_US_TEMPLATE = "email/template/yc-verification_en_us-mail.xml";
        /** 动态码邮件中文模版主题 */
        public static final String EMAIL_VERIFY_ZH_CN_SUBJECT = "邮箱验证码邮件";
    }
    public  static final  class PhoneVerify {
        /** 手机验证码英文短信模版 */
        public static final String SMS_CODE_TEMPLATE_EN_US ="[GTCOM] The verification code sent by YeeCloud is: {0}, to secure your account, please don't reveal the code to others, thank you.";
        /** 手机验证码中文短信模版 */
        public static final String SMS_CODE_TEMPLATE_ZH_CN ="[中译语通]您在译云获取的手机验证码为：{0}，为保证账户安全，请勿向他们泄露，谢谢！";
        /** 手机验证码长度 */
        public static final int VERIFY_SIZE = 6;

        /** 手机验证码注册操作 */
        public static final String  PHONE_CODE_REGISTER_OPERATION = "1";
        /** 手机验证码修改资料操作 */
        public static final String  PHONE_CODE_UPDATE_DATA_OPERATION = "2";
        /** 注册手机验证码key */
        public static final String REGISTER_PHONE_CODE = "register_phone_code";
        /** 注册手机验证码超时时间 */
        public static final String REGISTER_PHONE_CODE_OVERTIME = "register_phone_code_overtime";
        /** 注册手机验证码当前发送次数key */
        public static final String REGISTER_PHONE_CODE_COUNT = "register_phone_code_count";
        /** 注册手机验证码最多次数key */
        public static final String REGISTER_PHONE_CODE_MAX_COUNT = "register_phone_code_max_count";
        /** 注册手机验证码最大次数超时时间key */
        public static final String REGISTER_PHONE_CODE_MAX_COUNT_OVERTIME = "register_phone_code_max_count_overtime";

        /** 资料修改手机验证码key */
        public static final String UPDATE_DATA_PHONE_CODE = "update_data_phone_code";
        /** 资料修改手机验证码超时时间 */
        public static final String UPDATE_DATA_PHONE_CODE_OVERTIME = "update_data_phone_code_overtime";
        /** 资料修改手机验证码当前发送次数key */
        public static final String UPDATE_DATA_PHONE_CODE_COUNT = "update_data_phone_code_count";
        /** 资料修改手机验证码最多次数key */
        public static final String UPDATE_DATA_PHONE_CODE_MAX_COUNT = "update_data_phone_code_max_count";
        /** 资料修改手机验证码最大次数超时时间key */
        public static final String UPDATE_DATA_PHONE_CODE_MAX_COUNT_OVERTIME = "update_data_phone_code_max_count_overtime";
        /** 手机注册验证码UID后缀 */
        public static final String  PHONE_CODE_REGISTER_UID = "_uid";
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
        public static final String UNPAID = "11";
        public static final String UNCONFIRM = "50";
        public static final String FINISH = "90";
        public static final String CONFIRMED = "51";
        public static final String UNEVALUATE = "52";
        public static final String UNRECEIVE = "20";
        public static final String TRANSING = "23";
    }

    /**
     * 支付类型
     */
    public static final class PayType {
        //业务渠道,0：余额 
        // 1：支付宝
        //  2：网银 
        // 3：pay pal
        //  5：后付
        //  6：积分 
        // 7：优惠劵
        // 对应serial表中的CHANNEL字段
        public static final String YUE = "0";
        public static final String ZFB = "1";
        public static final String ZFB1 = "支付宝";
        public static final String YL = "2";
        public static final String YL1 = "银联";
        public static final String PP = "3";

    }

    /**
     * 用户类型
     */
    public static final class UserType {
        // 10：个人 11：企业 12：代理人
        public static final String PERSON = "10";
        public static final String ENTERPISE = "11";
        public static final String AGENT = "12";

    }

    /**
     * 性别
     */
    public static final class Sex {
        public static final String MALE = "0";
        public static final String FEMALE = "1";
        public static final String ALL = "2";

    }

    /**
     * 币种（充值）
     */
    public static final class Currency {
        public static final String RMB = "1";
        public static final String USD = "2";

    }

    public static final String COMPANY = "中译语通科技有限公司";
    public static final String SystemId = "Cloud-UAC_WEB";

    // 业务操作类型
    public static final String BusinessCode = "300001";
    public static final String BusinessOperCode = "300000";

    // 资金类型
    public static final long SubjectID = 100000L;

}

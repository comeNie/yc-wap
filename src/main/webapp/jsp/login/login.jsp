<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/8
  Time: 下午4:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
    String ToUrl = (String) session.getAttribute("ToUrl");

    System.out.println("LoginToUrl: " + ToUrl);
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title><spring:message code="login.login.title"/></title>
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
    <%@ include file="../common/timezone.jsp" %>
</head>
<body>
    <div class="wrapper-big">
        <%--登录界面--%>
        <div id="loginDiv"><!--包含除底部外的所有层-->
            <!--登录-->
            <nav class="wap-second-nav">
             <ul>
                 <a href="javascript:void(0)" onclick="leftBtn()"><i class="icon iconfont left">&#xe626;</i></a>
                 <li><spring:message code="login.login.title"/></li>
                 <a href="javascript:void(0)" class="btn login-btn right1" onclick="registJump()"><spring:message code="login.login.zhuce"/></a>
             </ul>
            </nav>
            <%--<!--tab-->
            <section class="login-tab">
             <ul>
                 <li><a href="javascript:void(0)" class="current">快速登录</a></li>
                 <li><a href="javascript:void(0)">普通登录</a></li>
             </ul>
            </section>
            <!--tab1-->
            <section id="tab1">
                <section class="login-prompt">验证成功则登录，未注册将自动创建译云帐号</section>
                <section class="form-big">
                    <div class="set-password">
                        <div class="set-int">
                            <ul>
                                <li>
                                    <p>
                                        <select class="select testing-select-big" id="selectid">
                                        </select>
                                        <span>|</span>
                                    </p>
                                </li>
                                <li>
                                    <p><input type="text" class="input input-large" placeholder="手机号"></p>
                                    <label id="phoneLabel"></label>
                                </li>
                                <li>
                                    <p><input type="text" class="input input-small" placeholder="请输入动态码"></p>
                                    <p class="yzm"><a href="javascript:void(0)" class="btn bnt-yzm">获取动态码</a></p>
                                    <label id="phonetips"></label>
                                </li>
                                <li><a href="javascript:void(0)" class="submit-btn btn-blue">立即登录</a></li>
                                <li class="right"><a href="javascript:void(0)">忘记密码 </a></li>
                            </ul>
                        </div>
        <div class="wrapper-big"><!--包含除底部外的所有层-->
            <!--登录-->
            <nav class="wap-second-nav">
                <ul>
                    <a href="javascript:window.history.go(-1)"><i class="icon iconfont left">&#xe626;</i></a>
                    <li>登录</li>
                    <a href="javascript:void(0)" class="btn login-btn right1" onclick="registJump()">注册</a>
                </ul>
            </nav>
            <%--<!--tab-->
            <section class="login-tab">
             <ul>
                 <li><a href="javascript:void(0)" class="current">快速登录</a></li>
                 <li><a href="javascript:void(0)">普通登录</a></li>
             </ul>
            </section>
            <!--tab1-->
            <section id="tab1">
                <section class="login-prompt">验证成功则登录，未注册将自动创建译云帐号</section>
                <section class="form-big">
                    <div class="set-password">
                        <div class="set-int">
                            <ul>
                                <li>
                                    <p>
                                        <select class="select testing-select-big" id="selectid">
                                        </select>
                                        <span>|</span>
                                    </p>
                                </li>
                                <li>
                                    <p><input type="text" class="input input-large" placeholder="手机号"></p>
                                    <label id="phoneLabel"></label>
                                </li>
                                <li>
                                    <p><input type="text" class="input input-small" placeholder="请输入动态码"></p>
                                    <p class="yzm"><a href="javascript:void(0)" class="btn bnt-yzm">获取动态码</a></p>
                                    <label id="phonetips"></label>
                                </li>
                                <li><a href="javascript:void(0)" class="submit-btn btn-blue">立即登录</a></li>
                                <li class="right"><a href="javascript:void(0)">忘记密码 </a></li>
                            </ul>
                        </div>
                    </div>
                </section>
            <!--tab1-->--%>
        <section id="tab2" style="display:block;">
            <section class="form-big">
                <div class="set-password">
                    <div class="set-int">
                        <ul>
                            <li>
                                <p><input id="phoneid" type="text" class="input input-large" placeholder="<spring:message code="login.login.phonepliceholder"/>"></p>
                                <label id="phoneLabel"></label>
                            </li>
                            <li>
                                <p><input id="psdid" type="password" class="input input-large" placeholder="<spring:message code="login.login.mima"/>" autocomplete="off"></p>
                                <label id="psdLabel"></label>
                            </li>
                            <li class="int-border">
                                <p><input id="codeInput" type="text" class="input input-yzm" placeholder="<spring:message code="login.login.yanzhengma"/>" autocomplete="off"></p>
                                <img id="checkCodeId" src="<%=path%>/safe/getpiccode" onclick="createCode()"/>
                                <p class="right"><a href="javascript:void(0)" onclick="createCode()"><i class="icon iconfont">&#xe66c;</i></a></p>
                                <label id="codeLabel"></label>
                            </li>
                            <li class="small-height" id="loginBtn"><a href="javascript:void(0)" class="submit-btn btn-blue" onclick="login()"><spring:message code="login.login.lijidenglu"/></a></li>
                            <img src="<%=path%>/ui/images/载入中.gif" id="translateGif" style="width: 5.29rem;height: 1.13rem; display:block;margin:0 auto">
                            <li class="right"><a href="javascript:void(0)" onclick="forgetpsd()"><spring:message code="login.login.wangjimima"/></a></li>
                        </ul>
                    </div>
                </div>
            </section>
        </section>
        <%--<!--其他登录-->
        <section class="other-big">
            <div class="other-login">
                <p class="line"></p>
                <p class="word">其他登录</p>
                <p class="line"></p>
            </div>
            <div class="other-login-icon">
                <ul>
                    <li class="none-ml"><a href="javascript:void(0)"><img src="../ui/images/iocn-4.png" /></a></li>
                    <li><a href="javascript:void(0)"><img src="../ui/images/iocn-5.png" /></a></li>
                    <li><a href="javascript:void(0)"><img src="../ui/images/iocn-6.png" /></a></li>
                    <li><a href="javascript:void(0)"><img src="../ui/images/iocn-7.png" /></a></li>
                    <li><a href="javascript:void(0)"><img src="../ui/images/iocn-8.png" /></a></li>
                </ul>
            </div>
        </section>--%>
        </div>

        <%--注册界面--%>
        <div id="registerDiv" hidden><!--包含除底部外的所有层-->
            <!--注册-->
            <nav class="wap-second-nav" >
                <ul>
                    <a href="javascript:" onclick="leftA()"><i class="icon iconfont left">&#xe626;</i></a>
                    <li><spring:message code="login.login.zhuce"/></li>
                    <a href="javascript:void(0)" class="btn login-btn right1" onclick="jumpLogin()"><spring:message code="login.login.title"/></a>
                </ul>
            </nav>

            <section class="form-big">
                <div class="set-password">
                    <div class="set-int">
                        <ul>
                            <li>
                                <p>
                                    <select class="select testing-select-big" id="selectid">
                                    </select>
                                    <span>|</span>
                                </p>
                                <label id="selectLabel"></label>
                            </li>
                            <li>
                                <p><input id="phone" type="text" class="input input-large int-color" placeholder="<spring:message code="login.register.enterphone"/>"></p>
                                <label id="phoneLabel1"></label>
                            </li>
                            <li>
                                <p><input id="codeid" type="text" class="input input-small" placeholder="<spring:message code="login.register.entercode"/>"  autocomplete="off"></p>
                                <p class="yzm"><a id="getnumber" href="javascript:void(0)" class="btn bnt-yzm" onclick="getnumberonclick()"><spring:message code="login.register.getcode"/></a></p>
                                <label id="codeLabel1"></label>
                            </li>
                            <li class="pass-smint">
                                <p><input id="psdids" type="password" class="input input-large" placeholder="<spring:message code="login.login.enterpsd"/>" autocomplete="off"></p>
                                <label id="psdLabel1"></label>
                            </li>
                            <li>
                                <p><input id="confimid" type="password" class="input input-large" placeholder="<spring:message code="login.register.enterpsdagain"/>" autocomplete="off"></p>
                                <label id="confimPsd"></label>
                            </li>
                            <li class="left">
                                <p><img src="<%=path%>/ui/images/checkbox1.png" class="imgcheckbox" onclick="checkImgAction()" id="checkImg"></p><spring:message code="login.register.agree"/><a href="javascript:void(0)" onclick="look()"><spring:message code="login.register.look"/></a>
                                <label id="agreeLabel"></label>
                            </li>
                            <li  class="small-height"><a href="javascript:void(0)" class="submit-btn btn-blue" onclick="confirmAction()"><spring:message code="login.register.lijizhuce"/></a></li>
                        </ul>
                    </div>
                </div>
            </section>
        </div>
    </div>
    <%--底部視圖--%>
    <jsp:include page="/jsp/common/bottom.jsp" flush="true"/>
    <%--loading--%>
    <jsp:include page="/jsp/common/loading.jsp" flush="true"/>
</body>
</html>
<script>
    var isAgree = 1;
    $(function(){
        $("#translateGif").hide();
        clearText();
        $("#phone").attr("disabled",false);
        if("${to}"=="login"){
            $("#loginDiv").show();
            $("#registerDiv").hide();
        }else {
            $("#loginDiv").hide();
            $("#registerDiv").show();
        }
        loadCountry();
    })
//——————————————————————登录——————————————————————
    function login() {
        var phone = $("#phoneid").val();
        var psd = $("#psdid").val();
        var code = $("#codeInput").val();
        if (phone == "" || phone == null) {
            $("#phoneLabel").html("<spring:message code="login.login.enterphone"/>");
            $("#phoneLabel").css("display", "block");
            return;
        } else {
            $("#phoneLabel").css("display", "none");
        }

        if (psd == "" || psd == null) {
            $("#psdLabel").html("<spring:message code="login.login.enterpsd"/>");
            $("#psdLabel").css("display", "block");
            return;
        } else {
            $("#psdLabel").css("display", "none");
        }
//        var t = /^[0-9a-zA-Z]{6,16}$/;
        var t = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/
        if (!t.test(psd)) {
            $("#psdLabel").html("<spring:message code="safe.changepsd.alert_newLength"/>");
            $("#psdLabel").css("display", "block");
            return;
        } else {
            $("#psdLabel").css("display", "none");
        }

        if (code == "" || code == null) {
            $("#codeLabel").html("<spring:message code="login.login.entercode"/>");
            $("#codeLabel").css("display", "block");
            return;
        } else {
            $("#codeLabel").css("display", "none");
        }
//        Loading.ShowLoading();
        $("#translateGif").show();
        $("#loginBtn").hide();
        toJump(phone, psd,code);
    }
    function toJump(phone, psd,code) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/login/checklogin",
            modal: true,
            timeout: 30000,
            data: {
                username: phone,
                password: psd,
                code:code
            },
            success: function (data) {
                $("#translateGif").hide();
                $("#loginBtn").show();
                if (data.status == 1) {
                    if (${ToUrl==null || ToUrl==""}) {
                        window.location.href = "<%=path%>" + "/";
                    } else {
                        window.location.href = "<%=path%>" + "<%=ToUrl%>";
                    }
//                    Loading.HideLoading();
                } else{
//                    Loading.HideLoading();
                    createCode();
                    $("#codeLabel").html(data.msg);
                    $("#codeLabel").css("display", "block");
                    return;
                }

            },
            error: function () {
                $("#translateGif").hide();
                $("#loginBtn").show();
                createCode();
                $("#codeLabel").html("<spring:message code="safe.safesuccess.failNet"/>");
                $("#codeLabel").css("display", "block");
//                Loading.HideLoading();
            }
        });

    }
    function forgetpsd() {
        clearText();
        var tourl = "<%=path%>/login/findpsd";
        window.location.href = tourl;
    }
    function registJump() {
        $("#loginDiv").hide();
        $("#registerDiv").show();
        clearText();
    }
    function leftBtn(){
        if ("${success}" == "success"){
            window.history.go(-3);
        }else {
            window.history.go(-1);
        }

    }
    function clearText(){
        $("#phoneid").val("");
        $("#psdid").val("");
        $("#codeInput").val("");
        $("#phone").val("");
        $("#codeid").val("");
        $("#psdids").val("");
        $("#confimid").val("");
        $("#phoneLabel").css("display", "none");
        $("#phoneLabel1").css("display", "none");
        $("#codeLabel1").css("display","none");
        $("#psdLabel1").css("display","none");
        $("#confimPsd").css("display","none");
        $("#agreeLabel").css("display", "none");
        $("#psdLabel").css("display", "none");
        $("#codeLabel").css("display", "none");
        $("#phone").attr("disabled",false);
    }
    //验证码代码
    function createCode() {
        var d =  new Date();
        $("#checkCodeId").attr("src","<%=path%>/safe/getpiccode?time="+ d.getTime());
    }

//------------------------------注册界面-------------------------
    //加载国家的数据
    var personUid;
    function loadCountry() {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/countryid",
            modal: true,
            showBusi: false,
            timeout: 30000,
            data: {
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#selectLabel").css("display","none");
                    var list = data.list;
                    $.each(list,function(index ,value){
                        if ("${pageContext.response.locale}".toUpperCase() == "ZH_CN"){
                            $('#selectid').append("<option value='"+value.countryValue+"'>" + value.countryNameCn+" +"+value.countryCode + "</option>");
                        }else {
                            $('#selectid').append("<option value='"+value.countryValue+"'>" + value.countryNameEn+" +"+value.countryCode + "</option>");
                        }
                        localStorage.setItem(value.countryValue,value.regularExpression);
                        localStorage.setItem(value.countryValue+"1",value.countryCode);
                    })
                    Loading.HideLoading();
                } else {
                    $("#selectLabel").html("<spring:message code="login.register.countryCode"/>");
                    $("#selectLabel").css("display","block");
                    Loading.HideLoading();
                }
            },
            error: function () {
                $("#selectLabel").html("<spring:message code="login.register.countryCode"/>");
                $("#selectLabel").css("display","block");
                Loading.HideLoading();
            }
        });
    }
    function leftA(){
        if("${to}"=="login"){
            $("#loginDiv").show();
            $("#registerDiv").hide();
            clearText();
            wait = 0;
        }
//        else if(document.referrer.indexOf("agreement")){
//            console.log(window.history);
//            window.history.go(-2);
//        }
        else {
            window.history.go(-1);
        }
    }
    function jumpLogin() {
        $("#loginDiv").show();
        $("#registerDiv").hide();
        clearText();
        wait = 0;
    }
    //同意协议
    function checkImgAction(){
        if (isAgree == 1){
            isAgree = 0;
            $("#checkImg").attr("src","<%=path%>/ui/images/checkbox.png")
        }else {
            isAgree = 1;
            $("#checkImg").attr("src","<%=path%>/ui/images/checkbox1.png");
        }
    }
    function confirmAction() {
        var phone = $("#phone").val();
        var codeid = $("#codeid").val();
        var psdid = $("#psdids").val();
        var confimid = $("#confimid").val();
        if (phone == "" || phone == null){
            $("#phoneLabel1").html("<spring:message code="login.register.enterphone"/>");
            $("#phoneLabel1").css("display","block");
            return;
        }else {
            $("#phoneLabel1").css("display","none");
        }
        var selectValue = $('#selectid').val();
        var code = localStorage.getItem(selectValue+"1");
        var reg = localStorage.getItem(selectValue);
        var t = new RegExp(reg);
        if(!t.test(code+phone)){
            $("#phoneLabel1").html("<spring:message code="login.register.enterRightphone"/>");
            $("#phoneLabel1").css("display","block");
            return;
        }else {
            $("#phoneLabel1").css("display","none");
        }

        if (codeid == "" || codeid == null){
            $("#codeLabel1").html("<spring:message code="login.login.entercode"/>");
            $("#codeLabel1").css("display","block");
            return;
        }else {
            $("#codeLabel1").css("display","none");
        }

        if (psdid == "" || psdid == null){
            $("#psdLabel1").html("<spring:message code="login.login.enterpsd"/>");
            $("#psdLabel1").css("display","block");
            return;
        }else {
            $("#psdLabel1").css("display","none");
        }
//        var t = /^[0-9a-zA-Z]{6,16}$/;
        var t = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/
        if (!t.test(psdid)){
            $("#psdLabel1").html("<spring:message code="safe.changepsd.alert_newLength"/>");
            $("#psdLabel1").css("display","block");
            return;
        }else {
            $("#psdLabel1").css("display","none");
        }

        if (confimid == "" || confimid == null){
            $("#confimPsd").html("<spring:message code="login.login.enterpsd"/>");
            $("#confimPsd").css("display","block");
            return;
        }else {
            $("#confimPsd").css("display","none");
        }
//        判断新密码是否相同
        if (psdid != confimid) {
            $("#confimPsd").html("<spring:message code="safe.changepsd.tip_lable"/>");
            $("#confimPsd").css("display","block");
            return;
        }else {
            $("#confimPsd").css("display","none");
        }


        if (!isAgree){
            $("#agreeLabel").html("<spring:message code="login.register.lookTip"/>");
            $("#agreeLabel").css("display","block");
            return;
        }else {
            $("#agreeLabel").css("display", "none");
        }

        Loading.ShowLoading();
//        登录验证
        checkPhoneWithJump(phone,codeid,psdid);

    }
    function checkPhoneWithJump(phone,codeid,psdid) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/login/checkregister",
            modal: true,
            timeout: 30000,
            data: {
                uid:personUid,
                phone:phone,
                newpw: psdid,
                code:codeid,
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#agreeLabel").css("display", "none");
                    var tourl = "<%=path%>/login/registersuccess";
                    window.location.href=tourl;
                    Loading.HideLoading();
                } else {
                    $("#agreeLabel").html(data.msg);
                    $("#agreeLabel").css("display", "block");
                    $("#phone").attr("disabled",false);
                    Loading.HideLoading();
                }
            },
            error: function () {
                $("#agreeLabel").html("<spring:message code="safe.safesuccess.failNet"/>");
                $("#agreeLabel").css("display", "block");
                $("#phone").attr("disabled",false);
                Loading.HideLoading();
            }
        });

    }


    function getnumberonclick(){
        var phone = $("#phone").val();
        if (phone == "" || phone == null){
            $("#phoneLabel1").html("<spring:message code="login.register.enterphone"/>");
            $("#phoneLabel1").css("display","block");
            return;
        }else {
            $("#phoneLabel1").css("display","none");
        }
        var selectValue = $('#selectid').val();
        var code = localStorage.getItem(selectValue+"1");
        var reg = localStorage.getItem(selectValue);
        var t = new RegExp(reg);
        if(!t.test(code+phone)){
            $("#phoneLabel1").html("<spring:message code="login.register.enterRightphone"/>");
            $("#phoneLabel1").css("display","block");
            return;
        }else {
            $("#phoneLabel1").css("display","none");
        }

        Loading.ShowLoading();
        getTestCode(phone,selectValue);
    }
    //    发送验证码
    function getTestCode(phone,selectValue) {

        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/sendTestCode",
            modal: true,
            timeout: 30000,
            data: {
                type: 1,
                info:phone,
                domain:selectValue,
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#phoneLabel1").css("display", "none");
                    $("#phone").attr("disabled","true");
                    personUid = data.uid;
                    countDown();
                    Loading.HideLoading();
                } else {
                    $("#phoneLabel1").html(data.msg);
                    $("#phoneLabel1").css("display", "block");
                    Loading.HideLoading();
                }
            },
            error: function () {
                $("#phoneLabel1").html("<spring:message code="safe.safesuccess.failNet"/>");
//                $("#phone").removeAttrs("disabled");
                $("#phoneLabel1").css("display", "block");
                Loading.HideLoading();
            }
        });
    }
    //    倒计时
    var wait = 120;
    function countDown() {
        if (wait == 0) {
            $("#getnumber").removeAttr("disabled");
            $("#getnumber").attr("onclick", "getnumberonclick()");
            $("#getnumber").html("<spring:message code="safe.checkphone.yzm_input"/>");//改变按钮中value的值

            $("#getnumber").attr("class","btn bnt-yzm");
            //p.html("如果您在1分钟内没有收到验证码，请检查您填写的手机号码是否正确或重新发送");
            wait = 120;
        }else {
            var txtStr = wait+ '<spring:message code="safe.changemail.chongxinhuoqu"/>';
            $("#getnumber").html(txtStr);
            $("#getnumber").attr("class","btn bnt-yzm-gray");
            // 按钮里面的内容呈现倒计时状态
            $("#getnumber").attr("disabled", "block");
            $("#getnumber").attr("onclick", "javascript:void(0)");
            wait --;
            setTimeout(function(){countDown();},1000);
        }
    }
    function look() {
        clearText();
        var u = window.location.pathname;
        var href = "<%=path%>/common/agreement?Flag="+u;
        window.location.href = href;
    }
</script>
<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/8
  Time: 下午4:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title><spring:message code="login.findpsd.title"/></title>
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
    <div class="wrapper-big"><!--包含除底部外的所有层-->
        <nav class="wap-second-nav">
            <ul>
                <a href="javascript:" onclick="leftRe()" id="leftId"><i class="icon iconfont left" >&#xe626;</i></a>
                <li id="liTitle"><spring:message code="login.findpsd.title"/></li>
            </ul>
        </nav>
        <section class="form-big">

            <div id="next1">
                <div class="set-password">
                    <div class="set-int">
                        <ul>
                            <li>
                                <p><input id="nameid1" type="text" class="input input-large" placeholder="<spring:message code="login.findpsd.phone"/>"></p>
                                <label id="nameLabel1"></label>
                            </li>
                            <li class="int-border">
                                <p><input id="codeid1" type="text" class="input input-yzm" placeholder="<spring:message code="login.login.yanzhengma"/>" autocomplete="off"></p>
                                <img id="checkCodeImg" src="<%=path%>/safe/getpiccode" onclick="createCode()"/>
                                <p class="right"><a href="javascript:void(0)" onclick="createCode()"><i class="icon iconfont">&#xe66c;</i></a></p>
                                <label id="codeLabel1"></label>
                            </li>
                            <li><a href="javascript:void(0)" id="next-btn1" class="submit-btn btn-blue"><spring:message code="login.findpsd.next"/></a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <div id="next2">
                <div class="set-password">
                    <div class="set-phone">
                        <p id="checkP"><spring:message code="safe.checkphone.hadcheckPhone"/></p>
                        <p class="word" id="phone2"></p>
                    </div>
                    <div class="set-int">
                        <ul>
                            <li>
                                <p><input id="codeid2" type="text" class="input input-small" placeholder="<spring:message code="login.register.entercode"/>" autocomplete="off"></p>
                                <p class="yzm"><a id="getnumber" onclick="getTestCode()" href="javascript:void(0)"  class="btn bnt-yzm"><spring:message code="login.register.getcode"/></a></p>
                                <label id="codeLabel2"></label>
                            </li>
                            <li><a href="javascript:void(0)" id="next-btn2" class="submit-btn btn-blue"><spring:message code="login.findpsd.next"/></a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <div id="next3">
                <div class="set-password">
                    <div class="set-int">
                        <ul>
                            <li>
                                <p><input id="psdid3" type="password" class="input input-large" placeholder="<spring:message code="safe.installpsd.large_input1"/>" autocomplete="off"></p>
                                <label id="psdLabel3"></label>
                            </li>
                            <li>
                                <p><input id="confirmid3" type="password" class="input input-large" placeholder="<spring:message code="safe.installpsd.large_input2"/>" autocomplete="off"></p>
                                <label id="confirmLabel3"></label>
                            </li>
                            <li><a href="javascript:void(0)" id="next-btn3" class="submit-btn btn-blue"><spring:message code="login.findpsd.next"/></a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <div id="next4">
                <section class="tij-cg">
                    <ul>
                        <li><i class="icon iconfont">&#xe612;</i></li>
                        <li class="word"><spring:message code="login.findpsd.success"/></li>
                        <li><span id="spanTime">5s</span><spring:message code="login.registersuccess.huidao"/><a href="javascript:void(0)" onclick="goLogin()"><spring:message code="login.registersuccess.jiemian"/></a></li>
                    </ul>
                </section>
            </div>

        </section>
    </div>

    <%--底部視圖--%>
    <jsp:include page="/jsp/common/bottom.jsp" flush="true"/>
    <%--loading--%>
    <jsp:include page="/jsp/common/loading.jsp" flush="true"/>
</body>
</html>
<script>
    //找回密码
    var index = 0;
    var getPhone;
    var getuids;
    var getCode;
    var countryCode;
    $(document).ready(function() {
       Loading.HideLoading();
    });
    $(function(){
        $("#psdid3").val("");
        $("#confirmid3").val("");
        $("#nameid1").val("");
        $("#codeid1").val("");
        $("#codeid2").val("");
        $("#next-btn1").click(function(){
            var phone = $("#nameid1").val();
            var code = $("#codeid1").val();
            if (phone == "" || phone == null) {
                $("#nameLabel1").html("<spring:message code="login.register.enterphone"/>");
                $("#nameLabel1").css("display","block");
                return;
            }else {
                $("#nameLabel1").css("display","none");
            }
            var t = /^[0-9]*$/;
            if(!t.test(phone)){
                $("#nameLabel1").html("<spring:message code="login.register.enterRightphone"/>");
                $("#nameLabel1").css("display","block");
                return;
            }else {
                $("#nameLabel1").css("display","none");
            }
            if (code == "" || code == null) {
                $("#codeLabel1").html("<spring:message code="login.login.entercode"/>");
                $("#codeLabel1").css("display","block");
                return;
            }else {
                $("#codeLabel1").css("display","none");
            }
            $("#codeLabel2").css("display","none");
            $("#codeid2").val("");
            Loading.ShowLoading();
            jump1(phone,code);

        });
        $("#next-btn2").click(function(){
            var code = $("#codeid2").val();
            var phone = $("#nameid1").val();
            if (code == "" || code == null) {
                $("#codeLabel2").html("<spring:message code="login.register.entercode"/>");
                $("#codeLabel2").css("display","block");
                return;
            }else {
                $("#codeLabel2").css("display","none");
            }
            $("#psdLabel3").css("display","none");
            $("#confirmLabel3").css("display","none");
            $("#psdid3").val("");
            $("#confirmid3").val("");
            Loading.ShowLoading();
            jump2(code,phone);

        });
        $("#next-btn3").click(function(){
            var psdid = $("#psdid3").val();
            var confimid = $("#confirmid3").val();
            if (psdid == "" || psdid == null){
                $("#psdLabel3").html("<spring:message code="login.login.enterpsd"/>");
                $("#psdLabel3").css("display","block");
                return;
            }else {
                $("#psdLabel3").css("display","none");
            }
//            var t = /^[0-9a-zA-Z]{6,16}$/;
            var t = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/
            if (!t.test(psdid)){
                $("#psdLabel3").html("<spring:message code="safe.changepsd.alert_newLength"/>");
                $("#psdLabel3").css("display","block");
                return;
            }else {
                $("#psdLabel3").css("display","none");
            }

            if (confimid == "" || confimid == null){
                $("#confirmLabel3").html("<spring:message code="login.login.enterpsd"/>");
                $("#confirmLabel3").css("display","block");
                return;
            }else {
                $("#confirmLabel3").css("display","none");
            }
//        判断新密码是否相同
            if (psdid != confimid) {
                $("#confirmLabel3").html("<spring:message code="safe.changepsd.tip_lable"/>");
                $("#confirmLabel3").css("display","block");
                return;
            }else {
                $("#confirmLabel3").css("display","none");
            }

            Loading.ShowLoading();
            jump3(psdid);

        });
    });
    function leftRe() {
//        $("#psdid3").val("");
//        $("#confirmid3").val("");
//        $("#nameid1").val("");
        $("#codeid1").val("");
        $("#codeid2").val("");
        if (index == 0){
            window.history.back(-1);
        }else if (index == 1){
            $("#next1").show();
            $("#next2").hide();
            index --;
            createCode();
            wait = 0;
            $("#checkP").html("<spring:message code="safe.checkphone.hadcheckPhone"/>");
        }else if (index == 2){

            $("#next2").show();
            $("#next3").hide();
            index --;
        }else if (index == 3){
            $("#next3").show();
            $("#next4").hide();
            index --;
            clearInterval(timer);
            fiveWait = 4;
            $("#spanTime").html("5s");
        }

    }
    function jump1(phone,code){
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/userinfo",
            modal: true,
            timeout: 30000,
            data: {
                username: phone,
                code:code
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#nameLabel1").css("display","none");
                    $("#codeLabel1").css("display","none");
                    var newphone = data.userPhone;
                    getuids = data.uids;
                    getPhone = newphone;
                    countryCode = data.countryCode;
                    var myphone1=newphone.substr(0,3);
                    var myphone2=newphone.substr(7,4);
                    var lphone=myphone1+"****"+myphone2;
                    $("#phone2").html(lphone);
                    index ++;//index = 1
                    $("#next1").hide();
                    $("#next2").show();
                    Loading.HideLoading();
                } else {
                    Loading.HideLoading();
                    if (data.status == 2){
                        $("#codeLabel1").css("display","block");
                        $("#codeLabel1").html(data.msg);
                        createCode();
                        return;
                    }
                    $("#codeLabel1").css("display","none");
                    var tourl = "<%=path%>/login/findfail";
                    window.location.href=tourl;
                }
            },
            error: function () {
                Loading.HideLoading();
                createCode();
                $("#codeLabel1").html("<spring:message code="safe.safesuccess.failNet"/>");
                $("#codeLabel1").css("display", "block");
            }
        });
    }
    function jump2(code,phone) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/checkTestCode",
            modal: true,
            timeout: 30000,
            data: {
                type: 6,    //密码操作码
                code:code,
                uid:getuids,
                userinfo:phone
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#codeLabel2").css("display", "none");
                    index ++;//index = 2
                    $("#next2").hide();
                    $("#next3").show();
                    getCode = code;

                    Loading.HideLoading();
                } else {
                    $("#codeLabel2").html(data.msg);
                    $("#codeLabel2").css("display", "block");

                    Loading.HideLoading();
                }
            },
            error: function () {
                Loading.HideLoading();
                $("#codeLabel2").html("<spring:message code="safe.safesuccess.failNet"/>");
                $("#codeLabel2").css("display", "block");
            }
        });
    }
    var timer;
    var fiveWait = 5;
    function jump3(psd){
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/editpssword",
            modal: true,
            timeout: 30000,
            data: {
                uid:getuids,
                newpw: psd,
                code:getCode,
                mode:2,  //密码操作吗
            },
            success: function (data) {
                if (data.status == 1) {
                    index ++;//index = 3

                    $("#leftId").hide();
                    <%--$("#liTitle").html("<spring:message code="login.findpsd.successTitle"/>")--%>
                    $("#next3").hide();
                    $("#next4").show();

                    var fiveWait = 4;
                    timer = setInterval(function(){
                        if(fiveWait==0){
                            fiveWait = 5;
                            goLogin();
                            return;
                        }
                        $("#spanTime").html(fiveWait+"s");
                        fiveWait--;
                    },1000);
                    Loading.HideLoading();
                } else {
                    $("#confirmLabel3").html(data.msg);
                    $("#confirmLabel3").css("display", "block");

                    Loading.HideLoading();
                }
            },
            error: function () {
                $("#confirmLabel3").html("<spring:message code="safe.safesuccess.failNet"/>");
                $("#confirmLabel3").css("display", "block");

                Loading.HideLoading();
            }
        });
    }

    //    发送验证码
    function getTestCode() {
        Loading.ShowLoading();
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/sendTestCode",
            modal: true,
            timeout: 30000,
            data: {
                type: 6,
                info:getPhone,
                domain:countryCode
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#codeLabel2").css("display", "none");
                    $("#checkP").html("已发送动态码短信到");
                    wait = 120;
                    countDown();

                    Loading.HideLoading();
                } else {
                    $("#codeLabel2").html(data.msg);
                    $("#codeLabel2").css("display", "block");
                    $("#checkP").html("<spring:message code="safe.checkphone.hadcheckPhone"/>");
                    Loading.HideLoading();
                }
            },
            error: function () {
                $("#codeLabel2").html(<spring:message code="safe.safesuccess.failNet"/>);
                $("#codeLabel2").css("display", "block");
                $("#checkP").html("<spring:message code="safe.checkphone.hadcheckPhone"/>");
                Loading.HideLoading();
            }
        });
    }
    //    倒计时
    var wait = 120;
    function countDown() {
        if (wait == 0) {
            $("#getnumber").removeAttr("disabled");
            $("#getnumber").attr("onclick", "getTestCode()");
            $("#getnumber").html("<spring:message code="login.register.getcode"/>");//改变按钮中value的值
            $("#getnumber").attr("class","btn bnt-yzm");
            //p.html("如果您在1分钟内没有收到验证码，请检查您填写的手机号码是否正确或重新发送");
            wait = 120;
        }else {
            <%--var txtStr = '<spring:message code="safe.changemail.chongxinhuoqu"/>(' + wait + ')';--%>
            var txtStr = wait+ '<spring:message code="safe.changemail.chongxinhuoqu"/>';
            $("#getnumber").html(txtStr);
            // 按钮里面的内容呈现倒计时状态
            $("#getnumber").attr("disabled", "block");
            $("#getnumber").attr("class","btn bnt-yzm-gray");
            $("#getnumber").attr("onclick", "javascript:void(0)");
            wait --;
            setTimeout(function(){countDown();},1000);
        }
    }

    function goLogin() {
        var tourl = "<%=path%>/login/login?to=login&success=success";
        window.location.href=tourl;
    }


    //验证码代码
    function createCode() {
        var d =  new Date();
        $("#checkCodeImg").attr("src","<%=path%>/safe/getpiccode?t="+d.getTime());
    }

</script>
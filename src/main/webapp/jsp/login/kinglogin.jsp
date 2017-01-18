<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2017/1/18
  Time: 上午10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title><spring:message code="login.kinglogin.title"/></title>
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/spin.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/loading.js"></script>
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
        <!--登录-->
        <nav class="wap-second-nav">
            <ul>
                <a href="javascript:void(0)" onclick="leftBtn()"><i class="icon iconfont left">&#xe626;</i></a>
                <li><spring:message code="login.kinglogin.title"/></li>
            </ul>
        </nav>
        <%--普通登录--%>
        <section id="tab2">
            <section class="form-big">
                <div class="set-password">
                    <div class="set-int">
                        <ul>
                            <li>
                                <p><input id="phoneid" type="text" class="input input-large" placeholder="<spring:message code="login.kinglogin.username"/>"></p>
                                <label id="phoneLabel"></label>
                            </li>
                            <li>
                                <p><input id="psdid" type="password" class="input input-large" placeholder="<spring:message code="login.login.mima"/>" autocomplete="off">
                                </p>
                                <label id="psdLabel"></label>
                            </li>
                            <li class="int-border" id="checkCodeIsHiden" hidden>
                                <p><input id="codeInput" type="text" class="input input-yzm" placeholder="<spring:message code="login.login.yanzhengma"/>" autocomplete="off"></p>
                                <img id="checkCodeId" src="<%=path%>/safe/getpiccode" onclick="createCode()"/>
                                <p class="right"><a href="javascript:void(0)" onclick="createCode()"><i class="icon iconfont">&#xe66c;</i></a></p>
                                <label id="codeLabel"></label>
                            </li>
                            <li class="small-height" id="loginBtn"><a href="javascript:void(0)" class="submit-btn btn-blue" onclick="login()"><spring:message code="login.login.lijidenglu"/></a></li>
                            <img src="<%=path%>/ui/images/载入中.gif" id="translateGif" style="width: 5.29rem;height: 1.13rem; display:block;margin:0 auto">
                        </ul>
                    </div>
                </div>
            </section>
        </section>
    </div>
</body>
<script>
    var hidenFlag;//验证码隐藏标识
    var isHiden = 1;    //验证码隐藏
    $(function(){
        $("#translateGif").hide();
        //是否显示验证码
//        showCode();
    })
    function leftBtn(){
        window.history.go(-1);
    }
    function createCode(){
        var d = new Date();
        $("#checkCodeId").attr("src", "<%=path%>/safe/getpiccode?time=" + d.getTime());
    }

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
        <%--var t = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/--%>
        <%--if (!t.test(psd)) {--%>
            <%--$("#psdLabel").html("<spring:message code="login.login.alert_newLength"/>");--%>
            <%--$("#psdLabel").css("display", "block");--%>
            <%--return;--%>
        <%--} else {--%>
            <%--$("#psdLabel").css("display", "none");--%>
        <%--}--%>
        if (isHiden == 0){
            if (code == "" || code == null) {
                $("#codeLabel").html("<spring:message code="login.login.entercode"/>");
                $("#codeLabel").css("display", "block");
                return;
            } else {
                $("#codeLabel").css("display", "none");
            }
        }
        $("#translateGif").show();
        $("#loginBtn").hide();
        toJump(phone, psd, code);
    }
    function toJump(phone, psd, code) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/login/kingchecklogin",
            modal: true,
            timeout: 30000,
            data: {
                username: phone,
                password: psd,
                code: code
            },
            success: function (data) {
                $("#translateGif").hide();
                $("#loginBtn").show();
                if (data.status == 1) {
                    localStorage.setItem("kingisHiden",0);
                    window.location.href = "<%=path%>" + "/";
                } else {
                    createCode();
                    if (isHiden == 1){
                        $("#psdLabel").html(data.msg);
                        $("#psdLabel").css("display", "block");
                    }else {
                        $("#codeLabel").html(data.msg);
                        $("#codeLabel").css("display", "block");
                    }
                    hidenFlag ++;
                    localStorage.setItem("kingisHiden",hidenFlag);
//                    showCode();
                }

            },
            error: function () {
                $("#translateGif").hide();
                $("#loginBtn").show();
                createCode();
                hidenFlag ++;
                localStorage.setItem("kingisHiden",hidenFlag);
                if (isHiden == 1){
                    $("#psdLabel").html("<spring:message code="safe.safesuccess.failNet"/>");
                    $("#psdLabel").css("display", "block");
                }else {
                    $("#codeLabel").html("<spring:message code="safe.safesuccess.failNet"/>");
                    $("#codeLabel").css("display", "block");
                }
//                showCode();
            },
            beforeSend: function () {
            },
            complete: function () {
            }
        });
    }
    function showCode(){
        hidenFlag = localStorage.getItem("kingisHiden");
        if (hidenFlag != null && hidenFlag != ""){
            if (hidenFlag >= 3){
                $("#checkCodeIsHiden").show();
                isHiden = 0;
                return;
            }
        }
        isHiden = 1;
        $("#checkCodeIsHiden").hide();
    }
</script>
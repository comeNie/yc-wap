<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/4
  Time: 上午10:58
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
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title><spring:message code="safe.safe.title"/></title>
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
    
</head>
<body>

    <nav class="wap-second-nav">
        <ul>
            <a href="javascript:" onclick="retLeft()"><i class="icon iconfont left">&#xe626;</i></a>
            <li><spring:message code="safe.safe.title"/></li>
            <a href="javascript:" id="nav-list"><i class="icon iconfont right">&#xe629;</i></a>
        </ul>
        <div class="pop-nav">
            <ul>
                <li>
                    <a href="#"><spring:message code="popnav.public.index"/></a>|
                    <a href="#"><spring:message code="popnav.public.ucenter"/></a>|
                    <a href="#"><spring:message code="popnav.public.order"/></a>|
                    <a href="#"><spring:message code="popnav.public.exit"/></a>
                </li>
            </ul>
        </div>
    </nav>
    
    <!--订单内容-->
    <section class="order-content ">
        <div class="setting-list">
            <ul>
                <a href="javascript:void(0)" onclick="changepsd()">
                    <li id="passwordLeft">修改密码</li>
                    <li class="right"><i class="icon iconfont">&#xe62c;</i></li>
                </a>
            </ul>
            <ul>
                <a href="javascript:void(0)" onclick="changePhone()">
                    <li>手机验证</li>
                    <li class="right" id="phoneRight">138****1234<i class="icon iconfont">&#xe62c;</i></li>
                </a>
            </ul>
            <ul class="none-border" onclick="changeMail()">
                <a href="javascript:void(0)">
                    <li>邮箱验证</li>
                    <li class="right" id="emalRight"><i class="icon iconfont">&#xe62c;</i></li>
                </a>
            </ul>
        </div>
    </section>


</body>
</html>
<script>
    var isEmail;
    var isPhone;
    var isPassword;
    $(function() {
        var email = "${email}";
        var password = "${password}";
        var mobilePhone = "${mobilePhone}";
        if(email == "" || email == null){
            $("#emalRight").html("您还没有通过邮箱验证，请验证");
            isEmail = 0;
        }else {
            $("#emalRight").html(email);
            isEmail = 1;
        }
        if(password == "" || password == null){
            $("#passwordLeft").html("设置密码");
            isPassword = 0;
        }else {
            $("#passwordLeft").html("修改密码");
            isPassword = 1;
        }
        if(mobilePhone == "" || mobilePhone == null){
            $("#phoneRight").html("您还没有通过手机验证，请验证");
            isPhone = 0;
        }else {
            var myphone=mobilePhone.substr(3,4);
            var hidePhone=mobilePhone.replace(myphone,"****");
            $("#phoneRight").html(hidePhone);
            isPhone = 1;
        }
    })
    function retLeft(){
        window.history.go(-1);
    }
    function changepsd() {
//        var c = confirm("是否有密码");
        var uid = "${UID}"
        if (isPassword == true) {
            var tourl = "<%=path%>/safe/changepsd?uid="+uid;
            window.location.href=tourl;
        }else {
            var tourl = "<%=path%>/safe/checkphone?jump=psd&phone="+"${mobilePhone}";
            window.location.href=tourl;
        }
    }
    function changeMail() {
//        var c = confirm("是否已验证邮箱");

        if (isEmail == true) {
            var tourl = "<%=path%>/safe/checkphone?jump=mail&phone="+"${mobilePhone}";
            window.location.href = tourl;
        } else {
            var tourl = "<%=path%>/safe/changemail?mailTitle=绑定";
            window.location.href = tourl;
        }
    }
    function changePhone() {
//        var c = confirm("是否已验证手机号");
        if (isPhone == true) {
            var tourl = "<%=path%>/safe/checkphone?jump=phone&phone="+"${mobilePhone}";
            window.location.href = tourl;
        } else {
            var tourl = "<%=path%>/safe/changephone?phoneTitle=绑定";
            window.location.href = tourl;
        }
    }
</script>

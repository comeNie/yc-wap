<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/4
  Time: 下午4:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
    String name = (String) request.getAttribute("name");
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title><spring:message code="safe.safesuccess.title"/></title>
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
    <div class="wrapper-big"><!--包含除底部外的所有层-->
        <nav class="wap-second-nav">
            <ul>
                <a href="javascript:"><i class="icon iconfont left" id="leftRe">&#xe626;</i></a>
                <li><spring:message code="safe.safesuccess.title"/></li>
            </ul>

        </nav>

        <!--订单内容-->
        <section class="index-wrapper ">
            <section class="tij-cg">
                <ul>
                    <li><i class="icon iconfont">&#xe612;</i></li>
                    <li class="word">${name}<spring:message code="safe.safesuccess.word_li"/></li>
                    <li><span class="red" id="spanTime">5s</span><spring:message code="safe.safesuccess.red_span"/><a href="#" onclick="goLogin()"><spring:message code="safe.safesuccess.red_a"/>登录页面</a></li>
                </ul>
            </section>
        </section>
    </div>

    <%--底部視圖--%>
    <jsp:include page="/jsp/common/bottom.jsp" flush="true"/>

</body>
</html>
<script>
    $(document).ready(function() {
        $("#leftRe").click(function() {
            window.history.go(-1);
        });
    });

    $(function() {
        countDown();
    })
    function goLogin() {
        var tourl = "<%=path%>/login/login";
        window.location.href=tourl;
    }
    var wait = 5;
    function countDown() {
        if (wait == 0) {
            goLogin();
        }else {
            wait --;
            $("#spanTime").html(wait+"s");
            setTimeout(function(){countDown();},1000);
        }
    }
</script>
<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/8
  Time: 下午4:33
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
    <title>找回密码失败</title>
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
            <a href="javascript:window.history.go(-1)" ><i class="icon iconfont left">&#xe626;</i></a>
            <li>找回密码</li>
        </ul>
    </nav>
    <section class="tij-cg">
        <ul>
            <li><i class="icon iconfont red">&#xe628;</i></li>
            <li>很遗憾，您没有绑定过任何信息，无法找回密码可以拨打400-119-8080电话，咨询人工客服</li>
        </ul>
    </section>


    <%--底部視圖--%>
    <jsp:include page="/jsp/common/bottom.jsp" flush="true"/>

</body>
</html>
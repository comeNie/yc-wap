<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/10
  Time: 上午11:22
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
    <title>译员招募</title>
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
    <%--头部--%>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="译员招募"/>
        <jsp:param name="BackTo" value="javascript:window.history.go(-1)"/>
    </jsp:include>
    <%--<nav class="wap-second-nav">--%>
        <%--<ul>--%>
            <%--<a href="javascript:"><i class="icon iconfont left">&#xe626;</i></a>--%>
            <%--<li>译员招募</li>--%>
            <%--<a href="javascript:" id="nav-list"><i class="icon iconfont right">&#xe629;</i></a>--%>
        <%--</ul>--%>
        <%--<div class="pop-nav">--%>
            <%--<ul>--%>
                <%--<li>--%>
                    <%--<a href="#">译云首页</a>|--%>
                    <%--<a href="#">个人中心</a>|--%>
                    <%--<a href="#">我的订单</a>|--%>
                    <%--<a href="#">安全退出</a>--%>
                <%--</li>--%>
            <%--</ul>--%>
        <%--</div>--%>
    <%--</nav>--%>
    <div class="rect-banner"><a href="#"><img src="<%=path%>/ui/images/recruit1.jpg"></a></div>
    <section class="recruit">
        <ul>
            <li>
                <p class="blue">第一步：注册译云</p>
                <p>您可以使用手机号或者邮箱进行注册</p>
            </li>
            <li class="right"><img src="<%=path%>/ui/images/recruit2.jpg"></li>
        </ul>
        <ul>
            <li>
                <p class="blue">第二步：认证译员</p>
                <p>通过译员认证的译员方可领取任务</p>
            </li>
            <li class="right img1"><img src="<%=path%>/ui/images/recruit3.jpg"></li>
        </ul>
        <ul>
            <li>
                <p class="blue">第三步：翻译接单</p>
                <p>进入订单大厅，选择适合的订单，开始翻译工作</p>
            </li>
            <li class="right img1"><img src="<%=path%>/ui/images/recruit4.jpg"></li>
        </ul>
        <span>译员的认证接单需通过pc端完成，现在就去吧！</span>
    </section>
</body>
</html>

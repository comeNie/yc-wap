<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/5/2016
  Time: 5:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String result = request.getParameter("result");
    request.setAttribute("result", result);
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>支付结果</title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
</head>
<body>

<nav class="wap-second-nav">
    <ul>
        <a href="javascript:"><i class="icon iconfont left">&#xe626;</i></a>
        <li>支付结果</li>
    </ul>
</nav>

<%--success--%>
<c:if test="${result=='success'}">
<section class="tij-cg" id="successlabel">
    <ul>
        <li><i class="icon iconfont">&#xe612;</i></li>
        <li class="word">您的订单支付成功</li>
        <li>您的订单号:<a href="#">5000020965</a>，您可以在<a href="#">“我的订单”</a>中查看您的订单信息，若有任何疑问，欢迎致电咨询:<br>400-119-8080</li>
    </ul>
</section>
</c:if>
<%--fail--%>
<c:if test="${result=='fail'}">
<section class="tij-cg" id="faillabel">
    <ul>
        <li><i class="icon iconfont red">&#xe62b;</i></li>
        <li class="word red">您的订单支付失败！</li>
        <li>您的订单号:<a href="#">3333333333</a>，您可以在“<a href="#">我的订单</a>”中查看您的订单信息，若有任何疑问，欢迎致电咨询:<br>400-119-8080</li>
    </ul>
</section>
</c:if>

<!--底部-->
<section class="footer-big">
    <section class="terminal">
        <ul>
            <li class="none">
                <p><img src="<%=path%>/ui/images/icon-1.png" /></p>
                <p>客户端</p>
            </li>
            <li class="tow current">
                <p><img src="<%=path%>/ui/images/icon-2.png" /></p>
                <p>触屏版</p>
            </li>
            <li class="three none-ml">
                <p><img src="<%=path%>/ui/images/icon-3.png" /></p>
                <p>电脑版</p>
            </li>
        </ul>
    </section>
    <footer class="footer">
        <ul>
            <li><a hrel="#">关于我们</a>|<a hrel="#">译云招募</a>|<a hrel="#">意见反馈</a>|<a hrel="#">ENGLISH</a></li>
            <li class="ash">中译语通科技（北京）有限公司版权所有</li>
        </ul>
    </footer>
</section>
</body>
</html>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
<script type="text/javascript">
    $(document).ready(function() {

    });

    $(function () {
        
    });

</script>
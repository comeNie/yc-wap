<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/12/2016
  Time: 2:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>订单报错</title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="wrapper-big">
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="支付"/>
        <jsp:param name="BackTo" value="javascript:window.history.go(-1)"/>
        <jsp:param name="ShowIcon" value="false"/>
    </jsp:include>
    <section class="tij-cg">
        <ul>
            <li><i class="icon iconfont red">&#xe62b;</i></li>
            <li class="word red">系统错误！</li>
            <li>您可以在“<a href="#">我的订单</a>”中查看您的订单信息<br>若有任何疑问,，欢迎致电咨询:400-119-8080</li>
        </ul>
    </section>
</div>
<!--底部-->
<jsp:include page="/jsp/common/bottom.jsp" flush="true"/>
</body>
</html>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
<script type="text/javascript">
    $(document).ready(function () {

    });

    $(function () {

    });

</script>
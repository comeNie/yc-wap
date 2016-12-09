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
    String index = path + "/";
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>支付结果</title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
</head>
<body>
<div class="wrapper-big" id="body">
    <%--头部--%>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="支付结果"/>
        <jsp:param name="BackTo" value="<%=index%>"/>
        <jsp:param name="ShowIcon" value="false"/>
    </jsp:include>

    <%--success--%>
    <c:if test="${result=='success'}">
        <section class="tij-cg" id="successlabel">
            <ul>
                <li><i class="icon iconfont">&#xe612;</i></li>
                <li class="word">您的订单支付成功</li>
                <li>您的订单号:<a href="javascript:toDetail(${OrderId})">${OrderId}</a>，若有任何疑问，欢迎致电咨询:<br>400-119-8080
                </li>
            </ul>
        </section>
    </c:if>

    <%--fail--%>
    <c:if test="${result=='fail'}">
        <section class="tij-cg" id="faillabel">
            <ul>
                <li><i class="icon iconfont red">&#xe62b;</i></li>
                <li class="word red">您的订单支付失败！</li>
                <li>您的订单号:<a href="javascript:toDetail('${OrderId}')">${OrderId}</a>，若有任何疑问，欢迎致电咨询:<br>400-119-8080
                </li>
            </ul>
        </section>
    </c:if>
</div>
<!--底部-->
<jsp:include page="/jsp/common/bottom.jsp" flush="true"/>
</body>
</html>

<script type="text/javascript">
    $(document).ready(function () {

    });

    $(function () {

    });

    function toDetail(OrderId) {
        var Order = OrderId + "";
        if (Order.substring(0, 3) == "901") {
            return;
        }
        var ToUrl = "<%=path%>/order/OrderDetail";
        window.location.href = ToUrl + "?OrderId=" + OrderId + "&FromRes=1";
    }

</script>
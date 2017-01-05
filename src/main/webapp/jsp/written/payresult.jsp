<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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

    String result = request.getParameter("result");
    String OrderId = request.getParameter("OrderId");
    String type = request.getParameter("type");
    String OrderAmount = request.getParameter("OrderAmount");
    if (result != null && !result.equals("")) {
        request.setAttribute("result", result);
    }
    if (OrderId != null && !OrderId.equals("")) {
        request.setAttribute("OrderId", OrderId);
    }
    if (type != null && !type.equals("")) {
        request.setAttribute("type", type);
    }
    if (OrderAmount != null && !OrderAmount.equals("")) {
        request.setAttribute("OrderAmount", OrderAmount);
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title><spring:message code="pay.result.title1"/></title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
    <%@ include file="../common/timezone.jsp" %>
</head>
<body>
<div class="wrapper-big" id="body">
    <%--头部--%>
    <spring:message code="pay.result.title2" var="title"/>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="${title}"/>
        <jsp:param name="BackTo" value="<%=index%>"/>
        <jsp:param name="ShowIcon" value="false"/>
    </jsp:include>

    <%--success--%>
    <c:if test="${result=='success'}">
        <c:if test="${type=='pay'}">
            <section class="tij-cg" id="successlabel">
                <ul>
                    <li><i class="icon iconfont">&#xe612;</i></li>
                    <li class="word"><spring:message code="pay.result.success"/></li>
                    <li><spring:message code="pay.result.order"/>
                        <a href="javascript:toDetail('${OrderId}')">${OrderId}</a>
                        <spring:message code="pay.result.order1"/><a href="javascript:toOrder()">
                            <spring:message code="pay.result.order2"/></a><spring:message code="pay.result.order3"/>
                        <br><spring:message code="pay.result.order4"/>
                    </li>
                </ul>
            </section>
        </c:if>
        <c:if test="${type=='recharge'}">
            <section class="tij-cg" id="successlabel">
                <ul>
                    <li><i class="icon iconfont">&#xe612;</i></li>
                    <li class="word"><spring:message code="pay.result.recharge"/>${OrderAmount}
                        <spring:message code="pay.result.yuan"/></li>
                    <li><spring:message code="pay.result.recharge1"/><a href="javascript:void(0)">${OrderId}</a>
                        <spring:message code="pay.result.recharge2"/><a href="javascript:toBalance()">
                            <spring:message code="pay.result.recharge3"/></a>
                    </li>
                </ul>
            </section>
        </c:if>
    </c:if>

    <%--fail--%>
    <c:if test="${result=='fail'}">
        <c:if test="${type=='pay'}">
            <section class="tij-cg" id="faillabel">
                <ul>
                    <li><i class="icon iconfont red">&#xe62b;</i></li>
                    <li class="word red"><spring:message code="pay.result.order5"/></li>
                    <li><spring:message code="pay.result.order"/>
                        <a href="javascript:toDetail('${OrderId}')">${OrderId}</a>
                        <spring:message code="pay.result.order1"/><a href="javascript:toOrder()">
                            <spring:message code="pay.result.order2"/></a><spring:message code="pay.result.order3"/>
                        <br><spring:message code="pay.result.order4"/>
                    </li>
                </ul>
            </section>
        </c:if>
        <c:if test="${type=='recharge'}">
            <section class="tij-cg" id="faillabel">
                <ul>
                    <li><i class="icon iconfont red">&#xe62b;</i></li>
                    <li class="word red"><spring:message code="pay.result.recharge4"/></li>
                    <li><spring:message code="pay.result.recharge2"/>
                        <a href="javascript:toBalance()"><spring:message code="pay.result.recharge3"/></a></li>
                </ul>
            </section>
        </c:if>
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

    function toOrder() {
        window.location.href = "<%=path%>/order";
    }

    function toBalance() {
        window.location.href = "<%=path%>/account/balance";
    }

</script>
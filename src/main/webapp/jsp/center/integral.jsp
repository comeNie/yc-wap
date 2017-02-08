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
    String isLogin = (String) session.getAttribute("isLogin");
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title><spring:message code="integral.title"/></title>
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
    <%--头部--%>
    <spring:message code="integral.title" var="title"/>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="${title}"/>
        <jsp:param name="BackTo" value="javascript:window.history.go(-1)"/>
    </jsp:include>
        <!--我的积分-->
        <section class="points">
            <ul>
                <li>
                    <p class="title"><spring:message code="integral.integral"/></p>
                    <p class="number">12331</p>
                </li>
                <li class="right"><p>2016-12-31将过期积分3232</p></li>
            </ul>
            <ul>
                <li>
                    <span class="title-j"><spring:message code="integral.integralEffect"/></span>
                    <span><spring:message code="integral.integralEffectSub"/></span>
                </li>
            </ul>
            <ul>
                <li>
                    <span class="title-j"><spring:message code="integral.integralGet"/></span>
                    <span><spring:message code="integral.integralGetSub"/></span>
                </li>
            </ul>
            <ul>
                <li>
                    <span class="title-j"><spring:message code="integral.integralDeadline"/></span>
                    <span><spring:message code="integral.integralDeadlineSub"/></span>
                </li>
            </ul>
        </section>
    </div>
    <jsp:include page="/jsp/common/bottom.jsp" flush="true"/>
</body>
</html>

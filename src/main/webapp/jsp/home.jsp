<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; utf-8" pageEncoding="utf-8" session="false"%>
<%
    String path = request.getContextPath();
%>
<html>
<head>
	<title>Home</title>
</head>
<body>
    <P>  The time on the server is ${serverTime}. </P>
    <p>  <spring:message code="test.test2"/></p>
    <p>  The local language is ${pageContext.response.locale}</p>
</body>
</html>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
    var Language = "${pageContext.response.locale}";
    $(function () {
        console.log("Local language:" + Language);
    });
</script>
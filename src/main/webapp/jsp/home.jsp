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
    <p>  <spring:message code="test.test1"/></p>
</body>
</html>
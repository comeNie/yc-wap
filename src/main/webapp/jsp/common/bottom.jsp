<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/8/2016
  Time: 7:41 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
</head>
<body>
<section class="footer-big">
    <section class="terminal">
        <ul>
            <li class="none">
                <p><img src="<%=path%>/ui/images/icon-1.png" /></p>
                <p><spring:message code="all.project.public.icon-1"/></p>
            </li>
            <li class="tow current">
                <p><img src="<%=path%>/ui/images/icon-2.png" /></p>
                <p><spring:message code="all.project.public.icon-2"/></p>
            </li>
            <li class="three none-ml">
                <p><img src="<%=path%>/ui/images/icon-3.png" /></p>
                <p><spring:message code="all.project.public.icon-3"/></p>
            </li>
        </ul>
    </section>
    <footer class="footer">
        <ul>
            <li><a href="#"><spring:message code="all.project.public.footer.about"/></a>|
                <a href="#"><spring:message code="all.project.public.footer.find"/></a>|
                <a href="#"><spring:message code="all.project.public.footer.idea"/></a>|
                <a href="#"><spring:message code="all.project.public.footer.language"/></a></li>
            <li class="ash"><spring:message code="all.project.public.footer.title"/></li>
        </ul>
    </footer>
</section>
</body>
</html>

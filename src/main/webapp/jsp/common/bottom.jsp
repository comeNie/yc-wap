<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/8/2016
  Time: 7:41 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@page import="java.util.regex.Matcher" %>
<%@page import="java.util.regex.Pattern" %>
<%!
    private String androidReg = "\\bandroid|Nexus\\b";
    private String iosReg = "ip(hone|od|ad)";

    private Pattern androidPat = Pattern.compile(androidReg, Pattern.CASE_INSENSITIVE);
    private Pattern iosPat = Pattern.compile(iosReg, Pattern.CASE_INSENSITIVE);

    private boolean Android(String userAgent) {
        if (null == userAgent) {
            userAgent = "";
        }
        Matcher matcherAndroid = androidPat.matcher(userAgent);
        return matcherAndroid.find();
    }

    private boolean IOS(String userAgent) {
        if (null == userAgent) {
            userAgent = "";
        }
        Matcher matcherIOS = iosPat.matcher(userAgent);
        return matcherIOS.find();
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String userAgent = request.getHeader("USER-AGENT").toLowerCase();
    String AppUrl = "http://m.yeecloud.com";
    System.out.println("userAgent: " + userAgent);
    if (Android(userAgent)) {
        AppUrl = "http://android.myapp.com/myapp/detail.htm?apkName=cn.com.gtcom.ydt";
    } else if (IOS(userAgent)) {
        AppUrl = "https://itunes.apple.com/cn/app/zhao-fan-yi-findyee/id1017302386?mt=8";
    }
    request.setAttribute("AppUrl", AppUrl);
    request.setAttribute("WapUrl", "http://m.yeecloud.com");
    request.setAttribute("PcUrl", "http://www.yeecloud.com/");
%>
<html>
<head>
</head>
<body>
<section id="_bottom" class="footer-big">
    <section class="terminal">
        <ul>
            <li class="none">
                <p><img src="<%=path%>/ui/images/icon-1.png" onclick="window.location.href='${AppUrl}'"/></p>
                <p><spring:message code="all.project.public.icon-1"/></p>
            </li>
            <li class="tow current">
                <p><img src="<%=path%>/ui/images/icon-2.png" onclick="window.location.href='${WapUrl}'"/></p>
                <p><spring:message code="all.project.public.icon-2"/></p>
            </li>
            <li class="three none-ml">
                <p><img src="<%=path%>/ui/images/icon-3.png" onclick="window.location.href='${PcUrl}'"/></p>
                <p><spring:message code="all.project.public.icon-3"/></p>
            </li>
        </ul>
    </section>
    <footer class="footer">
        <ul>
            <li><a href="<%=path%>/common/aboutus"><spring:message code="all.project.public.footer.about"/></a>|
                <a href="<%=path%>/common/recruit"><spring:message code="all.project.public.footer.find"/></a>|
                <a href="#"><spring:message code="all.project.public.footer.idea"/></a>|
                <a href="#"><spring:message code="all.project.public.footer.language"/></a></li>
            <li class="ash"><spring:message code="all.project.public.footer.title"/></li>
            <%--若多语言不可用，就改控制器进入jsp--%>
        </ul>
    </footer>
</section>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/10/2016
  Time: 11:10 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String title = request.getParameter("Title");
    String back = request.getParameter("BackTo");
    String show = request.getParameter("ShowIcon");
    request.setAttribute("show", show);
    request.setAttribute("isLogin", session.getAttribute("isLogin"));
%>

<!DOCTYPE html>
<html>
<head>
</head>
<body>
<nav class="wap-second-nav">
    <ul>
        <a href="<%=back%>"><i class="icon iconfont left">&#xe626;</i></a>
        <li><%=title%>
        </li>
        <c:if test="${show!=false}">
            <c:if test="${isLogin==null || isLogin=='0'}">
                <a href="javascript:window.location.href='<%=path%>/login/login'" class="btn login-btn right1">登陆</a>
            </c:if>
            <c:if test="${isLogin=='1'}">
                <a href="javascript:" id="nav-list"><i class="icon iconfont right">&#xe629;</i></a>
            </c:if>
        </c:if>
    </ul>
    <div class="pop-nav">
        <ul>
            <li>
                <a href="javascript:window.location.href='<%=path%>/'">
                    <spring:message code="popnav.public.index"/></a>|
                <a href="javascript:window.location.href='<%=path%>/center/center'">
                    <spring:message code="popnav.public.ucenter"/></a>|
                <a href="#">
                    <spring:message code="popnav.public.order"/></a>|
                <a href="javascript:onLogout()">
                    <spring:message code="popnav.public.exit"/></a>
            </li>
        </ul>
    </div>
</nav>
</body>
</html>
<script type="text/javascript">
    function onLogout() {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/login/Logout",
            modal: true,
            timeout: 30000,
            data: {},
            success: function (data) {
                if (data.status == 1) {
                    var ToUrl = "<%=path%>/";
                    window.location.href = ToUrl;
                }
            },
            error: function (data) {
                console.log(data);
            },
            beforeSend: function () {

            },
            complete: function () {

            }
        });
    }
</script>
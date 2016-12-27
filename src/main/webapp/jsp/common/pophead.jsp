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
    String index = request.getParameter("Index");
    request.setAttribute("index", index);
    request.setAttribute("show", show);
    request.setAttribute("isLogin", session.getAttribute("isLogin"));

    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>
<head>
</head>
<body>
<nav class="wap-second-nav">
    <ul>
        <c:if test="${index==1}">
            <c:if test="${isLogin==null || isLogin=='0'}">
                <a href="javascript:window.location.href='<%=path%>/login/login?to=login'"><i class="icon iconfont left">
                    <img style="width:3.13rem;height:1.06rem;" src="<%=path%>/ui/images/logo.png"/></i></a>
            </c:if>
            <c:if test="${isLogin=='1'}">
                <a href="<%=path%>/"><i class="icon iconfont left">
                    <img style="width:3.13rem;height:1.06rem;" src="<%=path%>/ui/images/logo.png"/></i></a>
            </c:if>
        </c:if>
        <c:if test="${index=='' || index==null}">
            <a href="<%=back%>"><i class="icon iconfont left">&#xe626;</i></a>
            <li><%=title%>
            </li>
        </c:if>
        <c:if test="${show!=false}">
            <c:if test="${isLogin==null || isLogin=='0'}">
                <a href="javascript:window.location.href='<%=path%>/login/login?to=login'" class="btn login-btn right1">登录</a>
            </c:if>
            <c:if test="${isLogin=='1'}">
                <a href="javascript:" id="nav-list"><i class="icon iconfont right" id="rightIcon">&#xe670;</i></a>
            </c:if>
        </c:if>
    </ul>
    <div class="pop-nav" id="pop-nav">
        <ul>
            <li>
                <a href="javascript:window.location.href='<%=path%>/'">
                    <spring:message code="popnav.public.index"/></a>|
                <a href="javascript:window.location.href='<%=path%>/center/center'">
                    <spring:message code="popnav.public.ucenter"/></a>|
                <a href="javascript:window.location.href='<%=path%>/order'">
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
    $(document).ready(function () {
        $("#nav-list").bind("click", function () {
            if ($("#pop-nav").attr("opened") == "1") {
                $("#pop-nav").css("display", "none");
                $("#pop-nav").attr("opened", "0");
                $("#rightIcon").html("&#xe629;");
            } else {
                $("#pop-nav").css("display", "block");
                $("#pop-nav").attr("opened", "1");
                $("#rightIcon").html("&#xe618;");
            }
        })
    });

    function onLogout() {
        window.onload = function () {
            window.history.go(1);
        };

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
                    window.location.href = ToUrl + "?bindLogout=1";
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
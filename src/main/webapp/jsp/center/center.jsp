<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/9
  Time: 下午9:01
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
    request.setAttribute("isLogin",isLogin);
%>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>个人中心</title>
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>

</head>
<body>
    <div class="wrapper-big"><!--包含除底部外的所有层-->
        <%--头部--%>
        <jsp:include page="/jsp/common/pophead.jsp" flush="true">
            <jsp:param name="Title" value="我的译云"/>
            <jsp:param name="BackTo" value="javascript:retLeft()"/>
        </jsp:include>

        <!--个人中心-->
        <section class="personal-banner">
            <ul>
                <li class="img"><img src="<%=path%>/ui/images/4.jpg" /></li>
                <li id="nameLi"></li>
                <li>普通会员</li>
            </ul>
        </section>
        <section class="personal-tab">
            <ul>
                <a href="#">
                    <li>
                        <p>0</p>
                        <p>待付款</p>
                    </li>
                </a>
                <a href="#">
                    <li class="none-border">
                        <p>5</p>
                        <p>待确认</p>
                    </li>
                </a>
            </ul>
        </section>
        <section class="personal-list">
            <ul>
                <a href="#">
                    <li>
                        <p><img src="<%=path%>/ui/images/icon-9.jpg" /></p>
                        <p>我的订单</p>
                    </li>
                </a>
                <a href="#" onclick="toBalance()">
                    <li>
                        <p><img src="<%=path%>/ui/images/icon-10.jpg" /></p>
                        <p>我的账户</p>
                    </li>
                </a>
                <a href="#" onclick="toSafe()">
                    <li>
                        <p><img src="<%=path%>/ui/images/icon-11.jpg" /></p>
                        <p>安全设置</p>
                    </li>
                </a>
                <a href="#">
                    <li>
                        <p><img src="<%=path%>/ui/images/icon-12.jpg" /></p>
                        <p>我的积分</p>
                    </li>
                </a>
            </ul>
        </section>

    </div>
    <section class="personal-ban1"><a href="#"><img src="<%=path%>/ui/images/person-banner.jpg" /></a></section>

</body>
</html>
<script>
    function toBalance(){
        var tourl = "<%=path%>/account/balance";
        window.location.href=tourl;
    }
    function toSafe(){
        var tourl = "<%=path%>/safe/safe";
        window.location.href=tourl;
    }
    $(function() {
        $("#nameLi").html("${username}");

    })
</script>
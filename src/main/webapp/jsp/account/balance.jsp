<%@ page import="com.ai.opt.sdk.components.ccs.CCSClientFactory" %>
<%@ page import="com.yc.wap.system.constants.Constants" %>
<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/9
  Time: 下午9:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
    String accountEnable = "1";
    try {
        accountEnable = CCSClientFactory.getDefaultConfigClient().get(Constants.Account.CCS_PATH_ACCOUNT_ENABLE);
    } catch (Exception e) {
        //获取配置出错，直接忽略，视为开启
    }
    System.out.println("accountEnable: " + accountEnable);
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title><spring:message code="center.myBalance"/></title>
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
    <spring:message code="center.myBalance" var="title"/>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="${title}"/>
        <jsp:param name="BackTo" value="javascript:retLeft()"/>
    </jsp:include>

    <%--<section class="account-tab">--%>
        <%--<ul>--%>
            <%--<a href="#" class="current">--%>
                <%--<li>--%>
                    <%--<p><spring:message code="account.balance.onlyyue"/></p>--%>
                <%--</li>--%>
            <%--</a>--%>
            <%--<a href="#">--%>
                <%--<li class="none-border">--%>
                    <%--<p><spring:message code="account.balance.youhujuan"/></p>--%>
                <%--</li>--%>
            <%--</a>--%>
        <%--</ul>--%>
    <%--</section>--%>

    <section class="form-big">
        <div class="balance">
            <spring:message code="account.balance.yuer"/><span id="BigSpan"><b id="littleB"></b></span>
        </div>

        <% if (Constants.Account.ACCOUNT_ENABLE.equals(accountEnable)) { %>
        <div class="wap-btn"><a href="javascript:void(0)" onclick="toRecharge()" class="btn submit-btn btn-blue">
            <spring:message code="account.balance.chongzhi"/></a></div>
        <% } %>

        <div class="balance-word"><spring:message code="account.balance.balancezhuyi"/></div>
    </section>

    <%--<section class="form-big" id="acc-tab2"  style="display: none;">--%>
        <%--<div class="coupon-bj">--%>
            <%--<div class="coupon-left">--%>
                <%--<ul>--%>
                    <%--<li class="word">满1000元可使用</li>--%>
                    <%--<li>仅可在中英翻译服务中使用</li>--%>
                    <%--<li>有效期： 2015/02/06—2015/05/06</li>--%>
                    <%--<li>编号：2467320578091758</li>--%>
                <%--</ul>--%>
            <%--</div>--%>
            <%--<div class="coupon-right"><span>¥</span>100</div>--%>
        <%--</div>--%>
        <%--<div class="coupon-bj">--%>
            <%--<div class="coupon-left">--%>
                <%--<ul>--%>
                    <%--<li class="word">满1000元可使用</li>--%>
                    <%--<li>仅可在中英翻译服务中使用</li>--%>
                    <%--<li>有效期： 2015/02/06—2015/05/06</li>--%>
                    <%--<li>编号：2467320578091758</li>--%>
                <%--</ul>--%>
            <%--</div>--%>
            <%--<div class="coupon-right"><span>¥</span>100</div>--%>
        <%--</div>--%>
    <%--</section>--%>
</div>

<%--底部視圖--%>
<jsp:include page="/jsp/common/bottom.jsp" flush="true"/>
<%--loading--%>
<jsp:include page="/jsp/common/loading.jsp" flush="true"/>
</body>
</html>
<script>
    var money = '${Balance}';
    function toRecharge() {
        var tourl = "<%=path%>/account/recharge?balance=" + money;
        window.location.href = tourl;
    }
    function retLeft() {
        var tourl = "<%=path%>/center/center";
        window.location.href = tourl;

    }
    $(function () {
        var arrMoney = money.split('.');
        $("#BigSpan").html(arrMoney[0] + "<b>." + arrMoney[1] + "元</b>");
    });
    $(document).ready(function () {
        Loading.HideLoading();

    });
</script>
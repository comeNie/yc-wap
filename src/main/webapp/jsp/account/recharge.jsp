<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/9
  Time: 上午10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title><spring:message code="account.recharge.title"/></title>
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
    <spring:message code="account.recharge.title" var="title"/>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="${title}"/>
        <jsp:param name="BackTo" value="javascript:retLeft()"/>
    </jsp:include>

    <section class="form-big">
        <div class="set-password">
            <div class="choice-list">
                <ul>
                    <li>
                        <p class="word"><spring:message code="account.recharge.yuer"/></p>
                        <p>${balance}<spring:message code="account.recharge.yuan"/></p>
                    </li>
                    <li>
                        <p class="word"><spring:message code="account.recharge.recharjiner"/></p>
                        <p><input id="price" type="text" class="input int-rech" placeholder="10~500" autocomplete="off"></p>
                        <p class="element"><spring:message code="account.recharge.yuan"/></p>
                        <label id="pricetip"></label>
                    </li>
                    <li>
                        <p class="word"><spring:message code="account.recharge.recharType"/></p>
                        <p id="zfbP" onclick="zfbAction()">
                            <%--<input type="radio" class="radio" name="way" value="1" checked>--%>
                            <img id="zfbImg" src="<%=path%>/ui/images/radio.jpg" class="radio-img" >
                            <img src="<%=path%>/ui/images/zhifb.png">
                        </p>
                        <p class="ml-a" id="ylP" onclick="ylAction()">
                            <%--<input type="radio" class="radio" name="way" value="2">--%>
                            <img id="ylImg"  src="<%=path%>/ui/images/radio1.jpg" class="radio-img" >
                            <img src="<%=path%>/ui/images/unionpay.png">
                        </p>
                        <%--<label id="inputid"></label>--%>
                    </li>
                </ul>
            </div>
            <div class="wap-btn"><a href="javascript:void(0)" class="btn submit-btn btn-blue" onclick="confirm()"><spring:message code="account.recharge.tijiao"/></a>
            </div>
        </div>
    </section>
    <form id="toPayForm" method="post" action="<%=path%>/pay/gotoPay">
        <input type="hidden" id="orderId" name="orderId" value="0">
        <input type="hidden" id="orderAmount" name="orderAmount" value="123.00">
        <input type="hidden" id="currencyUnit" name="currencyUnit" value="1">
        <input type="hidden" id="payType" name="payOrgCode" value="YL">
        <input type="hidden" id="merchantUrl" name="merchantUrl">
    </form>

</div>

<%--loading--%>
<jsp:include page="/jsp/common/loading.jsp" flush="true"/>

<%--底部視圖--%>
<jsp:include page="/jsp/common/bottom.jsp" flush="true"/>

</body>
</html>
<script>
    $(document).ready(function () {
        Loading.HideLoading();
    });
    var types = 0;
    function retLeft() {
        window.history.go(-1);
    }
    function zfbAction(){
        types = 0;
        $("#zfbImg").attr("src","<%=path%>/ui/images/radio.jpg");
        $("#ylImg").attr("src","<%=path%>/ui/images/radio1.jpg");
    }
    function ylAction(){
        types = 1;
        $("#zfbImg").attr("src","<%=path%>/ui/images/radio1.jpg");
        $("#ylImg").attr("src","<%=path%>/ui/images/radio.jpg");
    }
    function confirm() {
        var price = $("#price").val();
        if (price == null || price == "" || price == 0) {
            $("#pricetip").html("<spring:message code="account.recharge.enterRechargeMoney"/>");
            $("#pricetip").css("display", "block");
            return;
        } else {
            $("#pricetip").css("display", "none");
        }
        if (!(/^([1-9]\d{0,9}|0)([.]?|(\.\d{1,2})?)$/.test(price))) {
            $("#pricetip").html("<spring:message code="account.recharge.enterRechargeRight"/>");
            $("#pricetip").css("display", "block");
            return;
        } else {
            if (parseInt(price) < 10 || parseInt(price) > 500){
                $("#pricetip").html("<spring:message code="account.recharge.enterRechargeRange"/>");
                $("#pricetip").css("display", "block");
                return;
            }else{

                $("#pricetip").css("display", "none");
            }
        }
        if (types == 0) {
            $("#payType").val("ZFB");
        } else {
            $("#payType").val("YL");
        }
        GetSerial();

        var Amount = toDecimal($("#price").val());
        $("#orderAmount").val(Amount);

        $("#toPayForm").submit();
    }

    function GetSerial() {
        var timestamp = new Date().getTime();
        var Serial = "901${UID}" + timestamp;
        $("#orderId").val(Serial);
    }

    function toDecimal(x) {
        var f = parseFloat(x);
        if (isNaN(f)) {
            return false;
        }
        var f = Math.round(x * 100) / 100;
        var s = f.toString();
        var rs = s.indexOf('.');
        if (rs < 0) {
            rs = s.length;
            s += '.';
        }
        while (s.length <= rs + 2) {
            s += '0';
        }
        return s;
    }

</script>
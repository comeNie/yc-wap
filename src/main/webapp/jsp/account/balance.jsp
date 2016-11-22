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
%>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>账户余额</title>
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
            <jsp:param name="Title" value="账户余额"/>
            <jsp:param name="BackTo" value="javascript:retLeft()"/>
        </jsp:include>

        <section class="form-big">
            <div class="balance">
                账户余额:<span id="balanceSpan">0.00元</span>
            </div>
            <div class="wap-btn"><a href="javascript:void(0)" onclick="toRecharge()"  class="btn submit-btn btn-blue">充值</a></div>
            <div class="balance-word">账户余额是在译云账户中的款项，下单时可以直接用于支付订单。</div>
        </section>
    </div>

    <%--底部視圖--%>
    <jsp:include page="/jsp/common/bottom.jsp" flush="true"/>
    <%--loading--%>
    <jsp:include page="/jsp/common/loading.jsp" flush="true"/>
</body>
</html>
<script>
    var b;
    function toRecharge(){
        var tourl = "<%=path%>/account/recharge?balance="+b;
        window.location.href=tourl;
    }
    function retLeft() {
        var tourl = "<%=path%>/center/center";
        window.location.href=tourl;

    }
    $(function() {
        loadBalance()
    })
    function loadBalance(){
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/account/GetBalance",
            modal: true,
            timeout: 30000,
            data: {
            },
            success: function (data) {
                if (data.status == 1) {
                    Loading.HideLoading();
                    b = data.balance;
                    $("#balanceSpan").html(data.balance);
                }else {
                    Loading.HideLoading();
                }
            },
            error: function () {
                Loading.HideLoading();
            }
        });
    }
</script>
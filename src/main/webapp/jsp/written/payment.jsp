<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/5/2016
  Time: 5:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String OrderId = request.getParameter("orderid");
    request.setAttribute("OrderId", OrderId);
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>支付订单</title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
</head>
<body>
<div class="wrapper-big" id="body">
    <%--头部--%>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="支付订单"/>
        <jsp:param name="BackTo" value="javascript:window.history.go(-1)"/>
    </jsp:include>

    <!--订单内容-->
    <div class="confirm-list">
        <ul>
            <li class="word">翻译主题:</li>
            <li>
                <p>
                    <select class="select testing-select-big">
                        <option>企业订单（8折）</option>
                    </select>
                    <span>|</span>
                </p>
            </li>
        </ul>
        <ul>
            <li class="word">使用优惠劵:</li>
            <li>
                <p>
                    <select class="select testing-select-big" disabled id="sel">
                        <option>50元（有效期至2016-12-31）</option>
                    </select>
                    <span>|</span>
                    <label></label>
                </p>
            </li>
        </ul>
        <ul>
            <li class="word">输入优惠码:</li>
            <li>
                <p>
                    <select class="select testing-select-big">
                        <option>1214141212335</option>
                    </select>
                    <span>|</span>
                </p>
            </li>
        </ul>
        <ul>
            <li><input type="radio" class="radio"/>翻译后付费</li>
        </ul>

        <%--start--%>
        <ul>
            <li class="zhifb"><input type="radio" id="alipay" name="choose" class="radio"/>
                <img src="<%=path%>/ui/images/zhifb.png" id="imgAliPay"/></li>
            <li class="unionpay"><input type="radio" id="unipay" name="choose" class="radio"/>
                <img src="<%=path%>/ui/images/unionpay.png" id="imgUniPay"/></li>
        </ul>

        <ul>
            <li id="imgCash" class="word-ash"><input type="radio" id="cash" name="choose" class="radio"/>账户余额支付（余额：20元）
            </li>
            <li class="right"><a href="#">余额不足，请先充值</a></li>
        </ul>
    </div>
</div>

<form id="toPayForm" method="post" action="<%=path%>/pay/gotoPay">
    <input type="hidden" name="orderId" value="${OrderId}">
    <input type="hidden" name="orderAmount" value="${Price}">
    <input type="hidden" name="currencyUnit" value="1">
    <input type="hidden" id="payType" name="payOrgCode" value="PP">
    <input type="hidden" id="merchantUrl" name="merchantUrl"> <%--当前地址--%>
    <input type="hidden" name="orderType" value="1"> <%--订单类型 目前只支持用户--%>
</form>

<!--底部-->
<section class="order-submit">
    <div class="left">
        <p>应付金额:${PriceDisplay}元</p>
        <p>
            <span>订单金额:${PriceDisplay}元</span>
            <%--<span>优惠:50元</span>--%>
        </p>
    </div>
    <div class="right"><a href="javascript:void(0)" id="submit">确认支付</a></div>
</section>
</body>
</html>

<script type="text/javascript">
    $(document).ready(function () {
        var ToUrl = "<%=path%>/written/PayResult";
        $("#submit").bind("click", function () {
//            window.location.href = ToUrl;
            $("#toPayForm").submit();
        });

        $("#imgAliPay").bind("click", function () {
            document.getElementById("alipay").checked = true;
        })

        $("#imgUniPay").bind("click", function () {
            document.getElementById("unipay").checked = true;
        })

        $("#imgCash").bind("click", function () {
            document.getElementById("cash").checked = true;
        })
    });

    $(function () {

    });
</script>
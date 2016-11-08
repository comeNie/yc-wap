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
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>支付订单</title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
</head>
<body>

<nav class="wap-second-nav">
    <ul>
        <a href="javascript:"><i class="icon iconfont left">&#xe626;</i></a>
        <li>支付订单</li>
        <a href="javascript:" id="nav-list"><i class="icon iconfont right">&#xe629;</i></a>
    </ul>
    <div class="pop-nav">
        <ul>
            <li>
                <a href="#">译云首页</a>|
                <a href="#">个人中心</a>|
                <a href="#">我的订单</a>|
                <a href="#">安全退出</a>
            </li>
        </ul>
    </div>
</nav>

<!--订单内容-->

<div class="confirm-list">

    <ul style="display: none">
        <li class="word">使用优惠劵:</li>
        <li>
            <p>
                <select class="select testing-select-big">
                    <option>50元（有效期至2016-12-31）</option>
                </select>
                <span>|</span>
            </p>
        </li>
    </ul>
    <ul style="display: none">
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
    <ul style="display: none">
        <li><input  type="radio" class="radio"/>翻译后付费</li>
    </ul>

    <%--start--%>
    <ul>
        <li class="zhifb"><input  type="radio" class="radio"/><img src="<%=path%>/ui/images/zhifb.png" /></li>
        <li class="unionpay"><input  type="radio" class="radio"/><img src="<%=path%>/ui/images/unionpay.png" /></li>
    </ul>

    <ul>
        <li class="word-ash"><input type="radio" class="radio"/>账户余额支付（余额：20元）</li>
        <li class="right"><a href="#">余额不足，请先充值</a></li>
    </ul>
</div>

<!--底部-->
<section class="order-submit">
    <div class="left">
        <p>应付金额:110元</p>
        <p>
            <span>订单金额:160元</span>
            <span>优惠:50元</span>
        </p>
    </div>
    <div class="right"><a href="#" id="submit">确认支付</a></div>
</section>
</body>
</html>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var tourl = "<%=path%>/jsp/written/payresult.jsp";
        $("#submit").bind("click", function () {
            window.location.href=tourl+"?result=success";
        });
    });

    $(function () {

    });
</script>
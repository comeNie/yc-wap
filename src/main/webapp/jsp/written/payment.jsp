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
    <%@ include file="../common/timezone.jsp" %>
</head>
<body>
<div class="wrapper-big" id="body">
    <div class="eject-big">
        <div class="prompt" id="prompt">
            <div class="prompt-title">请选择</div>
            <div class="prompt-confirm">
                <ul>
                    <li id="EjectTitle">IOS端不支持上传附件请前往PC端</li>
                </ul>
            </div>
            <div class="prompt-confirm-btn">
                <a href="#" id="prompt-btn">确认</a>
            </div>

        </div>
        <div class="mask" id="eject-mask"></div>
    </div>

    <%--头部--%>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="支付订单"/>
        <jsp:param name="BackTo" value="javascript:window.history.go(-1)"/>
    </jsp:include>

    <!--订单内容-->
    <div class="confirm-list">
        <ul>
            <li class="word">订单性质:</li>
            <li>
                <p>
                    <select class="select testing-select-big" disabled id="sel">
                        <option>个人订单</option>
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
                        <option>暂无可用优惠券</option>
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
                    <select class="select testing-select-big" disabled id="sel">
                        <option>暂无可用优惠码</option>
                    </select>
                    <span>|</span>
                </p>
            </li>
        </ul>

        <%--<ul>--%>
            <%--<li><input type="radio" name="choose" class="radio" value="1"/>翻译后付费</li>--%>
        <%--</ul>--%>

        <ul>
            <li class="zhifb"><input type="radio" id="alipay" name="choose" class="radio" value="2" checked/>
                <img src="<%=path%>/ui/images/zhifb.png" id="imgAliPay"/></li>
            <li class="unionpay"><input type="radio" id="unipay" name="choose" class="radio" value="3"/>
                <img src="<%=path%>/ui/images/unionpay.png" id="imgUniPay"/></li>
        </ul>

        <ul id="balance" style="display: none">
            <li id="imgCash" class="word-ash">
                <input type="radio" id="cash" name="choose" class="radio" value="4"/>
                <a id="balanceNumber">账户余额支付（余额：0元）</a>
            </li>
            <li class="right" id="buzu" style="display: none">
                <a href="javascript:toRecharge()">余额不足，请先充值</a>
            </li>
        </ul>
    </div>
</div>

<form id="toPayForm" method="post" action="<%=path%>/pay/gotoPay">
    <input type="hidden" name="orderId" value="${OrderId}">
    <input type="hidden" name="orderAmount" value="${PriceDisplay}">
    <input type="hidden" name="currencyUnit" value="1">
    <input type="hidden" id="payType" name="payOrgCode" value="ZFB">
    <input type="hidden" id="merchantUrl" name="merchantUrl">
</form>

<form id="toBalancePay" method="post" action="<%=path%>/pay/BalancePayment">
    <input type="hidden" name="orderId" value="${OrderId}">
    <input type="hidden" name="orderAmount" value="${PriceDisplay}">
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
<jsp:include page="/jsp/common/loading.jsp" flush="true"/>

</body>
</html>

<script type="text/javascript">
    var balance = "0.00";
    var balanceBuzu = false;
    $(document).ready(function () {
        GetBalance();

        $("#submit").bind("click", function () {
            var a = $("input[name='choose']:checked").val();
            if (a == null || a == "" || a == 0) {
                return;
            } else {
                if (a == "2") {
                    $("#payType").val("ZFB");
                    $("#toPayForm").submit();
                } else if (a == "3") {
                    $("#payType").val("YL");
                    $("#toPayForm").submit();
                } else if (a == "4") {
                    if (!balanceBuzu) {
                        $("#toBalancePay").submit();
                    } else {
                        $("#EjectTitle").html("余额不足，请选用其他支付方式");
                        $('#eject-mask').fadeIn(100);
                        $('#prompt').slideDown(100);
                    }
                }
            }
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

    function GetBalance() {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/account/GetBalance",
            modal: true,
            timeout: 30000,
            data: {},
            success: function (data) {
                if (data.status == 1) {
                    balance = data.balance;
                    $("#balanceNumber").html("账户余额支付（余额：" + data.balance + "元）");
                    $("#balance").css("display", "block");
                    if (data.balance < ${PriceDisplay}) {
                        $("#buzu").css("display", "block");
                        balanceBuzu = true;
                    }
                }
            },
            error: function (data) {

            },
            beforeSend: function () {
                Loading.ShowLoading();
            },
            complete: function () {
                Loading.HideLoading();
            }
        });
    }

    function toRecharge() {
        window.location.href = '<%=path%>/account/recharge?balance=' + balance;
    }
</script>
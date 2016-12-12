<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/11/2016
  Time: 7:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <title>我的订单</title>
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
</head>
<body>
<div class="wrapper-big">
    <%--头部--%>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="我的订单"/>
        <jsp:param name="BackTo" value="javascript:window.history.go(-1)"/>
    </jsp:include>
    <section class="tij-cg" id="error" style="display: none">
        <ul>
            <li><i class="icon iconfont red">&#xe62b;</i></li>
            <li class="word red">您还没有相应的订单</li>
        </ul>
    </section>
    <div id="wrapper"></div>
    <div class="loading" id="spinner"><a href="javascript:doSomething()" id="spId">点击加载更多</a></div>
    <div><p></p></div>
</div>
<jsp:include page="/jsp/common/loading.jsp" flush="true"/>
<form id="ToOrderPay" method="post" action="<%=path%>/pay/OrderPay">
    <input type="hidden" id="OrderId" name="OrderId" value="">
    <input type="hidden" id="OrderAmount" name="OrderAmount" value="">
</form>
</body>
</html>
<script type="text/javascript">
    var index = 0;
    var PageCount = 1;
    var tips = "";
    var btn1 = "";
    var btn2 = "";
    var isEmpty = false;
    var noMore = false;
    var statusFlag = ""; //0正常 1待支付 2待确认 3待报价
    var detailUrl = "<%=path%>/order/OrderDetail?OrderId=";
    var indexArray = [];

    $(document).ready(function () {
        Loading.HideLoading();
        checkScroll();
    });

    Array.prototype.contains = function (obj) {
        var i = this.length;
        while (i--) {
            if (this[i] === obj) {
                return true;
            }
        }
        return false;
    };

    function lowEnough() {
        var pageHeight = Math.max(document.body.scrollHeight, document.body.offsetHeight);
        var viewportHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight || 0;
        var scrollHeight = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
//        console.log("pageHeight: " + pageHeight + ", viewportHeight: " + viewportHeight + ", scrollHeight: " + scrollHeight);
        return pageHeight - viewportHeight - scrollHeight < 20;
    }

    function doSomething() {
        if (isEmpty) {
            $("#spinner").css("display", "none");
            return;
        }
        if (index == PageCount) {
            return;
        }
        if (indexArray.contains(index + 1)) {
            return pollScroll();
        }

        indexArray.push(index + 1);
        GetOrderList(index + 1);
        pollScroll();
    }

    function checkScroll() {
        if (!lowEnough()) {
            return pollScroll();
        }
        setTimeout(doSomething, 200);
    }

    function pollScroll() {
        setTimeout(checkScroll, 200);
    }

    $(function () {

    });

    function GetOrderList(page) {
        var isUnPaid = "${isUnPaid}";
        var isUnConfirm = "${isUnConfirm}";
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/order/GetOrder",
            modal: true,
            timeout: 30000,
            data: {
                Page: page,
                isUnPaid: isUnPaid,
                isUnConfirm: isUnConfirm
            },
            success: function (data) {
                if (data.status == 1) {
                    if (data.Count == 0) {
                        $("#error").css("display", "block");
                        isEmpty = true;
                    }
                    if (data.PageCount == data.PageNo) {
                        noMore = true;
                    }

                    PageCount = data.PageCount;
                    index = data.PageNo;

                    for (var key in data.OrderList) {
                        var StateShow = GetStateShow(data.OrderList[key].displayFlag);
                        var orderId = data.OrderList[key].orderId;
                        var translateName = data.OrderList[key].translateName;
                        var date = new Date(data.OrderList[key].orderTime).Format("yyyy-MM-dd hh:mm:ss");
                        var price = (data.OrderList[key].totalFee / 1000).toFixed(2);

                        if (orderId == null || orderId == "") {
                            continue;
                        }

                        if (statusFlag == "0") {
                            var htmlStr = "<section class='my-order-content'><div class='my-order-list'><ul><li><p>订单号:</p><p class='blue-word' onclick='window.location.href=\"" + detailUrl + orderId + "\"'>" + orderId + "</p></li><li class='right red-word'>" + StateShow + "</li></ul><ul><li><p class='ow-h'>" + translateName + "</p></li><li class='right ash-word'>" + date + "</li></ul><ul class='ulborder'><li><p>" + tips + price + "元</p></li></ul></div></section>";
                        } else if (statusFlag == "1") {
                            var htmlStr = "<section class='my-order-content'><div class='my-order-list'><ul><li><p>订单号:</p><p class='blue-word' onclick='window.location.href=\"" + detailUrl + orderId + "\"'>" + orderId + "</p></li><li class='right red-word'>" + StateShow + "</li></ul><ul><li><p class='ow-h'>" + translateName + "</p></li><li class='right ash-word'>" + date + "</li></ul><ul class='ulborder'><li><p>" + tips + price + "元</p></li><li class='right'><p class='bord-btn blue'><a href='javascript:ToOrderPay(" + orderId + "," + price + ")'>" + btn1 + "</a></p><p class='bord-btn ash'><a href='javascript:CancelOrder(" + orderId + ")'>" + btn2 + "</a></p></li></ul></div></section>";
                        } else if (statusFlag == "2") {
                            var htmlStr = "<section class='my-order-content'><div class='my-order-list'><ul><li><p>订单号:</p><p class='blue-word' onclick='window.location.href=\"" + detailUrl + orderId + "\"'>" + orderId + "</p></li><li class='right red-word'>" + StateShow + "</li></ul><ul><li><p class='ow-h'>" + translateName + "</p></li><li class='right ash-word'>" + date + "</li></ul><ul class='ulborder'><li><p>" + tips + price + "元</p></li><li class='right'><p class='bord-btn ash'><a href='javascript:ConfirmOrder(" + orderId + ")'>" + btn2 + "</a></p></li></ul></div></section>";
                        } else if (statusFlag == "3") {
                            var htmlStr = "<section class='my-order-content'><div class='my-order-list'><ul><li><p>订单号:</p><p class='blue-word' onclick='window.location.href=\"" + detailUrl + orderId + "\"'>" + orderId + "</p></li><li class='right red-word'>" + StateShow + "</li></ul><ul><li><p class='ow-h'>" + translateName + "</p></li><li class='right ash-word'>" + date + "</li></ul><ul class='ulborder'><li><p>" + tips + "</p></li></ul></div></section>";
                        }

                        $('#wrapper').append(htmlStr);
                    }
                }
            },
            error: function (data) {

            },
            beforeSend: function () {
                $("#spId").html("正在加载");
                $("#spinner").css("display", "block");
            },
            complete: function () {
                if (noMore) {
                    $("#spId").html("没有更多了");
                    $("#spinner").css("display", "block");
                } else {
                    $("#spId").html("点击加载更多");
                    $("#spinner").css("display", "block");
                }
            }
        });
    }

    Date.prototype.Format = function (fmt) {
        var o = {
            "M+": this.getMonth() + 1,
            "d+": this.getDate(),
            "h+": this.getHours(),
            "m+": this.getMinutes(),
            "s+": this.getSeconds(),
            "q+": Math.floor((this.getMonth() + 3) / 3),
            "S": this.getMilliseconds()
        };
        if (/(y+)/.test(fmt))
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    };

    function CancelOrder(OrderId) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/order/OrderCancel",
            modal: true,
            timeout: 30000,
            data: {
                OrderId: OrderId
            },
            success: function (data) {
                if (data.status == 1) {
                    setTimeout(function () {
                        Loading.HideLoading();
                        window.location.reload(true);
                    }, 800);
                }
            },
            error: function (data) {
                Loading.HideLoading();
            },
            beforeSend: function () {
                Loading.ShowLoading();
            },
            complete: function () {

            }
        });
    }

    function ConfirmOrder(OrderId) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/order/OrderConfirm",
            modal: true,
            timeout: 30000,
            data: {
                OrderId: OrderId
            },
            success: function (data) {
                if (data.status == 1) {
                    setTimeout(function () {
                        Loading.ShowLoading();
                        window.location.reload(true);
                    }, 800);
                }
            },
            error: function (data) {
                Loading.ShowLoading();
            },
            beforeSend: function () {
                Loading.ShowLoading();
            },
            complete: function () {

            }
        });
    }

    function ToOrderPay(OrderId, Amount) {
        $("#OrderId").val(OrderId);
        $("#OrderAmount").val(Amount);
        $("#ToOrderPay").submit();
    }

    /**
     * @return {string}
     */
    function GetStateShow(state) {
        if (state == "11") {
            btn1 = "支付";
            btn2 = "取消";
            tips = "需支付：";
            statusFlag = "1";
            return "待支付";
        } else if (state == "13") {
            btn1 = "";
            btn2 = "";
            tips = "请等待报价";
            statusFlag = "3";
            return "待报价";
        } else if (state == "23") {
            btn1 = "";
            btn2 = "";
            tips = "订单金额：";
            statusFlag = "0";
            return "翻译中";
        } else if (state == "50") {
            btn1 = "";
            btn2 = "确认";
            tips = "订单金额：";
            statusFlag = "2";
            return "待确认";
        } else if (state == "52") {
            btn1 = "";
            btn2 = "";
            tips = "订单金额：";
            statusFlag = "0";
            return "待评价";
        } else if (state == "90") {
            btn1 = "";
            btn2 = "";
            tips = "订单金额：";
            statusFlag = "0";
            return "已完成";
        } else if (state == "91") {
            btn1 = "";
            btn2 = "";
            tips = "订单金额：";
            statusFlag = "0";
            return "已关闭";
        } else if (state == "92") {
            btn1 = "";
            btn2 = "";
            tips = "订单金额：";
            statusFlag = "0";
            return "已退款";
        }
    }

</script>
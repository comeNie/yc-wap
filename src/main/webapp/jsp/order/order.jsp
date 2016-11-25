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
    <div class="loading" id="spinner" style="display: none"><a href="#" id="spId">没有更多了</a></div>
</div>
<jsp:include page="/jsp/common/loading.jsp" flush="true"/>
</body>
</html>
<script type="text/javascript">
    var index = 0;
    var PageCount = 1;
    var tips = "";
    var btn1 = "";
    var btn2 = "";
    var isEmpty = false;
    var statusFlag = ""; //0正常 1待支付 2待确认 3待报价
    var detailUrl = "<%=path%>/order/OrderDetail?OrderId=";

    $(document).ready(function () {
        Loading.HideLoading();
        GetOrderList(index + 1);

        $(window).scroll(function () {
            if (isEmpty) {
                return;
            }

            if ($(document).scrollTop() <= 0) {
                console.log("滚动条已经到达顶部为0");
            }

            if ($(document).scrollTop() >= $(document).height() - $(window).height()) {
                console.log("滚动条已经到达底部为" + $(document).scrollTop());
                if (index == PageCount) {
                    $("#spinner").css("display", "block");
                    return;
                }
                GetOrderList(index + 1);
            }
        });
    });

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
                    PageCount = data.PageCount;
                    index = data.PageNo;
                    for (var key in data.OrderList) {
                        var StateShow = GetStateShow(data.OrderList[key].displayFlag);
                        var orderId = data.OrderList[key].orderId;
                        var translateName = data.OrderList[key].translateName;
                        var d = new Date(data.OrderList[key].orderTime);
                        var date = (d.getFullYear()) + "-" + (d.getMonth() + 1) + "-" + (d.getDate()) + " " + (d.getHours()) + ":" + (d.getMinutes()) + ":" + (d.getSeconds());
                        var price = (data.OrderList[key].totalFee / 1000).toFixed(2);

                        if (statusFlag == "0") {
                            var htmlStr = "<section class='my-order-content'><div class='my-order-list'><ul><li><p>订单号:</p><p class='blue-word' onclick='window.location.href=\"" + detailUrl + orderId + "\"'>" + orderId + "</p></li><li class='right red-word'>" + StateShow + "</li></ul><ul><li><p class='ow-h'>" + translateName + "</p></li><li class='right ash-word'>" + date + "</li></ul><ul class='ulborder'><li><p>" + tips + price + "元</p></li></ul></div></section>";
                        } else if (statusFlag == "1") {
                            var htmlStr = "<section class='my-order-content'><div class='my-order-list'><ul><li><p>订单号:</p><p class='blue-word' onclick='window.location.href=\"" + detailUrl + orderId + "\"'>" + orderId + "</p></li><li class='right red-word'>" + StateShow + "</li></ul><ul><li><p class='ow-h'>" + translateName + "</p></li><li class='right ash-word'>" + date + "</li></ul><ul class='ulborder'><li><p>" + tips + price + "元</p></li><li class='right'><p class='bord-btn blue'><a href='#'>" + btn1 + "</a></p><p class='bord-btn ash'><a href='javascript:CancelOrder(" + orderId + ")'>" + btn2 + "</a></p></li></ul></div></section>";
                        } else if (statusFlag == "2") {
                            var htmlStr = "<section class='my-order-content'><div class='my-order-list'><ul><li><p>订单号:</p><p class='blue-word' onclick='window.location.href=\"" + detailUrl + orderId + "\"'>" + orderId + "</p></li><li class='right red-word'>" + StateShow + "</li></ul><ul><li><p class='ow-h'>" + translateName + "</p></li><li class='right ash-word'>" + date + "</li></ul><ul class='ulborder'><li><p>" + tips + price + "元</p></li><li class='right'><p class='bord-btn ash'><a href='#'>" + btn2 + "</a></p></li></ul></div></section>";
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
                Loading.ShowLoading();
            },
            complete: function () {
                Loading.HideLoading();
            }
        });
    }

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
                    window.location.reload();
                }
            },
            error: function (data) {

            },
            beforeSend: function () {

            },
            complete: function () {

            }
        });
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
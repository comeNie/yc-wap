<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/12/2016
  Time: 2:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String to = request.getParameter("to");
    if (to != null && to.equals("text")) {
        request.setAttribute("text", "text");
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>订单详细</title>
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
<div class="wrapper-big" id="OrderDetail">
    <nav class="wap-second-nav">
        <ul>
            <c:if test="${FromRes==1}">
                <a href="javascript:window.location.href='<%=path%>/'"><i class="icon iconfont left">&#xe626;</i></a>
            </c:if>
            <c:if test="${FromRes==null || FromRes==''}">
                <a href="javascript:window.history.go(-1)"><i class="icon iconfont left">&#xe626;</i></a>
            </c:if>
            <li>订单详细</li>
            <a href="javascript:" id="nav-list"><i class="icon iconfont right" id="rightIcon">&#xe629;</i></a>
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

    <c:if test="${Params.translateType=='0' || Params.translateType=='1'}">
        <!--笔译-->
        <c:if test="${Params.translateType=='0'}">
            <section class="original-big">
                <div class="original-cont" id="cont-name">
                    <ul>
                        <li>
                            <p>翻译主题:</p>
                            <p class="sm-word">${Params.translateName}</p>
                        </li>
                    </ul>
                </div>
                <div id="cont-hid" style="display: none"><!--加载显示-->
                    <div class="original-cont">
                        <ul>
                            <li>
                                <p>原文:</p>
                                <p class="sm-word">${Params.needTranslateInfo}</p>
                            </li>
                        </ul>
                        <ul id="Translated">
                            <li>
                                <p>译文:</p>
                                <p class="sm-word">${Params.translateInfo}</p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="click-more" id="click-more"><a href="javascript:void(0)">点击查看更多</a></div>
                <div class="tran-jiaz" id="click-close" style="display: none"><a href="javascript:void(0)"><i
                        class="icon-double-angle-up"></i></a></div>
            </section>
        </c:if>
        <%--文档--%>
        <c:if test="${Params.translateType=='1'}">
            <section class="original-big">
                <div class="original-enclosure">
                    <c:forEach items="${Params.needTranslateFiles}" var="pair">
                        <ul>
                            <li>
                                <p>原文:</p>
                            </li>
                            <li>
                                <p>${pair.key}</p>
                                <p class="right"><a href="javascript:DownloadFile('${pair.value}', '${pair.key}')">下载</a></p>
                            </li>
                        </ul>
                    </c:forEach>
                    <c:forEach items="${Params.translatedFiles}" var="pair">
                        <ul>
                            <li>
                                <p>译文:</p>
                            </li>
                            <li>
                                <p>${pair.key}</p>
                                <p class="right"><a href="javascript:DownloadFile('${pair.value}', '${pair.key}')">下载</a></p>
                            </li>
                        </ul>
                    </c:forEach>
                </div>
            </section>
        </c:if>

        <section class="my-order-content">
            <div class="my-order-list">
                <ul>
                    <li>
                        <p>订单号:</p>
                    </li>
                    <li class="right">${Params.OrderId}</li>
                </ul>
                <ul>
                    <li>
                        <p>订单金额:</p>
                    </li>
                    <li class="right">${Params.PriceDisplay}</li>
                </ul>
                <ul>
                    <li>
                        <p>订单日期:</p>
                    </li>
                    <li class="right">${Params.OrderTime}</li>
                </ul>
                <ul>
                    <li>
                        <p>翻译语言:</p>
                    </li>
                    <li class="right">${Params.TransLang[0].langungePairName}</li>
                </ul>
                <ul>
                    <li>
                        <p>翻译级别:</p>
                    </li>
                    <li class="right">${Params.TranslateLevel[0].translateLevel}</li>
                </ul>
                <ul>
                    <li>
                        <p>用途:</p>
                    </li>
                    <li class="right">${Params.useCn}</li>
                </ul>
                <ul>
                    <li>
                        <p>领域:</p>
                    </li>
                    <li class="right">${Params.fieldCn}</li>
                </ul>
                <ul>
                    <li>
                        <p>预计翻译耗时:</p>
                    </li>
                    <c:if test="${Params.takeDay!='0'}">
                        <li class="right">${Params.takeDay}天${Params.takeTime}小时</li>
                    </c:if>
                    <c:if test="${Params.takeDay=='0'}">
                        <li class="right">${Params.takeTime}小时</li>
                    </c:if>
                </ul>

                <ul>
                    <li>
                        <p>其他:</p>
                    </li>
                    <li class="right">${Params.Urgent}</li>
                </ul>
                <ul class="ulborder">
                    <li class="lin-hei">
                        <p>需求备注:</p>
                    </li>
                </ul>
                <ul class="ulborder">
                    <li class="lin-hei">${Params.Remark}${Params.Remark1}</li>
                </ul>
            </div>
        </section>
        <section class="my-order-content">
            <div class="my-order-list">
                <ul class="ulborder">
                    <li>
                        <p>订单总额:</p>
                    </li>
                    <li class="right">${Params.PriceDisplay}</li>
                </ul>
                <c:if test="${Params.translateType=='0'}">
                    <ul class="zhek">
                        <li>
                            <p>－折扣:</p>
                        </li>
                        <li class="right">${Params.discountSum}</li>
                    </ul>
                </c:if>
                    <%--<ul class="zhek">--%>
                    <%--<li>--%>
                    <%--<p>－优惠码:</p>--%>
                    <%--</li>--%>
                    <%--<li class="right">32元</li>--%>
                    <%--</ul>--%>
                    <%--<ul class="zhek">--%>
                    <%--<li>--%>
                    <%--<p>－优惠卷:</p>--%>
                    <%--</li>--%>
                    <%--<li class="right">232元</li>--%>
                    <%--</ul>--%>
                <ul class="top-ulborder ulborder" id="PaidFee1">
                    <li>
                        <p>实付款:</p>
                    </li>
                    <li class="right blue-word">${Params.PriceDisplay}</li>
                </ul>
            </div>
        </section>
        <section class="my-order-content">
            <div class="my-order-list">
                <ul class="ulborder">
                    <li>
                        <p>联系人信息:</p>
                    </li>
                </ul>
                <ul class="zhek zhek-height">
                    <li>
                        <p>${Params.contactName}</p>
                        <p>${Params.contactTel}</p>
                        <p>${Params.contactEmail}</p>
                    </li>
                </ul>
            </div>
        </section>
        <section class="my-order-content" style="display: none;">
            <div class="my-order-list">
                <ul class="ulborder">
                    <li>
                        <p>发票类型:</p>
                    </li>
                    <li class="right">不开发票</li>
                </ul>
            </div>
        </section>
    </c:if>

    <!--口译订单-->
    <c:if test="${Params.translateType=='2'}">
        <section class="my-order-content">
            <div class="my-order-list">
                <ul>
                    <li>
                        <p>订单号:</p>
                    </li>
                    <li class="right">${Params.OrderId}</li>
                </ul>
                <ul>
                    <li>
                        <p>订单金额:</p>
                    </li>
                    <li class="right">${Params.PriceDisplay}</li>
                </ul>
                <ul>
                    <li>
                        <p>订单日期:</p>
                    </li>
                    <li class="right">${Params.OrderTime}</li>
                </ul>
                <ul class="big-word">
                    <li>
                        <p>翻译类型:</p>
                    </li>
                    <li class="right">
                        <c:forEach var="pair" items="${Params.TranslateLevel}">
                            <p>${pair.translateLevel}</p>
                        </c:forEach>
                    </li>
                </ul>
                <ul class="big-word">
                    <li>
                        <p>翻译语言:</p>
                    </li>
                    <li class="right">
                        <c:forEach var="pair" items="${Params.TransLang}">
                            <p>${pair.langungePairName}</p>
                        </c:forEach>
                    </li>
                </ul>
                <ul>
                    <li>
                        <p>会议开始时间:</p>
                    </li>
                    <li class="right">${Params.stateTime}</li>
                </ul>
                <ul>
                    <li>
                        <p>会议结束时间:</p>
                    </li>
                    <li class="right">${Params.endTime}</li>
                </ul>
                <ul>
                    <li>
                        <p>译员数量:</p>
                    </li>
                    <li class="right">${Params.interperSum}</li>
                </ul>
                <ul>
                    <li>
                        <p>会议地点:</p>
                    </li>
                    <li class="right">${Params.meetingAddress}</li>
                </ul>
                <ul>
                    <li>
                        <p>会议场数:</p>
                    </li>
                    <li class="right">${Params.meetingSum}</li>
                </ul>
                <ul>
                    <li>
                        <p>译员性别:</p>
                    </li>
                    <li class="right">${Params.interperGen}</li>
                </ul>
                    <%--<ul class="ulborder">--%>
                    <%--<li class="lin-hei">--%>
                    <%--<p>需求备注:</p>--%>
                    <%--</li>--%>
                    <%--</ul>--%>
                    <%--<ul class="ulborder">--%>
                    <%--<li class="lin-hei">${Params.Remark}</li>--%>
                    <%--</ul>--%>
            </div>
        </section>
        <section class="my-order-content">
            <div class="my-order-list">
                <ul class="ulborder">
                    <li>
                        <p>订单总额:</p>
                    </li>
                    <li class="right">${Params.PriceDisplay}</li>
                </ul>
                    <%--<ul class="zhek">--%>
                    <%--<li>--%>
                    <%--<p>－折扣:</p>--%>
                    <%--</li>--%>
                    <%--<li class="right">${Params.discountSum}</li>--%>
                    <%--</ul>--%>
                    <%--<ul class="zhek">--%>
                    <%--<li>--%>
                    <%--<p>－优惠码:</p>--%>
                    <%--</li>--%>
                    <%--<li class="right">32元</li>--%>
                    <%--</ul>--%>
                    <%--<ul class="zhek">--%>
                    <%--<li>--%>
                    <%--<p>－优惠卷:</p>--%>
                    <%--</li>--%>
                    <%--<li class="right">232元</li>--%>
                    <%--</ul>--%>
                <ul class="top-ulborder ulborder" id="PaidFee2">
                    <li>
                        <p>实付款:</p>
                    </li>
                    <li class="right blue-word">${Params.PriceDisplay}</li>
                </ul>
            </div>
        </section>
        <section class="my-order-content">
            <div class="my-order-list">
                <ul class="ulborder">
                    <li>
                        <p>联系人信息:</p>
                    </li>
                </ul>
                <ul class="zhek zhek-height">
                    <li>
                        <p>${Params.contactName}</p>
                        <p>${Params.contactTel}</p>
                        <p>${Params.contactEmail}</p>
                    </li>
                </ul>
            </div>
        </section>
        <section class="my-order-content" style="display: none;">
            <div class="my-order-list">
                <ul class="ulborder">
                    <li>
                        <p>发票类型:</p>
                    </li>
                    <li class="right">不开发票</li>
                </ul>
            </div>
        </section>
    </c:if>
</div>

<div class="wrapper-big" id="OrderTrack" style="display: none">
    <nav class="wap-second-nav">
        <ul>
            <a href="javascript:GoDetail()"><i class="icon iconfont left">&#xe626;</i></a>
            <li>订单跟踪</li>
            <a href="javascript:" id="nav-list1"><i class="icon iconfont right" id="rightIcon1">&#xe629;</i></a>
        </ul>
        <div class="pop-nav" id="pop-nav1">
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
    <!--跟踪-->
    <section class="original-big">
        <div class="track-title">
            <ul>
                <li>
                    <p>订单号：</p>
                    <p class="blue">${Params.OrderId}</p>
                </li>
                <li>
                    <p>订单状态：</p>
                    <p id="OrderStatus">Status</p>
                </li>
            </ul>
        </div>
    </section>
    <!--跟踪状态-->
    <section class="original-big mt-20">
        <div class="track-list">
            <div class="track-list-title">订单动态</div>
            <div class="track-list-ctn">
                <c:forEach var="pair" items="${OrderTrackCn}" varStatus="i">
                    <c:if test="${i.index==0}">
                        <div class="track-state track-bule">
                            <p>
                                <span class="circular"><i class="icon iconfont">&#xe630;</i></span>
                                <c:if test="${i.last==false}">
                                    <span class="line"></span>
                                </c:if>
                            </p>
                            <ul>
                                <li class="word">${pair.value}</li>
                                <li>${pair.key}</li>
                            </ul>
                        </div>
                    </c:if>
                    <c:if test="${i.index!=0}">
                        <div class="track-state track-ash">
                            <p>
                                <span class="circular"><i class="icon iconfont">&#xe630;</i></span>
                                <c:if test="${i.last==false}">
                                    <span class="line"></span>
                                </c:if>
                            </p>
                            <ul>
                                <li class="word">${pair.value}</li>
                                <li>${pair.key}</li>
                            </ul>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </section>
</div>

<div class="wrapper-big" id="OrderText" style="display: none">
    <nav class="wap-second-nav">
        <ul>
            <a href="javascript:window.history.go(-1)"><i class="icon iconfont left">&#xe626;</i></a>
            <li>订单详细</li>
            <a href="javascript:" id="nav-list2"><i class="icon iconfont right" id="rightIcon2">&#xe629;</i></a>
        </ul>
        <div class="pop-nav" id="pop-nav2">
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
    <!--译文-->
    <div class="tran-big">
        <ul>
            <li>原文:</li>
            <li>${Params.needTranslateInfo}</li>
        </ul>
    </div>
    <div class="tran-big m-top" id="TranslatedText">
        <ul>
            <li>译文:</li>
            <li>${Params.translateInfo}</li>
        </ul>
    </div>
    <%--<div class="tran-jiaz"><a href="#"><i class="icon-double-angle-up"></i></a></div>--%>
</div>

<div class="zanw"></div>
<section class="order-submit-kou" id="bottom_button">
    <p class="cent blue" id="ButtonLeftP"><a href="javascript:void(0)" id="ButtonLeft">评价订单</a></p>
    <p class="cent green" id="ButtonRightP"><a href="javascript:GoTrack()">订单跟踪</a></p>
</section>
<jsp:include page="/jsp/common/loading.jsp" flush="true"/>

<div class="eject-big">
    <div class="prompt" id="prompt">
        <div class="prompt-title">请选择</div>
        <div class="prompt-confirm">
            <ul>
                <li id="promptText"></li>
            </ul>
        </div>
        <div class="prompt-confirm-btn">
            <a class="btn btn-white-50" id="prompt-btn">确 认</a>
            <a class="btn btn-white-50" id="prompt-btn-close">取 消</a>
        </div>
    </div>
    <div class="mask" id="eject-mask"></div>
</div>

<form id="ToOrderPay" method="post" action="<%=path%>/pay/OrderPay">
    <input type="hidden" id="OrderId" name="OrderId" value="">
    <input type="hidden" id="OrderAmount" name="OrderAmount" value="">
</form>
</body>
</html>

<script type="text/javascript">
    var ShowAmount = "0";
    var ButtonLeft = "";
    var OrderStatus = "";
    $(document).ready(function () {
        Loading.HideLoading();

        GetStateShow('${Params.displayFlag}');

        if (ShowAmount == "0") {
            $("#PaidFee1").css("display", "none");
            $("#PaidFee2").css("display", "none");
            $("#Translated").css("display", "none");
            $("#TranslatedText").css("display", "none");
        }

        if (ButtonLeft != "") {
            $("#ButtonLeft").html(ButtonLeft);
            $("#ButtonLeft").bind("click", function () {
                if (ButtonLeft == "支付订单") {
                    ToOrderPay('${Params.OrderId}', '${Params.OrderPrice}');
                } else if (ButtonLeft == "确认订单") {
                    EjectConfirm();
                }
            });
        } else {
            $("#ButtonLeftP").css("display", "none");
            $("#ButtonRightP").attr("class", "cent2 green");
        }

        $("#OrderStatus").html(OrderStatus);

        $("#click-more").bind("click", function () {
            $("#cont-hid").css("display", "block");
            $("#click-close").css("display", "block");
            $("#click-more").css("display", "none");
        });

        $("#click-close").bind("click", function () {
            $("#cont-hid").css("display", "none");
            $("#click-close").css("display", "none");
            $("#click-more").css("display", "block");
        });

        $("#nav-list2").bind("click", function () {
            if ($("#pop-nav2").attr("opened") == "1") {
                $("#pop-nav2").css("display", "none");
                $("#pop-nav2").attr("opened", "0");
                $("#rightIcon2").html("&#xe629;");
            } else {
                $("#pop-nav2").css("display", "block");
                $("#pop-nav2").attr("opened", "1");
                $("#rightIcon2").html("&#xe618;");
            }
        });

        $("#nav-list1").bind("click", function () {
            if ($("#pop-nav1").attr("opened") == "1") {
                $("#pop-nav1").css("display", "none");
                $("#pop-nav1").attr("opened", "0");
                $("#rightIcon1").html("&#xe629;");
            } else {
                $("#pop-nav1").css("display", "block");
                $("#pop-nav1").attr("opened", "1");
                $("#rightIcon1").html("&#xe618;");
            }
        });

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
        });

        $("#prompt-btn").bind("click", function () {
            $('#eject-mask').fadeOut(200);
            $('#prompt').slideUp(200);
            ConfirmOrder('${Params.OrderId}');
        });

        $("#prompt-btn-close").bind("click", function () {
            $('#eject-mask').fadeOut(200);
            $('#prompt').slideUp(200);
        });

        if (${text=="text"}) {
            if (${Params.translateType=='1' || Params.translateType=="2"}) {
                return;
            }
            ShowText();
        }
    });

    $(function () {

    });

    function ShowText() {
        $("#cont-hid").css("display", "block");
        $("#click-close").css("display", "block");
        $("#click-more").css("display", "none");
    }

    function GoDetail() {
        $("#OrderDetail").css("display", "block");
        $("#OrderTrack").css("display", "none");
        $("#bottom_button").css("display", "block");
        $("#OrderText").css("display", "none");
    }

    function GoTrack() {
        $("#OrderDetail").css("display", "none");
        $("#OrderTrack").css("display", "block");
        $("#bottom_button").css("display", "none");
        $("#OrderText").css("display", "none");
    }

    function EjectConfirm() {
        $('#promptText').html("请确认翻译结果无问题，点击“确定”后将付款给译员");
        $('#eject-mask').fadeIn(100);
        $('#prompt').slideDown(100);
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
                        Loading.HideLoading();
                        window.location.reload(true);
                    }, 800);
                } else {
                    Loading.HideLoading();
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

    function ToOrderPay(OrderId, Amount) {
        $("#OrderId").val(OrderId);
        $("#OrderAmount").val(Amount);
        $("#ToOrderPay").submit();
    }

    function onLogout() {
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

    function DownloadFile(fileId, fileName) {
        var req = "?fileId=" + fileId + "&fileName=" + fileName;
        var url = "<%=path%>/order/download";
        window.location.href = url + req;
    }

    /**
     * @return {string}
     */
    function GetStateShow(state) {
        if (state == "11") {
            ShowAmount = "0";
            ButtonLeft = "支付订单";
            OrderStatus = "待支付";
        } else if (state == "13") {
            ShowAmount = "0";
            ButtonLeft = "";
            OrderStatus = "待报价";
        } else if (state == "23") {
            ShowAmount = "1";
            ButtonLeft = "";
            OrderStatus = "翻译中";
        } else if (state == "50") {
            ShowAmount = "1";
            ButtonLeft = "确认订单";
            OrderStatus = "待确认";
        } else if (state == "52") {
            ShowAmount = "1";
            ButtonLeft = "评价订单";
            OrderStatus = "待评价";
        } else if (state == "90") {
            ShowAmount = "1";
            ButtonLeft = "";
            OrderStatus = "已完成";
        } else if (state == "91") {
            ShowAmount = "0";
            ButtonLeft = "";
            OrderStatus = "已关闭";
        } else if (state == "92") {
            ShowAmount = "1";
            ButtonLeft = "";
            OrderStatus = "已退款";
        }
    }

</script>
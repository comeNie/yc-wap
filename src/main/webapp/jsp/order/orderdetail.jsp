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
%>
<html>
<head>
    <meta charset="utf-8">
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
            <li>订单详情</li>
            <a href="javascript:" id="nav-list"><i class="icon iconfont right">&#xe629;</i></a>
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
        <!--笔译/文档-->
        <section class="original-big">
            <div class="original-cont" id="cont-name">
                <ul>
                    <li>
                        <p>翻译主题:</p>
                        <p class="sm-word">${Params.translateName}</p>
                    </li>
                </ul>
                    <%--<ul>--%>
                    <%--<li>--%>
                    <%--<p>译文:<span>(修改中)</span></p>--%>
                    <%--<p class="sm-word">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aen euismod bibendum--%>
                    <%--laotreet. Proin ……</p>--%>
                    <%--</li>--%>
                    <%--</ul>--%>
            </div>
            <div id="cont-hid" style="display: none"><!--加载显示-->
                <div class="original-cont">
                    <ul>
                        <li>
                            <p>原文:</p>
                            <p class="sm-word">${Params.needTranslateInfo}</p>
                        </li>
                    </ul>
                    <ul>
                        <li>
                            <p>译文:</p>
                            <p class="sm-word">${Params.translateInfo}</p>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="click-more" id="click-more"><a href="javascript:void(0)" id="more" flag="closed">点击查看更多</a>
            </div>
        </section>
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
                    <li class="right">${Params.PriceDisplay}元</li>
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
                    <li class="right">${Params.TransLang}</li>
                </ul>
                <ul>
                    <li>
                        <p>翻译级别:</p>
                    </li>
                    <li class="right">${Params.TranslateLevel}</li>
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
                    <li class="right">${Params.takeTime}小时</li>
                </ul>

                <ul>
                    <li>
                        <p>其他:</p>
                    </li>
                    <li class="right">${Params.Urgent}</li>
                </ul>
                <ul class="ulborder">
                    <li>
                        <p>需求备注:</p>
                    </li>
                    <li class="right">${Params.Remark}</li>
                </ul>
            </div>
        </section>
        <section class="my-order-content">
            <div class="my-order-list">
                <ul class="ulborder">
                    <li>
                        <p>订单总额:</p>
                    </li>
                    <li class="right">${Params.PriceDisplay}元</li>
                </ul>
                <ul class="zhek">
                    <li>
                        <p>－折扣:</p>
                    </li>
                    <li class="right">${Params.discountSum}</li>
                </ul>
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
                <ul class="top-ulborder ulborder">
                    <li>
                        <p>实付款:</p>
                    </li>
                    <li class="right blue-word">${Params.PriceDisplay}元</li>
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
                <ul class="zhek">
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

    <c:if test="${Params.translateType=='2'}">
        <!--口译订单-->
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
                    <li class="right">${Params.PriceDisplay}元</li>
                </ul>
                <ul>
                    <li>
                        <p>订单日期:</p>
                    </li>
                    <li class="right">${Params.OrderTime}</li>
                </ul>
                <ul>
                    <li>
                        <p>翻译类型:</p>
                    </li>
                    <li class="right">陪同翻译</li>
                </ul>
                <ul>
                    <li>
                        <p>翻译语言:</p>
                    </li>
                    <li class="right">${Params.TransLang}</li>
                </ul>
                <ul>
                    <li>
                        <p>会议开始时间:</p>
                    </li>
                    <li class="right">2014-11-11 11:11:11</li>
                </ul>
                <ul>
                    <li>
                        <p>会议结束时间:</p>
                    </li>
                    <li class="right">2014-11-11 11:11:11</li>
                </ul>
                <ul>
                    <li>
                        <p>创建时间:</p>
                    </li>
                    <li class="right">2014-11-11 11:11:11</li>
                </ul>
                <ul>
                    <li>
                        <p>译员数量:</p>
                    </li>
                    <li class="right">2</li>
                </ul>
                <ul>
                    <li>
                        <p>会议地点:</p>
                    </li>
                    <li class="right">北京</li>
                </ul>
                <ul>
                    <li>
                        <p>会议场数:</p>
                    </li>
                    <li class="right">1</li>
                </ul>
                <ul>
                    <li>
                        <p>译员性别:</p>
                    </li>
                    <li class="right">不限</li>
                </ul>
                <ul class="ulborder">
                    <li>
                        <p>需求备注:</p>
                    </li>
                    <li class="right">${Params.Remark}</li>
                </ul>
            </div>
        </section>
        <section class="my-order-content">
            <div class="my-order-list">
                <ul class="ulborder">
                    <li>
                        <p>订单总额:</p>
                    </li>
                    <li class="right">${Params.PriceDisplay}元</li>
                </ul>
                <ul class="zhek">
                    <li>
                        <p>－折扣:</p>
                    </li>
                    <li class="right">${Params.discountSum}</li>
                </ul>
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
                <ul class="top-ulborder ulborder">
                    <li>
                        <p>实付款:</p>
                    </li>
                    <li class="right blue-word">${Params.PriceDisplay}元</li>
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
                <ul class="zhek">
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
            <a href="javascript:" id="nav-list1"><i class="icon iconfont right">&#xe629;</i></a>
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
                    <p>${Params.displayFlag}</p>
                </li>
            </ul>
        </div>
    </section>
    <!--跟踪状态-->
    <section class="original-big mt-20">
        <div class="track-list">
            <div class="track-list-title">订单动态</div>
            <div class="track-list-ctn">
                <c:forEach var="pair" items="${orderStateChange}" varStatus="i">
                    <c:if test="${i.index==0}">
                        <div class="track-state track-bule">
                            <p>
                                <span class="circular"><i class="icon iconfont">&#xe630;</i></span>
                                <span class="line"></span>
                            </p>
                            <ul>
                                <li class="word">${pair.chgDesc}</li>
                                <li><fmt:formatDate type="both" value="${pair.stateChgTime}"/></li>
                            </ul>
                        </div>
                    </c:if>
                    <c:if test="${i.index!=0}">
                        <div class="track-state track-ash">
                            <p>
                                <span class="circular"><i class="icon iconfont">&#xe630;</i></span>
                                <span class="line"></span>
                            </p>
                            <ul>
                                <li class="word">${pair.chgDesc}</li>
                                <li><fmt:formatDate type="both" value="${pair.stateChgTime}"/></li>
                            </ul>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </section>
</div>

<section class="order-submit-kou" id="bottom_button">
    <p class="cent blue"><a href="javascript:void(0)">评价订单</a></p>
    <p class="cent green"><a href="javascript:GoTrack()">订单跟踪</a></p>
</section>
</body>
</html>

<script type="text/javascript">
    $(document).ready(function () {
        $("#click-more").bind("click", function () {
            if ($("#more").attr("flag") == "closed") {
                $("#cont-hid").css("display", "block");
                $("#more").attr("flag", "opened");
            } else if ($("#more").attr("flag") == "opened") {
                $("#cont-hid").css("display", "none");
                $("#more").attr("flag", "closed");
            }
        });

        $("#nav-list1").bind("click", function () {
            if ($("#pop-nav1").attr("opened") == "1") {
                $("#pop-nav1").css("display", "none");
                $("#pop-nav1").attr("opened", "0");
            } else {
                $("#pop-nav1").css("display", "block");
                $("#pop-nav1").attr("opened", "1");
            }
        });

        $("#nav-list").bind("click", function () {
            if ($("#pop-nav").attr("opened") == "1") {
                $("#pop-nav").css("display", "none");
                $("#pop-nav").attr("opened", "0");
            } else {
                $("#pop-nav").css("display", "block");
                $("#pop-nav").attr("opened", "1");
            }
        });
    });

    $(function () {

    });

    function GoDetail() {
        $("#OrderDetail").css("display", "block");
        $("#OrderTrack").css("display", "none");
        $("#bottom_button").css("display", "block");
    }

    function GoTrack() {
        $("#OrderDetail").css("display", "none");
        $("#OrderTrack").css("display", "block");
        $("#bottom_button").css("display", "none");
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
                    window.location.href = ToUrl;
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

</script>
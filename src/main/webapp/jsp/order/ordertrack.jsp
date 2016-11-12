<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/12/2016
  Time: 2:24 PM
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
    <title>订单跟踪</title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="wrapper-big"><!--包含除底部外的所有层-->
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="订单跟踪"/>
        <jsp:param name="BackTo" value="javascript:window.history.go(-1)"/>
    </jsp:include>
    <!--跟踪-->
    <section class="original-big">
        <div class="track-title">
            <ul>
                <li>
                    <p>订单号:</p>
                    <p class="blue">124545667658</p>
                </li>
                <li>
                    <p>订单状态:</p>
                    <p>已完成</p>
                </li>
            </ul>
        </div>
    </section>
    <!--跟踪状态-->
    <section class="original-big mt-20">
        <div class="track-list">
            <div class="track-list-title">订单动态</div>
            <div class="track-list-ctn">
                <div class="track-state track-bule">
                    <p>
                        <span class="circular"><i class="icon iconfont">&#xe630;</i></span>
                        <span class="line"></span>
                    </p>
                    <ul>
                        <li class="word">确认订单</li>
                        <li>2015-04-07 09:53:51</li>
                    </ul>
                </div>
                <div class="track-state track-bule">
                    <p>
                        <span class="circular"><i class="icon iconfont">&#xe630;</i></span>
                        <span class="line"></span>
                    </p>
                    <ul>
                        <li class="word">您的订单已修改完成，请确认翻译结果</li>
                        <li>2015-04-07 09:53:51</li>
                    </ul>
                </div>
                <div class="track-state track-bule">
                    <p>
                        <span class="circular"><i class="icon iconfont">&#xe630;</i></span>
                        <span class="line"></span>
                    </p>
                    <ul>
                        <li class="word">您的订单正在修改中，请耐心等待</li>
                        <li>2015-04-07 09:53:51</li>
                    </ul>
                </div>
                <div class="track-state track-ash">
                    <p>
                        <span class="circular"><i class="icon iconfont">&#xe630;</i></span>
                        <span class="line"></span>
                    </p>
                    <ul>
                        <li class="word">您已申请延时确定译文</li>
                        <li>2015-04-07 09:53:51</li>
                    </ul>
                </div>
                <div class="track-state track-ash">
                    <p>
                        <span class="circular"><i class="icon iconfont">&#xe630;</i></span>
                        <span class="line"></span>
                    </p>
                    <ul>
                        <li class="word">您的订单已翻译完成，请确认翻译结果</li>
                        <li>2015-04-07 09:53:51</li>
                    </ul>
                </div>
                <div class="track-state track-ash">
                    <p>
                        <span class="circular"><i class="icon iconfont">&#xe630;</i></span>
                        <span class="line"></span>
                    </p>
                    <ul>
                        <li class="word">订单已被译员领取，正在翻译中，请耐心等待</li>
                        <li>2015-04-07 09:53:51</li>
                    </ul>
                </div>
                <div class="track-state track-ash">
                    <p>
                        <span class="circular"><i class="icon iconfont">&#xe630;</i></span>
                        <span class="line"></span>
                    </p>
                    <ul>
                        <li class="word">已经提交订单，订单号5000345</li>
                        <li>2015-04-07 09:53:51</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
</div>
</body>
</html>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
<script type="text/javascript">
    $(document).ready(function () {

    });

    $(function () {

    });

</script>
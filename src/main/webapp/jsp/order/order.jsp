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
    </head>
</head>
<body>
<div class="wrapper-big"><!--包含除底部外的所有层-->
    <%--头部--%>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="我的订单"/>
        <jsp:param name="BackTo" value="javascript:window.history.go(-1)"/>
    </jsp:include>

    <!--订单form-->
    <section class="my-order-content">
        <div class="my-order-list">
            <ul>
                <li>
                    <p>订单号:</p>
                    <p class="blue-word">124545667658</p>
                    <p class="bord-btn red"><a href="#">企业</a></p>
                </li>
                <li class="right red-word">修改中</li>
            </ul>
            <ul>
                <li>
                    <p class="ow-h">翻译什么什么内容翻译什么什么内容</p>
                </li>
                <li class="right ash-word">2015/11/11 20:23:49</li>
            </ul>
            <ul class="ulborder">
                <li>
                    <p>实付款:</p>
                    <p>1600元</p>
                </li>
            </ul>
        </div>
    </section>
    <section class="my-order-content">
        <div class="my-order-list">
            <ul>
                <li>
                    <p>订单号:</p>
                    <p class="blue-word">124545667658</p>
                </li>
                <li class="right red-word">已完成</li>
            </ul>
            <ul>
                <li>
                    <p class="ow-h">翻译文件名.txt</p>
                </li>
                <li class="right ash-word">2015/11/11 20:23:49</li>
            </ul>
            <ul class="ulborder">
                <li>
                    <p>请耐心等待报价</p>
                </li>
                <li class="right">
                    <p class="bord-btn blue"><a href="#">企业</a></p>
                    <p class="bord-btn ash"><a href="#">取消</a></p>
                </li>
            </ul>
        </div>
    </section>
    <section class="my-order-content">
        <div class="my-order-list">
            <ul>
                <li>
                    <p>订单号:</p>
                    <p class="blue-word">124545667658</p>
                    <p class="bord-btn red"><a href="#">企业</a></p>
                </li>
                <li class="right red-word">翻译中</li>
            </ul>
            <ul>
                <li>
                    <p class="ow-h">翻译什么什么内容翻译什么什么内容</p>
                </li>
                <li class="right ash-word">2015/11/11 20:23:49</li>
            </ul>
            <ul>
                <li>
                    <p>实付款:</p>
                    <p>1600元</p>
                </li>
            </ul>
        </div>
    </section>
    <div class="loading"><a href="#">加载更多…</a></div>
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
<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/3/2016
  Time: 5:14 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>新增联系方式</title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
    <%@ include file="../common/timezone.jsp" %>
</head>
<body>

<nav class="wap-second-nav">
    <ul>
        <a href="javascript:"><i class="icon iconfont left">&#xe626;</i></a>
        <li>联系方式</li>
    </ul>
</nav>

<!--订单内容-->
<section class="order-content new-cont">
    <div class="contact-list">
        <ul>
            <li class="noe"><i class="icon iconfont">&#xe60e;</i></li>
            <li class="tow">
                <p>
                    <span>王译云 138****8481</span>
                    <span class="mor">默认</span>
                </p>
                <p class="ash">wangyiyun@xxxx.com</p>
            </li>
            <li class="three"><i class="icon iconfont">&#xe62a;</i></li>
        </ul>
        <ul>
            <li class="tow">
                <p>
                    <span>王译云 138****8481</span>
                </p>
                <p class="ash">wangyiyun@xxxx.com</p>
            </li>
            <li class="three"><i class="icon iconfont">&#xe62a;</i></li>
        </ul>
        <ul class="none-border">
            <li class="tow">
                <p>
                    <span>王译云 138****8481</span>
                </p>
                <p class="ash">wangyiyun@xxxx.com</p>
            </li>
            <li class="three"><i class="icon iconfont">&#xe62a;</i></li>
        </ul>
    </div>
</section>
<section class="add-btn">
    <a href="#"><input type="button" class="btn submit-btn btn-blue" value="新增联系方式"></a>
</section>
</body>
</html>

<script type="text/javascript" src="<%=path%>/js/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
<script type="text/javascript">
    $(document).ready(function() {

    });

    $(function () {

    });

</script>

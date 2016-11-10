<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/3/2016
  Time: 5:28 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>联系方式</title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="wrapper-big" id="body">
    <%--头部--%>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="联系方式"/>
        <jsp:param name="BackTo" value="javascript:window.history.go(-1)"/>
    </jsp:include>
    <!--订单内容-->
    <section class="order-content new-cont">
        <div class="order-list">
            <ul>
                <li>手机:</li>
                <li><input type="text" class="input input-medium" placeholder="请输入手机号码（必填）"></li>
            </ul>
            <ul>
                <li>姓名:</li>
                <li><input type="text" class="input input-medium" placeholder="请输入姓名"></li>
            </ul>
            <ul>
                <li>邮箱:</li>
                <li><input type="text" class="input input-medium" placeholder="请输入接收译文的邮箱"></li>
            </ul>

            <ul class="none-border" style="display: none">
                <li class="width-large">
                    <p>设为默认地址</p>
                    <p class="right-multi"><input type="checkbox" class="multi-switch" value="0"/></p>
                </li>
            </ul>
        </div>
    </section>
</div>
<section class="add-btn">
    <a href="javascript:void(0)" id="submit" class="btn submit-btn btn-blue">提交订单</a>
</section>
</body>
</html>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
<script src="<%=path%>/js/modular/multi-switch.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.multi-switch').multiSwitch();
        $("#submit").bind("click", function () {
            onSubmit();
        });
    });

    $(function () {

    });

    function onSubmit() {
        var test = "haha";
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/written/onNewContactSubmit",
            modal: true,
            timeout: 30000,
            data: {
                test: test
            },
            success: function (data) {
                var ToUrl = "<%=path%>/written/payment";
                window.location.href = ToUrl;
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

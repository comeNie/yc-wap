<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/3/2016
  Time: 5:20 PM
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
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
    <script type="text/javascript" src="<%=path%>/js/common/wordcount.js"></script>
    <%@ include file="../common/timezone.jsp" %>
</head>
<body>
<div class="wrapper-big" id="body">
    <%--头部--%>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="确认下单"/>
        <jsp:param name="BackTo" value="javascript:window.history.go(-1)"/>
    </jsp:include>
    <!--新增联系方式-->
    <section class="add-contact" style="display: none">
        <a href="#"><i class="icon-plus"></i>新增联系方式</a>
    </section>
    <!--订单内容-->
    <section class="order-content">
        <div class="order-list">
            <ul>
                <li>翻译主题:</li>
                <li class="right word">${Detail}
                </li>
            </ul>
            <ul>
                <li>翻译语言:</li>
                <li class="right">${DualVal}
                </li>
            </ul>
            <ul>
                <li>领域:</li>
                <li class="right">${DomainVal}
                </li>
            </ul>
            <ul>
                <li>用途:</li>
                <li class="right">${PurposeVal}
                </li>
            </ul>
            <ul class="none-border">
                <li>级别:</li>
                <li class="right">${TransLvVal}
                </li>
            </ul>
        </div>
    </section>
    <!--订单内容-->
    <section class="order-content">
        <div class="order-message">
            <ul>
                <li>给译员留言:</li>
                <li><textarea id="message" class="textarea textarea-large"></textarea></li>
            </ul>
        </div>
    </section>
</div>
<!--底部-->
<section class="order-submit">
    <p class="left">${Price}
    </p>
    <p class="right"><a href="javascript:void(0)" id="submit">下一步</a></p>
</section>

</body>
</html>

<script type="text/javascript">
    $(function () {

    });

    $(document).ready(function () {
        $("#submit").bind("click", function () {
            onSubmit();
        });

        $("#message").on("input propertychange", function () {
            var $this = $(this);
            var _val = $this.val();
            if (_val.length > 50) {
                $this.val(_val.substring(0, 50));
            }
        });
    });


    function onSubmit() {
        var msg = $("#message").val();
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/written/onConfirmSubmit",
            modal: true,
            timeout: 30000,
            data: {
                msg: msg
            },
            success: function (data) {
                window.location.href = "<%=path%>/written/newContact";
            },
            error: function (data) {

            },
            beforeSend: function () {

            },
            complete: function () {

            }
        });
    }

</script>
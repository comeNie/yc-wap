<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title><spring:message code="written.confirm.title1"/></title>
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
    <spring:message code="written.confirm.title1" var="title"/>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="${title}"/>
        <jsp:param name="BackTo" value="javascript:ToContent()"/>
    </jsp:include>
    <!--新增联系方式-->
    <section class="add-contact" style="display: none">
        <a href="#"><i class="icon-plus"></i><spring:message code="written.confirm.new"/></a>
    </section>
    <!--订单内容-->
    <section class="order-content">
        <div class="order-list">
            <ul>
                <li><spring:message code="written.confirm.detail"/></li>
                <li class="right word">${Detail}
                </li>
            </ul>
            <ul>
                <li><spring:message code="written.confirm.language"/></li>
                <li class="right">${DualVal}
                </li>
            </ul>
            <ul>
                <li><spring:message code="written.confirm.domain"/></li>
                <li class="right">${DomainVal}
                </li>
            </ul>
            <ul>
                <li><spring:message code="written.confirm.purpose"/></li>
                <li class="right">${PurposeVal}
                </li>
            </ul>
            <ul class="none-border">
                <li><spring:message code="written.confirm.level11"/></li>
                <li class="right">${TransLvVal}
                </li>
            </ul>
        </div>
    </section>
    <!--订单内容-->
    <section class="order-content">
        <div class="order-message">
            <ul>
                <li><spring:message code="written.confirm.remark"/></li>
                <li><textarea id="message" class="textarea textarea-large"
                              placeholder="<spring:message code="written.confirm.holder"/>"></textarea></li>
            </ul>
        </div>
    </section>
</div>
<!--底部-->
<section class="order-submit">
    <p class="left">${Price}
    </p>
    <p class="right"><a href="javascript:void(0)" id="submit"><spring:message code="written.confirm.next"/></a></p>
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

    function ToContent() {
        var href = "<%=path%>/written";
        window.location.href = href;
        location.replace("<%=path%>/written");
    }


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
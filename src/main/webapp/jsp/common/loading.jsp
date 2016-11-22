<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/12/2016
  Time: 11:09 AM
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
    <title>Loading</title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="loading-bj" id="_loading" hidden>
    <section class="loading-wrapper" >
        <p class="img1"><img src="<%=path%>/ui/images/loading-logo.png"/></p>
        <p class="img2">
        <div id="foo" style="margin-top:1rem;"></div>
        <p class="img3">加载中</p>
    </section>
</div>
</body>
</html>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/spin.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/loading.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#_loading").css("display", "block");
    });

    $(function () {

    });

    var Loading = {
        ShowLoading: function () {
            $("#_loading").css("display", "block");
        },
        HideLoading: function () {
            $("#_loading").css("display", "none");
        }
    }

</script>
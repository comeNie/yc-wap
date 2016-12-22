<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 12/15/2016
  Time: 5:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
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
<div class="wrapper-big">
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="订单详细"/>
        <jsp:param name="BackTo" value="javascript:window.history.go(-1)"/>
        <jsp:param name="ShowIcon" value="false"/>
    </jsp:include>
    <!--译文-->
    <div class="tran-big">
        <ul>
            <li>原文:</li>
            <li>随着中国旅游业的发展，英语起着重要的作用。我认为这在主要是因为越来越多的外国人来中国参观，
                才使得英语走近我们的生活。事实上，作为一门国际性语言，英语的用法也在快速地发生变化。
                或许你会问英语在一段时间里为什么会起变化呢？让我来告诉你理由。
                当不同文化互相交流时，所有的语言都会有所发展。
                目前，英国仍被公认为第一外语，所以我们有必要学好英语。
                信不信由你，只要你尽量扩充词汇量，与此同时掌握语法规则，充分利用所学英语知识与人交流，你就一定可以掌握英语。
            </li>
        </ul>
    </div>
    <div class="tran-big m-top">
        <ul>
            <li>译文:</li>
            <li>With China's development of tourism, English plays an important role.
                I think that this is mainly because more and more foreigners come to China to visit,
                which makes the English approached our lives. In fact, as an international language,
                English usage is also rapidly changing. Perhaps you might ask why the English in the period of time will
                play a change?
                Let me tell you the reasons. When the exchange of different cultures, all languages will be developed.
                At present, the British still recognized as the first foreign language, so we need to learn English
                well.
                Believe it or not, as long as you try to expand the vocabulary,
                grammar rules at the same time grasp the full use of what they have learned with people sharing
                knowledge of English, you will be able to master English.
            </li>
        </ul>
    </div>
    <div class="tran-jiaz"><a href="#"><i class="icon-double-angle-up"></i></a></div>
</div>
<section class="order-submit-kou">
    <p class="cent blue"><a href="#">评价订单</a></p>
    <p class="cent green"><a href="#">订单跟踪</a></p>
</section>

</body>
</html>

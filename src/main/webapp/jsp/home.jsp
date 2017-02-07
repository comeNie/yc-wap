<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; utf-8" pageEncoding="utf-8" session="false"%>
<%
    String path = request.getContextPath();
%>
<%@ include file="common/timezone.jsp" %>
<html>
<!-- JiaThis Button BEGIN -->
    <script type="text/javascript" src="http://v1.jiathis.com/code/jia.js" charset="utf-8"></script>

    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
    <!-- JiaThis Button END -->
<head>
	<title>Home</title>
</head>
<body onload="loaded()">
<div class="eject-big">
    <div class="prompt-share" id="share-eject">
        <div class="prompt-share-title"><spring:message code="start.tishi"/></div>
        <!--确认删除-->
        <div class="prompt-share-confirm">
            <ul>
                <a href="#">
                    <li class="weix">
                        <p><i class="icon iconfont">&#xe61a;</i></p>
                        <p><spring:message code="start.weixin"/></p>
                    </li>
                </a>
                <a href="#">
                    <li class="weixq">
                        <p><i class="icon iconfont">&#xe61f;</i></p>
                        <p><spring:message code="start.weixinquan"/></p>
                    </li>
                </a>
                <a href="#">
                    <li class="blog">
                        <p><i class="icon iconfont">&#xe627;</i></p>
                        <p><spring:message code="start.weibo"/></p>
                    </li>
                </a>
                <a href="#">
                    <li class="qq">
                        <p><i class="icon iconfont">&#xe61e;</i></p>
                        <p><spring:message code="start.qq"/></p>
                    </li>
                </a>
                <a href="#">
                    <li class="watercress">
                        <p><i class="icon iconfont">&#xe625;</i></p>
                        <p><spring:message code="start.douban"/></p>
                    </li>
                </a>
                <a href="#">
                    <li class="message">
                        <p><i class="icon iconfont">&#xe622;</i></p>
                        <p><spring:message code="start.duanxin"/></p>
                    </li>
                </a>
                <a href="#">
                    <li class="copy">
                        <p><i class="icon iconfont">&#xe620;</i></p>
                        <p><spring:message code="start.copy"/></p>
                    </li>
                </a>
            </ul>
        </div>
        <div class="close-icon"><i class="icon iconfont" id="close-icon">&#xe611;</i></div>
    </div>
    <div class="mask" id="eject-mask1"></div>
    <div class="release-btn" id="release-btn"><a id="share-icon"><spring:message code="start.sayTrans"/></a></div>
    <a onclick="geturl()">haha</a>
</div>
    <!-- JiaThis Button BEGIN -->
    <%--<div class="jiathis_style_m">123</div>--%>
    <%--<script type="text/javascript" src="http://v3.jiathis.com/code/jiathis_m.js" charset="utf-8"></script>--%>
    <%--<!-- JiaThis Button END -->--%>
    <%--<!-- JiaThis Button BEGIN -->--%>
    <div id="ckepop">
        <%--<a href="http://www.jiathis.com/share/" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank"></a>--%>
        <a class="jiathis_button_tsina">新浪微博</a>
        <a class="jiathis_button_weixin">QQ空间</a>
        <a class="jiathis_button_kaixin001">开心网</a>
        <a class="jiathis_button_renren">人人网</a>
    </div>
    <%--<script type="text/javascript" src="http://v2.jiathis.com/code/jia.js" charset="utf-8"></script>--%>
    <!-- JiaThis Button END -->
    <!-- JiaThis Button BEGIN -->


    <%--<div id="ckepop">--%>
        <%--<a href="http://www.jiathis.com/share/" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank">分享到：</a>--%>
        <%--<a class="jiathis_button_tools_12"></a>--%>
        <%--<a class="jiathis_button_tools_1"></a>--%>
        <%--<a class="jiathis_button_tools_3"></a>--%>
        <%--<a class="jiathis_button_tools_4"></a>--%>
    <%--</div>--%>
    <%--<script type="text/javascript" src="http://v2.jiathis.com/code/jia.js" charset="utf-8"></script>--%>
    <!-- JiaThis Button END -->
</body>
</html>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
//    var jiathis_config = {
//        boldNum:0,
//        siteNum:7,
//        showClose:false,
//        sm:"t163,kaixin001,renren,douban,tsina,tqq,tsohu",
//        imageUrl:"http://v2.jiathis.com/code/images/r5.gif",
//        imageWidth:26,
//        marginTop:150,
//        url:"http://www.jiathis.com",
//        title:"自定义TITLE #微博话题#",
//        summary:"分享的文本摘要",
//        pic:"自定义分享的图片连接地址",
//        data_track_clickback:true,
//        appkey:{
//            "tweixin":"wx7422755a9ea3c6ed",
//        },
//        ralateuid:{
////            "tsina":"您的新浪微博UID"
//        },
//        "shortUrl":是否开启短链接,
//        evt:{
//            "share":"geturl"
////            ( 可以根据自己的命名规范来定义一个自定义函数，如：getEvent )
////    说明：evt参数可以得到用户的分享操作的相关信息。比如：用户分享的URL，用户分享到的媒体。但是，我们不能确定用
////    户是否真正成功的分享了内容，只能确定用户确实是点击了分享按钮……
//    }
//    }
//    function geturl(evt) {
//        alert('用户分享的网页是：'+evt.data.url);
//    }
</script>
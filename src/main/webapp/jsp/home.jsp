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
    <style>
        .prompt-share{width:11.52rem;height:10.98rem; background:#fff;position:fixed;top:50%;left:50%;margin-top:-5.49rem;margin-left:-5.76rem;z-index:999;border-radius:5px;display: none;}
        .prompt-share-title{ width:100%; float:left;height:1.28rem;color:#333;font-size:0.42rem;padding:0.64rem 0 0 0.64rem;}
        .prompt-share-confirm{ width:100%;float:left; margin-top:25px;}
        .prompt-share-confirm ul{ width:100%;float:left; }
        .prompt-share-confirm ul li{width:25%;float:left;margin-top:0.24rem;text-align: center;line-height:1.34rem;}
        .prompt-share-confirm ul a{font-size:0.42rem;color:#333}
        .prompt-share-confirm ul li i{font-size:1.53rem;}
        .prompt-share-confirm ul .weix i{color:#3cb034}
        .prompt-share-confirm ul .weixq i{color:#3eb135}
        .prompt-share-confirm ul .blog i{color:#f99211;font-size:1.5rem}
        .prompt-share-confirm ul .qq i{color:#1b82d2}
        .prompt-share-confirm ul .watercress i{color:#2e9e3b;font-size:1.52rem}
        .prompt-share-confirm ul .message i{color:#1cc03b}
        .prompt-share-confirm ul .copy i{color:#34495e;font-size:1.5rem}
        body .prompt-share-confirm a {background:none;padding-left:0px !important; margin-right:10px; width:40px!important; height:40px!important;}
        body .prompt-share-confirm .se { background:url(<%=path%>/ui/images/4.jpg) no-repeat;background-position: 2px 2px;}
    </style>
<head>
	<title>Home</title>
</head>
<body >
<div class="eject-big">
    <div class="prompt-share" id="share-eject">
        <div class="prompt-share-title"><spring:message code="start.tishi"/></div>
        <!--确认删除-->
        <div class="prompt-share-confirm" id="ckepop">
            <ul>
                <a class="jiathis_button_weixin se">
                    <%--&#xe61a;--%>
                    <%--<li class="weix">--%>
                        <%--&lt;%&ndash;<p><i class="icon iconfont"></i></p>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<p><spring:message code="start.weixin"/></p>&ndash;%&gt;--%>
                    <%--</li>--%>
                </a>
                <a class="jiathis_button_tsina">
                    <li class="blog">
                        <%--<p><i class="icon iconfont">&#xe627;</i></p>--%>
                        <p><spring:message code="start.weibo"/></p>
                    </li>
                </a>
                <a class="jiathis_button_cqq">
                    <li class="qq">
                        <%--<p><i class="icon iconfont">&#xe61e;</i></p>--%>
                        <p><spring:message code="start.qq"/></p>
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
    <%--<div class="jiathis_style_32x32" id="ckepop">--%>
        <%--<a class="jiathis_button_weixin">--%>
          <%--微信--%>
        <%--</a>--%>
        <%--<a class="jiathis_button_tsina">--%>
          <%--新浪--%>
        <%--</a>--%>
        <%--<a class="jiathis_button_cqq">--%>
          <%--QQ--%>
        <%--</a>--%>
    <%--</div>--%>



</body>
</html>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
    var jiathis_config = {
        boldNum:3,
        siteNum:3,
        showClose:false,
        sm:"tweixin,tsina,cqq",
        url:"http://waptest.yeecloud.com/",
        title:"测测测",
        summary:"这个一条测试数据",
        pic:"http://photocdn.sohu.com/20170216/Img480849192.jpeg",
        data_track_clickback:true,
        appkey:{
            "weixin":"wx7422755a9ea3c6ed",
            "tsina":"3005206551",
            "cqq":"101383604",
        },
//        ralateuid:{
//            "tsina":"您的新浪微博UID"
//        },
//        "shortUrl":是否开启短链接,
        evt:{
            "share":"geturl"
        }
    }
    function geturl(evt) {
        alert('用户分享的网页是：'+evt.data.url);
    }
</script>
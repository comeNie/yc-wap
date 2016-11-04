<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>首页</title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
</head>

<body>
<!--分享弹出框-->
<div class="eject-big">
    <div class="prompt-share" id="share-eject">
        <div class="prompt-share-title">请选择</div>
        <!--确认删除-->
        <div class="prompt-share-confirm">
            <ul>
                <a href="#">
                    <li class="weix">
                        <p><i class="icon iconfont">&#xe61a;</i></p>
                        <p>微信</p>
                    </li>
                </a>
                <a href="#">
                    <li class="weixq">
                        <p><i class="icon iconfont">&#xe61f;</i></p>
                        <p>微信朋友圈</p>
                    </li>
                </a>
                <a href="#">
                    <li class="blog">
                        <p><i class="icon iconfont">&#xe627;</i></p>
                        <p>微博</p>
                    </li>
                </a>
                <a href="#">
                    <li class="qq">
                        <p><i class="icon iconfont">&#xe61e;</i></p>
                        <p>QQ</p>
                    </li>
                </a>
                <a href="#">
                    <li class="watercress">
                        <p><i class="icon iconfont">&#xe625;</i></p>
                        <p>豆瓣</p>
                    </li>
                </a>
                <a href="#">
                    <li class="message">
                        <p><i class="icon iconfont">&#xe622;</i></p>
                        <p>短信</p>
                    </li>
                </a>
                <a href="#">
                    <li class="copy">
                        <p><i class="icon iconfont">&#xe620;</i></p>
                        <p>复制链接</p>
                    </li>
                </a>
            </ul>
        </div>
        <div class="close-icon"><i class="icon iconfont" id="close-icon">&#xe611;</i></div>
    </div>
    <div class="mask" id="eject-mask"></div>
</div>
<!--弹出框结束-->
<section class="notice" style="display: none">
    <p>公告信息等等等等</p>
    <label><i class="icon iconfont">&#xe618;</i></label>
</section>
<nav class="wap-nav">
    <ul>
        <li class="logo"><img src="<%=path%>/ui/images/logo.png" /></li>
        <li class="right"><input type="button" class="btn login-btn" value="登录"></li>
    </ul>
</nav>
<section class="index-wrapper">
    <!--转换语言-->
    <section class="testing">
        <p>
            <select class="select testing-select" id="source-lan">
                <%--<option>检测语言：中文</option>--%>
                <c:forEach items="${requestScope.languagepairs}" var="pair">
                    <option>${pair}</option>
                </c:forEach>
            </select>
            <span>|</span>
        </p>
        <p class="test-icon"><i class="icon iconfont">&#xe621;</i></p>
        <p>
            <select class="select testing-select" id="target-lan">
                <c:forEach items="${requestScope.languagepairs}" var="pair">
                    <option>${pair}</option>
                </c:forEach>
            </select>
            <span>|</span>
        </p>
    </section>
    <!--翻译内容-->
    <section class="translation-content">
        <textarea class="textarea textarea-large" name="chick-int" id="chick-int"></textarea>
        <a hrel="#"><i class="icon iconfont">&#xe618;</i></a>
    </section>
    <!--翻译按钮-->
    <section class="translate-btn" id="chick-btn">
        <input type="button" class="btn btn-big" value="翻译" id="btn-translate">
    </section>
    <!--翻译结果-->
    <section class="translation-content-english" id="results">
        <textarea class="textarea textarea-xlarge" id="result-text"></textarea>
        <p>
            <a href="#"><i class="icon iconfont" id="toAudio">&#xe61b;</i></a>
            <a href="#" id="share-icon"><i class="icon iconfont">&#xe61c;</i></a>
        </p>
    </section>

</section>
<section id="wrapper-hide" >
    <section class="index-wrapper">
        <!--历史纪录-->
        <section class="history" style="display: none">
            <div class="history-list">
                <ul>
                    <a href="javascript:">
                        <li>
                            <p><i class="icon iconfont">&#xe624;</i></p>
                            <p class="word">就显示一行 就显示一行显示一行</p>
                            <p class="word-en">yiwen yiwen yiwen</p>
                            <p class="right"><i class="icon iconfont">&#xe618;</i></p>
                        </li>
                    </a>
                    <a href="javascript:">
                        <li>
                            <p><i class="icon iconfont">&#xe624;</i></p>
                            <p class="word">就显示一行 就显示一行显示一行</p>
                            <p class="word-en">yiwen yiwen yiwen</p>
                            <p class="right"><i class="icon iconfont">&#xe618;</i></p>
                        </li>
                    </a>
                </ul>
            </div>
        </section>

    </section>
    <!--banner-->
    <section class="banner"><a href="#" id="banner1"><img src="<%=path%>/ui/images/banner-1.png"></a></section>
    <section class="banner"><a href="#"><img src="<%=path%>/ui/images/banner-2.png"></a></section>

</section>

<!--底部-->
<section class="footer-big">
    <section class="terminal">
        <ul>
            <li class="none">
                <p><img src="<%=path%>/ui/images/icon-1.png" /></p>
                <p>客户端</p>
            </li>
            <li class="tow current">
                <p><img src="<%=path%>/ui/images/icon-2.png" /></p>
                <p>触屏版</p>
            </li>
            <li class="three none-ml">
                <p><img src="<%=path%>/ui/images/icon-3.png" /></p>
                <p>电脑版</p>
            </li>
        </ul>
    </section>
    <footer class="footer">
        <ul>
            <li><a hrel="#">关于我们</a>|<a hrel="#">译云招募</a>|<a hrel="#">意见反馈</a>|<a hrel="#">ENGLISH</a></li>
            <li class="ash">中译语通科技（北京）有限公司版权所有</li>
        </ul>
    </footer>
</section>
</body>
</html>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#btn-translate").bind("click",function () {
            $("#chick-btn").css("display", "none");
            choosePairs();
            translate();
        });

//        $("#target-lan").bind("click",function () {
//            if (){
//
//            }
//        });

        $("#toAudio").bind("click",function () {
           textToAudio();
        });

        $(".none").bind("click",function () {
           downloadApp(); 
        });
//        跳转到笔译下单
        $("#banner1").bind("click",function () {
            window.location.href="<%=path%>/written";
        });


    });
        var beRead=$("#result-text").val();
    function textToAudio() {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/ttsSync",
            modal: true,
            showBusi: false,
            timeout: 30000,
            data: {
                languages:tarvalue,
                beRead:beRead
            },
            success: function (data) {
                console.info(data);
                if (data.status == 1) {//成功

                } else {

                }
            },
            error: function (data) {
                console.info(data);
            }
            });

    }

    function downloadApp() {
        var andlink="http://android.myapp.com/myapp/detail.htm?apkName=cn.com.gtcom.ydt";
        var ioslink="https://itunes.apple.com/cn/app/zhao-fan-yi-findyee/id1017302386?mt=8";
        if (/android/i.test(navigator.userAgent)){
            window.location.href=andlink;
        }else{
            window.location.href=ioslink;
        }
    }
    var srcvalue;
    var tarvalue;
    var sourcetext;
    function choosePairs() {
        sourcetext=$("#chick-int").val();
        srctext=$("#source-lan option:selected").text();
        console.info("sourcetext--------"+sourcetext);
        console.info("srctext-----"+srctext);
        if (srctext=="中文"){
            srcvalue="zh";
        }else if (srctext=="英语"){
            srcvalue="en";
        }else if (srctext=="法语"){
            srcvalue="fr";
        }else if (srctext=="俄语"){
            srcvalue="ru";
        }else {
            srcvalue="pt";
        }
        var tartext=$("#target-lan option:selected").text();
        console.info("tartext-------"+tartext);

        if (tartext=="中文"){
            tarvalue="zh";
        }else if (tartext=="英语"){
            tarvalue="en";
        }else if (tartext=="法语"){
            tarvalue="fr";
        }else if (tartext=="俄语"){
            tarvalue="ru";
        }else {
            tarvalue="pt";
        }
        console.info("srcvalue-----"+srcvalue);
        console.info("tarvalue-----"+tarvalue);
    }

    function translate() {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/translate",
            modal: true,
            showBusi: false,
            timeout: 30000,
            data: {
                srcl:srcvalue,
                tgtl:tarvalue,
                text:sourcetext
            },
            success: function (data) {
                console.info(data);
                if (data.status == 1) {//成功
                    $("#result-text").val(data.target);
                    console.info("data.msg.target...."+data.target);
                } else {

                }
            },
            error: function (data) {
                console.info(data);
            }
        });
    }


</script>
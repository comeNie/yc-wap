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
        <li class="right">
            <%--<input type="button" class="btn login-btn" value="登录" id="btn-login">--%>
            <a href="javascript:window.location.href='<%=path%>/login/login'" class="btn login-btn" id="btn-login">登录</a>
        </li>
    </ul>
</nav>
<section class="index-wrapper">
    <!--转换语言-->
    <section class="testing">
        <p>
            <select class="select testing-select" id="source-lan">
                <option id="auto-zh" style="display: none">检测语言：中文</option>
                <option id="auto-en" style="display: none">检测语言：英语</option>
                <c:forEach items="${requestScope.languagepairs}" var="pair">
                    <option>${pair}</option>
                </c:forEach>
            </select>
            <span>|</span>
        </p>
        <p class="test-icon" style="vertical-align: middle"><i class="icon iconfont" id="change-lan">&#xe621;</i></p>
        <p>
            <select class="select testing-select" id="target-lan">
                <c:forEach items="${requestScope.languagepairs}" var="pair">
                    <option>${pair}</option>
                </c:forEach>
            </select>
            <span >|</span>
        </p>
    </section>
    <!--翻译内容-->
    <section class="translation-content">
        <textarea class="textarea textarea-large" name="chick-int" id="chick-int"></textarea>
        <a hrel="#"><i class="icon iconfont" id="btn-textarea-clear">&#xe618;</i></a>
    </section>
    <!--翻译按钮-->
    <section class="translate-btn" id="chick-btn">
        <a href="#" class="btn btn-big" id="btn-translate">翻译</a>
    </section>
    <!--翻译结果-->
    <section class="translation-content-english" id="results">
        <textarea class="textarea textarea-xlarge" id="result-text" readonly="readonly"></textarea>
        <p>
            <a href="#"><i class="icon iconfont" id="toAudio">&#xe61b;</i></a>
            <a href="#" id="share-icon"><i class="icon iconfont">&#xe61c;</i></a>
            <%--<audio controls="controls" preload="true" id="audio" style="display: none">--%>
                <%--<source src=ttsUrl/>--%>
            <%--</audio>--%>
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


<jsp:include page="/jsp/common/bottom.jsp" flush="true"/>
<a onclick="javascript:window.location.href='<%=path%>/safe/safe'">安全设置</a>
<a onclick="javascript:window.location.href='<%=path%>/account/recharge'">充值</a>

</body>
</html>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>

<script type="text/javascript">
    var IsTranslated = false;
    $(document).ready(function () {
        <!--点击切换到英语版-->
        $("#english-btn").bind("click",function () {

        });
        <!--翻译源内容失去焦点-->
        $("#chick-int").blur(function () {
            var text = $("#chick-int").val();
            if(text == "" || text == null) {
                $("#results").css("display","none");
                $("#chick-btn").css("display","block");
                return;
            }
            var sourcetext=$("#chick-int").val();
            if(sourcetext=="" || sourcetext==null) {
                return;
            }
            translate(sourcetext);
        });

        $("#btn-textarea-clear").bind("click",function () {
            if(IsTranslated == true) {
                $("#results").css("display","none");
                $("#btn-translate").css("display","block");
                $("#chick-int").focus();
                IsTranslated = false;
            } else {
                window.location.href="<%=path%>";
            }
        });

        <!--翻译源内容文本框获取焦点-->
        $("#chick-int").focus(function () {
            $("#results").css("display","none");
            $("#chick-btn").css("display","block");
        });

        $("#chick-int").bind('input propertychange', function () {
            if($("#chick-int").val()!="" || $("#chick-int").val()!=null) {

            } else {
                
            }
        });

        <%--$("#btn-textarea-clear").bind("click",function () {--%>
            <%--window.location.href="<%=path%>";--%>
        <%--});--%>

        var Language = "${pageContext.response.locale}";
        console.info("locallanguage:"+Language);
        if (Language=="zh_CN"){
            $("#auto-zh").css("display","block");
            $("#auto-en").css("display", "none");
            srcvalue="zh";
            tarvalue="zh";
        }else if (Language=="en_US"){
            $("#source-lan option:selected").attr("selected","");
            $("#auto-en").css("display","block");
            $("#auto-en").attr("selected","selected");
            $("#auto-zh").css("display","none");
            srcvalue="en";
            tarvalue="zh";
        }

        $("#btn-login").bind("click",function () {
            <!--跳转到登录页面-->
        });
        <!--选择源语言-->
        $("#source-lan").bind("click",function () {
            chooseSourLan();
        });
        <!--选择目标语言-->
        $("#target-lan").bind("click",function () {
            chooseTarLan();
        });
        <!--交换语言-->
        $("#change-lan").bind("click",function () {
//            $("#source-lan option:selected")=$("#target-lan option:selected");
//            tartext=srctext;
        });
        <!--翻译-->
        $("#btn-translate").bind("click",function () {
            var sourcetext=$("#chick-int").val();
            if(sourcetext=="" || sourcetext==null) {
                return;
            }
            $("#chick-btn").css("display", "none");
            translate(sourcetext);
        });

        $("#toAudio").bind("click",function () {
           textToAudio();
        });

        $(".none").bind("click",function () {
           downloadApp(); 
        });
        <!--跳转到笔译下单-->
        $("#banner1").bind("click",function () {
            window.location.href="<%=path%>/written";
        });


    });

    function textToAudio() {
        if ($("#audio").paused) {
            $("#audio").play();
            return;
        }else{
            $("#audio").pause;
        }
    }

    function downloadApp() {
        var andlink="http://android.myapp.com/myapp/detail.htm?apkName=cn.com.gtcom.ydt";
        var ioslink="https://itunes.apple.com/cn/app/zhao-fan-yi-findyee/id1017302386?mt=8";
        if (/android/i.test(navigator.userAgent)){
            window.location.href=andlink;
        }else if(/iphone/i.test(navigator.userAgent)){
            window.location.href=ioslink;
        }
    }
    <!--手动选择源语言-->
    var srcvalue;
    var srctext;
    function chooseSourLan() {
        $("#auto-zh").css("display","none");
        srctext=$("#source-lan option:selected").text();
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
        console.info("srcvalue-----"+srcvalue);
    }

    <!--手动选择目标语种-->
    var tarvalue;
    var tartext;
    function chooseTarLan() {
        $("#auto-en").css("display","none");
        tartext=$("#target-lan option:selected").text();
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
        console.info("tarvalue-----"+tarvalue);
    }
    <!--翻译按钮的点击事件-->
    function translate(sourcetext) {
//        $("#chick-int").blur();

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
                    IsTranslated = true;
                } else {

                }
            },
            error: function (data) {
                console.info(data);
            }
        });
        var beRead=$("#result-text").text();
        console.info("lastbeRead........."+beRead);
        var ttsUrl=<%=path%>+"/ttsSync?languages="+tarvalue+"&beRead="+beRead;
        console.info("ttsUrl..."+ttsUrl);
    }


</script>
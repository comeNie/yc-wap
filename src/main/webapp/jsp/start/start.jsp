<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>首页</title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
</head>

<body>
<div class="wrapper-big">
<!--分享弹出框-->
<div class="eject-big">
    <div class="prompt-share" id="share-eject">
        <div class="prompt-share-title">请选择</div>
        <!--确认删除-->
        <div class="prompt-share-confirm">
            <ul>
                <a href="javascript:void(0)">
                    <li class="weix">
                        <p><i class="icon iconfont">&#xe61a;</i></p>
                        <p>微信</p>
                    </li>
                </a>
                <a href="javascript:void(0)">
                    <li class="weixq">
                        <p><i class="icon iconfont">&#xe61f;</i></p>
                        <p>微信朋友圈</p>
                    </li>
                </a>
                <a href="javascript:void(0)">
                    <li class="blog">
                        <p><i class="icon iconfont">&#xe627;</i></p>
                        <p>微博</p>
                    </li>
                </a>
                <a href="javascript:void(0)">
                    <li class="qq">
                        <p><i class="icon iconfont">&#xe61e;</i></p>
                        <p>QQ</p>
                    </li>
                </a>
                <a href="javascript:void(0)">
                    <li class="watercress">
                        <p><i class="icon iconfont">&#xe625;</i></p>
                        <p>豆瓣</p>
                    </li>
                </a>
                <a href="javascript:void(0)">
                    <li class="message">
                        <p><i class="icon iconfont">&#xe622;</i></p>
                        <p>短信</p>
                    </li>
                </a>
                <a href="javascript:void(0)">
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
<%--<nav class="wap-nav">--%>
    <%--<ul>--%>
        <%--<li class="logo"><img src="<%=path%>/ui/images/logo.png" /></li>--%>
        <%--<li class="right">--%>
            <%--&lt;%&ndash;<input type="button" class="btn login-btn" value="登录" id="btn-login">&ndash;%&gt;--%>
            <%--<a href="javascript:window.location.href='<%=path%>/login/login'" class="btn login-btn" id="btn-login">登录</a>--%>
        <%--</li>--%>
    <%--</ul>--%>
<%--</nav>--%>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Index" value="1"/>
    </jsp:include>
<section class="index-wrapper">
    <!--转换语言-->
    <section class="testing">
        <p>
            <select class="select testing-select" id="source-lan">
                <c:forEach items="${requestScope.languagepairs}" var="pair">
                    <option id="auto-zh" style="display: none">检测语言：中文</option>
                    <option id="auto-en" style="display: none">检测语言：英语</option>
                    <option>${pair}</option>
                </c:forEach>
            </select>
            <span>|</span>
        </p>
        <p class="test-icon" style="vertical-align: middle"><i class="icon iconfont" id="change-lan">&#xe621;</i></p>
        <p>
            <select class="select testing-select" id="target-lan">
                <c:forEach items="${requestScope.languagepairs}" var="pair">
                    <c:choose>
                        <c:when test="${pair=='英语'}">
                            <option selected="selected">${pair}</option>
                        </c:when>
                        <c:otherwise>
                            <option>${pair}</option>
                        </c:otherwise>
                    </c:choose>

                </c:forEach>
            </select>
            <span >|</span>
        </p>
    </section>
    <!--翻译内容-->
    <section class="translation-content">
        <textarea class="textarea textarea-large" name="chick-int" id="chick-int"></textarea>
        <a hrel="javascript:void(0)"><i class="icon iconfont" id="btn-textarea-clear">&#xe618;</i></a>
    </section>
    <!--翻译按钮-->
    <section class="translate-btn" id="chick-btn">
        <a href="javascript:void(0)" class="btn btn-big" id="btn-translate">翻译</a>
    </section>
    <!--翻译结果-->
    <section class="translation-content-english" id="results">
        <textarea class="textarea textarea-xlarge" id="result-text" readonly="readonly"></textarea>
        <p>
            <a href="javascript:void(0)" id="text_audio"><i class="icon iconfont" id="toAudio">&#xe61b;</i></a>
            <%--<a href="javascript:void(0)" id="share-icon"><i class="icon iconfont">&#xe61c;</i></a>--%>
            <audio src="" controls="controls"  id="audioPlay" hidden>
                Your browser does not support audio tag
            </audio>
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
</div>
<!--底部-->

<jsp:include page="/jsp/common/bottom.jsp" flush="true"/>

</body>
</html>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
<script type="text/javascript" src="<%=path%>/js/common/wordcount.js"></script>

<script type="text/javascript">
    var IsTranslated = false;
    var sourcetext="";
    var srctext;
    var tartext;
    var srcvalue="zh";
    var tarvalue="en";
    var landetec;
    var lanLength;
    var beRead;

    var Language = "${pageContext.response.locale}";
    if (Language=="zh_CN"){
        $("#auto-zh").css("display","block");
        $("#auto-en").css("display", "none");
        srcvalue="zh";
    }else if (Language=="en_US"){
        $("#source-lan option:selected").attr("selected","");
        $("#auto-en").css("display","block");
        $("#auto-en").attr("selected","selected");
        $("#auto-zh").css("display","none");
        srcvalue="en";
        tarvalue="zh";
    }
    $(function() {
        var audio = document.getElementById("audioPlay");
        audio.addEventListener("ended", //歌曲一经完整的加载完毕( 也可以写成上面提到的那些事件类型)
                function() {
                    $("#text_audio").css("display","block");
                });
    });
    $(document).ready(function () {
        <!--监听输入的文本内容-->
        $("#chick-int").bind("input propertychange",function () {
            landetec=$("#chick-int").val();
            lanLength=count(escape(landetec));
            console.info("lanLength...."+lanLength);
            if(lanLength>=2000){
                $("#chick-int").val(landetec.substring(0,2000));
            }
            console.info("landetec....."+landetec);
            contentDetection(landetec);
        });
        function contentDetection(landetec) {
            if (landetec == "" || landetec == null) {
                return;
            }
            $.ajax({
                url: "<%=path%>/lanDetection",
                type: "POST",
                data: {
                    text: landetec
                },
                success: function (result) {
                    var finLan = result.fintec;
                    console.info("finLan>>>>>>>" + finLan);
                },
                error: function (data) {
                    console.info(data);
                }

            });
        }

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


        <!--选择源语言-->
        $("#source-lan").bind("click",function () {
            chooseSourLan();
        });
        <!--选择目标语言-->
        $("#target-lan").bind("click",function () {
            chooseTarLan();
        });

        <!--翻译-->
        $("#chick-btn").bind("click",function () {
            sourcetext=$("#chick-int").val();
            if(sourcetext==""||sourcetext==null){
                $('#results').css("display","none");
                return;
            }
            $("#chick-btn").css("display", "none");
            $('#results').css("display","block");
            translate(sourcetext);
        });

        $("#toAudio").bind("click",function () {
            beRead=$.trim($("#result-text").val());
            if (beRead==""||beRead==null){
                return;
            }
            var ttslength=mbStringLength(beRead);
            if (ttslength>1024){
                $("#text_audio").css("display","none");
            }
            var audioPlay=document.getElementById("audioPlay");
            if (audioPlay.paused){
                var ttsUrl="<%=path%>/ttsSync?languages="+tarvalue+"&beRead="+beRead;
//                console.info("ttsUrl..."+ttsUrl);
                $("#audioPlay").attr("src",ttsUrl);
                audioPlay.play();
            }else{
                audioPlay.pause;
            }
        });

        function mbStringLength(s) {
            var totalLength = 0;
            var charCode;
            for (var i = 0; i < s.length; i++) {
                charCode = s.charCodeAt(i);
                if (charCode < 0x007f) {
                    totalLength = totalLength + 1;
                } else if ((0x0080 <= charCode) && (charCode <= 0x07ff)) {
                    totalLength += 2;
                } else if ((0x0800 <= charCode) && (charCode <= 0xffff)) {
                    totalLength += 3;
                }
            }
            return totalLength;
        }

        <!--跳转到笔译下单-->
        $("#banner1").bind("click",function () {
            window.location.href="<%=path%>/written";
        });


    });

    <!--手动选择源语言-->

    function chooseSourLan() {
        srctext=$("#source-lan option:selected").text();
        if (srctext=="中文"){
            srcvalue="zh";
        }else if (srctext=="英语"){
            srcvalue="en";
        }else if (srctext=="法语"){
            srcvalue="fr";
        }else if (srctext=="俄语"){
            srcvalue="ru";
        }else if (srctext=="葡萄牙语"){
            srcvalue="pt";
        }
        console.info("srcvalue-----"+srcvalue);
    }

    <!--手动选择目标语种-->
    function chooseTarLan() {
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
        }else if(tartext=="葡萄牙语"){
            tarvalue="pt";
        }
        console.info("tarvalue-----"+tarvalue);
    }

    <!--翻译按钮的点击事件-->
    function translate(sourcetext) {
        console.info("sourcetext...."+sourcetext);
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
                    $("#result-text").html(data.target);
                    IsTranslated = true;
                } else {

                }
            },
            error: function (data) {
                console.info(data);
            }
        });

    }


</script>
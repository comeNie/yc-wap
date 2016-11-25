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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>首页</title>
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
<div class="wrapper-big"><!--包含除底部外的所有层-->
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
                <select tabindex="5" class="select testing-select" id="source-lan">
                    <%--自动检测--%>
                    <option value="auto">自动检测</option>
                    <%--中文简体--%>
                    <option value="zh">简体中文</option>
                    <%--英语--%>
                    <option value="en">英语</option>
                    <%--法语--%>
                    <option value="fr">法语</option>
                    <%--俄语--%>
                    <option value="ru">俄语</option>
                    <%--葡萄牙语--%>
                    <option value="pt">葡萄牙语</option>
                </select>
                <span>|</span>
            </p>
            <p class="test-icon" style="vertical-align: middle" onclick="changeSelect()"><i class="icon iconfont" id="change-lan">&#xe621;</i>
            </p>

            <p>
                <select class="select testing-select" id="target-lan">
                    <%--中文简体--%>
                    <option value="zh">简体中文</option>
                    <%--英语--%>
                    <option value="en" selected>英语</option>
                    <%--法语--%>
                    <option value="fr">法语</option>
                    <%--俄语--%>
                    <option value="ru">俄语</option>
                    <%--葡萄牙语--%>
                    <option value="pt">葡萄牙语</option>
                </select>
                <span>|</span>
            </p>
        </section>
        <!--翻译内容-->
        <section class="translation-content">
            <textarea class="textarea textarea-large" name="chick-int" id="chick-int" maxlength="2000"></textarea>
            <a hrel="javascript:void(0)" ><i class="icon iconfont" id="clear">&#xe618;</i></a>
        </section>
        <!--翻译按钮-->
        <section class="translate-btn" id="chick-btn">
            <a href="javascript:void(0)" onclick="goTranslate()" id="translateAid" class="btn btn-big">翻译</a>
            <img src="<%=path%>/ui/images/载入中.gif" id="translateGif" style="display:none;padding-left: 2.5rem">
        </section>
        <!--翻译结果-->
        <section class="translation-content-english" id="results">
            <textarea class="textarea textarea-xlarge" id="result-text" readonly="readonly"></textarea>

            <p>
                <label id="tipLabel" style="font-size: 13px;color: #ff4949;"></label>
                <a href="javascript:void(0)" id="text_audio" onclick="playAudio()">
                    <i class="icon iconfont ash" id="hornid">&#xe61b;</i>
                    <img src="<%=path%>/ui/images/loading_back.gif" id="loading" style="display:none;">
                    <img src="<%=path%>/ui/images/首页声音.gif" id="soundGif" style="display:none;">
                </a>
                <%--<a href="javascript:void(0)" id="share-icon"><i class="icon iconfont">&#xe61c;</i></a>--%>
                <audio src="" controls="controls" id="audioPlay" hidden>
                    Your browser does not support audio tag
                </audio>
            </p>
        </section>

    </section>
    <section id="wrapper-hide">
        <section class="index-wrapper">
            <!--历史纪录-->
            <section class="history" style="display: block">
                <div class="history-list">
                    <ul>
                        <a href="javascript:" id="myHistory">
                            <%--<li>--%>
                                <%--<p><i class="icon iconfont">&#xe624;</i></p>--%>
                                <%--<p class="word">就显示一行 就显示一行显示一行</p>--%>
                                <%--<p class="word-en">yiwen yiwen yiwen</p>--%>
                                <%--<p class="right"><i class="icon iconfont">&#xe618;</i></p>--%>
                            <%--</li>--%>
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
</div>
</div>
<jsp:include page="/jsp/common/bottom.jsp" flush="true"/>
<jsp:include page="/jsp/common/loading.jsp" flush="true"/>

</body>
</html>


<script type="text/javascript">

    var IsTranslated = false;
    var realLangeuage="zh";

    $(function () {

        //初始化数据库
        initDatabase();
        showAllTheData();
        var audio = document.getElementById("audioPlay");
        audio.addEventListener("ended",function () {
            $("#hornid").show();
            $("#soundGif").hide();
        });
        audio.addEventListener("playing",function () {
            $("#loading").hide();
            $("#hornid").hide();
            $("#soundGif").show();
            $("#text_audio").attr("onclick", "playAudio()");
        });

        Loading.HideLoading();
    });
    $(document).ready(function () {
//        监听输入的文本内容
        $("#chick-int").bind("input propertychange", function () {
            landetec = $("#chick-int").val();
            if (landetec == "" || landetec == null) {
                return;
            }
            contentDetection(landetec);
        });

//        翻译源内容文本框获取焦点
        $("#chick-int").focus(function () {
            $("#results").hide();
            $('#chick-btn').show();
            $('#wrapper-hide').hide();
        });
        //清除
        $("#clear").click(function(){
            if (IsTranslated == true) {
                $("#results").hide()
                $("#btn-translate").show();
                $("#chick-int").focus();
                IsTranslated = false;
            } else {
                $("#chick-int").val("");
            }
        });

//        跳转到笔译下单
        $("#banner1").bind("click", function () {
            window.location.href = "<%=path%>/written";
        });

        $("#target-lan").bind("change",function(){
            goTranslate();
        });

        $("#source-lan").bind("change",function(){
            goTranslate();
        });

    });
    //播放声音
    function playAudio(){

        var beRead = $.trim($("#result-text").val());
        if (beRead == "" || beRead == null) {
            return;
        }
        var ttslength = mbStringLength(beRead);
        if (ttslength > 1024) {
            $("#text_audio").css("display", "none");
        }
        var audioPlay = document.getElementById("audioPlay");
        if (audioPlay.paused) {
            var target = $("#target-lan").val();
            var ttsUrl = "<%=path%>/ttsSync?languages=" + target + "&beRead=" + beRead;
            $("#audioPlay").attr("src", ttsUrl);
            $("#loading").show();
            $("#hornid").hide();
            $("#soundGif").hide();
            $("#text_audio").attr("onclick", "javascript:void(0)");
            audioPlay.play();
        } else {
            audioPlay.pause;
        }
    }
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
    //创建数据库
    function initDatabase()  {
        var db = getCurrentDb();//初始化数据库
        if(!db) {alert("您的浏览器不支持HTML5本地数据库");return;}
        db.transaction(function (trans) {//启动一个事务，并设置回调函数
            //执行创建表的Sql脚本
            trans.executeSql("create table if not exists History(id integer PRIMARY KEY AUTOINCREMENT ,sourceLan text,sourceCode text ,targetLan text,targetCode text)")
        });
    }
    //打开数据库
    function getCurrentDb() {
        //打开数据库，或者直接连接数据库参数：数据库名称，版本，概述，大小
        //如果数据库不存在那么创建之
        var db = openDatabase("MyDB", "1.0", "历史记录", 1024 * 1024);
        return db;
    }
    //展示所有数据
    function showAllTheData() {
        $("#myHistory").empty();
        var db = getCurrentDb();
        db.transaction(function (trans) {
            trans.executeSql("select * from History",[],function (ts, data) {
                if (data) {
                    if (data.rows.length <= 3){
                        for (var i = data.rows.length; i >0; i--) {
                            appendDataToTable(data.rows.item(i-1));//获取某行数据的json对象
                        }
                    }else {
                        for (var i = data.rows.length; i > data.rows.length-3; i--) {
                            appendDataToTable(data.rows.item(i-1));//获取某行数据的json对象
                        }
                    }
                }
            });
        });
    }
    //将数据展示到表格里面
    function appendDataToTable(data) {
        //sourceLan targetLan
        var sourceLan = data.sourceLan;
        var targetLan = data.targetLan;
        var sourceCode = data.sourceCode;
        var targetCode = data.targetCode;
        var idLan = data.id;
        var strHtml = "";
        strHtml += "<li id='li"+idLan+"'>";
        strHtml += "<p><i class='icon iconfont' >&#xe624;</i></p>";
        strHtml += "<p class='word' id='word"+idLan+"'>"+sourceLan+"</p>";
        strHtml += "<p class='word-en' id='word-en"+idLan+"'>"+targetLan+"</p>";
        strHtml += "<p class='right'><i class='icon iconfont' id='his"+idLan+"'>&#xe618;</i></p>";
        strHtml += "</li>";
        $("#myHistory").append(strHtml);

        //绑定事件进行删除
        $("#his"+idLan).click(function () {
            var db = getCurrentDb();
            db.transaction(function (trans) {
                trans.executeSql("delete from History WHERE ROWID =?",[idLan],function () {
                    $("#li"+idLan).remove();
                });
            },function (ts, error) {alert(error);});
        });
        $("#word"+idLan).click(function() {
            transHis(sourceLan,sourceCode,targetCode);
        });
        $("#word-en"+idLan).click(function() {
            transHis(sourceLan,sourceCode,targetCode);
        });
    }
    function transHis(sourceLan,sourceCode,targetCode){
        $("#chick-int").val(sourceLan);

        realLangeuage = sourceCode;
        chooseLan(sourceCode,"source-lan");
        chooseLan(targetCode,"target-lan");
        $("#results").hide();
        $('#chick-btn').show();
        $('#wrapper-hide').hide();
        goTranslate();
    }
//    翻译按钮的点击事件
    function goTranslate() {

        var textStr = $("#chick-int").val();
        if (textStr == "" || textStr == null) {         //判断为空,中断
            $('#results').hide();
            return;
        }

        var source = $("#source-lan").val();
        var target = $("#target-lan").val();
        $("#tipLabel").html("");
        if (realLangeuage != source){
            switch (realLangeuage){
                case "zh":
                    $("#tipLabel").html("源语言检测为简体中文");
                    break;
                case "en":
                    $("#tipLabel").html("源语言检测为英文");
                    break;
                case "fr":
                    $("#tipLabel").html("源语言检测为法语");
                    break;
                case "ru":
                    $("#tipLabel").html("源语言检测为俄语");
                    break;
                case "pt":
                    $("#tipLabel").html("源语言检测为葡萄牙语");
                    break;
            }
            source = realLangeuage;
        }
        if(realLangeuage == target){
            $("#result-text").html(textStr);
            return;
        }
        $("#translateAid").hide();
        $("#translateGif").show();
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/translate",
            modal: true,
            showBusi: false,
            timeout: 30000,
            data: {
                srcl: source,
                tgtl: target,
                text: textStr
            },
            success: function (data) {
                if (data.status == 1) {//成功
                    $("#result-text").html(data.target);
                    $("#results").show();
                    $("#chick-btn").hide();

                    $("#translateAid").show();
                    $("#translateGif").hide();

                    IsTranslated = true;
                    var db = getCurrentDb();
                    db.transaction(function(trans){
                       trans.executeSql("SELECT * FROM History WHERE sourceLan=? AND sourceCode=? AND targetCode=?",[textStr,source,target],function(trans,result){
                           if (result.rows.length == 0){
                               //执行sql脚本，插入数据
                               db.transaction(function (trans) {
                                   trans.executeSql("insert into History(sourceLan,sourceCode,targetLan,targetCode) values(?,?,?,?)", [textStr,source, data.target,target]);
                               });
                           }
                       });
                    });

                } else {
                    IsTranslated = false;
                    $("#results").hide();
                    $("#chick-btn").show();

                    $("#translateAid").show();
                    $("#translateGif").hide();
                }
            },
            error: function (data) {
                IsTranslated = false;
                $("#results").hide();
                $("#chick-btn").show();

                $("#translateAid").show();
                $("#translateGif").hide();
            }
        });

    }
//  调用接口查看语言
    function contentDetection(landetec) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/lanDetection",
            modal: true,
            timeout: 30000,
            data: {
                text: landetec
            },
            success: function (data) {
                if (data.status == 1) {
                    realLangeuage = data.fintec;
                    chooseLan(realLangeuage,"source-lan");
                }
            }
        });
    }
    //自动选择语言
    function chooseLan(lan,name) {
//        var lanText;
        var select = document.getElementById(name);
        if (lan != "" || lan != null){
            for(var i=0; i<select.options.length; i++){
                if(select.options[i].value == lan){
                    select.options[i].selected = true;
                    break;
                }
            }
        }
    }

    //切换语言对
    function changeSelect(){
        var source = $("#source-lan").val();
        var target = $("#target-lan").val();
        if (source != "auto" && source != target){
            var selectSource = document.getElementById("source-lan");
            for(var i=0; i<selectSource.options.length; i++){
                if(selectSource.options[i].value == target){
                    selectSource.options[i].selected = true;
                    break;
                }
            }
            var selectTarget = document.getElementById("target-lan");
            for(var i=0; i<selectTarget.options.length; i++){
                if(selectTarget.options[i].value == source){
                    selectTarget.options[i].selected = true;
                    break;
                }
            }
        }
    }
</script>
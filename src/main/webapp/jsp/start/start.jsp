<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title><spring:message code="start.title"/></title>
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

<!--分享弹出框-->
<div class="eject-big">
    <div class="prompt-share" id="share-eject">
        <div class="prompt-share-title"><spring:message code="start.qingxuanze"/></div>
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
</div>
<!--弹出框结束-->
<div class="wrapper-big"><!--包含除底部外的所有层-->
    <%--<section class="notice" style="display: none">--%>
        <%--<p>公告信息等等等等</p>--%>
        <%--<label><i class="icon iconfont">&#xe618;</i></label>--%>
    <%--</section>--%>
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
                    <c:if test="${pageContext.response.locale == 'zh_CN'}">
                        <option value="auto"><spring:message code="start.jianceCH"/></option>
                    </c:if>
                    <c:if test="${pageContext.response.locale != 'zh_CN'}">
                        <option value="auto"><spring:message code="start.jianceEng"/></option>
                    </c:if>
                    <%--中文简体--%>
                    <option value="zh"><spring:message code="start.zh"/></option>
                    <%--英语--%>
                    <option value="en"><spring:message code="start.en"/></option>
                    <%--俄语--%>
                    <option value="ru"><spring:message code="start.ru"/></option>
                    <%--葡萄牙语--%>
                    <option value="pt"><spring:message code="start.pt"/></option>
                </select>
                <span>|</span>
            </p>
            <p class="test-icon1" onclick="changeSelect()"><i class="icon iconfont" id="change-lan">&#xe66d;</i>
            </p>

            <p>
                <select class="select testing-select" id="target-lan">
                    <c:if test="${pageContext.response.locale != 'zh_CN'}">
                        <%--中文简体--%>
                        <option value="zh" selected><spring:message code="start.zh"/></option>
                        <%--英语--%>
                        <option value="en"><spring:message code="start.en"/></option>
                    </c:if>
                    <c:if test="${pageContext.response.locale == 'zh_CN'}">
                        <%--中文简体--%>
                        <option value="zh"><spring:message code="start.zh"/></option>
                        <%--英语--%>
                        <option value="en" selected><spring:message code="start.en"/></option>
                    </c:if>
                    <%--俄语--%>
                    <option value="ru"><spring:message code="start.ru"/></option>
                    <%--葡萄牙语--%>
                    <option value="pt"><spring:message code="start.pt"/></option>
                </select>
                <span>|</span>
            </p>
        </section>
        <!--翻译内容-->
        <section class="translation-content">
            <textarea class="textarea textarea-large" name="chick-int" id="chick-int" placeholder="<spring:message code="start.fanyiPlaceholder"/>"></textarea>
            <a hrel="javascript:void(0)"><i class="icon iconfont" id="clear" hidden>&#xe618;</i></a>
        </section>
        <!--翻译按钮-->
        <section class="translate-btn" id="chick-btn">
            <a href="javascript:void(0)" onclick="goTranslate()" id="translateAid" class="submit-btn btn-blue"><spring:message code="start.fanyi"/></a>
            <img src="<%=path%>/ui/images/载入中.gif" id="translateGif" style="width: 5.29rem;height: 1.13rem; display:block;margin:0 auto">
        </section>
        <!--翻译结果-->
        <section class="translation-content-english" id="results">
            <textarea class="textarea textarea-xlarge" id="result-text" readonly="readonly"></textarea>

            <p>
                <label id="tipLabel" ></label>
                <a href="javascript:void(0)" id="text_audio" onclick="playAudio()">
                    <i class="icon iconfont ash" id="hornid">&#xe61b;</i>
                    <img src="<%=path%>/ui/images/loading_back.gif" id="loading" style="display:none;">
                    <img src="<%=path%>/ui/images/voice.gif" id="soundGif" style="display:none;">
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
                        </a>
                    </ul>
                </div>
            </section>

        </section>
        <!--banner-->
        <section class="banner"><a href="javascript:void (0)" id="banner1"><img src="<%=path%>/ui/images/banner-1.png"></a></section>
        <section class="banner"><a href="javascript:void (0)"><img src="<%=path%>/ui/images/banner-2.png"></a></section>

    </section>

    <!--上传提示弹出框-->
    <%--<div class="eject-big">--%>
        <%--<div class="prompt" id="prompt">--%>
            <%--<div class="prompt-title">请选择</div>--%>
            <%--<div class="prompt-confirm">--%>
                <%--<ul>--%>
                    <%--<li id="EjectTitle">IOS端不支持上传附件请前往PC端</li>--%>
                <%--</ul>--%>
            <%--</div>--%>
            <%--<div class="prompt-confirm-btn">--%>
                <%--<a class="btn btn-white" id="prompt-btn">确认</a>--%>
            <%--</div>--%>

        <%--</div>--%>
        <%--<div class="mask" id="eject-mask"></div>--%>
    <%--</div>--%>

    <div class="eject-big">
        <div class="prompt" id="prompt">
            <div class="prompt-title"><spring:message code="start.tishi"/></div>
            <div class="prompt-confirm beyond-confirm">
                <ul>
                    <li id="EjectTitle"></li>
                </ul>
            </div>
        </div>
        <div class="mask" id="eject-mask"></div>
    </div>
</div>

<!--底部-->
<jsp:include page="/jsp/common/bottom.jsp" flush="true">
    <jsp:param name="class" value="index-footer-big"/>
</jsp:include>

<div id="index-btnshow" style="display:none;">
    <div class="release-showbj" id="release-showbj"></div>
    <div class="release-btn" id="release-btn"><a href="javascript:window.location.href='<%=path%>/written'">发布翻译需求</a></div>
</div>

</body>
</html>


<script type="text/javascript">

    var IsTranslated = false;
    var realLangeuage="zh";
    var getBlur = 0;
    $(function () {

        //初始化数据库
        initDatabase();
        showAllTheData();
        $("#translateGif").hide();
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
        audio.addEventListener("error",function(){
            $("#loading").hide();
            $("#hornid").show();
            $("#soundGif").hide();
            $("#text_audio").attr("onclick", "playAudio()");
        },false);

    });
    $(document).ready(function () {

//        document.getElementsByTagName("body")[0].onscroll=function(){
//            var rbtn=document.getElementById('index-btnshow');
//            if(document.getElementsByTagName("body")[0].scrollTop>10){
//                rbtn.style.display='block';
//            }
//        }
        $(window).scroll(function(e){
            p = $(this).scrollTop();
            var rbtn=document.getElementById('index-btnshow');
            if(0<=p){//下滚
                rbtn.style.display='block';
            }
        });
//        监听输入的文本内容
        $("#chick-int").bind("input propertychange", function () {
            var landetec = $("#chick-int").val();
            if(isEmojiCharacter(landetec)){
                autoTip("<spring:message code="start.tipBiaoqing"/>");
                return;
            }
            contentDetection(landetec);
            if(!checkLength(landetec)){
                var tex = landetec.substr(0,2000);
                $("#chick-int").val(tex);
                return;
            }
        });

//        翻译源内容文本框获取焦点
        $("#chick-int").focus(function () {
            $("#results").hide();
            $('#chick-btn').show();
            $('#wrapper-hide').hide();
            $("#clear").show();
            $("#release-showbj").hide();
            $("#release-btn").hide();
            getBlur = 1;
        });
        //清除
        $("#clear").click(function(){
            if ($("#chick-int").val() == ""){
                location.reload();
            }
            if (IsTranslated == true) {
                $("#results").hide();
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

        //对应语言对事件
        $("#target-lan").bind("change",function(){
            goTranslate();
        });
        //源语言对事件
        $("#source-lan").bind("change",function(){
            languagePair($("#source-lan").val())
            goTranslate();
        });
    });
    //检测文本长度
    function checkLength(landetec) {
        if (landetec.length > 2000){
            var t = landetec.length-2000;
            autoTip("<spring:message code="start.surpassWord"/>"+t+"<spring:message code="start.word"/>");
            return false;
        }else {
            return true;
        }
    }
    //3秒自動消失提示
    var timer;
    function autoTip(txt){
        $("#EjectTitle").html(txt);
        $('#eject-mask').fadeIn(100);
        $("#prompt").slideDown(100);
        timer = window.setInterval(function(){
            $("#eject-mask").fadeOut(200);
            $("#prompt").slideUp(200);
            clearInterval(timer);
        },1000);
    }
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
        if(!db) {return;}
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
    //历史记录处理
    function transHis(sourceLan,sourceCode,targetCode){
        $("#chick-int").val(sourceLan);

        realLangeuage = sourceCode;
        chooseLan(sourceCode,"source-lan");
        chooseLan(targetCode,"target-lan");
        $("#results").hide();
        $('#chick-btn').show();
        $('#wrapper-hide').hide();
        $("#clear").show();
        goTranslate();
    }
////    翻译按钮的点击事件
    function goTranslate() {
        var textStr = $("#chick-int").val();
        if (textStr == "" || textStr == null) {         //判断为空,中断
            $('#results').hide();
            return;
        }
        if(isEmojiCharacter(textStr)){
            autoTip("<spring:message code="start.tipBiaoqing"/>");
            return;
        }
        if(!checkLength(textStr)){
            return;
        }
        var source = $("#source-lan").val();
        var target = $("#target-lan").val();
        $("#tipLabel").html("");
        if (realLangeuage != source){
            switch (realLangeuage){
                case "zh":
                    $("#tipLabel").html("<spring:message code="start.testZH"/>");
                    break;
                case "en":
                    $("#tipLabel").html("<spring:message code="start.testEN"/>");
                    break;
                case "ru":
                    $("#tipLabel").html("<spring:message code="start.testRU"/>");
                    break;
                case "pt":
                    $("#tipLabel").html("<spring:message code="start.testPT"/>");
                    break;
                default:
                    autoTip("<spring:message code="start.buzhichiyuyan"/>");
                    return;
            }
            source = realLangeuage;
        }
        if(realLangeuage == target){
            $("#result-text").html(textStr);
            $("#results").show();
            $("#chick-btn").hide();

            $("#translateAid").show();
            $("#translateGif").hide();
            IsTranslated = true;
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
                    autoTip("<spring:message code="start.baoqiao"/>");
                    $("#results").hide();
                    $("#chick-btn").show();

                    $("#translateAid").show();
                    $("#translateGif").hide();
                }
            },
            error: function (data) {
                IsTranslated = false;
                autoTip("<spring:message code="start.baoqiao"/>");
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
        var select = document.getElementById(name);
        if (lan != "" || lan != null){
            for(var i=0; i<select.options.length; i++){
                if(select.options[i].value == lan){
                    select.options[i].selected = true;
                    if (name == "source-lan"){
                        languagePair($("#"+name).val());
                    }
                    return;
                }
            }
        }
    }
    function languagePair(txt){
        switch (txt){
            case "zh":
                addOption(0);
                break;
            case "en":
                addOption(1);
                break;
            case "ru":
                addOption(2);
                break;
            case "pt":
                addOption(3);
                break;
            default:
                addOption(4);
                break;
        }
    }
    function addOption(rmIndex){
        var select = document.getElementById("target-lan");
        var selectValue = $("#target-lan").val();
        select.length = 0;
        var arrLan = new Array("<spring:message code="start.zh"/>","<spring:message code="start.en"/>","<spring:message code="start.ru"/>","<spring:message code="start.pt"/>");
        var arrLanValue = ["zh","en","ru","pt"];
        if (rmIndex != 5){
            arrLan.splice(rmIndex,1);
            arrLanValue.splice(rmIndex,1);
        }

        for (var i = 0;i < arrLan.length; i++) {
            select.add(new Option(arrLan[i], arrLanValue[i]));
        }
        for(var j=0; j<select.options.length; j++){
            if(select.options[j].value == selectValue){
                select.options[j].selected = true;
                return;
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
            languagePair(target);
            for(var i=0; i<selectTarget.options.length; i++){
                if(selectTarget.options[i].value == source){
                    selectTarget.options[i].selected = true;
                    break;
                }
            }
            //翻译
            goTranslate();
        }
    }
    //判断是否是表情符号
    function isEmojiCharacter(substring) {
        for (var i = 0; i < substring.length; i++) {
            var hs = substring.charCodeAt(i);
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    var ls = substring.charCodeAt(i + 1);
                    var uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        return true;
                    }
                }
            } else if (substring.length > 1) {
                var ls = substring.charCodeAt(i + 1);
                if (ls == 0x20e3) {
                    return true;
                }
            } else {
                if (0x2100 <= hs && hs <= 0x27ff) {
                    return true;
                } else if (0x2B05 <= hs && hs <= 0x2b07) {
                    return true;
                } else if (0x2934 <= hs && hs <= 0x2935) {
                    return true;
                } else if (0x3297 <= hs && hs <= 0x3299) {
                    return true;
                } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030
                        || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b
                        || hs == 0x2b50) {
                    return true;
                }
            }
        }
    }
</script>
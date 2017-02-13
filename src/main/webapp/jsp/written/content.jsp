<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/3/2016
  Time: 2:11 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    request.setAttribute("isLogin", session.getAttribute("isLogin"));
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title><spring:message code="written.content.title"/></title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="<%=path%>/webuploader/webuploader.css">
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/common/wordcount.js"></script>
    <script type="text/javascript" src="<%=path%>/webuploader/webuploader.js"></script>
    <script type="text/javascript" src="<%=path%>/js/common/upload.js"></script>
    <%@ include file="../common/timezone.jsp" %>
</head>
<body>
<div class="wrapper-big" id="body">
    <div class="eject-big">
        <div class="prompt" id="prompt">
            <div class="prompt-title"><spring:message code="written.content.ptitle"/></div>
            <div class="prompt-confirm">
                <ul>
                    <li id="EjectTitle"></li>
                </ul>
            </div>
            <div class="prompt-confirm-btn">
                <a class="btn btn-white" id="prompt-btn"><spring:message code="written.content.confirm"/></a>
            </div>

        </div>
        <div class="mask" id="eject-mask"></div>
    </div>

    <%--头部--%>
    <spring:message code="written.content.ltitle" var="title"/>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="${title}"/>
        <jsp:param name="BackTo" value="javascript:Back()"/>
    </jsp:include>

    <section class="index-wrapper">
        <div class="testing-title">
            <p><spring:message code="written.content.choose"/></p>
        </div>
        <!--转换语言-->
        <section class="testing">
            <p>
                <select id="dualSource" class="select testing-select" onchange="DualChange()">
                    <c:forEach items="${DualMap}" var="pair">
                        <option>${pair.key}</option>
                    </c:forEach>
                </select>
                <span>|</span>
            </p>
            <p class="test-icon1" id="swap"><i class="icon iconfont">&#xe66d;</i></p>
            <p>
                <select id="dualTarget" class="select testing-select">

                </select>
                <span>|</span>
            </p>
        </section>
        <div class="testing-title">
            <p><spring:message code="written.content.content"/></p>
            <p class="right" id="backText" style="display: none"><a href="javascript:ChangeUpload(false)">返回</a></p>
        </div>

        <!--附件上传框-->
        <div class="enclosure" id="uploadText" style="display: none">
            <p><input type="text" class="enclosure-input" placeholder="请浏览选择上传文件，文件大小限10M。" disabled></p>
            <p><a  href="javascript:ChooseFile()">浏览</a></p>
        </div>

        <!--附件列表-->
        <section class="history" style="display:none">
            <div class="history-list">
                <ul>
                    <a href="javascript:">
                        <li>
                            <p><i class="icon iconfont">&#xe601;</i></p>
                            <p class="word-large">上传二十文件名称上传文件名称上传文件名称.docx</p>
                            <p class="right"><input type="button" class="btn btn-red btn-mini" value="删除"></p>
                        </li>
                    </a>
                </ul>
            </div>
        </section>

        <!--文字翻译-->
        <section class="translation-content" id="textInput">
            <textarea class="textarea textarea-large" name="chick-int" id="chick-int"
                      placeholder="<spring:message code="written.content.number"/>"></textarea>
            <a href="javascript:inputClear()" id="clearIcon" style="display: none"><i class="icon iconfont">&#xe618;</i></a>
        </section>

        <!--附件上传-->
        <div class="testing-title" id="toUpload">
            <p>
                <spring:message code="written.content.upload1"/>
                <a href="javascript:ChangeUpload(true)"><spring:message code="written.content.upload2"/></a>
            </p>
        </div>

        <div class="testing-title" id="uploadFileText" style="display: none">
            <p> 
                <a id="selectFile" href="javascript:ChooseFile()"><spring:message code="written.content.upload2"/></a>
            </p>
        </div>

        <div class="choice-list">
            <ul>
                <li>
                    <p class="word"><spring:message code="written.content.use"/></p>
                    <p>
                        <select id="purpose" class="select testing-select-small">
                            <c:forEach items="${PurposeList}" var="pair">
                                <option purposeId="${pair.purposeId}">${pair.purposeCn}</option>
                            </c:forEach>
                        </select>
                        <span>|</span>
                    </p>
                </li>
                <li>
                    <p class="word"><spring:message code="written.content.place"/></p>
                    <p>
                        <select id="domain" class="select testing-select-small">
                            <c:forEach items="${DomainList}" var="pair">
                                <option domainId="${pair.domainId}">${pair.domainCn}</option>
                            </c:forEach>
                        </select>
                        <span>|</span>
                    </p>
                </li>
                <li>
                    <p class="word"><spring:message code="written.content.service"/></p>
                    <p>
                        <select id="otherServ" class="select testing-select-small" onchange="ServerChange()" disabled>
                            <option otherServId="N">无增值服务</option>
                            <%--<option otherServId="Y">需排版</option>--%>
                        </select>
                        <span>|</span>
                    </p>
                    <p class="p-mr" id="otherService" style="display: none">
                        <select id="otherServi" class="select testing-select-small">
                            <option>Excel</option>
                            <option>Word</option>
                        </select>
                        <span>|</span>
                    </p>
                </li>
                <li>
                    <p class="word"><spring:message code="written.content.level"/></p>
                    <p>
                        <select id="translateLv" class="select testing-select-small" onchange="LvChange()">
                            <option transLv="100210"><spring:message code="written.content.level1"/></option>
                            <option transLv="100220" selected="selected"><spring:message
                                    code="written.content.level2"/></option>
                            <option transLv="100230"><spring:message code="written.content.level3"/></option>
                        </select>
                        <span>|</span>
                    </p>
                </li>
                <li class="word-checkbox mb-0">
                    <p id="TranslateSpeed"></p>
                    <p class="p-mr1" id="pQuick">
                        <img id="quick" src="<%=path%>/ui/images/checkbox.png" class="imgcheckbox" value="0">
                        <spring:message code="written.content.quick"/><b><spring:message
                            code="written.content.quick1"/></b>
                    </p>
                </li>
                <li id="pIsRead">
                    <p><img id="isRead" src="<%=path%>/ui/images/checkbox1.png" class="imgcheckbox" value="1"></p>
                    <p class="a-link"><spring:message code="written.content.read"/>
                        <a href="javascript:toLicense()"><spring:message code="written.content.protocol"/></a></p>
                </li>
            </ul>
        </div>
        <div class="wap-btn"><a href="javascript:void(0)" id="submit" class="btn submit-btn btn-blue"><spring:message
                code="written.content.submit"/></a></div>
    </section>
</div>
<!--底部-->
<jsp:include page="/jsp/common/bottom.jsp" flush="true"/>
<jsp:include page="/jsp/common/loading.jsp" flush="true"/>

</body>
</html>

<script type="text/javascript">
    var CheckedImg = "<%=path%>/ui/images/checkbox1.png";
    var UnCheckedImg = "<%=path%>/ui/images/checkbox.png";
    var ChineseEn = "";
    var ChineseCn = "";
    var EnglishEn = "";
    var EnglishCn = "";
    var oldContent = "";
    var notSupportChecked = false;
    var _base = "<%=path%>";

    $(function () {

    });

    $(document).ready(function () {
        Loading.HideLoading();
        var UserLanguage = '${pageContext.response.locale}';
        console.log("UserLanguage: " + UserLanguage);

        GetLanguageShow();
        SetDual(UserLanguage);
        ResetInfo();
        LvChange();
        ServerChange();

        $("#swap").bind("click", function () {
            SwapDual();
        });

        $("#chick-int").blur(function () {
            var Content = $("#chick-int").val();
            if (Content == "" || Content == oldContent) {
                return;
            }
            oldContent = Content;
            notSupportChecked = false;
            DetectLanguage(Content, false);
        });

        $("#chick-int").on("input propertychange", function () {
            var Content = $("#chick-int").val();
            if (Content == "") {
                $("#clearIcon").css("display", "none");
            } else {
                $("#clearIcon").css("display", "block");
            }
        });

        $("#pQuick").click(function () {
            var checked = $("#quick").attr("value");
            if (checked == "1") {
                document.getElementById("quick").src = UnCheckedImg;
                $("#quick").attr("value", "0");
            } else {
                document.getElementById("quick").src = CheckedImg;
                $("#quick").attr("value", "1");
            }
            LvChange();
        });

        $("#pIsRead").click(function () {
            var checked = $("#isRead").attr("value");
            if (checked == "1") {
                document.getElementById("isRead").src = UnCheckedImg;
                $("#isRead").attr("value", "0");
            } else {
                document.getElementById("isRead").src = CheckedImg;
                $("#isRead").attr("value", "1");
            }
        });

        $('#prompt-btn').click(function () {
            $('#eject-mask').fadeOut(200);
            $('#prompt').slideUp(200);
            notSupportChecked = true;
        });

        $("#submit").bind("click", function () {
            var Content = $("#chick-int").val();
            if (isEmojiCharacter(Content)) {
                $("#EjectTitle").html("请勿输入特殊字符及表情符号");
                $('#eject-mask').fadeIn(100);
                $('#prompt').slideDown(100);
                return;
            }

            Loading.ShowLoading();
            DetectLanguage(Content, true);
        });
    });

    function ChooseFile() {
//        var file = $("input[type='file']");
//        if (file != null && file.length > 0) {
//            $("input[type='file'] :first").click()
//        }
//        upload._uploadFile();
        upload._uploadFile();

    }

    function ChangeUpload(show) {
        if (show) {
            $("#backText").css("display", "block");
            $("#uploadText").css("display", "block");
            $("#uploadFileText").css("display", "block");
            $("#textInput").css("display", "none");
            $("#toUpload").css("display", "none");
        } else {
            $("#backText").css("display", "none");
            $("#uploadText").css("display", "none");
            $("#uploadFileText").css("display", "none");
            $("#textInput").css("display", "block");
            $("#toUpload").css("display", "block");
        }
    }

    function GetLanguageShow() {
        var DualList = ${DualList};
        for (var k in DualList) {
            var Code = DualList[k].sourceCode;
            if ("zh" == Code) {
                ChineseCn = DualList[k].sourceCn;
                ChineseEn = DualList[k].sourceEn;
            } else if ("en" == Code) {
                EnglishCn = DualList[k].sourceCn;
                EnglishEn = DualList[k].sourceEn;
            }
        }
        console.log("GetLanguageShow: " + ChineseCn + ChineseEn + EnglishCn + EnglishEn);
    }

    function SetDual(Language) {
        var setLanguageCn = "";
        var setLanguageEn = "";
        var TargetLanguageCn = "";
        var TargetLanguageEn = "";
        if (Language == "zh_CN") {
            setLanguageCn = ChineseCn;
            setLanguageEn = ChineseEn;
            TargetLanguageCn = EnglishCn;
            TargetLanguageEn = EnglishEn;
        } else {
            setLanguageCn = EnglishCn;
            setLanguageEn = EnglishEn;
            TargetLanguageCn = ChineseCn;
            TargetLanguageEn = ChineseEn;
        }

        $("#dualSource").children('option').each(function () {
            var temp_value = $(this).val();
            if (temp_value == setLanguageCn || temp_value == setLanguageEn) {
                $(this)[0].selected = true;
                $(this).html("检测语言：" + $(this).html());
            }
        });

        DualChange();

        $("#dualTarget").children('option').each(function () {
            var temp_value = $(this).html();
            if (temp_value == TargetLanguageCn || temp_value == TargetLanguageEn) {
                $(this)[0].selected = true;
            }
        });
    }

    function ResetInfo() {
        var json = ${contentJson};
        if (json != null) {
            var content = json.Content;
            var dualId = json.DualId;
            var PurposeId = json.PurposeId;
            var DomainId = json.DomainId;
            var TransLvId = json.TransLvId;
            var Express = json.Express;

            ResetDual(dualId);
            $("#chick-int").val(content);

            //用途
            $("#purpose").children('option').each(function () {
                var temp_value = $(this).attr("purposeId");
                if (temp_value == PurposeId) {
                    $(this)[0].selected = true;
                }
            });
            //领域
            $("#domain").children('option').each(function () {
                var temp_value = $(this).attr("domainId");
                if (temp_value == DomainId) {
                    $(this)[0].selected = true;
                }
            });
            //翻译级别
            $("#translateLv").children('option').each(function () {
                var temp_value = $(this).attr("transLv");
                if (temp_value == TransLvId) {
                    $(this)[0].selected = true;
                }
            });

            if (Express == "Y") {
                document.getElementById("quick").src = CheckedImg;
                $("#quick").attr("value", "1");
            }
            LvChange();
        }
    }

    function ResetDual(DualId) {
        var DualJson = ${DualJson};
        var DualJsonEn = ${DualJsonEn};
        var targetCn = "";
        var targetEn = "";
        var sourceCn = "";
        var sourceEn = "";
        for (var k in DualJson) {
            for (var v in DualJson[k]) {
                if (DualId == DualJson[k][v]) {
                    sourceCn = k;
                    targetCn = v;
                }
            }
        }

        for (var o in DualJsonEn) {
            for (var p in DualJsonEn[o]) {
                if (DualId == DualJsonEn[o][p]) {
                    sourceEn = o;
                    targetEn = p;
                }
            }
        }

        $("#dualSource").children('option').each(function () {
            var temp_value = $(this).val();
            if (temp_value == sourceCn || temp_value == sourceEn) {
                $(this)[0].selected = true;
            }
        });

        DualChange();

        $("#dualTarget").children('option').each(function () {
            var temp_value = $(this).html();
            if (temp_value == targetCn || temp_value == targetEn) {
                $(this)[0].selected = true;
            }
        });
    }

    function SwapDual() {
        var DualId = $("#dualTarget").val();
        var DualJson = ${DualJson};
        var DualJsonEn = ${DualJsonEn};
        var targetCn = "";
        var targetEn = "";
        var sourceCn = "";
        var sourceEn = "";
        for (var k in DualJson) {
            for (var v in DualJson[k]) {
                if (DualId == DualJson[k][v]) {
                    sourceCn = k;
                    targetCn = v;
                }
            }
        }

        for (var o in DualJsonEn) {
            for (var p in DualJsonEn[o]) {
                if (DualId == DualJsonEn[o][p]) {
                    sourceEn = o;
                    targetEn = p;
                }
            }
        }

        if (targetCn in DualJson) {
            $("#dualSource").children('option').each(function () {
                var temp_value = $(this).val();
                if (temp_value == targetCn || temp_value == targetEn) {
                    $(this)[0].selected = true;
                }
            });
        } else {
            $("#EjectTitle").html("<spring:message code="written.content.tips4"/>");
            $('#eject-mask').fadeIn(100);
            $('#prompt').slideDown(100);
            return;
        }

        DualChange();

        $("#dualTarget").children('option').each(function () {
            var temp_value = $(this).html();
            if (temp_value == sourceCn || temp_value == sourceEn) {
                $(this)[0].selected = true;
            }
        });
    }

    function AutoChangeDual(SourceCn, SourceEn) {
        $("#dualSource").children('option').each(function () {
            var temp_value = $(this).val();
            if (temp_value.substr(0, 4) == "检测语言") {
                temp_value = temp_value.substr(5);
            }
            if (temp_value == SourceCn || temp_value == SourceEn) {
                $(this)[0].selected = true;
            }
        });

        DualChange();

        if (SourceEn == ChineseEn || SourceCn == ChineseCn) {
            $("#dualTarget").children('option').each(function () {
                var temp_value = $(this).html();
                if (temp_value == EnglishEn || temp_value == EnglishCn) {
                    $(this)[0].selected = true;
                }
            });
        }
    }

    function LvChange() {
        var Lv = $("#translateLv").find("option:selected").attr("transLv");
        if (Lv == "100210") {
            if ($("#quick").attr("value") == "0") {
                $("#TranslateSpeed").html("<spring:message code="written.content.speed"/>" + "2" + "<spring:message code="written.content.speed1"/>");
            } else {
                $("#TranslateSpeed").html("<spring:message code="written.content.speed"/>" + "1" + "<spring:message code="written.content.speed1"/>");
            }
        } else if (Lv == "100220") {
            if ($("#quick").attr("value") == "0") {
                $("#TranslateSpeed").html("<spring:message code="written.content.speed"/>" + "3" + "<spring:message code="written.content.speed1"/>");
            } else {
                $("#TranslateSpeed").html("<spring:message code="written.content.speed"/>" + "2" + "<spring:message code="written.content.speed1"/>");
            }
        } else if (Lv == "100230") {
            if ($("#quick").attr("value") == "0") {
                $("#TranslateSpeed").html("<spring:message code="written.content.speed"/>" + "4" + "<spring:message code="written.content.speed1"/>");
            } else {
                $("#TranslateSpeed").html("<spring:message code="written.content.speed"/>" + "3" + "<spring:message code="written.content.speed1"/>");
            }
        }
    }

    function ServerChange() {
        var IsService = $("#otherServ").find("option:selected").attr("otherServId");
        if (IsService == "Y") {
            $("#otherService").css("display", "block");
        } else {
            $("#otherService").css("display", "none");
        }
    }

    function DualChange() {
        var key = $("#dualSource").val();
        var Map = ${DualJson};

        if (key.substr(0, 4) == "检测语言") {
            key = key.substr(5);
        }

        var obj = document.getElementById("dualTarget");
        obj.options.length = 0;
        for (var k in Map) {
            if (k == key) {
                for (var v in Map[k]) {
                    obj.add(new Option(v, Map[k][v]));
                }
            }
        }
    }

    function toLicense() {
        window.location.href = "<%=path%>/agreement"
    }

    function Back() {
        window.location.href = "<%=path%>/";
    }

    function saveContent(Content, ContentLength) {
        //语言对
        var DualId = $("#dualTarget").val();
        var targetCn = "";
        var targetEn = "";
        var sourceCn = "";
        var sourceEn = "";
        var DualJson = ${DualJson};
        var DualJsonEn = ${DualJsonEn};
        for (var k in DualJson) {
            for (var v in DualJson[k]) {
                if (DualId == DualJson[k][v]) {
                    sourceCn = k;
                    targetCn = v;
                }
            }
        }
        for (var o in DualJsonEn) {
            for (var p in DualJsonEn[o]) {
                if (DualId == DualJsonEn[o][p]) {
                    sourceEn = o;
                    targetEn = p;
                }
            }
        }
        var DualValCn = sourceCn + " → " + targetCn;
        var DualValEn = sourceEn + " → " + targetEn;
        //用途
        var PurposeId = $("#purpose").find("option:selected").attr("purposeId");
        var PurposeVal = $("#purpose").val();
        //领域
        var DomainId = $("#domain").find("option:selected").attr("domainId");
        var DomainVal = $("#domain").val();
        //翻译级别
        var TransLvId = $("#translateLv").find("option:selected").attr("transLv");
        var TransLvVal = $("#translateLv").val();
        //是否加急
        var Express = "N";
        if ($("#quick").attr("value") == "1") {
            Express = "Y";
        }
        var Detail = "";
        if (Content.length > 15) {
            Detail = Content.substring(0, 15) + "......";
        } else {
            Detail = Content;
        }
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/written/onSaveContent",
            modal: true,
            timeout: 30000,
            data: {
                Content: Content,
                ContentLength: ContentLength,
                DualId: DualId,
                DualVal: DualValCn,
                DualValEn: DualValEn,
                PurposeId: PurposeId,
                PurposeVal: PurposeVal,
                DomainId: DomainId,
                DomainVal: DomainVal,
                TransLvId: TransLvId,
                TransLvVal: TransLvVal,
                Express: Express,
                Detail: Detail
            },
            success: function (data) {
                if (data.status == 1) {
                    var date = new Date();
                    date.setDate(date.getDate() - 1);
                    document.cookie = "dualChoose=0" + ';expires=' + date + ";path=/";
                    document.cookie = "dualChoose=" + DualId + ";path=/"
                    ;
                    if (${isLogin==null || isLogin=='0'}) {
                        SaveToUrl("/written/onContentSubmit");
                        return;
                    }
                    window.location.href = "<%=path%>/written/onContentSubmit";
                }
            },
            error: function (data) {

            },
            beforeSend: function () {
                Loading.ShowLoading();
            },
            complete: function () {
                Loading.HideLoading();
            }
        });
    }

    function SaveToUrl(ToUrl) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/written/onSaveToUrl",
            modal: true,
            timeout: 30000,
            data: {
                ToUrl: ToUrl
            },
            success: function (data) {
                if (data.status == 1) {
                    var tourl = "<%=path%>/login/login?to=login";
                    window.location.href = tourl;
                }
            },
            error: function (data) {

            },
            beforeSend: function () {

            },
            complete: function () {

            }
        });
    }

    function inputClear() {
        $("#chick-int").val("");
    }

    function DetectLanguage(text, submit) {
        if (submit && text == "") {
            $("#EjectTitle").html("<spring:message code="written.content.tips1"/>");
            $('#eject-mask').fadeIn(100);
            $('#prompt').slideDown(100);
            Loading.HideLoading();
            return;
        }
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/lanDetection",
            modal: true,
            timeout: 30000,
            data: {
                text: text
            },
            success: function (data) {
                if (data.status == 1) {
                    var Language = data.fintec;
                    console.log("DetectLanguage: " + Language);
                    var SourceCn = "";
                    var SourceEn = "";

                    var DualList = ${DualList};
                    for (var k in DualList) {
                        var Code = DualList[k].sourceCode;
                        if (Language == Code) {
                            SourceCn = DualList[k].sourceCn;
                            SourceEn = DualList[k].sourceEn;
                        }
                    }

                    if (SourceCn == "" || SourceEn == "") { //&& notSupportChecked == false) {
                        $("#EjectTitle").html("<spring:message code="written.content.tips5"/>");
                        $('#eject-mask').fadeIn(100);
                        $('#prompt').slideDown(100);
                        Loading.HideLoading();
                        return;
                    }

                    AutoChangeDual(SourceCn, SourceEn);

                    if (submit) {
                        var Content = text;
                        var ContentLength = count(escape(Content));

                        if (ContentLength > 2000) {
                            $("#EjectTitle").html("<spring:message code="written.content.tips2"/>");
                            $('#eject-mask').fadeIn(100);
                            $('#prompt').slideDown(100);
                            Loading.HideLoading();
                            return;
                        }
                        if (!($("#isRead").attr("value") == "1")) {
                            $("#EjectTitle").html("<spring:message code="written.content.tips3"/>");
                            $('#eject-mask').fadeIn(100);
                            $('#prompt').slideDown(100);
                            Loading.HideLoading();
                            return;
                        }

                        saveContent(Content, ContentLength);
                    }
                }
            },
            error: function (data) {

            },
            beforeSend: function () {

            },
            complete: function () {

            }
        });
    }

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
        return false;
    }

</script>
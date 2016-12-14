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
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title><spring:message code="written.content.title"/></title>
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
<div class="wrapper-big" id="body">
    <div class="eject-big">
        <div class="prompt" id="prompt">
            <div class="prompt-title">请选择</div>
            <div class="prompt-confirm">
                <ul>
                    <li id="EjectTitle">IOS端不支持上传附件请前往PC端</li>
                </ul>
            </div>
            <div class="prompt-confirm-btn">
                <a class="btn btn-white" id="prompt-btn">确认</a>
            </div>

        </div>
        <div class="mask" id="eject-mask"></div>
    </div>

    <%--头部--%>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="翻译下单"/>
        <jsp:param name="BackTo" value="javascript:window.history.go(-1)"/>
    </jsp:include>

    <section class="index-wrapper">
        <div class="testing-title">
            <p>选择语言:</p>
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
            <p class="test-icon1" id="swap"><i class="icon iconfont">&#xe621;</i></p>
            <p>
                <select id="dualTarget" class="select testing-select">

                </select>
                <span>|</span>
            </p>
        </section>
        <!--文字翻译-->
        <section class="translation-content">
            <textarea class="textarea textarea-large" name="chick-int" id="chick-int"
                      placeholder="最多可输入2000字"></textarea>
            <a href="javascript:inputClear()"><i class="icon iconfont">&#xe618;</i></a>
        </section>
        <div class="testing-title" style="display: none">
            <p>您可以任意选择输入内容或者<a href="javascript:" id="upload">上传附件</a></p>
        </div>
        <div class="choice-list">
            <ul>
                <li>
                    <p class="word">用途:</p>
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
                    <p class="word">领域:</p>
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
                    <p class="word">增值服务:</p>
                    <p>
                        <select id="otherServ" class="select testing-select-small" onchange="ServerChange()">
                            <option otherServId="N">无排版</option>
                            <%--<option otherServId="Y">需排版</option>--%>
                        </select>
                        <span>|</span>
                    </p>
                    <p class="p-mr" id="otherService">
                        <select id="otherServi" class="select testing-select-small">
                            <option>Excel</option>
                            <option>Word</option>
                        </select>
                        <span>|</span>
                    </p>
                </li>
                <li>
                    <p class="word">级别选择:</p>
                    <p>
                        <select id="translateLv" class="select testing-select-small" onchange="LvChange()">
                            <option transLv="100210">标准级</option>
                            <option transLv="100220" selected="selected">专业级</option>
                            <option transLv="100230">出版级</option>
                        </select>
                        <span>|</span>
                    </p>
                </li>
                <li class="word-checkbox mb-0">
                    <p id="TranslateSpeed">预计翻译速度: N/A小时/千字</p>
                    <p class="p-mr1" id="pQuick">
                        <img id="quick" src="<%=path%>/ui/images/checkbox.png" class="imgcheckbox" value="0">加急<b>（加急订单，更快获得译文）</b>
                    </p>
                </li>
                <li id="pIsRead">
                    <p><img id="isRead" src="<%=path%>/ui/images/checkbox1.png" class="imgcheckbox" value="1"></p>
                    <p class="a-link">我已阅读并同意中译语通的<a href="javascript:toLicense()">《翻译协议》</a></p>
                </li>
            </ul>
        </div>
        <div class="wap-btn"><a href="javascript:void(0)" id="submit" class="btn submit-btn btn-blue">提交</a></div>
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

    $(function () {
        LvChange();
        ServerChange();
        DualChange();
    });

    $(document).ready(function () {
        Loading.HideLoading();
        var UserLanguage = '${pageContext.response.locale}';
        console.log("UserLanguage: " + UserLanguage);
        SetDual(UserLanguage);

        $("#swap").bind("click", function () {
            SwapDual();
        });

        $("#chick-int").blur(function () {
            var Content = $("#chick-int").val();
            if (Content == "") {
                return;
            }
            DetectLanguage(Content);
        });

        $("#submit").bind("click", function () {
            var Content = $("#chick-int").val();
            var ContentLength = count(escape(Content));
            if (ContentLength == 0) {
                $("#EjectTitle").html("请输入翻译内容");
                $('#eject-mask').fadeIn(100);
                $('#prompt').slideDown(100);
                return;
            }
            if (ContentLength > 2000) {
                $("#EjectTitle").html("翻译内容超出2000字");
                $('#eject-mask').fadeIn(100);
                $('#prompt').slideDown(100);
                return;
            }
            if (!($("#isRead").attr("value")=="1")) {
                $("#EjectTitle").html("请阅读翻译协议");
                $('#eject-mask').fadeIn(100);
                $('#prompt').slideDown(100);
                return;
            }
            saveContent(Content, ContentLength);
        });

        $('#upload').click(function () {

        });

//        $('#prompt-btn').click(function () {
//            $('#eject-mask').fadeOut(200);
//            $('#prompt').slideUp(200);
//        })

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
    });

    function SetDual(Language) {
        var setLanguageCn = "";
        var setLanguageEn = "";
        if (Language == "zh_CN") {
            setLanguageCn = "简体中文";
            setLanguageEn = "Chinese";
        } else {
            setLanguageCn = "英语";
            setLanguageEn = "English";
        }

        $("#dualSource").children('option').each(function () {
            var temp_value = $(this).val();
            if (temp_value == setLanguageCn || temp_value == setLanguageEn) {
                $(this)[0].selected = true;
            }
        });

        DualChange();

        $("#dualTarget").children('option').each(function () {
            var temp_value = $(this).html();
            if (temp_value == sourceCn || temp_value == sourceEn) {
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
            $("#EjectTitle").html("系统不支持该语言");
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
        if (SourceCn == "" || SourceEn == "") {
            $("#EjectTitle").html("检测输入语言系统暂不支持，请确认");
            $('#eject-mask').fadeIn(100);
            $('#prompt').slideDown(100);
            return;
        }

        $("#dualSource").children('option').each(function () {
            var temp_value = $(this).val();
            if (temp_value == SourceCn || temp_value == SourceEn) {
                $(this)[0].selected = true;
            }
        });
        DualChange();
    }

    function LvChange() {
        var Lv = $("#translateLv").find("option:selected").attr("transLv");
        if (Lv == "100210") {
            if ($("#quick").attr("value")=="0") {
                $("#TranslateSpeed").html("预计翻译速度: 1小时/千字");
            } else {
                $("#TranslateSpeed").html("预计翻译速度: 2小时/千字");
            }
        } else if (Lv == "100220") {
            if ($("#quick").attr("value")=="0") {
                $("#TranslateSpeed").html("预计翻译速度: 2小时/千字");
            } else {
                $("#TranslateSpeed").html("预计翻译速度: 3小时/千字");
            }
        } else if (Lv == "100230") {
            if ($("#quick").attr("value")=="0") {
                $("#TranslateSpeed").html("预计翻译速度: 3小时/千字");
            } else {
                $("#TranslateSpeed").html("预计翻译速度: 4小时/千字");
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
        window.location.href = "<%=path%>/common/agreement"
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
        if ($("#quick").prop("checked")) {
            Express = "Y";
        }
        var Detail = Content.substring(0, 15) + "...";
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

    function DetectLanguage(text) {
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
                    switch (Language) {
                        case "en":
                            SourceCn = "英语";
                            SourceEn = "English";
                            break;
                        case "zh":
                            SourceCn = "简体中文";
                            SourceEn = "Chinese";
                            break;
                        case "fr":
                            SourceCn = "法语";
                            SourceEn = "France";
                            break;
                        case "pt":
                            SourceCn = "葡萄牙语";
                            SourceEn = "Portuguese";
                            break;
                        default:
                            SourceCn = ""
                            SourceEn = ""
                    }
                    AutoChangeDual(SourceCn, SourceEn);
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

</script>
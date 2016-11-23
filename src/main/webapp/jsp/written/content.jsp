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
</head>
<body>
<div class="wrapper-big" id="body">
    <!--上传提示弹出框-->
    <div class="eject-big">
        <div class="prompt" id="prompt">
            <div class="prompt-title">请选择</div>
            <div class="prompt-confirm">
                <ul>
                    <li id="EjectTitle">IOS端不支持上传附件请前往PC端</li>
                </ul>
            </div>
            <div class="prompt-confirm-btn">
                <a href="#" id="prompt-btn">确认</a>
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
                <select id="dual" class="select testing-select-big">
                    <c:forEach items="${DualList}" var="pair">
                        <option dualId="${pair.duadId}">${pair.sourceCn}->${pair.targetCn}</option>
                    </c:forEach>
                </select>
                <span>|</span>
            </p>
        </section>
        <!--文字翻译-->
        <section class="translation-content">
            <textarea class="textarea textarea-large" name="chick-int" id="chick-int"
                      placeholder="最多可输入2000字"></textarea>
            <a hrel="#"><i class="icon iconfont">&#xe618;</i></a>
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
                        <select id="otherServ" class="select testing-select-small" onchange="ServChange()">
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
                            <option transLv="100220">专业级</option>
                            <option transLv="100230">出版级</option>
                        </select>
                        <span>|</span>
                    </p>
                    </p>
                </li>
                <li class="word-checkbox">
                    <p id="TranslateSpeed">预计翻译速度: N/A小时/千字</p>
                    <p class="p-mr1"><input type="checkbox" id="quick" class="checkbox" onchange="LvChange()">加急<b
                            id="pQuick">(加急订单，更快获得译文)</b>
                    </p>
                </li>
                <li>
                    <p><input id="isRead" type="checkbox" class="checkbox"></p>
                    <p id="pIsRead" class="a-link">我已阅读并同意中译语通的<a href="javascript:toLicense()">《翻译协议》</a></p>
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
    $(function () {
        LvChange();
        ServChange();
    });

    $(document).ready(function () {
        Loading.HideLoading();
        $("#submit").bind("click", function () {
            var Content = $("#chick-int").val();
            var ContentLength = count(escape(Content));

            if (ContentLength == 0) {
                $("#EjectTitle").html("请输入翻译内容");
                $('#eject-mask').fadeIn(100);
                $('#prompt').slideDown(100);
                return;
            }
            if (ContentLength >= 2000) {
                $("#EjectTitle").html("翻译内容超出2000字");
                $('#eject-mask').fadeIn(100);
                $('#prompt').slideDown(100);
                return;
            }
            if (!$("#isRead").prop("checked")) {
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
            var checked = document.getElementById("quick").checked;
            document.getElementById("quick").checked = !checked;
            LvChange();
        });

        $("#pIsRead").click(function () {
            var checked = document.getElementById("isRead").checked;
            document.getElementById("isRead").checked = !checked;
        });
    });

    function LvChange() {
        var Lv = $("#translateLv").find("option:selected").attr("transLv");
        if (Lv == "100210") {
            if ($("#quick").prop("checked")) {
                $("#TranslateSpeed").html("预计翻译速度: 1小时/千字");
            } else {
                $("#TranslateSpeed").html("预计翻译速度: 2小时/千字");
            }
        } else if (Lv == "100220") {
            if ($("#quick").prop("checked")) {
                $("#TranslateSpeed").html("预计翻译速度: 2小时/千字");
            } else {
                $("#TranslateSpeed").html("预计翻译速度: 3小时/千字");
            }
        } else if (Lv == "100230") {
            if ($("#quick").prop("checked")) {
                $("#TranslateSpeed").html("预计翻译速度: 3小时/千字");
            } else {
                $("#TranslateSpeed").html("预计翻译速度: 4小时/千字");
            }
        }
    }

    function ServChange() {
        var IsService = $("#otherServ").find("option:selected").attr("otherServId");
        if (IsService == "Y") {
            $("#otherService").css("display", "block");
        } else {
            $("#otherService").css("display", "none");
        }
    }

    function toLicense() {
        window.location.href = "<%=path%>/common/agreement"
    }

    function saveContent(Content, ContentLength) {
        //语言对
        var DualId = $("#dual").find("option:selected").attr("dualId");
        var DualVal = $("#dual").val();
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
                DualVal: DualVal,
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
                    window.location.href = "<%=path%>/login/login";
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
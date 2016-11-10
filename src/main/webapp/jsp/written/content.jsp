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
                <select class="select testing-select">
                    <option>检测语言：中文</option>
                    <option>检测语言：英文</option>
                </select>
                <span>|</span>
            </p>
            <p class="test-icon"><i class="icon iconfont">&#xe621;</i></p>
            <p>
                <select class="select testing-select">
                    <option>英文</option>
                </select>
                <span>|</span>
            </p>
        </section>
        <!--文字翻译-->
        <section class="translation-content">
            <textarea class="textarea textarea-large" name="chick-int" id="chick-int" placeholder="2000字"></textarea>
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

<%--协议--%>
<div class="wrapper-big" id="license" style="display: none">
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="协议"/>
        <jsp:param name="BackTo" value="javascript:toBody()"/>
    </jsp:include>

    <section class="about">
        <ul>
            <li class="td">
                译云平台在此特别提醒您（用户）在注册成为用户之前，请认真阅读本《用户协议》（以下简称“本协议”），确保您充分理解本协议中各条款。请您审慎阅读并选择接受或不接受本协议。除非您接受本协议所有条款，否则您无权注册、登录或使用本协议所涉服务。您的注册、登录、使用等行为将视为对本协议的接受，
                并同意接受本协议各项条款的约束。如果您未满18周岁，请在法定监护人的陪同下阅读本协议，并特别注意未成年人使用条款。
            </li>
            <li class="td">
                本协议约定译云平台与用户之间关于“译云”软件服务（以下简称“服务”）的权利义务。“用户”是指注册、登录、使用本服务的个人。本协议可由译云平台随时更新，更新后的协议条款一旦公布即代替原来的协议条款，恕不再另行通知，用户可在本网站查阅最新版协议条款。在译云平台修改协议条款后，如果用户不接受修改后的条款，请立即停止使用译云平台提供的服务，用户继续使用译云平台提供的服务将被视为接受修改后的协议。
            </li>
            <li>一．账号注册</li>
            <li class="td">1-1．用户在使用本服务前需要注册一个“译云”账号。“译云”账号应当使用电子邮箱或手机号码绑定注册，请用户使用尚未与“译云”账号绑定的电子邮箱或手机号码。</li>
            <li class="td">
                1-2．在用户注册及使用本服务时，译云平台需要搜集能识别用户身份的个人信息以便译云平台可以在必要时联系用户，或为用户提供更好的使用体验。译云平台搜集的信息包括但不限于用户的姓名、性别、年龄、出生日期、身份证号、地址、学校情况、公司情况、所属行业、个人说明；译云平台同意对这些信息的使用将受限于第三条用户个人隐私信息保护的约束。
            </li>
        </ul>
    </section>
</div>


</body>
</html>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
<script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
<script type="text/javascript" src="<%=path%>/js/common/wordcount.js"></script>
<script type="text/javascript">
    $(function () {
        LvChange();
        ServChange();
    });

    $(document).ready(function () {
        $("#submit").bind("click", function () {
            var Content = $("#chick-int").val();
            var ContentLength = count(escape(Content));
            if (ContentLength == 0) {
                $("#EjectTitle").html("没字");
                $('#eject-mask').fadeIn(100);
                $('#prompt').slideDown(100);
                return;
            }
            if (ContentLength >= 2000) {
                $("#EjectTitle").html("多了");
                $('#eject-mask').fadeIn(100);
                $('#prompt').slideDown(100);
                return;
            }
            if (!$("#isRead").prop("checked")) {
                $("#EjectTitle").html("没读");
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
        $("#body").css("display", "none");
        $("#_bottom").css("display", "none");
        $("#license").css("display", "block");
    }

    function toBody() {
        $("#body").css("display", "block");
        $("#_bottom").css("display", "block");
        $("#license").css("display", "none");
    }

    function saveContent(Content, ContentLength) {
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
        var Detail = Content.substring(0, 10) + "...";
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/written/onSaveContent",
            modal: true,
            timeout: 30000,
            data: {
                Content: Content,
                ContentLength: ContentLength,
                DualId: "1",
                PurposeId: PurposeId,
                TransLvId: TransLvId,
                Express: Express
            },
            success: function (data) {
                if (data.status == 1) {
                    var Price = data.Price;
                    onSubmit("PurposeId=" + PurposeId + "&PurposeVal=" + PurposeVal
                            + "&DomainId=" + DomainId + "&DomainVal=" + DomainVal
                            + "&TransLvId=" + TransLvId + "&TransLvVal=" + TransLvVal
                            + "&Express=" + Express + "&Detail=" + Detail + "&Price=" + Price);
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

    function onSubmit(url) {
        window.location.href = "<%=path%>/written/onContentSubmit?" + url;
    }

</script>
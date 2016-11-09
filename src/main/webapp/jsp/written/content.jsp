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
<div class="wrapper-big">
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
    <!--上传提示弹出框-->
    <nav class="wap-second-nav">
        <ul>
            <a href="javascript:window.history.go(-1)"><i class="icon iconfont left">&#xe626;</i></a>
            <li>翻译下单</li>
            <a href="javascript:" id="nav-list"><i class="icon iconfont right">&#xe629;</i></a>
        </ul>
        <div class="pop-nav">
            <ul>
                <li>
                    <a href="#">译云首页</a>|
                    <a href="#">个人中心</a>|
                    <a href="#">我的订单</a>|
                    <a href="#">安全退出</a>
                </li>
            </ul>
        </div>
    </nav>
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
            <textarea class="textarea textarea-large" name="chick-int" id="chick-int"></textarea>
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
                            <option purposeId="111">哈哈</option>
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
                    <p class="p-mr1"><input type="checkbox" id="quick" class="checkbox" onchange="LvChange()">加急<b>(加急订单，更快获得译文)</b>
                    </p>
                </li>
                <li>
                    <p><input id="isRead" type="checkbox" class="checkbox"></p>
                    <p class="a-link">我已阅读并同意中译语通的<a href="#">《翻译协议》</a></p>
                </li>
            </ul>
        </div>
        <div class="wap-btn"><a href="javascript:void(0)" id="submit" class="btn submit-btn btn-blue">提交</a></div>
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
    $(document).ready(function () {
        $("#submit").bind("click", function () {
            if (!$("#isRead").prop("checked")) {
                $("#EjectTitle").html("没读");
                $('#eject-mask').fadeIn(100);
                $('#prompt').slideDown(100);
            }
            var PurposeId = $("#purpose").find("option:selected").attr("purposeId");
            var PurposeVal = $("#purpose").val();
            var DomainId = $("#domain").find("option:selected").attr("domainId");
            var DomainVal = $("#domain").val();
            var TransLvId = $("#translateLv").find("option:selected").attr("transLv");
            var TransLvVal = $("#translateLv").val();
            var Express = "N";
            if ($("#quick").prop("checked")) {
                Express = "Y";
            }

            var Content = $("#chick-int").val();
            var ContentLength = count(escape(content));
            alert(ContentLength);
//            onSubmit("DomainId="+DomainId+"&DomainVal="+DomainVal);
        })

        $('#upload').click(function () {

        })

        $('#prompt-btn').click(function () {
            $('#eject-mask').fadeOut(200);
            $('#prompt').slideUp(200);
        })
    });

    $(function () {
        LvChange();
        ServChange();
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
            $("#otherService").css("display", "none")
        }
    }

    function onSubmit(url) {
        window.location.href = "<%=path%>/written/onContentSubmit?" + url;
    }

</script>
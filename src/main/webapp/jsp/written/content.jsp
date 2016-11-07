<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title><spring:message code="written.content.title"/></title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<!--上传提示弹出框-->
<div class="eject-big">
    <div class="prompt" id="prompt">
        <div class="prompt-title"><spring:message code="written.content.ptitle"/></div>
        <div class="prompt-confirm">
            <ul>
                <li><spring:message code="written.content.iosts"/></li>
            </ul>
        </div>
        <div class="prompt-confirm-btn">
            <%--<input  type="button" class="btn btn-white" id="prompt-btn" value=<spring:message code="written.content.confirm"/>/>--%>
            <a href="#" class="btn btn-white" id="prompt-btn"><spring:message code="written.content.confirm"/></a>
        </div>

    </div>
    <div class="mask" id="eject-mask"></div>
</div>
<!--上传提示弹出框-->
<nav class="wap-second-nav">
    <ul>
        <a href="javascript:"><i class="icon iconfont left">&#xe626;</i></a>
        <li><spring:message code="written.content.ltitle"/></li>
        <a href="javascript:" id="nav-list"><i class="icon iconfont right">&#xe629;</i></a>
    </ul>
    <div class="pop-nav">
        <ul>
            <li>
                <a href="#"><spring:message code="popnav.public.index"/></a>|
                <a href="#"><spring:message code="popnav.public.ucenter"/></a>|
                <a href="#"><spring:message code="popnav.public.order"/></a>|
                <a href="#"><spring:message code="popnav.public.exit"/></a>
            </li>
        </ul>
    </div>
</nav>
<section class="index-wrapper">
    <div class="testing-title">
        <p><spring:message code="written.content.choose"/></p>
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
    <!--转换语言结束-->
    <div class="testing-title">
        <p><spring:message code="written.content.content"/></p>
        <p class="right"><a href="#"><spring:message code="written.content.back"/></a></p>
    </div>
    <!--翻译内容-->
    <section class="history">
        <div class="history-list">
            <ul>
                <a href="javascript:">
                    <li>
                        <p><i class="icon iconfont">&#xe601;</i></p>
                        <p class="word-large">上传二十文件名称上传文件名称上传文件名称.docx</p>
                        <p class="right"><a href="#" class="btn btn-red btn-mini">删除</a></p>
                    </li>
                </a>
            </ul>
        </div>
    </section>
    <div class="testing-title">
        <p><a href="javascript:" id="upload">上传附件</a></p>
    </div>
    <div class="choice-list">
        <ul>
            <li>
                <p class="word"><spring:message code="written.content.use"/></p>
                <p>
                    <select class="select testing-select-small">
                        <option>不限时</option>
                    </select>
                    <span>|</span>
                </p>
            </li>
            <li>
                <p class="word"><spring:message code="written.content.place"/></p>
                <p>
                    <select class="select testing-select-small">
                        <option>不限时</option>
                    </select>
                    <span>|</span>
                </p>
            </li>
            <li>
                <p class="word"><spring:message code="written.content.service"/></p>
                <p>
                    <select class="select testing-select-small">
                        <option>无排版</option>
                    </select>
                    <span>|</span>
                </p>
                <p class="p-mr">
                    <select class="select testing-select-small">
                        <option>无转化格式</option>
                    </select>
                    <span>|</span>
                </p>
            </li>
            <li>
                <p class="word"><spring:message code="written.content.level"/></p>
                <p>
                    <select class="select testing-select-small">
                        <option>专业级</option>
                    </select>
                    <span>|</span>
                </p>
                </p>
            </li>
            <li class="word-checkbox">
                <p>预计翻译速度: 1小时/千字</p>
                <p class="p-mr1"><input type="checkbox" class="checkbox">加急<b>(加急订单，更快获得译文)</b></p>
            </li>
            <li>
                <p><input type="checkbox" class="checkbox"></p>
                <p class="a-link"><spring:message code="written.content.read"/><a href="#"><spring:message code="written.content.protocol"/></a></p>
            </li>
        </ul>
    </div>
    <div class="wap-btn"><a href="#" id="submit" class="btn submit-btn btn-blue">提交</a></div>
</section>
<!--底部-->
<section class="footer-big">
    <section class="terminal">
        <ul>
            <li class="none">
                <p><img src="<%=path%>/ui/images/icon-1.png" /></p>
                <p><spring:message code="all.project.public.icon-1"/></p>
            </li>
            <li class="tow current">
                <p><img src="<%=path%>/ui/images/icon-2.png" /></p>
                <p><spring:message code="all.project.public.icon-2"/></p>
            </li>
            <li class="three none-ml">
                <p><img src="<%=path%>/ui/images/icon-3.png" /></p>
                <p><spring:message code="all.project.public.icon-3"/></p>
            </li>
        </ul>
    </section>
    <footer class="footer">
        <ul>
            <li><a hrel="#"><spring:message code="all.project.public.footer.about"/></a>|
                <a hrel="#"><spring:message code="all.project.public.footer.find"/></a>|
                <a hrel="#"><spring:message code="all.project.public.footer.idea"/></a>|
                <a hrel="#"><spring:message code="all.project.public.footer.language"/></a></li>
            <li class="ash"><spring:message code="all.project.public.footer.title"/></li>
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
    $(document).ready(function() {
        $("#submit").bind("click", function () {
            onSubmit();
        })
    });

    $(function () {

    });

    function onSubmit() {
        var test = "haha";
        $.ajax({
            async : true,
            type : "POST",
            url : "<%=path%>/written/onContentSubmit",
            modal : true,
            timeout: 30000,
            data : {
                test:test
            },
            success : function(data) {
                var ToUrl = "<%=path%>/written/confirm";
                window.location.href=ToUrl;
            },
            error : function(data){

            },
            beforeSend:function(){

            },
            complete:function(){

            }
        });
    }

</script>
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
    <title><spring:message code="written.title"/></title>
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
        <div class="prompt-title">请选择</div>
        <div class="prompt-confirm">
            <ul>
                <li>IOS端不支持上传附件请前往PC端</li>
            </ul>
        </div>
        <div class="prompt-confirm-btn">
            <input  type="button" class="btn btn-white" id="prompt-btn" value="确认"/>
        </div>

    </div>
    <div class="mask" id="eject-mask"></div>
</div>
<!--上传提示弹出框-->
<nav class="wap-second-nav">
    <ul>
        <a href="javascript:"><i class="icon iconfont left">&#xe626;</i></a>
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
    <!--转换语言结束-->
    <div class="testing-title">
        <p>翻译内容:</p>
        <p class="right"><a href="#">返回</a></p>
    </div>
    <!--翻译内容-->
    <section class="history">
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
    <div class="testing-title">
        <p><a href="javascript:" id="upload">上传附件</a></p>
    </div>
    <div class="choice-list">
        <ul>
            <li>
                <p class="word">用途:</p>
                <p>
                    <select class="select testing-select-small">
                        <option>不限时</option>
                    </select>
                    <span>|</span>
                </p>
            </li>
            <li>
                <p class="word">领域:</p>
                <p>
                    <select class="select testing-select-small">
                        <option>不限时</option>
                    </select>
                    <span>|</span>
                </p>
            </li>
            <li>
                <p class="word">增值服务:</p>
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
                <p class="word">级别选择:</p>
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
                <p class="a-link">我已阅读并同意中译语通的<a href="#">《翻译协议》</a></p>
            </li>
        </ul>
    </div>
    <div class="wap-btn"><a href="#"><input type="button" id="submit" class="btn submit-btn btn-blue" value="提交"></a></div>
</section>
<!--底部-->
<section class="footer-big">
    <section class="terminal">
        <ul>
            <li class="none">
                <p><img src="<%=path%>/ui/images/icon-1.png" /></p>
                <p>客户端</p>
            </li>
            <li class="tow current">
                <p><img src="<%=path%>/ui/images/icon-2.png" /></p>
                <p>触屏版</p>
            </li>
            <li class="three none-ml">
                <p><img src="<%=path%>/ui/images/icon-3.png" /></p>
                <p>电脑版</p>
            </li>
        </ul>
    </section>
    <footer class="footer">
        <ul>
            <li><a hrel="#">关于我们</a>|<a hrel="#">译云招募</a>|<a hrel="#">意见反馈</a>|<a hrel="#">ENGLISH</a></li>
            <li class="ash">中译语通科技（北京）有限公司版权所有</li>
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
            url : "<%=path%>/written/onsubmit",
            modal : true,
            timeout: 30000,
            data : {
                test:test
            },
            success : function(data) {
                console.log("success");
            },
            error : function(data){
                console.log("fail");
            }
        });
    }

</script>
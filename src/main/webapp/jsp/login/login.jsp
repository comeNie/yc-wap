<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/8
  Time: 下午4:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
%>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>登录</title>
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>

</head>
<body>
 <!--登录-->
 <nav class="wap-second-nav">
     <ul>
         <a href="javascript:"><i class="icon iconfont left">&#xe626;</i></a>
         <li>登录</li>
         <a href="#" class="btn login-btn right1" onclick="registJump()">注册</a>
     </ul>
 </nav>
 <%--<!--tab-->
 <section class="login-tab">
     <ul>
         <li><a href="#" class="current">快速登录</a></li>
         <li><a href="#">普通登录</a></li>
     </ul>
 </section>
    <!--tab1-->
    <section id="tab1">
        <section class="login-prompt">验证成功则登录，未注册将自动创建译云帐号</section>
        <section class="form-big">
            <div class="set-password">
                <div class="set-int">
                    <ul>
                        <li>
                            <p>
                                <select class="select testing-select-big" id="selectid">
                                </select>
                                <span>|</span>
                            </p>
                        </li>
                        <li>
                            <p><input type="text" class="input input-large" placeholder="手机号"></p>
                            <label id="phoneLabel"></label>
                        </li>
                        <li>
                            <p><input type="text" class="input input-small" placeholder="请输入动态码"></p>
                            <p class="yzm"><a href="#" class="btn bnt-yzm">获取动态码</a></p>
                            <label id="phonetips"></label>
                        </li>
                        <li><a href="#" class="submit-btn btn-blue">立即登录</a></li>
                        <li class="right"><a href="#">忘记密码 </a></li>
                    </ul>
                </div>
            </div>
        </section>
    </section>
    <!--tab1-->--%>
    <section id="tab2" style="display:block;">
        <section class="form-big">
            <div class="set-password">
                <div class="set-int">
                    <ul>
                        <li>
                            <p><input id="phoneid" type="text" class="input input-large" placeholder="用户名/邮箱/手机号"></p>
                            <label id="phoneLabel"></label>
                        </li>
                        <li>
                            <p><input id="psdid" type="password" class="input input-large" placeholder="密码"></p>
                            <label id="psdLabel"></label>
                        </li>
                        <li class="int-border">
                            <p><input id="codeid" type="text" class="input input-yzm" placeholder="验证码"></p>
                            <p><img src="../ui/images/yzm.jpg"/></p>
                            <p><a href="#"><i class="icon-refresh"></i></a></p>
                            <label id="codeLabel"></label>
                        </li>
                        <li><a href="#" class="submit-btn btn-blue" onclick="login()">立即登录</a></li>
                        <li class="right"><a href="#" onclick="forgetpsd()">忘记密码 </a></li>
                    </ul>
                </div>
            </div>
        </section>
    </section>
    <%--<!--其他登录-->
    <section class="other-big">
        <div class="other-login">
            <p class="line"></p>
            <p class="word">其他登录</p>
            <p class="line"></p>
        </div>
        <div class="other-login-icon">
            <ul>
                <li class="none-ml"><a href="#"><img src="../ui/images/iocn-4.png" /></a></li>
                <li><a href="#"><img src="../ui/images/iocn-5.png" /></a></li>
                <li><a href="#"><img src="../ui/images/iocn-6.png" /></a></li>
                <li><a href="#"><img src="../ui/images/iocn-7.png" /></a></li>
                <li><a href="#"><img src="../ui/images/iocn-8.png" /></a></li>
            </ul>
        </div>
    </section>--%>

    <!--底部-->
    <section class="footer-big">
        <section class="terminal">
            <ul>
                <li class="none">
                    <p><img src="<%=path%>/ui/images/icon-1.png"/></p>

                    <p><spring:message code="all.project.public.icon-1"/></p>
                </li>
                <li class="tow current">
                    <p><img src="<%=path%>/ui/images/icon-2.png"/></p>

                    <p><spring:message code="all.project.public.icon-2"/></p>
                </li>
                <li class="three none-ml">
                    <p><img src="<%=path%>/ui/images/icon-3.png"/></p>

                    <p><spring:message code="all.project.public.icon-3"/></p>
                </li>
            </ul>
        </section>
        <footer class="footer">
            <ul>
                <li><a hrel="#"><spring:message code="all.project.public.footer.about"/></a>|<a hrel="#"><spring:message code="all.project.public.footer.find"/></a>|<a hrel="#"><spring:message code="all.project.public.footer.idea"/></a>|<a hrel="#"><spring:message code="all.project.public.footer.language"/></a></li>
                <li class="ash"><spring:message code="all.project.public.footer.title"/></li>
            </ul>
        </footer>
    </section>
</body>
</html>
<script>

    function login() {
        var phone = $("#phoneid").val();
        var psd = $("#psdid").val();
        var code = $("#codeid").val();
        if (phone == "" || phone == null) {
            $("#phoneLabel").html("请输入用户名/邮箱/手机号");
            $("#phoneLabel").css("display","block");
            return;
        }else {
            $("#phoneLabel").css("display","none");
        }

        if (psd == "" || psd == null) {
            $("#psdLabel").html("请输入密码");
            $("#psdLabel").css("display","block");
            return;
        }else {
            $("#psdLabel").css("display","none");
        }
        var t = /^[0-9a-zA-Z]{6,16}$/;
        if (!t.test(psd)){
            $("#psdLabel").html("<spring:message code="safe.changepsd.alert_newLength"/>");
            $("#psdLabel").css("display","block");
            return;
        }else {
            $("#psdLabel").css("display","none");
        }

        if (code == "" || code == null) {
            $("#codeLabel").html("请输入验证码");
            $("#codeLabel").css("display","block");
            return;
        }else {
            $("#codeLabel").css("display","none");
        }

        alert("该跳走了");
    }
    function forgetpsd() {
        var tourl = "<%=path%>/login/findpsd";
        window.location.href=tourl;
    }
    function registJump() {
        var tourl = "<%=path%>/login/register";
        window.location.href=tourl;
    }
</script>
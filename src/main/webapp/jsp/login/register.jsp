<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/8
  Time: 下午4:35
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
    <title>注册</title>
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
    <!--注册-->
    <nav class="wap-second-nav">
        <ul>
            <a href="javascript:"><i class="icon iconfont left">&#xe626;</i></a>
            <li>注册</li>
            <a href="#" class="btn login-btn right1">登录</a>
        </ul>
    </nav>

    <section class="form-big">
        <div class="set-password">
            <div class="set-int">
                <ul>
                    <li>
                        <p>
                            <select class="select testing-select-big">
                                <option>中国大陆 +86</option>
                                <option>中国大陆 +86</option>
                            </select>
                            <span>|</span>
                        </p>
                    </li>
                    <li>
                        <p><input type="text" class="input input-large" placeholder="用请输入手机号"></p>
                        <label>请输入正确手机号</label>
                    </li>
                    <li>
                        <p><input type="text" class="input input-small" placeholder="请输入动态码"></p>
                        <p class="yzm"><a href="#" class="btn bnt-yzm">获取动态码</a></p>
                    </li>
                    <li>
                        <p><input type="password" class="input input-large" placeholder="请输入密码"></p>
                    </li>
                    <li>
                        <p><input type="password" class="input input-large" placeholder="请再输入密码"></p>
                    </li>
                    <li><a href="#" class="submit-btn btn-blue">立即注册</a></li>
                    <li class="left"><p><input type="checkbox" class="checkbox"></p>我已经阅读并同意<a href="#">《译云用户协议》</a></li>
                </ul>
            </div>
        </div>
    </section>


    <!--底部-->
    <section class="footer-big">
        <section class="terminal">
            <ul>
                <li class="none">
                    <p><img src="../images/icon-1.png" /></p>
                    <p>客户端</p>
                </li>
                <li class="tow current">
                    <p><img src="../images/icon-2.png" /></p>
                    <p>触屏版</p>
                </li>
                <li class="three none-ml">
                    <p><img src="../images/icon-3.png" /></p>
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

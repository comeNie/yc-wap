<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
%>
<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/4
  Time: 上午10:58
  To change this template use File | Settings | File Templates.
--%>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>安全设置</title>
    <script type="text/javascript" src="<%=path%>/js/modular/jquery-1.11.1.min.js"></script>
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

    <nav class="wap-second-nav">
        <ul>
            <a href="javascript:"><i class="icon iconfont left">&#xe626;</i></a>
            <li>安全设置</li>
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
    
    <!--订单内容-->
    <section class="order-content ">
        <div class="setting-list">
            <ul>
                <a href="#" onclick="changepsd()">
                    <li>修改密码</li>
                    <li class="right"><i class="icon iconfont">&#xe62c;</i></li>
                </a>
            </ul>
            <ul>
                <a href="#">
                    <li>手机验证</li>
                    <li class="right">138****1234<i class="icon iconfont">&#xe62c;</i></li>
                </a>
            </ul>
            <ul class="none-border">
                <a href="#">
                    <li>邮箱验证</li>
                    <li class="right">您还没有通过邮箱验证，请验证<i class="icon iconfont">&#xe62c;</i></li>
                </a>
            </ul>
        </div>
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
<script>
    $(document).ready(function () {

    });
    function changepsd() {
        var tourl = "<%=path%>/safe/changepsd";
        window.location.href=tourl;
        <%--$.ajax({--%>
            <%--async : true,--%>
            <%--type : "POST",--%>
            <%--url : "<%=path%>/safe/changepsd",--%>
            <%--modal : true,--%>
            <%--timeout: 30000,--%>
            <%--data : {--%>

            <%--},--%>
            <%--success : function(data) {--%>
                <%----%>
            <%--},--%>
            <%--error : function(data){--%>
                <%--console.log("fail");--%>
                <%--console.log(data);--%>
            <%--}--%>
        <%--});--%>
    }
</script>

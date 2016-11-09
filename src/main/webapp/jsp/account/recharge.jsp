<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/9
  Time: 上午10:19
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
    <title>充值</title>
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
    <nav class="wap-second-nav">
        <ul>
            <a href="javascript:" onclick="retLeft()"><i class="icon iconfont left">&#xe626;</i></a>
            <li>充值</li>
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
    <section class="form-big">
        <div class="set-password">
            <div class="choice-list">
                <ul>
                    <li>
                        <p class="word">账户余额:</p>
                        <p>100元</p>
                    </li>
                    <li>
                        <p class="word">充值金额:</p>
                        <p><input id="price" type="text" class="input int-rech" placeholder="50"></p>
                        <p>元</p>

                    </li>
                    <label id="pricetip"></label>
                    <li>
                        <p class="word">充值方式:</p>
                        <p>
                            <input type="radio" class="radio" name="way" value="1" checked>
                            <img src="<%=path%>/ui/images/zhifb.png">
                        </p>
                        <p class="ml-a">
                            <input type="radio" class="radio" name="way" value="2">
                            <img src="<%=path%>/ui/images/unionpay.png">
                        </p>
                        <label id="inputid"></label>
                    </li>
                </ul>
            </div>
            <div class="wap-btn"><a href="#"  class="btn submit-btn btn-blue" onclick="confirm()">提交</a></div>
        </div>
    </section>

    <%--底部視圖--%>
    <jsp:include page="/jsp/common/bottom.jsp" flush="true"/>

</body>
</html>
<script>
    $(function() {

    });
    function retLeft(){
        window.history.go(-1);
    }
    function confirm() {
        var price = $("#price").val();
        if (price == null || price == "" || price == 0){
            $("#pricetip").html("请输入充值金额");
            $("#pricetip").css("display","block");
            return;
        }else {
            $("#pricetip").css("display","none");
        }
        if (!(/^([1-9]\d{0,9}|0)([.]?|(\.\d{1,2})?)$/.test(price))){
            $("#pricetip").html("请输入正确的充值金额");
            $("#pricetip").css("display","block");
            return;
        }else {
            $("#pricetip").css("display","none");
        }
        var a = $("input[name='way']:checked").val();
        if (a == null || a == "" || a == 0){
            $("#inputid").html("请选择支付方式");
            $("#inputid").css("display","block");
            return;
        }else {
            $("#inputid").css("display","none");
        }
        var tourl = "<%=path%>/account/rechargesuccess";
        window.location.href=tourl;
    }
</script>
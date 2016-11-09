<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/8
  Time: 下午4:32
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
    <title>找回密码</title>
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
            <a href="javascript:" onclick="leftRe()"><i class="icon iconfont left">&#xe626;</i></a>
            <li>找回密码</li>
        </ul>
    </nav>
    <section class="form-big">

        <div id="next1">
            <div class="set-password">
                <div class="set-int">
                    <ul>
                        <li>
                            <p><input id="nameid1" type="text" class="input input-large" placeholder="用户名/邮箱/手机号"></p>
                            <label id="nameLabel1"></label>
                        </li>
                        <li class="int-border">
                            <p><input id="codeid1" type="text" class="input input-yzm" placeholder="验证码"></p>

                            <p><div class="code" id="checkCode"></div></p>
                            <p><a href="javascript:void(0)" onclick="createCode()"><i class="icon-refresh" ></i></a></p>
                            <label id="codeLabel1"></label>
                        </li>
                        <li><a href="javascript:void(0)" id="next-btn1" class="submit-btn btn-blue">下一步</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="next2">
            <div class="set-password">
                <div class="set-phone">
                    <p>已验证手机</p>
                    <p class="word" id="phone2">138****1234</p>
                </div>
                <div class="set-int">
                    <ul>
                        <li>
                            <p><input id="codeid2" type="text" class="input input-small" placeholder="请输入动态码"></p>
                            <p class="yzm"><a id="getnumber" onclick="getnumberonclick()" href="#"  class="btn bnt-yzm">获取动态码</a></p>
                            <label id="codeLabel2"></label>
                        </li>
                        <li><a href="javascript:void(0)" id="next-btn2" class="submit-btn btn-blue">下一步</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="next3">
            <div class="set-password">
                <div class="set-int">
                    <ul>
                        <li>
                            <p><input id="psdid3" type="password" class="input input-large" placeholder="新密码"></p>
                            <label id="psdLabel3"></label>
                        </li>
                        <li>
                            <p><input id="confirmid3" type="password" class="input input-large" placeholder="确认密码"></p>
                            <label id="confirmLabel3"></label>
                        </li>
                        <li><a href="javascript:void(0)" id="next-btn3" class="submit-btn btn-blue">下一步</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="next4">
            <section class="tij-cg">
                <ul>
                    <li><i class="icon iconfont">&#xe612;</i></li>
                    <li class="word">密码设置成功</li>
                    <li><span id="spanTime">5s</span>内自动回到<a href="#" onclick="goLogin()">登录页面</a></li>
                </ul>
            </section>
        </div>

    </section>


    <%--底部視圖--%>
    <jsp:include page="/jsp/common/bottom.jsp" flush="true"/>

</body>
</html>
<script>
    //找回密码
    var index = 0;
    var getPhone;
    var getCode;
    $(function(){
        $("#next-btn1").click(function(){
            var phone = $("#nameid1").val();
            var code = $("#codeid1").val();
            if (phone == "" || phone == null) {
                $("#nameLabel1").html("请输入用户名/邮箱/手机号");
                $("#nameLabel1").css("display","block");
                return;
            }else {
                $("#nameLabel1").css("display","none");
            }
            if (code == "" || code == null) {
                $("#codeLabel1").html("请输入验证码");
                $("#codeLabel1").css("display","block");
                return;
            }else {
                $("#codeLabel1").css("display","none");
            }
//            if(!validateCode()){
//               return;
//            }
            jump1(phone);

        });
        $("#next-btn2").click(function(){
            var code = $("#codeid2").val();
            if (code == "" || code == null) {
                $("#codeLabel2").html("请输入动态码");
                $("#codeLabel2").css("display","block");
                return;
            }else {
                $("#codeLabel2").css("display","none");
            }
            jump2(code);

        });
        $("#next-btn3").click(function(){
            var psdid = $("#psdid3").val();
            var confimid = $("#confirmid3").val();
            if (psdid == "" || psdid == null){
                $("#psdLabel3").html("请输入密码");
                $("#psdLabel3").css("display","block");
                return;
            }else {
                $("#psdLabel3").css("display","none");
            }
            var t = /^[0-9a-zA-Z]{6,16}$/;
            if (!t.test(psdid)){
                $("#psdLabel3").html("<spring:message code="safe.changepsd.alert_newLength"/>");
                $("#psdLabel3").css("display","block");
                return;
            }else {
                $("#psdLabel3").css("display","none");
            }

            if (confimid == "" || confimid == null){
                $("#confirmLabel3").html("请输入密码");
                $("#confirmLabel3").css("display","block");
                return;
            }else {
                $("#confirmLabel3").css("display","none");
            }
//        判断新密码是否相同
            if (psdid != confimid) {
                $("#confirmLabel3").html("<spring:message code="safe.changepsd.tip_lable"/>");
                $("#confirmLabel3").css("display","block");
                return;
            }else {
                $("#confirmLabel3").css("display","none");
            }

            jump3(psdid);

        });
    });
    function leftRe() {

        if (index == 0){
            window.history.go(-1);
        }else if (index == 1){
            $("#next1").show();
            $("#next2").hide();
            index --;
        }else if (index == 2){

            $("#next2").show();
            $("#next3").hide();
            index --;
        }else if (index == 3){
            $("#next3").show();
            $("#next4").hide();
            index --;
        }

    }
    function jump1(phone){
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/userinfo",
            modal: true,
            timeout: 30000,
            data: {
                phone: phone,
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#nameLabel1").css("display","none");
                    var newphone = "15510179081";
                    getPhone = newphone;
                    $("#phone2").html(newphone);
                    var myphone=newphone.substr(3,4);
                    var lphone=newphone.replace(myphone,"****");
                    $("#phone2").html(lphone);
                    index ++;//index = 1
                    $("#next1").hide();
                    $("#next2").show();

                } else {
                    var tourl = "<%=path%>/login/findfail";
                    window.location.href=tourl;
                }
            },
            error: function () {
                $("#nameLabel1").html("网络请求超时，请稍候再试");
                $("#nameLabel1").css("display", "block");

//                var newphone = "15510179081";
//                getPhone = newphone;
//                $("#phone2").html(newphone);
//                var myphone=newphone.substr(3,4);
//                var lphone=newphone.replace(myphone,"****");
//                $("#phone2").html(lphone);
//                index ++;//index = 1
//                $("#next1").hide();
//                $("#next2").show();
            }
        });
    }
    function jump2(code) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/checkTestCode",
            modal: true,
            timeout: 30000,
            data: {
                type: 6,    //密码操作码
                code:code
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#codeLabel2").css("display", "none");
                    index ++;//index = 2
                    $("#next2").hide();
                    $("#next3").show();
                    getCode = code;
                } else {
                    $("#codeLabel2").html("短信验证码错误");
                    $("#codeLabel2").css("display", "block");
//                    index ++;//index = 2
//                    $("#next2").hide();
//                    $("#next3").show();
                }
            },
            error: function () {
                $("#codeLabel2").html("网络请求超时，请稍候再试");
                $("#codeLabel2").css("display", "block");
            }
        });
    }
    function jump3(psd){
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/editpssword",
            modal: true,
            timeout: 30000,
            data: {
                newpw: psd,
                code:getCode,
                mode:2  //密码操作吗
            },
            success: function (data) {
                if (data.status == 1) {
                    index ++;//index = 3
                    $("#next3").hide();
                    $("#next4").show();
                    countDownFive();
                } else {
                    $("#confirmLabel3").html("找回失败");
                    $("#confirmLabel3").css("display", "block");

                }
            },
            error: function () {
                $("#confirmLabel3").html("网络请求超时，请稍候再试");
                $("#confirmLabel3").css("display", "block");
            }
        });
    }
    function getnumberonclick(){
//        调用接口校验合法性

        getTestCode(getPhone);
    }
    //    发送验证码
    function getTestCode(phone) {

        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/sendTestCode",
            modal: true,
            timeout: 30000,
            data: {
                type: 6,
                info:phone
            },
            success: function (data) {
                if (data.status == 1) {
                    countDown(60);
                } else {
                    $("#codeLabel2").html("短信验证码错误");
                    $("#codeLabel2").css("display", "block");
                }
            },
            error: function () {
                $("#codeLabel2").html("网络请求超时，请稍候再试");
                $("#codeLabel2").css("display", "block");
            }
        });
    }
    //    倒计时
    var wait = 60;
    function countDown() {
        if (wait == 0) {
            $("#getnumber").removeAttr("disabled");
            $("#getnumber").attr("onclick", "getnumberonclick()");
            $("#getnumber").html("获取动态码");//改变按钮中value的值
//            $("#getnumber").attr("class","");
            //p.html("如果您在1分钟内没有收到验证码，请检查您填写的手机号码是否正确或重新发送");
            wait = 60;
        }else {
            var txtStr = '重新获取(' + wait + ')';
            $("#getnumber").html(txtStr);
//            $("#getnumber").attr("class","ash-cl");
            // 按钮里面的内容呈现倒计时状态
            $("#getnumber").attr("disabled", "block");
            $("#getnumber").attr("onclick", "javascript:void(0)");
            wait --;
            setTimeout(function(){countDown();},1000);
        }
    }

    function goLogin() {
        var tourl = "<%=path%>/login/login";
        window.location.href=tourl;
    }
    var fiveWait = 5;
    function countDownFive() {
        if (fiveWait == 0) {
            goLogin();
        }else {
            fiveWait --;
            $("#spanTime").html(fiveWait+"s");
            setTimeout(function(){countDownFive();},1000);
        }
    }

    //验证码代码
    var code;
    function createCode() {
        code = "";
        var codeLength = 6; //验证码的长度
        var checkCode = document.getElementById("checkCode");
        var codeChars = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
                'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
                'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'); //所有候选组成验证码的字符，当然也可以用中文的
        for (var i = 0; i < codeLength; i++)
        {
            var charNum = Math.floor(Math.random() * 52);
            code += codeChars[charNum];
        }
        if (checkCode)
        {
            checkCode.className = "code";
            checkCode.innerHTML = code;
        }
    }
    function validateCode()
    {
        var inputCode = document.getElementById("codeid1").value;
        if (inputCode.length <= 0)
        {
            $("#codeLabel1").html("请输入验证码");
            $("#codeLabel1").css("display","block");
            return false;
        }
        else if (inputCode.toUpperCase() != code.toUpperCase())
        {
            $("#codeLabel1").html("验证码错误");
            $("#codeLabel1").css("display","block");
            createCode();
            return false;
        }
        else
        {
            $("#codeLabel1").css("display","none");
            return true;
        }
    }
</script>
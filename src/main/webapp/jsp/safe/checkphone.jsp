<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/5
  Time: 下午12:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
    String jump = (String) request.getAttribute("jump");
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>验证</title>
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
    <div class="wrapper-big"><!--包含除底部外的所有层-->
        <nav class="wap-second-nav">
            <ul>
                <a href="javascript:void(0)"><i class="icon iconfont left" id="leftRe">&#xe626;</i></a>
                <li id="navtitle"><spring:message code="safe.checkphone.title"/></li>
            </ul>

        </nav>

        <!--订单内容-->
        <section class="index-wrapper ">
            <div class="set-password">
                <div class="set-phone">
                    <p id="ptitle"><spring:message code="safe.checkphone.psd_p"/></p>
                    <p class="word" id="phone"></p>
                </div>
                <div class="set-int">
                    <ul>
                        <li>
                            <p><input id="codeid" type="text" class="input input-small" placeholder="<spring:message code="safe.checkphone.small_input"/>"></p>
                            <p class="yzm"><input id="getnumber" onclick="getnumberonclick()" type="button" class="btn bnt-yzm" value="<spring:message code="safe.checkphone.yzm_input"/>"></p>
                            <label id="phonetips"></label>
                        </li>
                        <li><a class="btn submit-btn btn-blue" href="javascript:void(0)" onclick="confirmBtn()"><spring:message code="safe.checkphone.nextbtn"/></a></li>
                    </ul>
                </div>
            </div>
        </section>
    </div>

    <%--底部視圖--%>
    <jsp:include page="/jsp/common/bottom.jsp" flush="true"/>

</body>
</html>
<script>
    $(document).ready(function() {
        $("#leftRe").click(function() {
            window.history.go(-1);
        });
    });
    $(function() {
        var mobilePhone = "${phone}";
        var myphone=mobilePhone.substr(3,4);
        var hidePhone=mobilePhone.replace(myphone,"****");
        $("#phone").html(hidePhone)
        var s = "${jump}";
        if (s == "mail") {
            $("#ptitle").html("已验证邮箱");
            $("#navtitle").html("验证邮箱");
        }
    })
    function confirmBtn() {
//        校验验证码为空
        var code = $("#codeid").val();
        if (code == "" || code == null){
            $("#phonetips").html("请输入验证码");
            $("#phonetips").css("display","block");
            return;
        }else {
            $("#phonetips").css("display","none");
        }
//        校验验证码
        checkCode(code);

    }
    function checkCode(code){
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/checkTestCode",
            modal: true,
            timeout: 30000,
            data: {
                type: 2,    //密码操作码
                code:code,
                uid:${UID},
            },
            success: function (data) {
//                if (data.status == 1) {
                    $("#phonetips").css("display", "none");

                    //跳转
                    var s = "${jump}";
                    if (s=="psd"){
                        var tourl = "<%=path%>/safe/installpsd";
                        window.location.href=tourl;
                    }else if(s == "mail") {
                        var tourl = "<%=path%>/safe/changemail?mailTitle=<spring:message code="safe.checkphone.change_jump"/>";
                        window.location.href=tourl;
                    }else if(s == "phone") {
                        var tourl = "<%=path%>/safe/changephone?phoneTitle=<spring:message code="safe.checkphone.change_jump"/>";
                        window.location.href=tourl;
                    }
//                } else {
                    $("#phonetips").html(data.msg);
                    $("#phonetips").css("display", "block");
//                }
            },
            error: function () {
                $("#phonetips").html(data.msg);
                $("#phonetips").css("display", "block");
            }
        });
    }
    function getnumberonclick(){

        var s = "${jump}";
        var type;
        if (s == "mail") {
            type = 5;
        }else {
            type = 2
        }
        getTestCode(type);
    }
    function getTestCode(type) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/sendTestCode",
            modal: true,
            timeout: 30000,
            data: {
                type: type,
                info:"${phone}"
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#phonetips").css("display", "none");
                    countDown(60);
                } else {
                    $("#phonetips").html(data.msg);
                    $("#phonetips").css("display", "block");
                }
            },
            error: function () {
                $("#phonetips").html(data.msg);
                $("#phonetips").css("display", "block");
            }
        });
    }
    var wait = 60;
    function countDown() {
        if (wait == 0) {
            $("#getnumber").removeAttr("disabled");
            $("#getnumber").attr("onclick", "getnumberonclick()");
            $("#getnumber").val("<spring:message code="safe.checkphone.yzm_input"/>");//改变按钮中value的值
            //p.html("如果您在1分钟内没有收到验证码，请检查您填写的手机号码是否正确或重新发送");
            wait = 60;
        }else {
            var txtStr = '重新获取(' + wait + ')';
            $("#getnumber").val(txtStr);
            // 按钮里面的内容呈现倒计时状态
            $("#getnumber").attr("disabled", "block");
            $("#getnumber").attr("onclick", "javascript:void(0)");
            wait --;
            setTimeout(function(){countDown();},1000);
        }
    }
</script>
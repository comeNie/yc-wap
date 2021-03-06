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
    response.setHeader("Pragma","No-cache");  //HTTP 1.1
    response.setHeader("Cache-Control","private, no-cache, no-store, max-age=0, proxy-revalidate, s-maxage=0");//HTTP 1.0
    response.setDateHeader("Expires",-1); //防止被proxy
    response.setHeader("Vary","*");
%>
<%response.setHeader("cache-control","public"); %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%--<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />--%>
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <title><spring:message code="safe.checkphone.title"/></title>
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
    <%@ include file="../common/timezone.jsp" %>
</head>
<body onunload="">
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
                    <p id="ptitle"><spring:message code="safe.checkphone.hadcheckPhone"/></p>
                    <p class="word" id="phone"></p>
                </div>
                <div class="set-int">
                    <ul>
                        <li>
                            <p><input id="codeid" type="text" class="input input-small" placeholder="<spring:message code="safe.checkphone.small_input"/>" autocomplete="off"></p>
                            <p class="yzm"><a id="getnumber" onclick="getnumberonclick()"class="btn bnt-yzm"><spring:message code="safe.checkphone.yzm_input"/></a></p>
                            <label id="phonetips"></label>
                        </li>
                        <li class="small-h"><a class="btn submit-btn btn-blue" href="javascript:void(0)" onclick="confirmBtn()"><spring:message code="safe.checkphone.nextbtn"/></a></li>
                        <li class="tis blue" id="tipCheck" onclick="changeCheckType()"></li>
                    </ul>
                </div>
            </div>
        </section>
    </div>


    <%--底部視圖--%>
    <jsp:include page="/jsp/common/bottom.jsp" flush="true"/>
    <%--loading--%>
    <jsp:include page="/jsp/common/loading.jsp" flush="true"/>
</body>
</html>
<script>
    var value;  //本页验证的值,手机号或邮箱
    $(document).ready(function() {

        $("#leftRe").click(function() {
            window.history.go(-1);
        });
        Loading.HideLoading();
    });
    $(function() {
        $("#codeid").val("");
        var mobilePhone = "${phone}";
        var mail = "${mail}";
        $("#getnumber").removeAttr("disabled");
        $("#getnumber").attr("class","btn bnt-yzm");
        $("#getnumber").attr("onclick", "getnumberonclick()");
        $("#getnumber").html("<spring:message code="safe.checkphone.yzm_input"/>");//改变按钮中value的值
        if(mobilePhone == ""){
            chgMail(mail);

        }else if (mail == ""){
            chgPhone(mobilePhone);

        }else {
            if ("${jump}" == "mail") {
                chgMail(mail);
            }else {
                chgPhone(mobilePhone);
            }
        }

    })
    //切换验证方式
    function changeCheckType(){

        var mobilePhone = "${phone}";
        var mail = "${mail}";
        if(mobilePhone == ""){
            $("#tipCheck").attr("class","tis red");
            $("#tipCheck").html("<spring:message code="safe.checkphone.notCheckPhone"/>");

        }else if (mail == ""){
            $("#tipCheck").html("<spring:message code="safe.checkphone.notCheckMail"/>");
            $("#tipCheck").attr("class","tis red");
        }else {
            $("#tipCheck").attr("class","tis blue");
            wait = 0;
            if (value == "${phone}"){
                chgMail(mail);
            }else {
                chgPhone(mobilePhone)
            }
        }


    }
    //手机号验证界面
    function chgPhone(mobilePhone){
        value = mobilePhone;
        $("#ptitle").html("<spring:message code="safe.checkphone.hadcheckPhone"/>");
        $("#navtitle").html("<spring:message code="safe.checkphone.title"/>");
        $("#tipCheck").html("<spring:message code="safe.checkphone.userMailCheck"/>");
        var myphone1=mobilePhone.substr(0,3);
        var myphone2=mobilePhone.substr(7,4);
        var hidePhone=myphone1+"****"+myphone2;
        $("#phone").html(hidePhone);
    }
    //邮箱验证界面
    function chgMail(mail){
        value = mail;
        $("#ptitle").html("<spring:message code="safe.checkphone.hadcheckMail"/>");
        $("#navtitle").html("<spring:message code="safe.checkphone.checkMail"/>");
        $("#tipCheck").html("<spring:message code="safe.checkphone.userPhoneCheck"/>");
        var index = mail.indexOf("@");
        var email1 = mail.slice(0,index-1);
        var email2 = mail.slice(index+2,mail.length);
        var hideMail = email1+"***"+email2;
        $("#phone").html(hideMail);
    }
    function confirmBtn() {
//        校验验证码为空
        var code = $("#codeid").val();
        if (code == "" || code == null){
            $("#phonetips").html("<spring:message code="safe.checkphone.small_input"/>");
            $("#phonetips").css("display","block");
            return;
        }else {
            $("#phonetips").css("display","none");
        }
//        校验验证码
        var type;
        if (value == "${phone}"){
            type = 2;
        }else {
            type = 5
        }
        Loading.ShowLoading();
        checkCode(code,type,value);

    }
    function checkCode(code,type,userinfo){
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/checkTestCode",
            modal: true,
            timeout: 30000,
            data: {
                type: type,    //密码操作码
                code:code,
                uid:${UID},
                userinfo:userinfo
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#phonetips").css("display", "none");
                    //跳转
                    var s = "${jump}";
                    if (s=="psd"){
                        var tourl = "<%=path%>/safe/installpsd?jump=psd&code="+code;
                        window.location.href=tourl;
                    }else if(s == "mail") {
                        var tourl = "<%=path%>/safe/changemail?mailTitle=<spring:message code="safe.checkphone.change_jump"/>";
                        window.location.href=tourl;
                    }else if(s == "phone") {
                        var tourl = "<%=path%>/safe/changephone?phoneTitle=<spring:message code="safe.checkphone.change_jump"/>";
                        window.location.href=tourl;
                    }else if (s == "pay") {
                        var tourl = "<%=path%>/safe/installpsd?jump=pay&code="+code;
                        window.location.href=tourl;
                    }
                    Loading.HideLoading();
                } else {
                    $("#phonetips").html(data.msg);
                    $("#phonetips").css("display", "block");
                    Loading.HideLoading();
                }
            },
            error: function () {
                $("#phonetips").html("<spring:message code="safe.safesuccess.failNet"/>");
                $("#phonetips").css("display", "block");
                Loading.HideLoading();
            }
        });
    }
    function getnumberonclick(){
        var type;
        if (value == "${phone}"){
            type = 2;
        }else {
            type = 5
        }
        Loading.ShowLoading();
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
                info:value,
                uid:${UID},
                domain:"${domainname}"
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#phonetips").css("display", "none");
                    wait = 120;
                    countDown();
                    Loading.HideLoading();
                } else {
                    $("#phonetips").html(data.msg);
                    $("#phonetips").css("display", "block");
                    Loading.HideLoading();
                }
            },
            error: function () {
                $("#phonetips").html("<spring:message code="safe.safesuccess.failNet"/>");
                $("#phonetips").css("display", "block");
                Loading.HideLoading();
            }
        });
    }
    var wait = 120;
    function countDown() {
        if (wait == 0) {
            $("#getnumber").removeAttr("disabled");
            $("#getnumber").attr("onclick", "getnumberonclick()");
            $("#getnumber").html("<spring:message code="safe.checkphone.yzm_input"/>");//改变按钮中value的值
            $("#getnumber").attr("class","btn bnt-yzm");
            //p.html("如果您在1分钟内没有收到验证码，请检查您填写的手机号码是否正确或重新发送");
            wait = 120;
        }else {
            <%--var txtStr = '<spring:message code="safe.changemail.chongxinhuoqu"/>(' + wait + ')';--%>
            var txtStr = wait+ '<spring:message code="safe.checkphone.chongxinhuoqu"/>';
            $("#getnumber").html(txtStr);
            $("#getnumber").attr("class","btn bnt-yzm-gray");
            // 按钮里面的内容呈现倒计时状态
            $("#getnumber").attr("disabled", "block");
            $("#getnumber").attr("onclick", "javascript:void(0)");
            wait --;
            setTimeout(function(){countDown();},1000);
        }
    }
</script>
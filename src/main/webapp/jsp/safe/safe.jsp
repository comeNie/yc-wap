<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/4
  Time: 上午10:58
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
    <title><spring:message code="safe.safe.title"/></title>
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

    <%--头部--%>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="安全设置"/>
        <jsp:param name="BackTo" value="javascript:retLeft()"/>
    </jsp:include>

    <!--订单内容-->
    <section class="order-content ">
        <div class="setting-list">
            <ul>
                <a href="javascript:void(0)" onclick="changepsd()">
                    <li id="passwordLeft">修改密码</li>
                    <li class="right"><i class="icon iconfont">&#xe62c;</i></li>
                </a>
            </ul>
            <ul>
                <a href="javascript:void(0)" onclick="changePhone()">
                    <li>手机验证</li>
                    <li class="right" id="phoneRight"><i class="icon iconfont">&#xe62c;</i></li>
                </a>
            </ul>
            <ul class="none-border" onclick="changeMail()">
                <a href="javascript:void(0)">
                    <li>邮箱验证</li>
                    <li class="right" id="emalRight"><i class="icon iconfont">&#xe62c;</i></li>
                </a>
            </ul>
        </div>
    </section>


</body>
</html>
<script>
    var isEmail;
    var isPhone;
    var isPassword;
    $(function() {
        var email = "${email}";
        var password = "${password}";
        var mobilePhone = "${mobilePhone}";
        if(email == "" || email == null){
            $("#emalRight").html("您还没有通过邮箱验证，请验证");
            isEmail = 0;
        }else {
            var index = email.indexOf("@");
            var email1 = email.slice(0,index-1);
            var email2 = email.slice(index+2,email.length);
            var hideMail = email1+"***"+email2;
            $("#emalRight").html(hideMail);
            isEmail = 1;
        }
        if(password != "true"){
            $("#passwordLeft").html("设置密码");
            isPassword = 0;
        }else {
            $("#passwordLeft").html("修改密码");
            isPassword = 1;
        }
        if(mobilePhone == "" || mobilePhone == null){
            $("#phoneRight").html("您还没有通过手机验证，请验证");
            isPhone = 0;
        }else {
            var myphone1=mobilePhone.substr(0,3);
            var myphone2=mobilePhone.substr(7,4);
            var hidePhone=myphone1+"****"+myphone2;
            $("#phoneRight").html(hidePhone);
            isPhone = 1;
        }
    })
    function retLeft(){
        var tourl = "<%=path%>/center/center";
        window.location.href=tourl;
    }
    function changepsd() {
//        var c = confirm("是否有密码");
        var uid = "${UID}"
        if (isPassword == true) {
            var tourl = "<%=path%>/safe/changepsd?uid="+uid;
            window.location.href=tourl;
        }else {
            var tourl = "<%=path%>/safe/checkphone?jump=psd&phone="+"${mobilePhone}";
            window.location.href=tourl;
        }
    }
    function changeMail() {
//        var c = confirm("是否已验证邮箱");

        if (isEmail == true) {
            var tourl = "<%=path%>/safe/checkphone?jump=mail&phone="+"${email}";
            window.location.href = tourl;
        } else {
            var tourl = "<%=path%>/safe/changemail?mailTitle=绑定";
            window.location.href = tourl;
        }
    }
    function changePhone() {
//        var c = confirm("是否已验证手机号");
        if (isPhone == true) {
            var tourl = "<%=path%>/safe/checkphone?jump=phone&phone="+"${mobilePhone}";
            window.location.href = tourl;
        } else {
            var tourl = "<%=path%>/safe/changephone?phoneTitle=绑定";
            window.location.href = tourl;
        }
    }
</script>

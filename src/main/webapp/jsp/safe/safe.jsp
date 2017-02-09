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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
    <%@ include file="../common/timezone.jsp" %>
</head>
<body>

    <%--头部--%>
    <spring:message code="safe.safe.title" var="title"/>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="${title}"/>
        <jsp:param name="BackTo" value="javascript:retLeft()"/>
    </jsp:include>

    <!--订单内容-->
    <section class="order-content ">
        <div class="setting-list">
            <ul>
                <a href="javascript:void(0)" onclick="changepsd()">
                    <li id="passwordLeft"></li>
                    <li class="right"><i class="icon iconfont">&#xe62c;</i></li>
                </a>
            </ul>
            <ul>
                <a href="javascript:void(0)" onclick="changePhone()">
                    <li id="phone"><spring:message code="safe.safe.bangdingphone"/></li>
                    <li class="right" id="phoneRight"><i class="icon iconfont">&#xe62c;</i></li>
                </a>
            </ul>
            <ul >
                <a href="javascript:void(0)" onclick="changeMail()">
                    <li id="mail"><spring:message code="safe.safe.bangdingmail"/></li>
                    <li class="right" id="emalRight"><i class="icon iconfont">&#xe62c;</i></li>
                </a>
            </ul>
            <ul class="none-border" >
                <a href="javascript:void(0)" onclick="changePay()">
                    <li id="pay"><spring:message code="safe.safe.bangdingpay"/></li>
                    <li class="right" id="payRight"><i class="icon iconfont">&#xe62c;</i></li>
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
    var isPay;
    $(function() {
        if(${isLogin=="1"}){
            var email = "${email}";
            var password = "${password}";
            var mobilePhone = "${mobilePhone}";
            var paypsd = "${payPsd}";
            if(email == "" || email == null){
                $("#emalRight").html("<spring:message code="safe.safe.mailTip"/>"+"<i class='icon iconfont'>&#xe62c;</i>");
                $("#mail").html("<spring:message code="safe.safe.bangdingmail"/>");
                isEmail = 0;
            }else {
                var index = email.indexOf("@");
                var email1 = email.slice(0,index-1);
                var email2 = email.slice(index+2,email.length);
                var hideMail = email1+"***"+email2;
                $("#emalRight").html(hideMail+"<i class='icon iconfont'>&#xe62c;</i>");
                $("#mail").html("<spring:message code="safe.safe.xiugaimail"/>");
                isEmail = 1;
            }
            if(password != "true"){
                $("#passwordLeft").html("<spring:message code="safe.safe.shezhemima"/>");
                isPassword = 0;
            }else {
                $("#passwordLeft").html("<spring:message code="safe.safe.xiugaimima"/>");
                isPassword = 1;
            }
            if(mobilePhone == "" || mobilePhone == null){
                $("#phoneRight").html("<spring:message code="safe.safe.phoneTip"/>"+"<i class='icon iconfont'>&#xe62c;</i>");
                $("#phone").html("<spring:message code="safe.safe.bangdingphone"/>");
                isPhone = 0;
            }else {
                var myphone1=mobilePhone.substr(0,3);
                var myphone2=mobilePhone.substr(7,4);
                var hidePhone=myphone1+"****"+myphone2;
                $("#phoneRight").html(hidePhone+"<i class='icon iconfont'>&#xe62c;</i>");
                $("#phone").html("<spring:message code="safe.safe.xiugaiphone"/>");
                isPhone = 1;
            }
            if(paypsd == "0"){
                $("#pay").html("<spring:message code="safe.safe.bangdingpay"/>");
                isPay = 0;
            }else {
                $("#pay").html("<spring:message code="safe.safe.xiugaipay"/>");
                isPay = 1;
            }
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
            var tourl = "<%=path%>/safe/changepsd?jump=psd";
            window.location.href=tourl;
        }else {
            var tourl = "<%=path%>/safe/checkphone?jump=psd";
            window.location.href=tourl;
        }
    }
    function changeMail() {
//        var c = confirm("是否已验证邮箱");

        if (isEmail == true) {
            var tourl = "<%=path%>/safe/checkphone?jump=mail";
            window.location.href = tourl;
        } else {
            var tourl = "<%=path%>/safe/changemail?mailTitle=<spring:message code="safe.safe.bangding"/>";
            window.location.href = tourl;
        }
    }
    function changePhone() {
//        var c = confirm("是否已验证手机号");
        if (isPhone == true) {
            var tourl = "<%=path%>/safe/checkphone?jump=phone";
            window.location.href = tourl;
        } else {
            var tourl = "<%=path%>/safe/changephone?phoneTitle=<spring:message code="safe.safe.bangding"/>";
            window.location.href = tourl;
        }
    }
    function changePay() {
        if (isPay == true) {
            var tourl = "<%=path%>/safe/changepsd?jump=pay";
            window.location.href = tourl;
        } else {
            var tourl = "<%=path%>/safe/checkphone?jump=pay";
            window.location.href = tourl;
        }
    }
</script>

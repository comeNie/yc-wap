<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/5
  Time: 下午12:04
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
    <title><spring:message code="safe.installpsd.title"/></title>
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
    <div class="wrapper-big"><!--包含除底部外的所有层-->
        <nav class="wap-second-nav">
            <ul>
                <a href="javascript:"><i class="icon iconfont left" id="leftRe">&#xe626;</i></a>
                <li id="naviLi"><spring:message code="safe.installpsd.navi_li"/></li>
            </ul>

        </nav>

        <!--订单内容-->
        <section class="index-wrapper ">
            <div class="set-password">
                <div class="set-int">
                    <ul>
                        <li>
                            <p><input id="newPsdID" type="password" class="input input-large" placeholder="<spring:message code="safe.installpsd.large_input1"/>" autocomplete="off"></p>
                            <label id="newLable"></label>
                        </li>
                        <li>
                            <p><input id="confirmPsdID" type="password" class="input input-large" placeholder="<spring:message code="safe.installpsd.large_input2"/>" autocomplete="off"></p>
                            <label id="confirmLable"></label>
                        </li>
                        <li><a class="btn submit-btn btn-blue" href="javascript:void(0)" onclick="confirmBtn()"><spring:message code="safe.installpsd.nextbtn"/></a></li>
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
    $(document).ready(function() {
        $("#leftRe").click(function() {
            window.history.go(-1);
        });
        Loading.HideLoading();
    });
    $(function () {
        var s = "${jump}";
        if (s == "psd"){
            $("#naviLi").html("<spring:message code="safe.installpsd.navi_li"/>")
        }else {
            $("#naviLi").html("<spring:message code="safe.installpsd.navi_liPay"/>")

        }
    })
    function confirmBtn() {
        var newpsd = $("#newPsdID").val();
        var confirmpsd = $("#confirmPsdID").val();
//        新密码
        if(newpsd == null || newpsd == "") {
            $("#newLable").html("<spring:message code="safe.changepsd.alert_newPsd"/>");
            $("#newLable").css("display","block");
            return;
        }else {
            $("#newLable").css("display","none");
        }
        <%--var t = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/--%>
        <%--if (!t.test(newpsd)){--%>
            <%--$("#newLable").html("<spring:message code="safe.changepsd.alert_newLength"/>");--%>
            <%--$("#newLable").css("display","block");--%>
            <%--return;--%>
        <%--}else {--%>
            <%--$("#newLable").css("display","none");--%>
        <%--}--%>
//        确认密码
        if(confirmpsd == null || confirmpsd == "") {
            $("#confirmLable").html("<spring:message code="safe.changepsd.alert_newPsd"/>");
            $("#confirmLable").css("display","block");
            return;
        }else {
            $("#confirmLable").css("display","none");
        }
//        判断新密码是否相同
        if (newpsd != confirmpsd) {
            $("#confirmLable").html("<spring:message code="safe.changepsd.tip_lable"/>");
            $("#confirmLable").css("display","block");
            return;
        }else {
            $("#confirmLable").css("display","none");
        }
        if ("${jump}" == "psd"){
            editPsd(newpsd);
        }else {
            setPayPsd(newpsd);
        }
    }
    function editPsd(newpsd){
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/editpssword",
            modal: true,
            timeout: 30000,
            data: {
                uid:${uid},
                newpw: newpsd,
                code:${code},
                mode:2,
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#confirmLable").css("display", "none");
            //        跳转
                    var tourl = "<%=path%>/safe/safesuccess?name=<spring:message code="safe.safe.shezhemima"/>";
                    window.location.href=tourl;
                } else {
                    $("#confirmLable").html(data.msg);
                    $("#confirmLable").css("display", "block");
                }
            },
            error: function () {
                $("#confirmLable").html("<spring:message code="safe.safesuccess.failNet"/>");
                $("#confirmLable").css("display", "block");
            },
            beforeSend: function () {
                Loading.ShowLoading();
            },
            complete: function () {
                Loading.HideLoading();
            }
        });
    }
    function setPayPsd(newpsd){
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/sendpaypsd",
            modal: true,
            timeout: 30000,
            data: {
                paypsd: newpsd,

            },
            success: function (data) {
                if (data.status == 1) {
                    $("#confirmLable").css("display", "none");
            //        跳转
                    var tourl = "<%=path%>/safe/safesuccess?name=<spring:message code="safe.safe.shezhepay"/>";
                    window.location.href=tourl;
                } else {
                    $("#confirmLable").html(data.msg);
                    $("#confirmLable").css("display", "block");
                }
            },
            error: function () {
                $("#confirmLable").html("<spring:message code="safe.safesuccess.failNet"/>");
                $("#confirmLable").css("display", "block");
            },
            beforeSend: function () {
                Loading.ShowLoading();
            },
            complete: function () {
                Loading.HideLoading();
            }
        });
    }
</script>
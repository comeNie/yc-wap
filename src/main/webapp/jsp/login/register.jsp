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
    <title><spring:message code="login.login.zhuce"/></title>
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
    <div class="wrapper-big" ><!--包含除底部外的所有层-->
        <!--注册-->
        <nav class="wap-second-nav" >
            <ul>
                <a href="javascript:" onclick="leftRe()"><i class="icon iconfont left">&#xe626;</i></a>
                <li><spring:message code="login.login.zhuce"/></li>
                <a href="javascript:void(0)" class="btn login-btn right1" onclick="jumpLogin()"><spring:message code="login.login.title"/></a>
            </ul>
        </nav>

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
                            <label id="selectLabel"></label>
                        </li>
                        <li>
                            <p><input id="phone" type="text" class="input input-large" placeholder="<spring:message code="login.register.enterphone"/>"></p>
                            <label id="phoneLabel1"></label>
                        </li>
                        <li>
                            <p><input id="codeid" type="text" class="input input-small" placeholder="<spring:message code="login.register.entercode"/>"></p>
                            <p class="yzm"><a id="getnumber" href="javascript:void(0)" class="btn bnt-yzm" onclick="getnumberonclick()"><spring:message code="login.register.getcode"/></a></p>
                            <label id="codeLabel1"></label>
                        </li>
                        <li>
                            <p><input id="psdids" type="password" class="input input-large" placeholder="<spring:message code="login.login.enterpsd"/>"></p>
                            <label id="psdLabel1"></label>
                        </li>
                        <li>
                            <p><input id="confimid" type="password" class="input input-large" placeholder="<spring:message code="login.register.enterpsdagain"/>"></p>
                            <label id="confimPsd"></label>
                        </li>
                        <li><a href="javascript:void(0)" class="submit-btn btn-blue" onclick="confirmAction()"><spring:message code="login.register.lijizhuce"/></a></li>
                        <li class="left">
                            <p><input id="checkid" type="checkbox" class="checkbox" checked></p><spring:message code="login.register.agree"/><a href="javascript:void(0)" onclick="look()"><spring:message code="login.register.look"/></a>
                            <label id="agreeLabel"></label>
                        </li>

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
    var personUid;
    function leftRe() {
        window.history.go(-1);

    }
    $(function() {
        var phone = $("#phone").val();
        var codeid = $("#codeid").val();
        var psdid = $("#psdids").val();
        var confimid = $("#confimid").val();
        //加载国家的数据
        loadCountry();
    });
    //加载国家的数据
    function loadCountry() {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/countryid",
            modal: true,
            showBusi: false,
            timeout: 30000,
            data: {
            },
            success: function (data) {
                if (data.status == 1) {
                    var list = data.list;
                    $.each(list,function(index ,value){
                        $('#selectid').append("<option>" + value.countryNameCn+"+"+value.countryCode + "</option>");
                    })
                    Loading.HideLoading();
                } else {
                    Loading.HideLoading();
                }
            },
            error: function () {
                var tourl ="<%=path%>/jsp/common/404.jsp";
                window.location.href=tourl;
                Loading.HideLoading();
            }
        });
    }
    function jumpLogin() {
        var tourl = "<%=path%>/login/login?to=login";
        window.location.href=tourl;
    }
    function confirmAction() {
        var phone = $("#phone").val();
        var codeid = $("#codeid").val();
        var psdid = $("#psdids").val();
        var confimid = $("#confimid").val();
        if (phone == "" || phone == null){
            $("#phoneLabel1").html("<spring:message code="login.register.enterphone"/>");
            $("#phoneLabel1").css("display","block");
            return;
        }else {
            $("#phoneLabel1").css("display","none");
        }

        var t = /^1\d{10}$/;
        if(!t.test(phone)){
            $("#phoneLabel1").html("<spring:message code="login.register.enterRightphone"/>");
            $("#phoneLabel1").css("display","block");
            return;
        }else {
            $("#phoneLabel1").css("display","none");
        }

        if (codeid == "" || codeid == null){
            $("#codeLabel1").html("<spring:message code="login.login.entercode"/>");
            $("#codeLabel1").css("display","block");
            return;
        }else {
            $("#codeLabel1").css("display","none");
        }

        if (psdid == "" || psdid == null){
            $("#psdLabel1").html("<spring:message code="login.login.enterpsd"/>");
            $("#psdLabel1").css("display","block");
            return;
        }else {
            $("#psdLabel1").css("display","none");
        }
//        var t = /^[0-9a-zA-Z]{6,16}$/;
        var t = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/
        if (!t.test(psdid)){
            $("#psdLabel1").html("<spring:message code="safe.changepsd.alert_newLength"/>");
            $("#psdLabel1").css("display","block");
            return;
        }else {
            $("#psdLabel1").css("display","none");
        }

        if (confimid == "" || confimid == null){
            $("#confimPsd").html("<spring:message code="login.login.enterpsd"/>");
            $("#confimPsd").css("display","block");
            return;
        }else {
            $("#confimPsd").css("display","none");
        }
//        判断新密码是否相同
        if (psdid != confimid) {
            $("#confimPsd").html("<spring:message code="safe.changepsd.tip_lable"/>");
            $("#confimPsd").css("display","block");
            return;
        }else {
            $("#confimPsd").css("display","none");
        }


        if (!$("#checkid").prop("checked")){
            $("#agreeLabel").html("<spring:message code="login.register.lookTip"/>");
            $("#agreeLabel").css("display","block");
            return;
        }else {
            $("#agreeLabel").css("display", "none");
        }

        Loading.ShowLoading();
//        登录验证
        checkPhoneWithJump(phone,codeid,psdid);

    }
    function checkPhoneWithJump(phone,codeid,psdid) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/login/checkregister",
            modal: true,
            timeout: 30000,
            data: {
                uid:personUid,
                phone:phone,
                newpw: psdid,
                code:codeid,
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#confimPsd").css("display", "none");
                    var tourl = "<%=path%>/login/registersuccess";
                    window.location.href=tourl;
                    Loading.HideLoading();
                } else {
                    $("#confimPsd").html(data.msg);
                    $("#confimPsd").css("display", "block");
                    $("#phone").attr("disabled",false);
                    Loading.HideLoading();
                }
            },
            error: function () {
                $("#confimPsd").html(data.msg);
                $("#confimPsd").css("display", "block");
                $("#phone").attr("disabled",false);
                Loading.HideLoading();
            }
        });

    }


    function getnumberonclick(){
        var phone = $("#phone").val();
        if (phone == "" || phone == null){
            $("#phoneLabel1").html("<spring:message code="login.register.enterphone"/>");
            $("#phoneLabel1").css("display","block");
            return;
        }else {
            $("#phoneLabel1").css("display","none");
        }
        var t = /^1\d{10}$/;
        if(!t.test(phone)){
            $("#phoneLabel1").html("<spring:message code="login.register.enterRightphone"/>");
            $("#phoneLabel1").css("display","block");
            return;
        }else {
            $("#phoneLabel1").css("display","none");
        }
        Loading.ShowLoading();
        getTestCode(phone);
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
                type: 1,
                info:phone,
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#phoneLabel1").css("display", "none");
                    $("#phone").attr("disabled","true");
                    personUid = data.uid;
                    countDown(60);
                    Loading.HideLoading();
                } else {
                    $("#phoneLabel1").html(data.msg);
                    $("#phoneLabel1").css("display", "block");
                    Loading.HideLoading();
                }
            },
            error: function () {
                $("#phoneLabel1").html(data.msg);
//                $("#phone").removeAttrs("disabled");
                $("#phoneLabel1").css("display", "block");
                Loading.HideLoading();
            }
        });
    }
    //    倒计时
    var wait = 60;
    function countDown() {
        if (wait == 0) {
            $("#getnumber").removeAttr("disabled");
            $("#getnumber").attr("onclick", "getnumberonclick()");
            $("#getnumber").html("<spring:message code="safe.checkphone.yzm_input"/>");//改变按钮中value的值
//            $("#getnumber").attr("class","");
            //p.html("如果您在1分钟内没有收到验证码，请检查您填写的手机号码是否正确或重新发送");
            wait = 60;
        }else {
            var txtStr = '<spring:message code="safe.changemail.chongxinhuoqu"/>(' + wait + ')';
            $("#getnumber").html(txtStr);
//            $("#getnumber").attr("class","ash-cl");
            // 按钮里面的内容呈现倒计时状态
            $("#getnumber").attr("disabled", "block");
            $("#getnumber").attr("onclick", "javascript:void(0)");
            wait --;
            setTimeout(function(){countDown();},1000);
        }
    }
    function look() {
        var href = "<%=path%>/common/agreement";
        window.location.href = href;
    }

</script>
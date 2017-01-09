<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/4
  Time: 下午3:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
    String phoneTitle = (String) request.getAttribute("phoneTitle");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title><spring:message code="safe.changephone.title"/></title>
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
                <li>${phoneTitle}<spring:message code="safe.changephone.navli"/></li>
            </ul>

        </nav>

        <!--订单内容-->
        <section class="index-wrapper ">
            <div class="set-password">
                <div class="set-int">
                    <ul>
                        <li>
                            <p>
                                <select class="select testing-select-big" id="selectid">
                                </select>
                                <span>|</span>
                            </p>
                        </li>
                        <li>
                            <p><input id="phone" type="text" class="input input-large" placeholder="<spring:message code="safe.changephone.phone"/>"></p>
                            <label id="phoneLabel"></label>
                        </li>
                        <li>
                            <p><input type="text" id="codeid" class="input input-small" placeholder="<spring:message code="safe.changephone.small_input"/>" autocomplete="off"></p>
                            <p class="yzm"><a id="getnumber" onclick="javascript:getnumberonclick()" class="btn bnt-yzm"><spring:message code="safe.changephone.bntyzm_input"/></a></p>
                            <label id="phonetips"></label>
                        </li>
                        <li><a class="btn submit-btn btn-blue" href="javascript:void(0)" onclick="confirmBtn()"><spring:message code="safe.changephone.nextbtn"/></a></li>
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
    });
    $(function() {

        $("#codeid").val("");
        $("#getnumber").removeAttr("disabled");
        $("#getnumber").attr("class","btn bnt-yzm");
        $("#getnumber").attr("onclick", "getnumberonclick()");
        $("#getnumber").html("<spring:message code="safe.checkphone.yzm_input"/>");//改变按钮中value的值
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
                        if ("${pageContext.response.locale}".toUpperCase() == "ZH_CN"){
                            $('#selectid').append("<option value='"+value.countryValue+"'>" + value.countryNameCn+" +"+value.countryCode + "</option>");
                        }else {
                            $('#selectid').append("<option value='"+value.countryValue+"'>" + value.countryNameEn+" +"+value.countryCode + "</option>");
                        }
                        localStorage.setItem(value.countryValue,value.regularExpression);
                        localStorage.setItem(value.countryValue+"1",value.countryCode);
                    })
                    Loading.HideLoading();
                } else {
                    Loading.HideLoading();
                }
            },
            error: function () {
                Loading.HideLoading();
            }
        });
    }
    function confirmBtn() {
        var phone = $("#phone").val();
        if (phone == "" || phone == null){
            $("#phoneLabel").html("<spring:message code="safe.changephone.enterPhone"/>");
            $("#phoneLabel").css("display","block");
            return;
        }else {
            $("#phoneLabel").css("display","none");
        }
        var selectValue = $('#selectid').val();
        var reg = localStorage.getItem(selectValue);
        var code1 = localStorage.getItem(selectValue+"1");
        var t = new RegExp(reg);
        if(!t.test(code1+phone)){
            $("#phoneLabel").html("<spring:message code="safe.changephone.enterRightPhone"/>");
            $("#phoneLabel").css("display","block");
            return;
        }else {
            $("#phoneLabel").css("display","none");
        }

        var code = $("#codeid").val();
        if (code == "" || code == null){
            $("#phonetips").html("<spring:message code="safe.changephone.enterCode"/>");
            $("#phonetips").css("display","block");
            return;
        }else {
            $("#phonetips").css("display","none");
        }
        Loading.ShowLoading();
        checkPhone(code,phone,selectValue);

    }
    function checkPhone(code,phone,domainvalue){
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/editphone",
            modal: true,
            timeout: 30000,
            data: {
                uid: "${UID}",
                code:code,
                phone:phone,
                domainvalue:domainvalue,
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#phonetips").css("display", "none");
                    var tourl = "<%=path%>/safe/safesuccess?name=<spring:message code="safe.safe.bangdingphone"/>";
                    window.location.href=tourl;
                    Loading.HideLoading();
                } else {
                    $("#phonetips").html(data.msg);
                    $("#phonetips").css("display", "block");
                    $("#phone").attr("disabled",false);
                    Loading.HideLoading();
                }
            },
            error: function () {
                $("#phonetips").html("<spring:message code="safe.safesuccess.failNet"/>");
                $("#phonetips").css("display", "block");
                $("#phone").attr("disabled",false);
                Loading.HideLoading();
            }
        });
    }
    function getnumberonclick(){
        var phone = $("#phone").val();
        if (phone == "" || phone == null){
            $("#phoneLabel").html("<spring:message code="safe.changephone.enterPhone"/>");
            $("#phoneLabel").css("display","block");
            return;
        }else {
            $("#phoneLabel").css("display","none");
        }
        var selectValue = $('#selectid').val();
        var reg = localStorage.getItem(selectValue);
        var code = localStorage.getItem(selectValue+"1");
        var t = new RegExp(reg);
        if(!t.test(code+phone)){
            $("#phoneLabel").html("<spring:message code="safe.changephone.enterRightPhone"/>");
            $("#phoneLabel").css("display","block");
            return;
        }else {
            $("#phoneLabel").css("display","none");
        }
        Loading.ShowLoading();
        checkAvailable(phone,selectValue)

    }
    //检测是否可用
    function checkAvailable(phone,selectValue){
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/checkPhoneOrEmail",
            modal: true,
            timeout: 30000,
            data: {
                checkType: "phone",
                checkVal:phone,
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#phoneLabel").css("display", "none");
                    getTestCode(phone,selectValue);
                } else {
                    $("#phoneLabel").html(data.msg);
                    $("#phoneLabel").css("display", "block");
                    Loading.HideLoading();
                }
            },
            error: function () {
                Loading.HideLoading();
            }
        });
    }
//    发送验证码
    function getTestCode(phone,selectValue) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/sendTestCode",
            modal: true,
            timeout: 30000,
            data: {
                type: 2,
                info:phone,
                uid:"${UID}",
                domain:selectValue,
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#phonetips").css("display", "none");
                    $("#phone").attr("disabled","true");
                    wait = 60;
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
//    倒计时
    var wait = 60;
    function countDown() {
        if (wait == 0) {
            $("#getnumber").removeAttr("disabled");
            $("#getnumber").attr("onclick", "getnumberonclick()");
            $("#getnumber").html("<spring:message code="safe.checkphone.yzm_input"/>");//改变按钮中value的值
            $("#getnumber").attr("class","btn bnt-yzm");
            //p.html("如果您在1分钟内没有收到验证码，请检查您填写的手机号码是否正确或重新发送");
            wait = 60;
        }else {
            <%--var txtStr = '<spring:message code="safe.changemail.chongxinhuoqu"/>(' + wait + ')';--%>
            var txtStr = wait+ '<spring:message code="safe.changemail.chongxinhuoqu"/>';
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
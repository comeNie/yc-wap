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
    <title>注册</title>
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
    <div id="otherDiv">
        <div class="wrapper-big" ><!--包含除底部外的所有层-->
            <!--注册-->
            <nav class="wap-second-nav" >
                <ul>
                    <a href="javascript:" onclick="leftRe()"><i class="icon iconfont left">&#xe626;</i></a>
                    <li>注册</li>
                    <a href="javascript:void(0)" class="btn login-btn right1" onclick="jumpLogin()">登录</a>
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
                                <p><input id="phone" type="text" class="input input-large" placeholder="用请输入手机号"></p>
                                <label id="phoneLabel"></label>
                            </li>
                            <li>
                                <p><input id="codeid" type="text" class="input input-small" placeholder="请输入动态码"></p>
                                <p class="yzm"><a id="getnumber" href="javascript:void(0)" class="btn bnt-yzm" onclick="getnumberonclick()">获取动态码</a></p>
                                <label id="codeLabel"></label>
                            </li>
                            <li>
                                <p><input id="psdid" type="password" class="input input-large" placeholder="请输入密码"></p>
                                <label id="psdLabel"></label>
                            </li>
                            <li>
                                <p><input id="confimid" type="password" class="input input-large" placeholder="请再输入密码"></p>
                                <label id="confimPsd"></label>
                            </li>
                            <li><a href="javascript:void(0)" class="submit-btn btn-blue" onclick="confirmAction()">立即注册</a></li>
                            <li class="left">
                                <p><input id="checkid" type="checkbox" class="checkbox" checked></p>我已经阅读并同意<a href="javascript:void(0)" onclick="look()">《译云用户协议》</a>
                                <label id="agreeLabel"></label>
                            </li>

                        </ul>
                    </div>
                </div>
            </section>
        </div>

        <%--底部視圖--%>
        <jsp:include page="/jsp/common/bottom.jsp" flush="true"/>
    </div>

    <div id="xieyiDiv">
        <%--头部--%>
        <jsp:include page="/jsp/common/pophead.jsp" flush="true">
            <jsp:param name="Title" value="协议"/>
            <jsp:param name="BackTo" value="javascript:disMiss()"/>
        </jsp:include>

        <section class="about">
            <ul>
                <li class="td">译云平台在此特别提醒您（用户）在注册成为用户之前，请认真阅读本《用户协议》（以下简称“本协议”），确保您充分理解本协议中各条款。请您审慎阅读并选择接受或不接受本协议。除非您接受本协议所有条款，否则您无权注册、登录或使用本协议所涉服务。您的注册、登录、使用等行为将视为对本协议的接受， 并同意接受本协议各项条款的约束。如果您未满18周岁，请在法定监护人的陪同下阅读本协议，并特别注意未成年人使用条款。</li>
                <li class="td">本协议约定译云平台与用户之间关于“译云”软件服务（以下简称“服务”）的权利义务。“用户”是指注册、登录、使用本服务的个人。本协议可由译云平台随时更新，更新后的协议条款一旦公布即代替原来的协议条款，恕不再另行通知，用户可在本网站查阅最新版协议条款。在译云平台修改协议条款后，如果用户不接受修改后的条款，请立即停止使用译云平台提供的服务，用户继续使用译云平台提供的服务将被视为接受修改后的协议。</li>
                <li>一．账号注册</li>
                <li class="td">1-1．用户在使用本服务前需要注册一个“译云”账号。“译云”账号应当使用电子邮箱或手机号码绑定注册，请用户使用尚未与“译云”账号绑定的电子邮箱或手机号码。</li>
                <li class="td">1-2．在用户注册及使用本服务时，译云平台需要搜集能识别用户身份的个人信息以便译云平台可以在必要时联系用户，或为用户提供更好的使用体验。译云平台搜集的信息包括但不限于用户的姓名、性别、年龄、出生日期、身份证号、地址、学校情况、公司情况、所属行业、个人说明；译云平台同意对这些信息的使用将受限于第三条用户个人隐私信息保护的约束。</li>
            </ul>
        </section>
    </div>
</body>
</html>
<script>
    var personUid;
    function leftRe() {
        window.history.go(-1);
    }
    $(function() {
        //加载国家的数据
        loadCountry();

        //隐藏协议
        $("#otherDiv").show();
        $("#xieyiDiv").hide();

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
                } else {

                }
            },
            error: function () {
                $("#selectLabel").html("网络请求超时，请稍候再试");
                $("#selectLabel").css("display", "block");
            }
        });
    }
    function jumpLogin() {
        var tourl = "<%=path%>/login/login";
        window.location.href=tourl;
    }
    function confirmAction() {
        var phone = $("#phone").val();
        var codeid = $("#codeid").val();
        var psdid = $("#psdid").val();
        var confimid = $("#confimid").val();
        if (phone == "" || phone == null){
            $("#phoneLabel").html("请输入手机号");
            $("#phoneLabel").css("display","block");
            return;
        }else {
            $("#phoneLabel").css("display","none");
        }
        if(!(/^[0-9]*$/.test(phone))){
            $("#phoneLabel").html("请输入正确手机号");
            $("#phoneLabel").css("display","block");
            return;
        }else {
            $("#phoneLabel").css("display","none");
        }

        if (codeid == "" || codeid == null){
            $("#codeLabel").html("请输入验证码");
            $("#codeLabel").css("display","block");
            return;
        }else {
            $("#codeLabel").css("display","none");
        }

        if (psdid == "" || psdid == null){
            $("#psdLabel").html("请输入密码");
            $("#psdLabel").css("display","block");
            return;
        }else {
            $("#psdLabel").css("display","none");
        }
        var t = /^[0-9a-zA-Z]{6,16}$/;
        if (!t.test(psdid)){
            $("#psdLabel").html("<spring:message code="safe.changepsd.alert_newLength"/>");
            $("#psdLabel").css("display","block");
            return;
        }else {
            $("#psdLabel").css("display","none");
        }

        if (confimid == "" || confimid == null){
            $("#confimPsd").html("请输入密码");
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
            $("#agreeLabel").html("您还未接收翻译条款");
            $("#agreeLabel").css("display","block");
            return;
        }else {
            $("#agreeLabel").css("display", "none");
        }

//        登录验证
        checkPhoneWithJump(phone,codeid,psdid);

    }
    function checkPhoneWithJump(phone,codeid,psdid) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/editpssword",
            modal: true,
            timeout: 30000,
            data: {
                uid:personUid,
                newpw: psdid,
                code:codeid,
                mode:2  //密码操作吗
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#codeLabel").css("display", "none");
                    var tourl = "<%=path%>/login/registersuccess";
                    window.location.href=tourl;
                } else {
                    $("#codeLabel").html(data.msg);
                    $("#codeLabel").css("display", "block");
                }
            },
            error: function () {
                $("#codeLabel").html(data.msg);
                $("#codeLabel").css("display", "block");
            }
        });

    }


    function getnumberonclick(){
        var phone = $("#phone").val();
        if (phone == "" || phone == null){
            $("#phoneLabel").html("请输入手机号");
            $("#phoneLabel").css("display","block");
            return;
        }else {
            $("#phoneLabel").css("display","none");
        }
        if(!(/^[0-9]*$/.test(phone))){
            $("#phoneLabel").html("请输入正确手机号");
            $("#phoneLabel").css("display","block");
            return;
        }else {
            $("#phoneLabel").css("display","none");
        }
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
                    $("#codeLabel").css("display", "none");
                    personUid = data.uid;
                    countDown(60);
                } else {
                    $("#codeLabel").html(data.msg);
                    $("#codeLabel").css("display", "block");
                }
            },
            error: function () {
                $("#codeLabel").html(data.msg);
                $("#codeLabel").css("display", "block");
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
    function look() {
        //隐藏协议
        $("#otherDiv").hide();
        $("#xieyiDiv").show();
    }
    function disMiss(){
        $("#otherDiv").show();
        $("#xieyiDiv").hide();
    }
    <%--function checkRegister(phone,psdid,codeid){--%>
    <%--$.ajax({--%>
    <%--async: true,--%>
    <%--type: "POST",--%>
    <%--url: "<%=path%>/login/checkregister",--%>
    <%--modal: true,--%>
    <%--timeout: 30000,--%>
    <%--data: {--%>
    <%--phone: phone,--%>
    <%--password:psdid,--%>
    <%--code:codeid--%>
    <%--},--%>
    <%--success: function (data) {--%>
    <%--if (data.status == 1) {--%>
    <%--$("#confimPsd").css("display","none");--%>

    <%--var tourl = "<%=path%>/login/registersuccess";--%>
    <%--window.location.href=tourl;--%>
    <%--} else {--%>
    <%--$("#confimPsd").html("请输入密码");--%>
    <%--$("#confimPsd").css("display","block");--%>
    <%--return;--%>
    <%--}--%>
    <%--},--%>
    <%--error: function () {--%>
    <%--$("#confimPsd").html(data.msg);--%>
    <%--$("#confimPsd").css("display", "block");--%>
    <%--}--%>
    <%--});--%>
    <%--}--%>
</script>
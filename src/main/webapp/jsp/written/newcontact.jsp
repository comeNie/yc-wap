<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/3/2016
  Time: 5:28 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>联系方式</title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
    <script src="<%=path%>/js/modular/multi-switch.js"></script>
    <%@ include file="../common/timezone.jsp" %>
</head>
<body>
<div class="wrapper-big" id="body">
    <div class="eject-big">
        <div class="prompt" id="prompt">
            <div class="prompt-title">提示</div>
            <div class="prompt-confirm">
                <ul>
                    <li id="EjectTitle">IOS端不支持上传附件请前往PC端</li>
                </ul>
            </div>
            <div class="prompt-confirm-btn">
                <a class="btn btn-white" id="prompt-btn">确认</a>
            </div>

        </div>
        <div class="mask" id="eject-mask"></div>
    </div>
    <%--头部--%>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="联系方式"/>
        <jsp:param name="BackTo" value="javascript:window.history.go(-1)"/>
    </jsp:include>
    <!--订单内容-->
    <section class="order-content new-cont">
        <div class="order-list">
            <ul>
                <li>手机：</li>
                <li>
                    <select class="select newly-select" id="selectid"></select>
                </li>
            </ul>
            <ul>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
                <li class="iphone"><input type="text" class="input input-medium" id="phone" placeholder="请输入手机号码（必填）">
                </li>
            </ul>
            <ul>
                <li>姓名：</li>
                <li><input type="text" class="input input-medium" id="name" placeholder="请输入姓名" maxlength="10"></li>
            </ul>
            <ul>
                <li>邮箱：</li>
                <li><input type="text" class="input input-medium" id="email" placeholder="请输入接收译文的邮箱" maxlength="35">
                </li>
            </ul>

            <ul class="none-border" style="display: none">
                <li class="width-large">
                    <p>设为默认地址</p>
                    <p class="right-multi"><input type="checkbox" class="multi-switch" value="0"/></p>
                </li>
            </ul>
        </div>
    </section>
</div>
<section class="add-btn">
    <a href="javascript:void(0)" id="submit" class="btn submit-btn btn-blue">保存</a>
</section>
<jsp:include page="/jsp/common/loading.jsp" flush="true"/>
</body>
</html>

<script type="text/javascript">
    var contactId = "";
    var GnCountryId = "";

    $(function () {

    });

    $(document).ready(function () {

        loadCountry();

        $("#submit").bind("click", function () {
            var selectVal = $('#selectid').val();
            var phone = $("#phone").val();
            var name = $("#name").val();
            var email = $("#email").val();
            var phoneCheck = new RegExp(localStorage.getItem(localStorage.getItem(selectVal)));
            var emailCheck = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
            var nameCheck = /['"#$%&\^*]/;

            if (phone == "" || phone == null) {
                $("#EjectTitle").html("请输入手机号");
                $('#eject-mask').fadeIn(100);
                $('#prompt').slideDown(100);
                return;
            } else {
                if (!phoneCheck.test((localStorage.getItem(localStorage.getItem(selectVal) + "1")) + phone)) {
                    $("#EjectTitle").html("请输入正确的手机号");
                    $('#eject-mask').fadeIn(100);
                    $('#prompt').slideDown(100);
                    return;
                }
            }

            if (name == "" || name == null) {
                $("#EjectTitle").html("请输入姓名");
                $('#eject-mask').fadeIn(100);
                $('#prompt').slideDown(100);
                return;
            } else {
                if (isEmojiCharacter(name) || nameCheck.test(name)) {
                    $("#EjectTitle").html("请输入正确的姓名");
                    $('#eject-mask').fadeIn(100);
                    $('#prompt').slideDown(100);
                    return;
                }
            }

            if (email == "" || email == null) {
                $("#EjectTitle").html("请输入邮箱");
                $('#eject-mask').fadeIn(100);
                $('#prompt').slideDown(100);
                return;
            } else {
                if (!emailCheck.test(email)) {
                    $("#EjectTitle").html("请输入正确的邮箱");
                    $('#eject-mask').fadeIn(100);
                    $('#prompt').slideDown(100);
                    return;
                }
            }

            onSubmit(phone, name, email);
        });
    });

    function onSubmit(phone, name, email) {
        GnCountryId = $('#selectid').val();
        var countryCode = localStorage.getItem(localStorage.getItem(GnCountryId) + "1");
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/written/onSaveContact",
            modal: true,
            timeout: 30000,
            data: {
                phone: phone,
                name: name,
                email: email,
                contactId: contactId,
                GnCountryId: GnCountryId
            },
            success: function (data) {
                if (data.status == 1) {
                    window.location.href = "<%=path%>/written/onContentSubmit";
                } else {
                    $("#EjectTitle").html("保存失败，请重试");
                    $('#eject-mask').fadeIn(100);
                    $('#prompt').slideDown(100);
                }
            },
            error: function (data) {
                $("#EjectTitle").html("保存失败，请重试");
                $('#eject-mask').fadeIn(100);
                $('#prompt').slideDown(100);
            },
            beforeSend: function () {
                Loading.ShowLoading();
            },
            complete: function () {
                Loading.HideLoading();
            }
        });
    }

    function loadCountry() {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/countryid",
            modal: true,
            showBusi: false,
            timeout: 30000,
            data: {},
            success: function (data) {
                if (data.status == 1) {
                    var list = data.list;
                    $.each(list, function (index, value) {
                        if ("${pageContext.response.locale}".toUpperCase() == "ZH_CN") {
                            $('#selectid').append("<option value='" + value.id + "'>" + value.countryNameCn + " +" + value.countryCode + "</option>");
                        } else {
                            $('#selectid').append("<option value='" + value.id + "'>" + value.countryNameEn + " +" + value.countryCode + "</option>");
                        }
                        localStorage.setItem(value.countryValue, value.regularExpression);
                        localStorage.setItem(value.id, value.countryValue);
                        localStorage.setItem(value.countryValue + "1", value.countryCode);
                    });

                    var json = ${contentJson};
                    if (json != null) {
                        var phone = json.phone;
                        var name = json.name;
                        var email = json.email;
                        contactId = json.contactId;
                        GnCountryId = json.GnCountryId;

                        if (phone != null && phone != "") {
                            var phoneNumber = phone.split(" ");
                            $("#phone").val(phoneNumber[1]);
                        }
                        if (name != null && name != "") {
                            $("#name").val(name);
                        }
                        if (email != null && email != "") {
                            $("#email").val(email);
                        }
                    }

                    $("#selectid").children('option').each(function () {
                        var temp_value = $(this).val();
                        if (temp_value == GnCountryId) {
                            $(this)[0].selected = true;
                        }
                    });
                } else {
                    $("#EjectTitle").html("获取信息失败，请重试");
                    $('#eject-mask').fadeIn(100);
                    $('#prompt').slideDown(100);
                }
            },
            error: function () {
                $("#EjectTitle").html("获取信息失败，请重试");
                $('#eject-mask').fadeIn(100);
                $('#prompt').slideDown(100);
            },
            beforeSend: function () {

            },
            complete: function () {
                Loading.HideLoading();
            }
        });
    }

    function isEmojiCharacter(substring) {
        for (var i = 0; i < substring.length; i++) {
            var hs = substring.charCodeAt(i);
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    var ls = substring.charCodeAt(i + 1);
                    var uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        return true;
                    }
                }
            } else if (substring.length > 1) {
                var ls = substring.charCodeAt(i + 1);
                if (ls == 0x20e3) {
                    return true;
                }
            } else {
                if (0x2100 <= hs && hs <= 0x27ff) {
                    return true;
                } else if (0x2B05 <= hs && hs <= 0x2b07) {
                    return true;
                } else if (0x2934 <= hs && hs <= 0x2935) {
                    return true;
                } else if (0x3297 <= hs && hs <= 0x3299) {
                    return true;
                } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030
                        || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b
                        || hs == 0x2b50) {
                    return true;
                }
            }
        }
        return false;
    }
</script>

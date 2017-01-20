<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/3/2016
  Time: 5:20 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>确认订单</title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
    <script type="text/javascript" src="<%=path%>/js/common/wordcount.js"></script>
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
        <jsp:param name="Title" value="确认订单"/>
        <jsp:param name="BackTo" value="javascript:ToContent()"/>
    </jsp:include>
    <!--新增联系方式-->
    <section class="add-contact" id="contactNew">
        <a href="#" id="newContact" style="display: none"><i class="icon-plus"></i>新增联系方式</a>
        <ul class="left" id="contacts1">
            <li>
                <p>
                    <span><img src="<%=path%>/ui/images/icon-lx.jpg" class="img1"></span>
                    <span class="uesr" id="contactName"></span>
                </p>
                <p>
                    <span><img src="<%=path%>/ui/images/icon-lx1.jpg" class="img2"></span>
                    <span class="iphone" id="contactPhone"></span>
                </p>
            </li>
            <li class="mail" id="contactMail"></li>
        </ul>
        <ul class="right" id="contacts2">
            <li><i class="icon iconfont">&#xe62c;</i></li>
        </ul>
    </section>
    <!--订单内容-->
    <section class="order-content">
        <div class="order-list">
            <ul>
                <li>翻译主题:</li>
                <li class="right word">${Detail}
                </li>
            </ul>
            <ul>
                <li>翻译语言:</li>
                <li class="right">${DualVal}
                </li>
            </ul>
            <ul>
                <li>领域:</li>
                <li class="right">${DomainVal}
                </li>
            </ul>
            <ul>
                <li>用途:</li>
                <li class="right">${PurposeVal}
                </li>
            </ul>
            <ul class="none-border">
                <li>级别:</li>
                <li class="right">${TransLvVal}
                </li>
            </ul>
        </div>
    </section>
    <!--订单内容-->
    <section class="order-content">
        <div class="order-message">
            <ul>
                <li>给译员留言:</li>
                <li><textarea id="message" class="textarea textarea-large" placeholder="有问题请随时联系"></textarea></li>
            </ul>
        </div>
    </section>
</div>
<!--底部-->
<section class="order-submit">
    <p class="left">${Price}
    </p>
    <p class="right"><a href="javascript:void(0)" id="submit">提交订单</a></p>
</section>
<jsp:include page="/jsp/common/loading.jsp" flush="true"/>
</body>
</html>

<script type="text/javascript">
    var contactId = "${contactId}";
    var GnCountryId = "${GnCountryId}";
    var countryCode = "${countryCode}";
    var name = "${name}";
    var phone = "${phone}";
    var email = "${email}";
    $(function () {
        if (contactId == "") {
            $("#newContact").css("display", "block");
            $("#contacts1").css("display", "none");
            $("#contacts2").css("display", "none");
        } else {
            $("#newContact").css("display", "none");
            $("#contacts1").css("display", "block");
            $("#contacts2").css("display", "block");
            $("#contactName").html(name);
            $("#contactPhone").html(phone);
            $("#contactMail").html(email);
        }
    });

    $(document).ready(function () {
        Loading.HideLoading();
        $("#submit").bind("click", function () {
            if (name == "" || phone == "" || email == "") {
                $("#EjectTitle").html("请添加联系方式");
                $('#eject-mask').fadeIn(100);
                $('#prompt').slideDown(100);
                return;
            }
            orderSubmit();
        });

        $("#contactNew").bind("click", function () {
            toNewContact();
        });

        $("#message").on("input propertychange", function () {
            var $this = $(this);
            var _val = $this.val();
            if (_val.length > 50) {
                $this.val(_val.substring(0, 50));
            }
        });
    });

    function toNewContact() {
        var msg = $("#message").val();
        if (isEmojiCharacter(msg)) {
            $("#EjectTitle").html("请勿输入特殊字符及表情符号");
            $('#eject-mask').fadeIn(100);
            $('#prompt').slideDown(100);
            return;
        }

        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/written/saveMessage",
            modal: true,
            timeout: 30000,
            data: {
                msg: msg
            },
            success: function (data) {
                var ToUrl = "";
                if (contactId == "") {
                    ToUrl = "/written/newContact";
                } else {
                    ToUrl = "/written/newContact?name="
                            + encodeURIComponent(name) + "&phone=" + encodeURIComponent(phone)
                            + "&email=" + encodeURIComponent(email) + "&contactId=" + contactId + "&GnCountryId=" + GnCountryId;
                }
                window.location.href = "<%=path%>" + ToUrl;
            },
            error: function (data) {

            },
            beforeSend: function () {
                Loading.ShowLoading();
            },
            complete: function () {
                Loading.HideLoading();
            }
        });
    }

    function orderSubmit() {
        var msg = $("#message").val();
        if (isEmojiCharacter(msg)) {
            $("#EjectTitle").html("请勿输入特殊字符及表情符号");
            $('#eject-mask').fadeIn(100);
            $('#prompt').slideDown(100);
            return;
        }

        Date.prototype.stdTimezoneOffset = function () {
            var jan = new Date(this.getFullYear(), 0, 1);
            var jul = new Date(this.getFullYear(), 6, 1);
            return Math.max(jan.getTimezoneOffset(), jul.getTimezoneOffset());
        };

        Date.prototype.dst = function () {
            return this.getTimezoneOffset() < this.stdTimezoneOffset();
        };
        var today = new Date();
        var TimeZoneOffset = today.stdTimezoneOffset();

        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/written/onOrderSubmit",
            modal: true,
            timeout: 30000,
            data: {
                msg: msg,
                name: name,
                phone: phone,
                email: email,
                TimeZoneOffset: TimeZoneOffset
            },
            success: function (data) {
                if (data.status == 1) {
                    var OrderId = data.OrderId;
                    if (OrderId == "") {
                        $("#EjectTitle").html("下单失败，请重试");
                        $('#eject-mask').fadeIn(100);
                        $('#prompt').slideDown(100);
                        return;
                    }
                    window.location.href = "<%=path%>/written/payment?orderid=" + OrderId;
                } else {
                    $("#EjectTitle").html("下单失败，请重试");
                    $('#eject-mask').fadeIn(100);
                    $('#prompt').slideDown(100);
                }
            },
            error: function (data) {
                $("#EjectTitle").html("下单失败，请重试");
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

    function ToContent() {
        var href = "<%=path%>/written";
        window.location.href = href;
        location.replace("<%=path%>/written");
    }

</script>
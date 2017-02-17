<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>评价订单</title>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
    <%@ include file="../common/timezone.jsp" %>
</head>
<body>
<div class="wrapper-big"><!--包含除底部外的所有层-->
    <div class="eject-big">
        <div class="prompt" id="prompt">
            <div class="prompt-title">提示</div>
            <div class="prompt-confirm">
                <ul>
                    <li id="EjectTitle"></li>
                </ul>
            </div>
            <div class="prompt-confirm-btn">
                <a class="btn btn-white" id="prompt-btn">确认</a>
            </div>
        </div>
        <div class="mask" id="eject-mask"></div>
    </div>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="评价订单"/>
        <jsp:param name="BackTo" value="javascript:window.history.go(-1)"/>
    </jsp:include>

    <section class="evaluate">
        <div class="evaluate-title">
            <ul>
                <li>
                    <p class="word">服务质量：</p>
                    <p>
                        <span><img id="quality1" src="<%=path%>/ui/images/x.jpg"></span>
                        <span><img id="quality2" src="<%=path%>/ui/images/x.jpg"></span>
                        <span><img id="quality3" src="<%=path%>/ui/images/x.jpg"></span>
                        <span><img id="quality4" src="<%=path%>/ui/images/x.jpg"></span>
                        <span><img id="quality5" src="<%=path%>/ui/images/x.jpg"></span>
                    </p>
                </li>
                <li>
                    <p class="word">服务速度：</p>
                    <p>
                        <span><img id="speed1" src="<%=path%>/ui/images/x.jpg"></span>
                        <span><img id="speed2" src="<%=path%>/ui/images/x.jpg"></span>
                        <span><img id="speed3" src="<%=path%>/ui/images/x.jpg"></span>
                        <span><img id="speed4" src="<%=path%>/ui/images/x.jpg"></span>
                        <span><img id="speed5" src="<%=path%>/ui/images/x.jpg"></span>
                    </p>
                </li>
                <li>
                    <p class="word">服务态度：</p>
                    <p>
                        <span><img id="attitude1" src="<%=path%>/ui/images/x.jpg"></span>
                        <span><img id="attitude2" src="<%=path%>/ui/images/x.jpg"></span>
                        <span><img id="attitude3" src="<%=path%>/ui/images/x.jpg"></span>
                        <span><img id="attitude4" src="<%=path%>/ui/images/x.jpg"></span>
                        <span><img id="attitude5" src="<%=path%>/ui/images/x.jpg"></span>
                    </p>
                </li>
            </ul>
        </div>
        <div class="evaluate-list">
            <div class="evaluate-list-word">评价内容：</div>
            <div class="evaluate-list-te">
                <textarea id="message" class="textarea evaluate-textarea" placeholder="点击输入评价" maxlength="200">
                </textarea>
            </div>
        </div>
    </section>
</div>
<section class="add-btn">
    <a href="javascript:submit()" class="btn submit-btn btn-blue">评价</a>
</section>

</body>
</html>
<script type="text/javascript">
    var checkedImg = "<%=path%>/ui/images/x-l.jpg";
    var unCheckedImg = "<%=path%>/ui/images/x.jpg";

    $(function () {

    });

    $(document).ready(function () {
        for (var k = 1; k <= 5; k++) {
            document.getElementById("quality" + k).setAttribute("num", k);
            document.getElementById("quality" + k).onclick = function () {
                var num = Number(this.getAttribute("num"));
                var next = Number(num + 1);
                for (var v = num; v >= 1; v--) {
                    document.getElementById("quality" + v).src = checkedImg;
                    document.getElementById("quality" + v).setAttribute("checked", "1");
                }
                for (var o = next; o <= 5; o++) {
                    document.getElementById("quality" + o).src = unCheckedImg;
                    document.getElementById("quality" + o).setAttribute("checked", "0");
                }
            };

            document.getElementById("speed" + k).setAttribute("num", k);
            document.getElementById("speed" + k).onclick = function () {
                var num = Number(this.getAttribute("num"));
                var next = Number(num + 1);
                for (var v = num; v >= 1; v--) {
                    document.getElementById("speed" + v).src = checkedImg;
                    document.getElementById("speed" + v).setAttribute("checked", "1");
                }
                for (var o = next; o <= 5; o++) {
                    document.getElementById("speed" + o).src = unCheckedImg;
                    document.getElementById("speed" + o).setAttribute("checked", "0");
                }
            };

            document.getElementById("attitude" + k).setAttribute("num", k);
            document.getElementById("attitude" + k).onclick = function () {
                var num = Number(this.getAttribute("num"));
                var next = Number(num + 1);
                for (var v = num; v >= 1; v--) {
                    document.getElementById("attitude" + v).src = checkedImg;
                    document.getElementById("attitude" + v).setAttribute("checked", "1");
                }
                for (var o = next; o <= 5; o++) {
                    document.getElementById("attitude" + o).src = unCheckedImg;
                    document.getElementById("attitude" + o).setAttribute("checked", "0");
                }
            };
        }
    });

    function submit() {
        var quality = "";
        var speed = "";
        var attitude = "";
        var msg = $("#message").val();
        for (var k = 5; k >= 1; k--) {
            if (document.getElementById("quality" + k).getAttribute("checked") == "1") {
                if (quality == "") {
                    quality = document.getElementById("quality" + k).getAttribute("num");
                }
            }
            if (document.getElementById("speed" + k).getAttribute("checked") == "1") {
                if (speed == "") {
                    speed = document.getElementById("speed" + k).getAttribute("num");
                }
            }
            if (document.getElementById("attitude" + k).getAttribute("checked") == "1") {
                if (attitude == "") {
                    attitude = document.getElementById("attitude" + k).getAttribute("num");
                }
            }
        }
        console.log(quality + speed + attitude);
        if (quality == "" || speed == "" || attitude == "") {
            $("#EjectTitle").html("请评价");
            $('#eject-mask').fadeIn(100);
            $('#prompt').slideDown(100);
            return;
        }

        console.log(msg);
        if (msg == null || msg == "") {
            $("#EjectTitle").html("请输入评价内容");
            $('#eject-mask').fadeIn(100);
            $('#prompt').slideDown(100);
            return;
        }
    }

</script>
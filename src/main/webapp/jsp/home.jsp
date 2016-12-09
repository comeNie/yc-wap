<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; utf-8" pageEncoding="utf-8" session="false"%>
<%
    String path = request.getContextPath();
%>
<html>
<head>
	<title>Home</title>
</head>
<body onload="loaded()">
    <div id="wrapper">
        <div id="scroller">
            <ul id="thelist">
                <li>Pretty row 1</li>
                <li>Pretty row 2</li>
                <li>Pretty row 3</li>
                <li>Pretty row 4</li>
                <li>Pretty row 5</li>
                <li>Pretty row 6</li>
                <li>Pretty row 7</li>
                <li>Pretty row 8</li>
                <li>Pretty row 9</li>
                <li>Pretty row 10</li>
            </ul>
            <div id="pullUp">
                <span class="pullUpIcon"></span><span class="pullUpLabel">Pull up to load more...</span>
            </div>
        </div>
    </div>
</body>
</html>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
<%--<script src="http://res.wx.qq.com/connect/zh_CN/htmledition/js/wxLogin.js"></script>--%>
<%--<script src="<%=path%>/js/jquery/iscroll/iscroll.js"></script>--%>
<script src="<%=path%>/js/jquery/iscroll/iscroll-probe.js"></script>
<script type="text/javascript">

    var myScroll,pullUpEl,generatedCount = 0;;
    function loaded(){
        pullUpEl = document.getElementById('pullUp');
        myScroll = new IScroll("#wrapper",{
            useTransition: true,
        });
        myScroll.on("scroll",positionJudge);

        myScroll.on("scrollEnd",action);
        setTimeout(function () { document.getElementById('wrapper').style.left = '0'; }, 800);
        console.dir(myScroll.options);
    }
    function positionJudge () {
        if (this.y<(this.maxScrollY-40)){

            pullUpEl.querySelector('.pullUpLabel').innerHTML = 'Release to refresh...';
            this.maxScrollY = this.maxScrollY;
        }
    };
    function action () {
        pullUpEl.querySelector('.pullUpLabel').innerHTML = 'Loading...';
        pullUpAction();	// Execute custom function (ajax call?)
    }
    function pullUpAction () {
        setTimeout(function () {	// <-- Simulate network congestion, remove setTimeout from production!
            var el, li, i;
            el = document.getElementById('thelist');

            for (i=0; i<3; i++) {
                li = document.createElement('li');
                li.innerText = 'Generated row ' + (++generatedCount);
                el.appendChild(li, el.childNodes[0]);
            }

            myScroll.refresh();		// Remember to refresh when contents are loaded (ie: on ajax completion)
            pullUpEl.querySelector('.pullUpLabel').innerHTML = 'Pull up to load more...';
        }, 1000);	// <-- Simulate network congestion, remove setTimeout from production!
    }
    //初始化绑定iScroll控件
    document.addEventListener('touchmove', function (e) {
        e.preventDefault();
    }, false);
    document.addEventListener('DOMContentLoaded', loaded, false);
</script>
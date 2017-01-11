<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 12/9/2016
  Time: 7:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%
    String _base = request.getContextPath();
    request.setAttribute("_base", _base);
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%--CNZZ--%>
    <%@ include file="cs.jsp" %>
</head>

<body>
<%--CNZZ--%>
<%
    CS cs = new CS(1253200201);
    cs.setHttpServlet(request, response);
    String imgurl = cs.trackPageView();
%>
<img src="<%= imgurl %>" width="0" height="0"/>
</body>

<script>
    Date.prototype.stdTimezoneOffset = function () {
        var jan = new Date(this.getFullYear(), 0, 1);
        var jul = new Date(this.getFullYear(), 6, 1);
        return Math.max(jan.getTimezoneOffset(), jul.getTimezoneOffset());
    };

    //get timezone
    Date.prototype.dst = function () {
        return this.getTimezoneOffset() < this.stdTimezoneOffset();
    };

    var today = new Date();
    //send to the back
    $.post("${_base}/timezone.htm?offset=" + today.stdTimezoneOffset());

    //百度商桥
    var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
    document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F0f7edd714a27976c6673e5db7079b08a' type='text/javascript'%3E%3C/script%3E"));

    //百度统计
    var _hmt = _hmt || [];
    (function () {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?abc0c1bd59df490d1d8c8e6a44b09fdc";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>

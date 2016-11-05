<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 11/5/2016
  Time: 5:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <p>这是支付界面</p>
    <input type="button" id="submit1" class="btn submit-btn btn-blue" value="支付成功">
    <input type="button" id="submit2" class="btn submit-btn btn-blue" value="支付失败">
</body>
</html>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var tourl = "<%=path%>/jsp/written/payresult.jsp";
        $("#submit1").bind("click", function () {
            window.location.href=tourl+"?result=success";
        });

        $("#submit2").bind("click", function () {
            window.location.href=tourl+"?result=fail";
        });
    });

    $(function () {

    });

</script>

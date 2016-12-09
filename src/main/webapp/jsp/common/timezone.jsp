<%--
  Created by IntelliJ IDEA.
  User: Nozomi
  Date: 12/9/2016
  Time: 7:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String _base = request.getContextPath();
    request.setAttribute("_base", _base);
%>
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
    $.post(<%=_base%>+"/timezone.htm?offset=" + today.stdTimezoneOffset());
</script>

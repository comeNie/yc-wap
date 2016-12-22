<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/10
  Time: 上午11:21
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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>关于我们</title>
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
    <%--头部--%>
    <jsp:include page="/jsp/common/pophead.jsp" flush="true">
        <jsp:param name="Title" value="关于我们"/>
        <jsp:param name="BackTo" value="javascript:window.history.go(-1)"/>
    </jsp:include>
    <section class="about">
        <ul>
            <li class="img"><img src="<%=path%>/ui/images/about-logo.png" /></li>
            <li>中译语通科技（北京）有限公司 是中国对外翻译出版有限公司（经国务院批准成立的国家级翻译出版机构）的控股子公司，致力于以先进大数据技术和互联网为用户提供更全面、更便捷、更具性价比的翻译服务和专业翻译平台。中译语通传承中国对外翻译出版有限公司40年的优秀服务品质和海量语料资源，整合中国出版集团及其下属人民文学出版社、商务印书馆、中华书局等14家子公司以及81家相关公司的优质语言资源，将世界领先的创新科技引入语言服务领域。曾先后服务于北京奥运会、上海世博会、南京亚青会等多个国家级赛事，是中国境内唯一为联合国提供翻译和出版服务的指定供应商，国家级语言服务提供商。</li>
            <li class="blue">公司资质</li>
            <li>中译的前身，是1973年3月成立的“联合国资料小组”。</li>
            <li>中国境内唯一为联合国提供翻译和出版服务的指定供应商。</li>
            <li>国家会议服务提供商，并曾先后服务于北京奥运会、上海世博会、南京亚青会等多个国际级赛事。</li>
            <li>中国翻译协会发起创始单位、中国翻译协会翻译服务委员会秘书处单位。</li>
            <li>国家标准《翻译服务规范、笔译、口译》的倡导、起草单位之一。</li>
            <li>国家标准《翻译服务译文质量要求》（GB/T19682-2005）的倡导、起草单位之一。</li>
            <li>国家标准《翻译服务口译质量要求》的倡导、起草单位之一，中国标准化协会成员。</li>
            <li class="blue">服务特色</li>
            <li>极致的速度,自动化流程，译审同步，立等可取</li>
            <li>全面的服务,全语种，全行业，多领域</li>
            <li>放心的质量,多重审核，国家级翻译品质，不满意免费修改</li>
            <li class="blue">联系方式</li>
            <li>北京总部</li>
            <li>地址：北京市石景山区石景山路20号中铁建设大厦16层</li>
            <li>邮编：100131</li>
            <li>服务热线：400-119-8080</li>
            <li>邮箱：service@gtcom.com.cn </li>
        </ul>
    </section>

</body>
</html>

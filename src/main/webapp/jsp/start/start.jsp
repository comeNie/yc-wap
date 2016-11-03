<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>首页</title>
    <link href="/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="/ui/css/modular/iconfont.css" rel="stylesheet" type="text/css">
    <link href="/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
</head>

<body>
<!--分享弹出框-->
<div class="eject-big" style="display:none">
    <div class="prompt-share" id="share-eject">
        <div class="prompt-share-title">请选择</div>
        <!--确认删除-->
        <div class="prompt-share-confirm">
            <ul>
                <li class="weix">
                    <p><i class="icon iconfont">&#xe61a;</i></p>
                    <p>微信</p>
                </li>
                <li class="weixq">
                    <p><i class="icon iconfont">&#xe61f;</i></p>
                    <p>微信朋友圈</p>
                </li>
                <li class="blog">
                    <p><i class="icon iconfont">&#xe627;</i></p>
                    <p>微博</p>
                </li>
                <li class="qq">
                    <p><i class="icon iconfont">&#xe61e;</i></p>
                    <p>QQ</p>
                </li>
                <li class="watercress">
                    <p><i class="icon iconfont">&#xe625;</i></p>
                    <p>豆瓣</p>
                </li>
                <li class="message">
                    <p><i class="icon iconfont">&#xe622;</i></p>
                    <p>短信</p>
                </li>
                <li class="copy">
                    <p><i class="icon iconfont">&#xe620;</i></p>
                    <p>复制链接</p>
                </li>
            </ul>
        </div>
        <div class="close-icon"><i class="icon iconfont" id="close-icon">&#xe611;</i></div>
    </div>
    <div class="mask" id="eject-mask"></div>
</div>
<!--弹出框结束-->
<section class="notice">
    <p>公告信息等等等等</p>
    <label><i class="icon iconfont">&#xe618;</i></label>
</section>
<nav class="wap-nav">
    <ul>
        <li class="logo"><img src="/ui/images/start/logo.png" /></li>
        <li class="right"><input type="button" class="btn login-btn" value="登录"></li>
    </ul>
</nav>
<section class="index-wrapper">
    <!--转换语言-->
    <section class="testing">
        <p>
            <select class="select testing-select">
                <option>检测语言：中文</option>
                <c:forEach items="${requestScope.languagepairs}" var="pair">
                    <option>${pair}</option>
                </c:forEach>
            </select>
            <span>|</span>
        </p>
        <p class="test-icon"><i class="icon iconfont">&#xe621;</i></p>
        <p>
            <select class="select testing-select">
                <c:forEach items="${requestScope.languagepairs}" var="pair">
                <option>${pair}</option>
                </c:forEach>
            </select>
            <span>|</span>
        </p>
    </section>
    <!--翻译内容-->
    <section class="translation-content">
        <textarea class="textarea textarea-large" name="chick-int" id="chick-int"></textarea>
        <a hrel="#"><i class="icon iconfont">&#xe618;</i></a>
    </section>
    <!--翻译按钮-->
    <section class="translate-btn" id="chick-btn">
        <input type="button" class="btn btn-big" value="翻译">
    </section>
    <!--翻译结果-->
    <section class="translation-content-english" id="results">
        <textarea class="textarea textarea-xlarge"></textarea>
        <p>
            <a href="#"><i class="icon iconfont">&#xe61b;</i></a>
            <a href="#" id="share-icon"><i class="icon iconfont">&#xe61c;</i></a>
        </p>
    </section>

</section>
<section id="wrapper-hide" >
    <section class="index-wrapper">
        <!--历史纪录-->
        <section class="history">
            <div class="history-list">
                <ul>
                    <a href="javascript:">
                        <li>
                            <p><i class="icon iconfont">&#xe624;</i></p>
                            <p class="word">就显示一行 就显示一行显示一行</p>
                            <p class="word-en">yiwen yiwen yiwen</p>
                            <p class="right"><i class="icon iconfont">&#xe618;</i></p>
                        </li>
                    </a>
                    <a href="javascript:">
                        <li>
                            <p><i class="icon iconfont">&#xe624;</i></p>
                            <p class="word">就显示一行 就显示一行显示一行</p>
                            <p class="word-en">yiwen yiwen yiwen</p>
                            <p class="right"><i class="icon iconfont">&#xe618;</i></p>
                        </li>
                    </a>
                </ul>
            </div>
        </section>

    </section>
    <!--banner-->
    <section class="banner"><a href="#"><img src="/ui/images/start/banner-1.png"></a></section>
    <section class="banner"><a href="#"><img src="/ui/images/start/banner-2.png"></a></section>

</section>

<!--底部-->
<section class="footer-big">
    <section class="terminal">
        <ul>
            <li>
                <p><img src="/ui/images/start/icon-1.png" /></p>
                <p>客户端</p>
            </li>
            <li class="current">
                <p><img src="/ui/images/start/icon-2.png" /></p>
                <p>触屏版</p>
            </li>
            <li class="none-ml">
                <p><img src="/ui/images/start/icon-3.png" /></p>
                <p>电脑版</p>
            </li>
        </ul>
    </section>
    <footer class="footer">
        <ul>
            <li><a hrel="#">关于我们</a>|<a hrel="#">译云招募</a>|<a hrel="#">意见反馈</a>|<a hrel="#">ENGLISH</a></li>
            <li class="ash">中译语通科技（北京）有限公司版权所有</li>
        </ul>
    </footer>
</section>

</body>
</html>
<script type="text/javascript" src="/js/start/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/start/global.js"></script>
<script type="text/javascript" src="/js/start/frame.js"></script>
<script type="text/javascript" src="/js/start/eject.js"></script>

<script type="text/javascript">
/////////////////////


</script>
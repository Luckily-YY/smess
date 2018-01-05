<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/static/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <title>404</title>
    <meta name="description" content=""/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="static/ace/css/bootstrap.css"/>
    <link rel="stylesheet" href="static/ace/css/font-awesome.css"/>
    <!-- page specific plugin styles -->
    <!-- text fonts -->
    <link rel="stylesheet" href="static/ace/css/ace-fonts.css"/>
    <!-- ace styles -->
    <link rel="stylesheet" href="static/ace/css/ace.css" class="ace-main-stylesheet" id="main-ace-style"/>
    <script src="static/ace/js/ace-extra.js"></script>
</head>

<body class="no-skin">

<div class="main-container" id="main-container">
    <div class="main-content">
        <div class="main-content-inner">
            <div class="page-content">
                <div class="hr hr-18 dotted hr-double"></div>
                <div class="row">
                    <div class="col-xs-12">
                        <div class="error-container">
                            <div class="well">
                                <h1 class="grey lighter smaller">
                                    <span class="blue bigger-125"><i class="icon-sitemap"></i> 404</span> 没有找到此页面
                                </h1>
                                <hr/>

                                <div>

                                    <div class="space"></div>

                                    <h4 class="smaller">检查一下可能性:</h4>
                                    <ul>
                                        <li><i class="icon-hand-right blue"></i> 检查请求链接是不是有误</li>
                                        <li><i class="icon-hand-right blue"></i> 检查处理类代码是不是有误</li>
                                        <li><i class="icon-hand-right blue"></i> 检查环境配置是不是有误</li>
                                        <li><i class="icon-hand-right blue"></i> 检查处理类视图映射路径</li>
                                    </ul>
                                </div>

                                <hr/>
                                <div class="space"></div>

                                <div class="row-fluid">
                                    <div id="zhongxin">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- 返回顶部 -->
    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>

</div>

<!-- 页面底部js¨ -->

<script type="text/javascript">
    window.jQuery || document.write("<script src='<%=basePath%>static/ace/js/jquery.js'>" + "<" + "/script>");
</script>
<script type="text/javascript">
    window.jQuery || document.write("<script src='<%=basePath%>static/ace/js/jquery1x.js'>" + "<" + "/script>");
</script>
<script type="text/javascript">
    if ('ontouchstart' in document.documentElement) document.write("<script src='<%=basePath%>static/ace/js/jquery.mobile.custom.js'>" + "<" + "/script>");
</script>
<script src="static/ace/js/bootstrap.js"></script>

<script src="static/ace/js/ace/ace.js"></script>
<script type="text/javascript">
    $(top.hangge());
</script>


</body>
</html>
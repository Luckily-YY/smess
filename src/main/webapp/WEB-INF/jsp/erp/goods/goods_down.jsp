<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- 下拉框 -->
    <link rel="stylesheet" href="static/ace/css/chosen.css"/>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/top.jsp" %>
    <!-- 日期框 -->
    <link rel="stylesheet" href="static/ace/css/datepicker.css"/>
    <style type="text/css">
        .plainstyle {
            width: 88%;
            height: 100px;
        }
    </style>
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
    <!-- /section:basics/sidebar -->
    <div class="main-content">
        <div class="main-content-inner">
            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12">

                        <form action="goods/down.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="GOODS_ID" id="GOODS_ID" value="${pd.GOODS_ID}"/>
                            <div id="zhongxin" style="padding-top: 13px;">
                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">商品名称:</td>
                                        <td colspan="10">
                                            <input type="text" name="TITLE" id="TITLE"
                                                   value="${pd.TITLE}"
                                                   maxlength="30" title="商品名称" READONLY
                                                   style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">货架数量:</td>
                                        <td><input type="text" id="OLD" value="${pd.GCOUNT}" READONLY
                                                   maxlength="30" title="货架数量"
                                                   style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">下架数量:</td>
                                        <td>
                                            <input type="text" name="GCOUNT" id="GCOUNT"
                                                   maxlength="30" placeholder="请填写下架数量" title="下架数量"
                                                   style="width:98%;"/>
                                        </td>
                                    </tr>

                                </table>
                            </div>
                            <div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img
                                    src="static/images/jiazai.gif"/><br/><h4 class="lighter block green">提交中...</h4>
                            </div>
                        </form>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.page-content -->
        </div>
    </div>
    <!-- /.main-content -->
</div>
<!-- /.main-container -->

<footer>
    <div style="width: 100%;padding-bottom: 2px;" class="center">
        <a class="btn btn-mini btn-primary" onclick="save('${pd.GOODS_ID}');">保存</a>
        <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
    </div>

</footer>

<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp" %>
<!-- 百度富文本编辑框-->
<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
<!-- 百度富文本编辑框-->
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
    $(top.hangge());


    //保存
    function save(id) {

        if ($("#GCOUNT").val() == "") {
            $("#GCOUNT").tips({
                side: 3,
                msg: '请输入下架数量',
                bg: '#AE81FF',
                time: 2
            });
            $("#GCOUNT").focus();
            return false;
        }

        $.ajax({
            type: "POST",
            url: 'goods/checkById.do',
            data: {GOODS_ID: id},
            dataType: 'json',
            cache: false,
            success: function (data) {
                if ("success" == data.result) {
                    $("#OLD").val(data.pd.GCOUNT);
                } else {
                    $("#TITLE").tips({
                        side: 3,
                        msg: "此商品不存在",
                        bg: '#FF5080',
                        time: 15
                    });
                }
            }
        });

        var old = $("#OLD").val();
        var news = $("#GCOUNT").val();
        var a = (old - news).toFixed(2);
        if (a < 0.00) {
            $("#GCOUNT").tips({
                side: 3,
                msg: '下架数量不能大于原有数量',
                bg: '#AE81FF',
                time: 2
            });
            $("#GCOUNT").focus();
            return false;
        }
        else {
            $("#Form").submit();
            $("#zhongxin").hide();
            $("#zhongxin2").show();
        }
    }
</script>
</body>
</html>
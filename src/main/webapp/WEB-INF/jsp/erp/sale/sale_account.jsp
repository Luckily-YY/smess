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
                            <div id="zhongxin" style="padding-top: 25px;">
                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">总金额:</td>
                                        <td><input type="text" name="ZPRICE" id="ZPRICE" value="${pd.SALEPRICE}"
                                                   maxlength="30"  title="购买总金额" readonly
                                                   style="width:89%;"/>&nbsp;元
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">应收金额:</td>
                                        <td><input type="text" name="ZPRICE1" id="ZPRICE1" value="${pd.SALEPRICE}"
                                                   maxlength="30" title="商品库存量" readonly
                                                   style="width:89%;"/>&nbsp;元
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">实收金额:</td>
                                        <td><input type="text" name="ZPRICE2" id="ZPRICE2"
                                                   maxlength="30" title="实收金额" onchange="getcount();"
                                                   style="width:89%;"/>&nbsp;元
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">找零:</td>
                                        <td><input type="text" name="ZPRICE3" id="ZPRICE3"
                                                   maxlength="30" title="找零"
                                                   style="width:89%;"/>&nbsp;元
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img
                                    src="static/images/jiazai.gif"/><br/><h4 class="lighter block green">提交中...</h4>
                            </div>
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
            <a class="btn btn-mini btn-primary" onclick="account();">结算</a>
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

    var point = /^\d*\.{0,1}\d{0,1}\d{0,1}$/;  //两位小数
    var number = /^\d*$/; //纯数字

    function getcount() {
        if ($("#ZPRICE2").val() == "") {
            $("#ZPRICE2").tips({
                side: 3,
                msg: '请输入实收金额',
                bg: '#AE81FF',
                time: 2
            });
            $("#ZPRICE2").focus();
            return false;
        }

        if (!point.test($("#ZPRICE2").val())) {
            $("#ZPRICE2").tips({
                side: 3,
                msg: '请输入正确的金额',
                bg: '#AE81FF',
                time: 2
            });
            $("#ZPRICE2").focus();
            return false;
        }
        var price1 = Number("" == $("#ZPRICE1").val() ? "0" : $("#ZPRICE1").val());
        var price2 = Number("" == $("#ZPRICE2").val() ? "0" : $("#ZPRICE2").val());
        var newprice = (price2 - price1).toFixed(2);
        $("#ZPRICE3").val(newprice);
    }


    //结账
    function account() {
        if ($("#ZPRICE2").val() == "") {
            $("#ZPRICE2").tips({
                side: 3,
                msg: '请输入实收金额',
                bg: '#AE81FF',
                time: 2
            });
            $("#ZPRICE2").focus();
            return false;
        }

        if (!point.test($("#ZPRICE2").val())) {
            $("#ZPRICE2").tips({
                side: 3,
                msg: '请输入正确的金额',
                bg: '#AE81FF',
                time: 2
            });
            $("#ZPRICE2").focus();
            return false;
        }
        if ($("#ZPRICE3").val() == "") {
            $("#ZPRICE3").tips({
                side: 3,
                msg: '请输入找零金额',
                bg: '#AE81FF',
                time: 2
            });
            $("#ZPRICE3").focus();
            return false;
        }

        if (!point.test($("#ZPRICE3").val())) {
            $("#ZPRICE3").tips({
                side: 3,
                msg: '请输入正确的金额',
                bg: '#AE81FF',
                time: 2
            });
            $("#ZPRICE3").focus();
            return false;
        }
        else {
            ddpirnt($("#ZPRICE2").val(),$("#ZPRICE3").val());
        }
    }

    //打印清单
    function ddpirnt(price1,price2) {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "打印清单";
        diag.URL = '<%=basePath%>sale/ddpirnt.do?ZPRICE1='+price1+'&ZPRICE2='+price2;
        diag.Width = 450;
        diag.Height = 600;
        diag.Modal = true;			//有无遮罩窗口
        diag.ShowMaxButton = true;	//最大化按钮
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function () { //关闭事件
            diag.close();
        };
        diag.show();
    }

</script>
</body>
</html>
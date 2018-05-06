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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sweet/css/example.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sweet/css/sweet-alert.css">
    <script src="${pageContext.request.contextPath}/sweet/js/sweet-alert.min.js"></script>
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

                        <div style="padding-top: 13px; height: 330px;" align="center">
                            <table style="margin-top:5px;border: 0px;">
                                <tr style="width: 440px;font-size: 22px;">
                                    <td colspan="3" align="center">
                                        <b>品名</b>
                                    </td>
                                    <td colspan="3" align="center">
                                        <b>${pd.GOODS_NAME}</b>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="center">包装日期：</th>
                                    <th class="center">${pd.CREATEDTIME}</th>
                                    <th class="center">&nbsp;&nbsp;&nbsp;</th>
                                    <th class="center">&nbsp;&nbsp;&nbsp;</th>
                                    <th class="center">保质日期：</th>
                                    <th class="center">${pd.LASTTIME}</th>
                                </tr>
                            </table>
                            <table id="simple-table" style="margin-top:5px;border: 0px;width: 440px;" align="center" >
                                <tr style="width: 440px;">
                                    <td colspan="6" align="center">
                                        <img id="encoderImgId" cache="false" src="<%=basePath%>uploadFiles/barcode/${pd.GOODS_ID }.png" width="261px"/>
                                    </td>

                                </tr>
                                <tr style="width: 440px;height: 50px;font-size: 18px;">
                                    <td colspan="2" align="center">
                                        <b>单价</b>
                                    </td>
                                    <td colspan="2" align="center">
                                        <b>${pd.WPRICE}</b>
                                    </td>
                                    <td colspan="2" align="center">
                                        <b>元/${pd.NAME}</b>
                                    </td>
                                </tr>
                                <tr style="width: 440px;font-size: 18px;">
                                    <td colspan="2" align="center">
                                        <b>重量</b>
                                    </td>
                                    <td colspan="2" align="center">
                                        <b>${pd.WEIGHT}</b>
                                    </td>
                                    <td colspan="2" align="center">
                                        <b>${pd.NAME}</b>
                                    </td>
                                </tr>
                                <tr style="width: 440px;font-size: 22px;">
                                    <td colspan="2" align="center">
                                        <b>售价</b>
                                    </td>
                                    <td colspan="2" align="center">
                                        <b>${pd.WZPRICE}</b>
                                    </td>
                                    <td colspan="2" align="center">
                                        <b>元</b>
                                    </td>
                                </tr>
                            </table>


                        </div>

                        <table id="table_report" align="center">
                            <tr>
                                <td style="text-align: center;" colspan="10">
                                    <a class="btn btn-mini btn-primary" onClick="printWeight();">打印</a>
                                    <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
                                </td>
                            </tr>
                        </table>
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


<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp" %>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
    $(top.hangge());

    function printWeight() {

        $.ajax({
            type: "POST",
            url: 'weight/printWeight.do',

            data: {WEIGHT_ID: "${pd.WEIGHT_ID}",GOODS_ID: "${pd.GOODS_ID}",
                    WBIANMA: "${pd.WBIANMA}",WEIGHT: "${pd.WEIGHT}",
                    WPRICE: "${pd.WPRICE}",WZPRICE: "${pd.WZPRICE}",
                    GOODS_NAME: "${pd.GOODS_NAME}",CREATEDTIME: "${pd.CREATEDTIME}"},
            dataType: 'json',
            cache: false,
            success: function (data) {
                if ("success" == data.result) {
                    window.print();
                } else {
                    swal("操作失败", "无法调用打印机!", "error");
                }
            }
        });
    }

</script>
</body>
</html>
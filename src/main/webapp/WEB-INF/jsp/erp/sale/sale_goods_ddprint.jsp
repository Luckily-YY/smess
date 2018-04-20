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

                        <div style="padding-top: 13px; height: 530px;">
                            <table style="margin-top:5px;border: 0px;">
                                <tr>
                                    <th class="center">购买总金额：</th>
                                    <th class="center">${pd.SALEPRICE}</th>
                                    <th class="center">&nbsp;&nbsp;&nbsp;</th>
                                    <th class="center">&nbsp;&nbsp;&nbsp;</th>
                                    <th class="center">购买时间：</th>
                                    <th class="center">${pd.TIME}</th>
                                </tr>
                            </table>
                            <table id="simple-table" style="margin-top:5px;border: 0px;" >
                                <thead>
                                <tr>
                                    <th class="center" style="width:50px;">序号</th>
                                    <th class="center">&nbsp;&nbsp;商品名称</th>
                                    <th class="center">&nbsp;&nbsp;数目</th>
                                    <th class="center"></th>
                                    <th class="center"></th>
                                    <th class="center">&nbsp;&nbsp;单价</th>
                                    <th class="center"></th>
                                    <th class="center">&nbsp;&nbsp;总价</th>
                                </tr>
                                </thead>

                                <tbody>
                                <!-- 开始循环 -->
                                <c:choose>
                                    <c:when test="${not empty varList}">
                                        <c:forEach items="${varList}" var="var" varStatus="vs">
                                            <tr>
                                                <td class='center' style="width: 30px;">${vs.index+1}</td>
                                                <td class='center'>${var.GOODS_NAME}</td>
                                                <td class='center'>${var.SALECOUNT}</td>
                                                <td class='center'>..........</td>
                                                <td class='center'>..........</td>
                                                <td class='center'>${var.PRICE}</td>
                                                <td class='center'>**</td>
                                                <td class='center'>${var.ZPRICE}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr class="main_info">
                                            <td colspan="100" class="center">没有相关数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>


                        </div>

                        <table id="table_report" align="center">
                            <tr>
                                <td style="text-align: center;" colspan="10">
                                    <a class="btn btn-mini btn-primary" onClick="printSale();">打印</a>
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

    function printSale() {

        $.ajax({
            type: "POST",
            url: 'sale/printSale.do',
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
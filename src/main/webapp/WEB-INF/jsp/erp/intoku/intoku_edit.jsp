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

                        <form action="intoku/${msg }.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="INTOKU_ID" id="INTOKU_ID" value="${pd.INTOKU_ID}"/>
                            <div id="zhongxin" style="padding-top: 13px;">
                                <table id="table_report" class="table table-striped table-bordered table-hover">

                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">商品名称:</td>
                                        <td><input type="text" name="GOODS_NAME" id="GOODS_NAME"
                                                   value="${pd.GOODS_NAME}" maxlength="32" title="商品名称"
                                                   style="width:99%;"/></td>
                                    </tr>

                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">商品类别:</td>
                                        <td>
                                            <select class="chosen-select form-control" name="SPTYPE_ID" id="SPTYPE_ID"
                                                    data-placeholder="请选择商品类别" style="vertical-align:top;width:340px;">
                                                <option value="">无分类</option>
                                                <c:forEach items="${sptypeList}" var="var">
                                                    <option value="${var.SPTYPE_ID }"
                                                            <c:if test="${var.SPTYPE_ID == pd.SPTYPE_ID }">selected</c:if>>${var.NAME }</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">数量:</td>
                                        <c:if test="${pd.INCOUNT !=null}">
                                        <td><input onblur="jisuanz();" type="number" name="INCOUNT" readonly
                                                   value="${pd.INCOUNT}" id="INCOUNT" maxlength="32" title="数量"
                                                   style="width:99%;"/></td>
                                        </c:if>
                                        <c:if test="${pd.INCOUNT == null}">
                                            <td><input onblur="jisuanz();" type="number" name="INCOUNT"
                                                        id="INCOUNT" maxlength="32" title="数量"
                                                       style="width:99%;"/></td>
                                        </c:if>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">单价:</td>
                                        <c:if test="${pd.PRICE!=null&&pd.PRICE!=''}">
                                        <td><input onblur="jisuanz();" type="number" name="PRICE" id="PRICE" readonly
                                                   VALUE="${pd.PRICE}" maxlength="32" placeholder="这里输入单价（进价）"
                                                   title="单价" style="width:89%;"/>&nbsp;元
                                        </td>
                                        </c:if>
                                        <c:if test="${pd.PRICE==null || pd.PRICE==''}">
                                        <td><input onblur="jisuanz();" type="number" name="PRICE" id="PRICE"
                                                    maxlength="32" placeholder="这里输入单价（进价）"
                                                   title="单价" style="width:89%;"/>&nbsp;元
                                        </td>
                                        </c:if>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">总价:</td>
                                        <td><input type="number" name="ZPRICE" id="ZPRICE" maxlength="32" readonly
                                                   VALUE="${pd.ZPRICE}" placeholder="总价" title="总价" style="width:89%;"/>&nbsp;元
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
                                        <td>
                                            <textarea rows="" cols="" name="BZ" id="BZ"
                                                      style="width:99%;">${pd.BZ}</textarea>
                                        </td>
                                    </tr>
                                    <tr>

                                        <c:if test="${'edit' == msg }">
                                            <td style="text-align: center;" colspan="10">
                                                <a class="btn btn-mini btn-primary" onclick="edit();">保存</a>
                                                <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
                                            </td>
                                        </c:if>
                                        <c:if test="${'save' == msg }">
                                            <td style="text-align: center;" colspan="10">
                                                <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
                                                <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
                                            </td>
                                        </c:if>
                                    </tr>
                                </table>
                            </div>
                            <div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img
                                    src="static/images/jiazai.gif"/><br/><h4 class="lighter block green">提交中...</h4>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

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

    var point=/^\d*\.{0,1}\d{0,1}\d{0,1}$/;  //两位小数
    var number=/^\d*$/; //纯数字

    //计算总价
    function jisuanz() {
        var INCOUNT = Number("" == $("#INCOUNT").val() ? "0" : $("#INCOUNT").val());
        var PRICE = Number("" == $("#PRICE").val() ? "0" : $("#PRICE").val());
        if (0 - INCOUNT > 0) {
            $("#INCOUNT").tips({
                side: 3,
                msg: '数量不能小于零',
                bg: '#AE81FF',
                time: 2
            });
            $("#INCOUNT").focus();
            return false;
        }
        if (0 - PRICE > 0) {
            $("#PRICE").tips({
                side: 3,
                msg: '单价不能小于零',
                bg: '#AE81FF',
                time: 2
            });
            $("#PRICE").focus();
            return false;
        }
        $("#ZPRICE").val(INCOUNT * PRICE);
    }

    //保存
    function save() {


        if ($("#GOODS_NAME").val() == "") {
            $("#GOODS_NAME").tips({
                side: 3,
                msg: '请填写商品名称',
                bg: '#AE81FF',
                time: 2
            });
            $("#GOODS_NAME").focus();
            return false;
        }


        if ($("#INCOUNT").val() == "") {
            $("#INCOUNT").tips({
                side: 3,
                msg: '请输入数量',
                bg: '#AE81FF',
                time: 2
            });
            $("#INCOUNT").focus();
            return false;
        }

        if(!point.test($("#INCOUNT").val()))
        {
            $("#INCOUNT").tips({
                side: 3,
                msg: '请输入正确的数量',
                bg: '#AE81FF',
                time: 2
            });
            $("#INCOUNT").focus();
            return false;
        }

        if ($("#PRICE").val() == "") {
            $("#PRICE").tips({
                side: 3,
                msg: '请输入单价',
                bg: '#AE81FF',
                time: 2
            });
            $("#PRICE").focus();
            return false;
        }

        if(!point.test($("#PRICE").val()))
        {
            $("#PRICE").tips({
                side: 3,
                msg: '请输入正确的单价',
                bg: '#AE81FF',
                time: 2
            });
            $("#PRICE").focus();
            return false;
        }

        if ($("#ZPRICE").val() == "") {
            $("#ZPRICE").tips({
                side: 3,
                msg: '请输入总价',
                bg: '#AE81FF',
                time: 2
            });
            $("#ZPRICE").focus();
            return false;
        }

        if(!point.test($("#ZPRICE").val()))
        {
            $("#ZPRICE").tips({
                side: 3,
                msg: '请输入正确的总价',
                bg: '#AE81FF',
                time: 2
            });
            $("#ZPRICE").focus();
            return false;
        }

        if ($("#BZ").val() == "") {
            $("#BZ").tips({
                side: 3,
                msg: '请输入备注',
                bg: '#AE81FF',
                time: 2
            });
            $("#BZ").focus();
            return false;
        }
        $("#Form").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
    }

    //修改
    function edit() {

        if ($("#GOODS_NAME").val() == "") {
            $("#GOODS_NAME").tips({
                side: 3,
                msg: '请填写商品名称',
                bg: '#AE81FF',
                time: 2
            });
            $("#GOODS_NAME").focus();
            return false;
        }


        if ($("#INCOUNT").val() == "") {
            $("#INCOUNT").tips({
                side: 3,
                msg: '请输入数量',
                bg: '#AE81FF',
                time: 2
            });
            $("#INCOUNT").focus();
            return false;
        }
        if(!point.test($("#INCOUNT").val()))
        {
            $("#INCOUNT").tips({
                side: 3,
                msg: '请输入正确的数量',
                bg: '#AE81FF',
                time: 2
            });
            $("#INCOUNT").focus();
            return false;
        }

        if ($("#PRICE").val() == "") {
            $("#PRICE").tips({
                side: 3,
                msg: '请输入单价',
                bg: '#AE81FF',
                time: 2
            });
            $("#PRICE").focus();
            return false;
        }

        if(!point.test($("#PRICE").val()))
        {
            $("#PRICE").tips({
                side: 3,
                msg: '请输入正确的单价',
                bg: '#AE81FF',
                time: 2
            });
            $("#PRICE").focus();
            return false;
        }

        if ($("#ZPRICE").val() == "") {
            $("#ZPRICE").tips({
                side: 3,
                msg: '请输入总价',
                bg: '#AE81FF',
                time: 2
            });
            $("#ZPRICE").focus();
            return false;
        }


        if(!point.test($("#ZPRICE").val()))
        {
            $("#ZPRICE").tips({
                side: 3,
                msg: '请输入正确的总价',
                bg: '#AE81FF',
                time: 2
            });
            $("#ZPRICE").focus();
            return false;
        }
        if ($("#BZ").val() == "") {
            $("#BZ").tips({
                side: 3,
                msg: '请输入备注',
                bg: '#AE81FF',
                time: 2
            });
            $("#BZ").focus();
            return false;
        }
        $("#Form").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
    }

</script>
</body>
</html>
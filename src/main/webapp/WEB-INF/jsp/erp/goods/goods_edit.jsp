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

                        <form action="goods/${msg }.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="GOODS_ID" id="GOODS_ID" value="${pd.GOODS_ID}"/>
                            <input type="hidden" name="KUCUN_ID" id="KUCUN_ID" value="${pd.KUCUN_ID}"/>
                            <textarea name="DESCRIPTION" id="DESCRIPTION"
                                      style="display:none">${pd.DESCRIPTION}</textarea>
                            <div id="zhongxin" style="padding-top: 13px;">
                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">商品名称:</td>
                                        <td colspan="10">
                                            <c:if test="${pd.TITLE == null || pd.TITLE ==''}">
                                                <select class="chosen-select form-control" name="GOODS_ID" id="GOODS"
                                                        data-placeholder="请选择商品" style="vertical-align:top;width:98%;"
                                                        onchange="getGoods(this.value);">
                                                    <option value="">--商品名称--</option>
                                                    <c:forEach items="${goodsList}" var="var">
                                                        <option value="${var.GOODS_ID }"
                                                                <c:if test="${var.GOODS_ID == pd.GOODS_ID }">selected</c:if>>${var.GOODS_NAME }</option>
                                                    </c:forEach>
                                                </select>
                                            </c:if>
                                            <c:if test="${pd.TITLE != null && pd.TITLE !=''}">
                                                <input type="text" name="TITLE" id="TITLE" value="${pd.TITLE}" readonly
                                                       maxlength="30" title="商品名称"
                                                       style="vertical-align:top;width:98%;"/>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">商品编码:</td>
                                        <td><input type="text" name="BIANMA" id="BIANMA" value="${pd.BIANMA}"
                                                   maxlength="30" placeholder="上一个商品编码为${pd.LASTBIANMA}" title="商品编码"
                                                   style="width:98%;"/></td>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">商品品牌:</td>
                                        <td>
                                            <select class="chosen-select form-control" name="SPBRAND_ID" id="SPBRAND_ID"
                                                    data-placeholder="请选择品牌" style="vertical-align:top;width:210px;">
                                                <option value="">无品牌</option>
                                                <c:forEach items="${spbrandList}" var="var">
                                                    <option value="${var.SPBRAND_ID }"
                                                            <c:if test="${var.SPBRAND_ID == pd.SPBRAND_ID }">selected</c:if>>${var.NAME }</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">商品类别:</td>
                                        <td>
                                            <select class="chosen-select form-control" name="SPTYPE_ID" id="SPTYPE_ID"
                                                    data-placeholder="请选择商品类别" style="vertical-align:top;width:210px;">
                                                <option value="">无分类</option>
                                                <c:forEach items="${sptypeList}" var="var">
                                                    <option value="${var.SPTYPE_ID }"
                                                            <c:if test="${var.SPTYPE_ID == pd.SPTYPE_ID }">selected</c:if>>${var.NAME }</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">计量单位:</td>
                                        <td>
                                            <select class="chosen-select form-control" name="SPUNIT_ID" id="SPUNIT_ID"
                                                    data-placeholder="请选择计量单位" style="vertical-align:top;width:210px;">
                                                <option value="">无</option>
                                                <c:forEach items="${spunitList}" var="var">
                                                    <option value="${var.SPUNIT_ID }"
                                                            <c:if test="${var.SPUNIT_ID == pd.SPUNIT_ID }">selected</c:if>>${var.NAME }</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">仓库库存:</td>
                                        <td><input type="text" name="ZCOUNT" id="ZCOUNT" value="${pd.ZCOUNT}"
                                                   maxlength="30" title="商品库存量" readonly
                                                   style="width:98%;"/></td>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">商品成本:</td>
                                        <td><input type="text" name="PRICE" id="PRICE" value="${pd.PRICE}"
                                                   maxlength="30" title="商品成本价" readonly
                                                   style="width:89%;"/>&nbsp;元
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">上架数量:</td>
                                        <td><input type="text" name="GCOUNT" id="GCOUNT" value="${pd.GCOUNT}"
                                                   maxlength="30" title="商品上架数量"
                                                   style="width:98%;"/></td>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">商品现价:</td>
                                        <td><input type="text" name="GPRICE" id="GPRICE" value="${pd.GPRICE}"
                                                   maxlength="30" title="商品价格"
                                                   style="width:89%;"/>&nbsp;元
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;height:190px; text-align: right;padding-top: 13px;">
                                            商品描述:
                                        </td>
                                        <td colspan="10">
                                            <script id="editor" type="text/plain"
                                                    class="plainstyle">${pd.DESCRIPTION}</script>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">商品简述:</td>
                                        <td colspan="10">
                                            <textarea rows="" cols="" name="SHORTDESC" id="SHORTDESC"
                                                      style="width:98%;">${pd.SHORTDESC}</textarea>
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

<c:if test="${'edit' == msg }">
    <div>
        <iframe name="treeFrame" id="treeFrame" frameborder="0"
                src="<%=basePath%>/goodsmx/list.do?MASTER_ID=${pd.GOODS_ID}"
                style="margin:0 auto;width:805px;height:368px;;"></iframe>
    </div>
</c:if>

<footer>
    <c:if test="${'save' == msg }">
        <div style="width: 100%;padding-bottom: 2px;" class="center">
            <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
            <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
        </div>
    </c:if>
    <c:if test="${'edit' == msg }">
        <div style="width: 100%;padding-bottom: 2px;" class="center">
            <a class="btn btn-mini btn-primary" onclick="edit('${pd.GCOUNT}','${pd.BIANMA}');">保存</a>
            <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
        </div>
    </c:if>

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

    //通过商品id读取数据
    function getGoods(id) {
        $.ajax({
            type: "POST",
            url: 'goods/getById.do',
            data: {GOODS_ID: id},
            dataType: 'json',
            cache: false,
            success: function (data) {
                if ("success" == data.result) {
                    $("#GOODS_ID").val(data.pd.GOODS_ID);
                    $("#SPBRAND_ID").val(data.pd.SPBRAND_ID);
                    $("#SPTYPE_ID").val(data.pd.SPTYPE_ID);
                    $("#SPUNIT_ID").val(data.pd.SPUNIT_ID);
                    $("#ZCOUNT").val(data.pd.ZCOUNT);
                    $("#PRICE").val(data.pd.PRICE);
                    $("#KUCUN_ID").val(data.pd.KUCUN_ID);
                } else {
                    $("#GOODS").tips({
                        side: 3,
                        msg: "此商品不存在",
                        bg: '#FF5080',
                        time: 15
                    });
                }
            }
        });
    }


    //保存
    function save() {
        if ($("#TITLE").val() == "") {
            $("#TITLE").tips({
                side: 3,
                msg: '请输入商品名称',
                bg: '#AE81FF',
                time: 2
            });
            $("#TITLE").focus();
            return false;
        }
        if ($("#GOODS").val() == "") {
            $("#GOODS").tips({
                side: 3,
                msg: '请输入商品名称',
                bg: '#AE81FF',
                time: 2
            });
            $("#GOODS").focus();
            return false;
        }
        if ($("#BIANMA").val() == "") {
            $("#BIANMA").tips({
                side: 3,
                msg: '请输入商品编码',
                bg: '#AE81FF',
                time: 2
            });
            $("#BIANMA").focus();
            return false;
        }
        $("#DESCRIPTION").val(getContent());
        if ($("#DESCRIPTION").val() == "") {
            $("#DESCRIPTION").tips({
                side: 3,
                msg: '请输入商品描述',
                bg: '#AE81FF',
                time: 2
            });
            $("#DESCRIPTION").focus();
            return false;
        }
        if ($("#SHORTDESC").val() == "") {
            $("#SHORTDESC").tips({
                side: 3,
                msg: '请输入简述',
                bg: '#AE81FF',
                time: 2
            });
            $("#SHORTDESC").focus();
            return false;
        }
        var zcount = $("#ZCOUNT").val();
        var gcount = $("#GCOUNT").val();
        var a = (zcount - gcount).toFixed(2);
        if (a < 0.00) {
            $("#GCOUNT").tips({
                side: 3,
                msg: '上架数量不能大于库存数量',
                bg: '#AE81FF',
                time: 2
            });
            $("#GCOUNT").focus();
            return false;
        }

        $.ajax({
            type: "POST",
            url: 'goods/findsameBm.do',
            data: {BIANMA: $("#BIANMA").val(), GOODS_ID: $("#GOODS_ID").val()},
            dataType: 'json',
            cache: false,
            success: function (data) {
                if ("success" == data.result) {
                    $("#Form").submit();
                    $("#zhongxin").hide();
                    $("#zhongxin2").show();
                }
                if ("IDerror" == data.result) {
                    $("#GOODS").tips({
                        side: 3,
                        msg: '该商品已经上架，请直接修改',
                        bg: '#FF5080',
                        time: 15
                    });
                    $("#GOODS").focus();
                    return false;
                } else {
                    $("#BIANMA").tips({
                        side: 3,
                        msg: "此商品编号已被使用,请关闭窗口后重试",
                        bg: '#FF5080',
                        time: 15
                    });
                    $("#BIANMA").focus();
                    return false;
                }
            }
        });
    }

        //修改
        function edit(old,BIANMA) {
            if ($("#TITLE").val() == "") {
                $("#TITLE").tips({
                    side: 3,
                    msg: '请输入商品名称',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#TITLE").focus();
                return false;
            }
            if ($("#GOODS").val() == "") {
                $("#GOODS").tips({
                    side: 3,
                    msg: '请输入商品名称',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#GOODS").focus();
                return false;
            }
            if ($("#BIANMA").val() == "") {
                $("#BIANMA").tips({
                    side: 3,
                    msg: '请输入商品编码',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#BIANMA").focus();
                return false;
            }
            $("#DESCRIPTION").val(getContent());
            if ($("#DESCRIPTION").val() == "") {
                $("#DESCRIPTION").tips({
                    side: 3,
                    msg: '请输入商品描述',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#DESCRIPTION").focus();
                return false;
            }
            if ($("#SHORTDESC").val() == "") {
                $("#SHORTDESC").tips({
                    side: 3,
                    msg: '请输入简述',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#SHORTDESC").focus();
                return false;
            }
            var zcount = $("#ZCOUNT").val();
            var gcount = $("#GCOUNT").val();
            var count = (gcount - old).toFixed(2);
            var newcount = (zcount - count).toFixed(2);
            if (newcount < 0.00) {
                $("#GCOUNT").tips({
                    side: 3,
                    msg: '添加的商品数量不能大于库存数量',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#GCOUNT").focus();
                return false;
            }

                if (BIANMA != $("#BIANMA").val()) {
                    $.ajax({
                        type: "POST",
                        url: 'goods/changeBm.do',
                        data: {BIANMA: $("#BIANMA").val()},
                        dataType: 'json',
                        cache: false,
                        success: function (data) {
                            if ("success" == data.result) {
                                $("#Form").submit();
                                $("#zhongxin").hide();
                                $("#zhongxin2").show();
                            } else {
                                $("#BIANMA").tips({
                                    side: 3,
                                    msg: "此商品编号已被使用,请关闭窗口后重试",
                                    bg: '#FF5080',
                                    time: 15
                                });
                                $("#BIANMA").focus();
                                return false;
                            }
                        }
                    });
                }
                else {
                    $("#Form").submit();
                    $("#zhongxin").hide();
                    $("#zhongxin2").show();
                }
    }
    $(function () {
        //日期框
        $('.date-picker').datepicker({autoclose: true, todayHighlight: true});
    });

    //百度富文本
    setTimeout("ueditor()", 500);
    function ueditor() {
        UE.getEditor('editor');
    }

    //ueditor有标签文本
    function getContent() {
        var arr = [];
        arr.push(UE.getEditor('editor').getContent());
        return arr.join("");
    }

</script>
</body>
</html>
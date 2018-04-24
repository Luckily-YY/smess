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

                        <form action="outku/${msg }.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="OUTKU_ID" id="OUTKU_ID" value="${pd.OUTKU_ID}"/>
                            <input type="hidden" name="KUCUN_ID" id="KUCUN_ID" value="${pd.KUCUN_ID}"/>
                            <input type="hidden" name="GOODS_ID" id="GOODS_ID" value="${pd.GOODS_ID}"/>

                            <div id="zhongxin" style="padding-top: 13px;">
                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">商品名称:</td>
                                        <td>
                                                <input type="text" name="GOODS_NAME" id="GOODS_NAME" value="${pd.GOODS_NAME}" readonly
                                                       maxlength="30" title="商品名称"
                                                       style="vertical-align:top;width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">仓库库存:</td>
                                        <td><input type="text" name="ZCOUNT" id="ZCOUNT" value="${pd.ZCOUNT}"
                                                   maxlength="30" title="商品库存量" readonly
                                                   style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">原价:</td>
                                        <td><input type="text" name="PRICE" id="PRICE" value="${pd.PRICE}"
                                                   maxlength="30" title="商品原价" readonly
                                                   style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">现价:</td>
                                        <td>
                                            <input onblur="jisuanz();" type="text" name="OUTPRICE" id="OUTPRICE" value="${pd.OUTPRICE}"
                                                   maxlength="30" title="出售价格"
                                                   style="vertical-align:top;width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">数量:</td>
                                        <td>
                                            <input onblur="jisuanz();" type="text" name="OUTCOUNT" id="OUTCOUNT" value="${pd.OUTCOUNT}"
                                                   maxlength="30" title="销售数量"
                                                   style="vertical-align:top;width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">总价:</td>
                                        <td>
                                            <input type="text" name="ZPRICE" id="ZPRICE" value="${pd.ZPRICE}"
                                                   maxlength="30" title="销售总额" readonly
                                                   style="width:98%;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
                                        <td>
                                            <input type="text" name="BZ" id="BZ" value="${pd.BZ}"
                                                   maxlength="30" title="订单备注"
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

<c:if test="${'edit' == msg }">
    <div>
        <iframe name="treeFrame" id="treeFrame" frameborder="0"
                src="<%=basePath%>/goodsmx/list.do?MASTER_ID=${pd.GOODS_ID}"
                style="margin:0 auto;width:805px;height:368px;;"></iframe>
    </div>
</c:if>

<footer>
    <c:if test="${'chooseSave' == msg }">
        <div style="width: 100%;padding-bottom: 2px;" class="center">
            <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
            <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
        </div>
    </c:if>
    <c:if test="${'chooseEdit' == msg }">
        <div style="width: 100%;padding-bottom: 2px;" class="center">
            <a class="btn btn-mini btn-primary" onclick="edit();">保存</a>
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

    var point=/^\d*\.{0,1}\d{0,1}\d{0,1}$/;  //两位小数
    var number=/^\d*$/; //纯数字

    //保存
    function save() {
        if ($("#GOODS_ID").val() == "") {
            $("#GOODS_ID").tips({
                side: 3,
                msg: '请输入商品名称',
                bg: '#AE81FF',
                time: 2
            });
            $("#GOODS_ID").focus();
            return false;
        }
        if ($("#OUTPRICE").val() == "") {
            $("#OUTPRICE").tips({
                side: 3,
                msg: '请输入商品出售价格',
                bg: '#AE81FF',
                time: 2
            });
            $("#OUTPRICE").focus();
            return false;
        }

        if(!point.test($("#OUTPRICE").val())){
            $("#OUTPRICE").tips({
                side: 3,
                msg: '请输入正确的出售价格',
                bg: '#AE81FF',
                time: 2
            });
            $("#OUTPRICE").focus();
            return false;
        }

        if ($("#OUTCOUNT").val() == "") {
            $("#OUTCOUNT").tips({
                side: 3,
                msg: '请输入商品出售数量',
                bg: '#AE81FF',
                time: 2
            });
            $("#OUTCOUNT").focus();
            return false;
        }

        if(!point.test($("#OUTCOUNT").val())){
            $("#OUTCOUNT").tips({
                side: 3,
                msg: '请输入正确的销售数量',
                bg: '#AE81FF',
                time: 2
            });
            $("#OUTCOUNT").focus();
            return false;
        }

        var OUTCOUNT = Number("" == $("#OUTCOUNT").val() ? "0" : $("#OUTCOUNT").val());
        var OUTPRICE = Number("" == $("#OUTPRICE").val() ? "0" : $("#OUTPRICE").val());

        if (0 - OUTCOUNT > 0) {
            $("#OUTCOUNT").tips({
                side: 3,
                msg: '数量不能小于零',
                bg: '#AE81FF',
                time: 2
            });
            $("#OUTCOUNT").focus();
            return false;
        }
        if (0 - OUTPRICE > 0) {
            $("#OUTPRICE").tips({
                side: 3,
                msg: '单价不能小于零',
                bg: '#AE81FF',
                time: 2
            });
            $("#OUTPRICE").focus();
            return false;
        }
        $("#ZPRICE").val(OUTCOUNT * OUTPRICE);


        $.ajax({
            type: "POST",
            url: 'goods/getById.do',
            data: {GOODS_ID: $("#GOODS_ID").val()},
            dataType: 'json',
            cache: false,
            success: function (data) {
                if ("success" == data.result) {
                    $("#ZCOUNT").val(data.pd.ZCOUNT);
                } else {
                    $("#GOODS_NAME").tips({
                        side: 3,
                        msg: "此商品不存在",
                        bg: '#FF5080',
                        time: 15
                    });
                }
            }
        });

        var zcount = $("#ZCOUNT").val();
        var outcount = $("#OUTCOUNT").val();
        var a = (zcount - outcount).toFixed(2);
        if (a < 0.00) {
            $("#OUTCOUNT").tips({
                side: 3,
                msg: '出售数量不能大于库存数量',
                bg: '#AE81FF',
                time: 2
            });
            $("#OUTCOUNT").focus();
            return false;
        }
        else {
            $("#Form").submit();
            $("#zhongxin").hide();
            $("#zhongxin2").show();
            diag.close();
        }

    }

        //修改
        function edit() {
            if ($("#GOODS_ID").val() == "") {
                $("#GOODS_ID").tips({
                    side: 3,
                    msg: '请输入商品名称',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#GOODS_ID").focus();
                return false;
            }
            if ($("#OUTPRICE").val() == "") {
                $("#OUTPRICE").tips({
                    side: 3,
                    msg: '请输入商品出售价格',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#OUTPRICE").focus();
                return false;
            }

            if(!point.test($("#OUTPRICE").val())){
                $("#OUTPRICE").tips({
                    side: 3,
                    msg: '请输入正确的出售价格',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#OUTPRICE").focus();
                return false;
            }

            if ($("#OUTCOUNT").val() == "") {
                $("#OUTCOUNT").tips({
                    side: 3,
                    msg: '请输入商品出售数量',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#OUTCOUNT").focus();
                return false;
            }
            if(!point.test($("#OUTCOUNT").val())){
                $("#OUTCOUNT").tips({
                    side: 3,
                    msg: '请输入正确的出售数量',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#OUTCOUNT").focus();
                return false;
            }

            var OUTCOUNT = Number("" == $("#OUTCOUNT").val() ? "0" : $("#OUTCOUNT").val());
            var OUTPRICE = Number("" == $("#OUTPRICE").val() ? "0" : $("#OUTPRICE").val());

            if (0 - OUTCOUNT > 0) {
                $("#OUTCOUNT").tips({
                    side: 3,
                    msg: '数量不能小于零',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#OUTCOUNT").focus();
                return false;
            }
            if (0 - OUTPRICE > 0) {
                $("#OUTPRICE").tips({
                    side: 3,
                    msg: '单价不能小于零',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#OUTPRICE").focus();
                return false;
            }
            $("#ZPRICE").val(OUTCOUNT * OUTPRICE);

            $.ajax({
                type: "POST",
                url: 'goods/getById.do',
                data: {GOODS_ID: $("#GOODS_ID").val()},
                dataType: 'json',
                cache: false,
                success: function (data) {
                    if ("success" == data.result) {
                        $("#ZCOUNT").val(data.pd.ZCOUNT);
                    } else {
                        $("#GOODS_NAME").tips({
                            side: 3,
                            msg: "此商品不存在",
                            bg: '#FF5080',
                            time: 15
                        });
                    }
                }
            });

            var zcount = $("#ZCOUNT").val();
            var outcount = $("#OUTCOUNT").val();
            var a = (zcount - outcount).toFixed(2);
            if (a < 0.00) {
                $("#OUTCOUNT").tips({
                    side: 3,
                    msg: '出售数量不能大于库存数量',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#OUTCOUNT").focus();
                return false;
            }
            else {
                $("#Form").submit();
                $("#zhongxin").hide();
                $("#zhongxin2").show();
                diag.close();
            }
    }



    $(top.hangge());

    //计算总价
    function jisuanz() {
        var OUTCOUNT = Number("" == $("#OUTCOUNT").val() ? "0" : $("#OUTCOUNT").val());
        var OUTPRICE = Number("" == $("#OUTPRICE").val() ? "0" : $("#OUTPRICE").val());
        if (0 - OUTCOUNT > 0) {
            $("#OUTCOUNT").tips({
                side: 3,
                msg: '数量不能小于零',
                bg: '#AE81FF',
                time: 2
            });
            $("#OUTCOUNT").focus();
            return false;
        }
        if (0 - OUTPRICE > 0) {
            $("#OUTPRICE").tips({
                side: 3,
                msg: '单价不能小于零',
                bg: '#AE81FF',
                time: 2
            });
            $("#OUTPRICE").focus();
            return false;
        }
        $("#ZPRICE").val(OUTCOUNT * OUTPRICE);
    }


</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
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

                    <div class="row-fluid col-xs-10">
                        <div class="span12">
                            <div class="widget-box">
                                <div class="widget-header widget-header-blue widget-header-flat">
                                    <h4 class="lighter">前台销售</h4>
                                </div>
                                <form action="sale/addsale.do" name="Form" id="Form" method="post">
                                    <div class="widget-body" style="height: 180px;">
                                        <div class="widget-main">
                                            <input type="hidden" name="GOODS_ID" id="GOODS_ID"/>
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label no-padding-right"
                                                           style="font-size: 16px;">商品编码：</label>

                                                    <div class="nav-search">
										<span class="input-icon">
											<input type="text" name="GOODS_BM" id="GOODS_BM"
                                                   class="nav-search-input form-control form-control input-lg"
                                                   placeholder="模拟扫描商品编码" style="min-width: 240px;"
                                                   onchange="getGoods(this.value);"/>
											<i class="ace-icon fa fa-leaf icon-leaf green"></i>
										</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label no-padding-right"
                                                           style="font-size: 16px;">商品名称：</label>

                                                    <div class="nav-search">
										<span class="input-icon">
											<input type="text" name="GOODS_NAME" id="GOODS_NAME"
                                                   class="nav-search-input form-control form-control input-lg"
                                                   style="min-width: 240px;"/>
											<i class="ace-icon fa fa-newspaper-o green"></i>
										</span>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label no-padding-right"
                                                           style="font-size: 16px;">商品数目：</label>

                                                    <div class="nav-search">
										<span class="input-icon">
											<input type="text" name="GOODS_COUNT" id="GOODS_COUNT"
                                                   class="nav-search-input form-control form-control input-lg"
                                                   value="1" style="min-width: 240px;" onchange="getPrice();"/>
											<i class="ace-icon fa fa-magic green"></i>
										</span>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label no-padding-right"
                                                           style="font-size: 16px;">商品单价：</label>

                                                    <div class="nav-search">
										<span class="input-icon">
											<input type="text" name="PRICE" id="PRICE"
                                                   class="nav-search-input form-control form-control input-lg"
                                                   style="min-width: 240px;"/>
											<i class="ace-icon fa fa-asterisk green"></i>
										</span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label no-padding-right"
                                                           style="font-size: 16px;">打折优惠：</label>

                                                    <div class="nav-search">
										<span class="input-icon">
											<input type="text" name="ZHEKOU" id="ZHEKOU"
                                                   class="nav-search-input form-control form-control input-lg"
                                                   value="10.0" style="min-width: 240px;" onchange="getZheKou();"/>
											<i class="ace-icon fa fa-anchor green"></i>
										</span>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label no-padding-right"
                                                           style="font-size: 16px;">购买总价：</label>

                                                    <div class="nav-search">
										<span class="input-icon">
											<input type="text" name="Z_PRICE" id="Z_PRICE"
                                                   class="nav-search-input form-control form-control input-lg"
                                                   style="min-width: 240px;" readonly/>
											<i class="ace-icon fa fa-shopping-cart green"></i>
										</span>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="col-xs-11" align="right" style="padding-right: 25px">
                                                <a id="add" class="btn btn-mini btn-purple" onclick="add();">确认商品</a>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="row-fluid col-xs-10">
                        <div class="widget-box" style="height:250px;">
                            <div class="widget-header widget-header-blue widget-header-flat">
                                <h4 class="lighter">购物车清单</h4>
                            </div>
                            <c:if test="${fn:length(varList) == 1 || fn:length(varList) == 0}">
                                <select class="form-control" id="form-field-select-2" multiple="multiple"
                                        style="height: 40px;border-bottom:0px; " onclick="del(this.value);">
                                    <c:forEach items="${varList}" var="var">
                                        <option value="${var.SALE_ID }">
                                           ${var.GOODS_NAME }***(&nbsp;数目:&nbsp;${var.SALECOUNT }&nbsp;)
                                               -----------------------&nbsp;${var.ZPRICE}
                                        </option>
                                    </c:forEach>
                                </select>
                            </c:if>
                            <c:if test="${fn:length(varList) > 1}">
                                <select class="form-control" id="form-field-select-2" multiple="multiple"
                                        style="height: 210px" onchange="del(this.value);">
                                    <c:forEach items="${varList}" var="var">
                                        <option value="${var.SALE_ID }">
                                           ${var.GOODS_NAME }***(&nbsp;数目:&nbsp;${var.SALECOUNT }&nbsp;)
                                               -----------------------&nbsp;${var.ZPRICE}
                                        </option>
                                    </c:forEach>
                                </select>
                            </c:if>
                        </div>
                        <div align="right">
                            <a class="btn btn-mini btn-purple" onclick="ddpirnt();">打印清单</a>
                        </div>
                    </div>

                </div>
                <!-- /.row -->
            </div>
            <!-- /.page-content -->
        </div>
    </div>
    <!-- /.main-content -->
</div>
<!-- /.main-container -->

<!-- basic scripts -->
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp" %>
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
    $(top.hangge());//关闭加载状态

    var point=/^\d*\.{0,1}\d{0,1}\d{0,1}$/;  //两位小数
    var number=/^\d*$/; //纯数字

    /*获取该编码的详细信息
     * */
    function getGoods(bianma) {
        if($("#GOODS_BM").val() == ""){
            $("#GOODS_BM").tips({
                side: 3,
                msg: '请输入编码',
                bg: '#AE81FF',
                time: 2
            });
            $("#GOODS_BM").focus();
            return false;
        }

        if(!number.test($("#GOODS_BM").val()))
        {
            $("#GOODS_BM").tips({
                side: 3,
                msg: '请输入正确格式的编码',
                bg: '#AE81FF',
                time: 2
            });
            $("#GOODS_BM").focus();
            return false;
        }

        if ($("#GOODS_BM").val().length == 10 || $("#GOODS_BM").val().length == 12) {
            if ($("#GOODS_BM").val().length == 10) {
                $.ajax({
                    type: "POST",
                    url: 'sale/getGoods.do',
                    data: {BIANMA: bianma},
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        if ("success" == data.result) {
                            $("#GOODS_NAME").val(data.pd.GOODS_NAME);
                            $("#PRICE").val(data.pd.PRICE);
                            $("#GOODS_ID").val(data.pd.GOODS_ID);
                            var count = Number("" == $("#GOODS_COUNT").val() ? "0" : $("#GOODS_COUNT").val());
                            var price = Number("" == $("#PRICE").val() ? "0" : $("#PRICE").val());
                            $("#Z_PRICE").val(count * price);
                        } else {
                            $("#GOODS_BM").tips({
                                side: 3,
                                msg: "此商品不存在",
                                bg: '#FF5080',
                                time: 8
                            });
                        }
                    }
                });
            }

            if ($("#GOODS_BM").val().length == 12) {
                $.ajax({
                    type: "POST",
                    url: 'sale/getWeight.do',
                    data: {WBIANMA: bianma},
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        if ("success" == data.result) {
                            $("#PRICE").val(data.pd.PRICE);
                            $("#GOODS_COUNT").val(data.pd.GOODS_COUNT);
                            $("#GOODS_NAME").val(data.pd.GOODS_NAME);
                            $("#GOODS_ID").val(data.pd.GOODS_ID);
                            $("#Z_PRICE").val(data.pd.Z_PRICE);
                        } else {
                            $("#GOODS_BM").tips({
                                side: 3,
                                msg: "此商品不存在",
                                bg: '#FF5080',
                                time: 8
                            });
                        }
                    }
                });
            }
        }

        else {
            $("#GOODS_BM").tips({
                side: 3,
                msg: '编码长度只能是10位或者12位',
                bg: '#AE81FF',
                time: 2
            });
            $("#GOODS_BM").focus();
            return false;
        }


    }

    function del(id) {
        swal({
                title: "确定操作",
                text: "你确定要删除该清单吗？",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: '#00FF00',
                confirmButtonText: 'sure'
            },
            function () {
                window.location.href = "${pageContext.request.contextPath}/sale/delsale.do?SALE_ID=" + id;
            });
    }


    /*单价乘以数量
     * */
    function getPrice() {
        var count = Number("" == $("#GOODS_COUNT").val() ? "0" : $("#GOODS_COUNT").val());
        var price = Number("" == $("#PRICE").val() ? "0" : $("#PRICE").val());
        var newprice = (count * price).toFixed(2);
        $("#Z_PRICE").val(newprice);
    }

    /*总价乘以折扣
     * */
    function getZheKou() {
        var zhekou = Number("" == $("#ZHEKOU").val() ? "0" : $("#ZHEKOU").val());
        var zprice = Number("" == $("#Z_PRICE").val() ? "0" : $("#Z_PRICE").val());
        var newprice = (zhekou * zprice * 0.1).toFixed(2);
        $("#Z_PRICE").val(newprice);
    }

    /*录入购物清单
     * */
    function add() {
        if ($("#GOODS_BM").val() == "") {
            $("#GOODS_BM").tips({
                side: 3,
                msg: '请输入编码',
                bg: '#AE81FF',
                time: 2
            });
            $("#GOODS_BM").focus();
            return false;
        }

        if(!number.test($("#GOODS_BM").val()))
        {
            $("#GOODS_BM").tips({
                side: 3,
                msg: '请输入正确格式的编码',
                bg: '#AE81FF',
                time: 2
            });
            $("#GOODS_BM").focus();
            return false;
        }

        if ($("#GOODS_NAME").val() == "") {
            $("#GOODS_NAME").tips({
                side: 3,
                msg: '请输入商品名称',
                bg: '#AE81FF',
                time: 2
            });
            $("#GOODS_NAME").focus();
            return false;
        }
        if ($("#PRICE").val() == "") {
            $("#PRICE").tips({
                side: 3,
                msg: '请输入商品单价',
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
                msg: '请输入正确格式的单价',
                bg: '#AE81FF',
                time: 2
            });
            $("#PRICE").focus();
            return false;
        }

        $("#Form").submit();
    }

    //打印清单
    function ddpirnt() {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "打印清单";
        diag.URL = '<%=basePath%>sale/ddpirnt.do?';
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
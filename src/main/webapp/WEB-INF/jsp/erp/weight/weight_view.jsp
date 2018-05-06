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
                                    <h4 class="lighter">前台称量</h4>
                                </div>
                                <table style="margin-top:8px;" align="center">
                                    <tr style="height: 90px;">
                                        <td style="width:105px;text-align: left;font-size: 22px;">手动选择:</td>
                                        <td id="xzsp">
                                            <select onchange="setGoogsName(this.value);" class="form-control"
                                                    name="SGOODS_ID" id="SGOODS_ID"
                                                    style="vertical-align:top;width:300px;min-height: 38px;">
                                                <option value="">请选择商品(若录入商品编码则无需选择)</option>
                                                <c:forEach items="${goodsList}" var="var">
                                                    <option value="${var.GOODS_ID }" style="min-height: 30px;" <c:if
                                                            test="${var.GOODS_ID == pd.GOODS_ID }">
                                                        selected</c:if>>${var.TITLE }&nbsp;(${var.NAME })
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </td>

                                    </tr>
                                    <tr style="height: 90px;">

                                        <td style="width:105px;text-align: left;font-size: 22px;">商品编码:</td>
                                        <td>
                                            <div class="nav-search">
										<span class="input-icon">
											<input type="text" name="GOODS_BM" id="GOODS_BM"
                                                   class="nav-search-input "
                                                   placeholder="请输入商品编码"
                                                   style="min-width: 300px;min-height: 42px;font-size: 22px;"
                                                   onchange="getGoods(this.value);"/>
											<i class="ace-icon fa fa-search nav-search-icon" style="top: 9px;"></i>
										</span>
                                            </div>
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td style="width:105px;text-align: left;font-size: 22px;">商品名称:</td>
                                        <td>
                                            <div class="nav-search">
										<span class="input-icon">
											<input type="text" name="GOODS_NAME" id="GOODS_NAME"
                                                   class="nav-search-input " readonly
                                                   style="min-width: 300px;min-height: 42px;font-size: 22px;"/>
											<i class="ace-icon fa fa-search nav-search-icon" style="top: 9px;"></i>
										</span>
                                            </div>
                                        </td>

                                    </tr>

                                    <tr style="height: 90px;">
                                        <td style="width:105px;text-align: left;font-size: 22px;">商品单价:</td>
                                        <td>
                                            <div class="nav-search">
										<span class="input-icon">
											<input type="text" name="GOODS_PRICE" id="GOODS_PRICE"
                                                   class="nav-search-input " readonly
                                                   style="min-width: 300px;min-height: 42px;font-size: 22px;"/>
											<i class="ace-icon fa fa-newspaper-o purple" style="top: 9px;"></i>
										</span>
                                            </div>
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </td>

                                        <td style="width:105px;text-align: left;font-size: 22px;">商品重量:</td>
                                        <td id="xzsp">
                                            <div class="nav-search">
										<span class="input-icon">
											<input type="text" name="GOODS_WEIGHT" id="GOODS_WEIGHT"
                                                   class="nav-search-input "
                                                   placeholder="模拟获取商品重量"
                                                   style="min-width: 300px;min-height: 42px;font-size: 22px;"
                                                   onchange="getPrice(this.value);"/>
											<i class="ace-icon fa fa-magic green" style="top: 9px;"></i>
										</span>
                                            </div>
                                        </td>
                                    </tr>

                                    <tr style="height: 90px;">
                                        <td style="width:105px;text-align: left;font-size: 22px;">商品总价:</td>
                                        <td>
                                            <div class="nav-search">
										<span class="input-icon">
											<input type="text" name="GOODS_Z" id="GOODS_Z"
                                                   class="nav-search-input "
                                                   readonly style="min-width: 300px;min-height: 42px;font-size: 22px;"/>
											<i class="ace-icon fa fa-anchor green" style="top: 9px;"></i>
										</span>
                                            </div>
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </td>

                                        <td style="width:105px;text-align: left;font-size: 22px;">称量编码:</td>
                                        <td id="xzsp">
                                            <div class="nav-search">
										<span class="input-icon">
											<input type="text" name="WBIANMA" id="WBIANMA"
                                                   class="nav-search-input "
                                                   placeholder="上一个编码${pd.WBIANMA}"
                                                   style="min-width: 300px;min-height: 42px;font-size: 22px;"/>
											<i class="ace-icon fa fa-shopping-cart purple" style="top: 9px;"></i>
										</span>
                                            </div>
                                        </td>
                                    </tr>

                                    <tr style="height: 60px;margin-bottom: 35px;">
                                        <td colspan="5" align="center">
                                            <a id="add" class="btn btn-purple" onclick="add();">打印信息条</a>
                                        <td>
                                    </tr>
                                </table>
                            </div>
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
    var gid = "";

    /*通过id获取信息
     * */
    function setGoogsName(id) {
        $.ajax({
            type: "POST",
            url: 'weight/getGoodsById.do',
            data: {GOODS_ID: id},
            dataType: 'json',
            cache: false,
            success: function (data) {
                if ("success" == data.result) {
                    $("#GOODS_BM").val(data.pd.BIANMA);
                    $("#GOODS_NAME").val(data.pd.TITLE);
                    $("#GOODS_PRICE").val(data.pd.GPRICE);
                    gid = data.pd.GOODS_ID;
                } else {
                    $("#SGOODS_ID").tips({
                        side: 3,
                        msg: "此商品不在称量范围内",
                        bg: '#FF5080',
                        time: 1
                    });
                }
            }
        });
    }


    /*获取该编码的详细信息
     * */
    function getGoods(bianma) {
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
        if($("#GOODS_BM").val().length != 10){
            $("#GOODS_BM").tips({
                side: 3,
                msg: '商品编码长度为10位',
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
        $.ajax({
            type: "POST",
            url: 'weight/getGoods.do',
            data: {BIANMA: bianma},
            dataType: 'json',
            cache: false,
            success: function (data) {
                if ("success" == data.result) {
                    $("#GOODS_NAME").val(data.pd.GOODS_NAME);
                    $("#GOODS_PRICE").val(data.pd.PRICE);
                    $("#SGOODS_ID").val(data.pd.GOODS_ID);
                    gid = data.pd.GOODS_ID;
                } else {
                    $("#GOODS_BM").tips({
                        side: 3,
                        msg: "此商品不在称量范围内",
                        bg: '#FF5080',
                        time: 1
                    });
                }
            }
        });

    }


    /*单价乘以数量
     * */
    function getPrice() {
        var count = Number("" == $("#GOODS_WEIGHT").val() ? "0" : $("#GOODS_WEIGHT").val());
        var price = Number("" == $("#GOODS_PRICE").val() ? "0" : $("#GOODS_PRICE").val());
        var newprice = (count * price).toFixed(2);
        $("#GOODS_Z").val(newprice);
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

        if ($("#GOODS_WEIGHT").val() == "") {
            $("#GOODS_WEIGHT").tips({
                side: 3,
                msg: '请输入商品重量',
                bg: '#AE81FF',
                time: 2
            });
            $("#GOODS_WEIGHT").focus();
            return false;
        }

        if(!point.test($("#GOODS_WEIGHT").val()))
        {
            $("#GOODS_WEIGHT").tips({
                side: 3,
                msg: '请输入正确格式的重量',
                bg: '#AE81FF',
                time: 2
            });
            $("#GOODS_WEIGHT").focus();
            return false;
        }

        if ($("#WBIANMA").val() == "") {
            $("#WBIANMA").tips({
                side: 3,
                msg: '请输入信息编码',
                bg: '#AE81FF',
                time: 2
            });
            $("#WBIANMA").focus();
            return false;
        }

        if ($("#WBIANMA").val().length != 12) {
            $("#WBIANMA").tips({
                side: 3,
                msg: '信息编码长度为12位',
                bg: '#AE81FF',
                time: 2
            });
            $("#WBIANMA").focus();
            return false;
        }
        if(!number.test($("#WBIANMA").val()))
        {
            $("#WBIANMA").tips({
                side: 3,
                msg: '请输入正确格式的编码',
                bg: '#AE81FF',
                time: 2
            });
            $("#WBIANMA").focus();
            return false;
        }


        var weight = $("#GOODS_WEIGHT").val();
        var zprice = $("#GOODS_Z").val();
        var price = $("#GOODS_PRICE").val();
        var bianma = $("#WBIANMA").val();
        var name = $("#GOODS_NAME").val();

        if(bianma.length != 12)
        {
            $("#WBIANMA").tips({
                side: 3,
                msg: "编号长度必须为12位",
                bg: '#FF5080',
                time: 3
            });
            $("#WBIANMA").focus();
            return false;
        }
        else
        {$.ajax({
            type: "POST",
            url: 'weight/findsameBm.do',
            data: {WBIANMA: bianma},
            dataType: 'json',
            cache: false,
            success: function (data) {
                if ("success" == data.result) {
                    ddpirnt(gid,weight,zprice,price,bianma,name);
                } else {
                    $("#WBIANMA").tips({
                        side: 3,
                        msg: "此编号已被使用,请刷新后重试",
                        bg: '#FF5080',
                        time: 6
                    });
                    $("#WBIANMA").focus();
                    return false;
                }
            }
        });}

    }



    //打印清单
    function ddpirnt(gid,weight,zprice,price,bianma,name) {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "打印信息条";
        diag.URL = '<%=basePath%>weight/ddpirnt.do?WPRICE='+price+
            '&GOODS_ID='+gid+'&WZPRICE='+zprice+'&WEIGHT='+weight+
            '&WBIANMA='+bianma+'&GOODS_NAME='+name;
        diag.Width = 450;
        diag.Height = 400;
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
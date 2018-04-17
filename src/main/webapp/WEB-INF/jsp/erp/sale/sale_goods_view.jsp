<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

                                <div class="widget-body" style="height: 180px;">
                                    <div class="widget-main">

                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label no-padding-right"
                                                       style="font-size: 16px;">商品编码：</label>

                                                <div class="nav-search">
										<span class="input-icon">
											<input type="text" name="GOODS_BM" id="GOODS_BM"
                                                   class="nav-search-input form-control form-control input-lg"
                                                   placeholder="请读取商品编码" style="min-width: 240px;"/>
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
                                                       style="font-size: 16px;">商品数量：</label>

                                                <div class="nav-search">
										<span class="input-icon">
											<input type="text" name="GOODS_COUNT" id="GOODS_COUNT"
                                                   class="nav-search-input form-control form-control input-lg"
                                                   value="1" style="min-width: 240px;"/>
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
                                                   value="1" style="min-width: 240px;"/>
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
                                            <a class="btn btn-mini btn-purple" onclick="add();">确认商品</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row-fluid col-xs-10">
                        <div class="widget-box">
                            <div class="widget-header widget-header-blue widget-header-flat">
                                <h4 class="lighter">购物车清单</h4>
                            </div>
                            <select class="form-control" id="form-field-select-2" multiple="multiple"
                                    style="height: 210px">
                                <option value="AL">Alabama</option>
                                <option value="AK">Alaska</option>
                                <option value="AZ">Arizona</option>
                                <option value="AR">Arkansas</option>


                                <%-- <c:forEach items="${goodsList}" var="var">
                                     <option value="${var.GOODS_ID }"
                                             <c:if test="${var.GOODS_ID == pd.GOODS_ID }">selected</c:if>>${var.GOODS_NAME }</option>
                                 </c:forEach>
 --%>
                            </select>
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
    //打印订单
    function ddpirnt(OUTKU_ID) {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "打印清单";
        diag.URL = '<%=basePath%>sale/ddpirnt.do?OUTKU_ID=' + OUTKU_ID;
        diag.Width = 450;
        diag.Height = 399;
        diag.Modal = false;			//有无遮罩窗口
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
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
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
							<thead>
							<tr>
								<th class="center" style="width:35px;" id="fhadminth"></th>
								<th class="center" style="width:50px;">序号</th>
								<th class="center">商品名称</th>
								<th class="center">原价</th>
								<th class="center">现价</th>
								<th class="center">数量</th>
								<th class="center">总价</th>
								<th class="center">操作</th>
							</tr>
							</thead>

							<tbody>
							<!-- 开始循环 -->
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
										<c:forEach items="${varList}" var="var" varStatus="vs">
											<tr>
												<td class='center'>
													<label class="pos-rel"><input type='radio' name="fhadmin" value="${var.CUSTOMER_ID }" onclick="setCustomer(this.value,'${var.NAME }')" class="ace" /><span class="lbl"></span></label>
												</td>
												<td class='center' style="width: 30px;">${vs.index+1}</td>
												<td class='center'>${var.NAME}</td>
												<td class='center'>${var.PHONE}</td>
												<td class='center'>${var.CTIME}</td>
												<td class='center'>${var.MONEY}&nbsp;元</td>
												<td class='center'>${var.TITLE}</td>
												<td class="center">
													<c:if test="${QX.edit != 1 && QX.del != 1 }">
														<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
													</c:if>
													<div class="hidden-sm hidden-xs btn-group">
														<a class="btn btn-xs btn-info" title="查看订单信息" onclick="view('${var.OUTKU_ID}');">
															<i class="ace-icon fa fa-eye bigger-120" title="查看订单信息"></i>
														</a>
														<c:if test="${QX.edit == 1 }">
															<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.OUTKU_ID}');">
																<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
															</a>
														</c:if>
														<c:if test="${QX.del == 1 }">
															<a class="btn btn-xs btn-danger" onclick="del('${var.OUTKU_ID}');">
																<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
															</a>
														</c:if>
													</div>
													<div class="hidden-md hidden-lg">
														<div class="inline pos-rel">
															<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
																<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
															</button>

															<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
																<li>
																	<a style="cursor:pointer;" onclick="view('${var.OUTKU_ID}');" class="tooltip-info" data-rel="tooltip" title="查看订单信息">
																	<span class="blue">
																		<i class="ace-icon fa fa-eye bigger-120"></i>
																	</span>
																	</a>
																</li>
																<c:if test="${QX.edit == 1 }">
																	<li>
																		<a style="cursor:pointer;" onclick="edit('${var.OUTKU_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																		</a>
																	</li>
																</c:if>
																<c:if test="${QX.del == 1 }">
																	<li>
																		<a style="cursor:pointer;" onclick="del('${var.OUTKU_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																		</a>
																	</li>
																</c:if>
															</ul>
														</div>
													</div>
												</td>
											</tr>
										</c:forEach>
									</c:if>

								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
							<table style="width:100%;">
								<tr>
									<td style="vertical-align:top;">
									</td>
									<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
								</tr>
							</table>
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


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		
		//设置商品ID和名称
		function setGoogsName(){
			var selectVale = $("#SGOODS_ID").val();
			var selectText = $("#SGOODS_ID").find("option:selected").text();
			$("#GOODS_ID").val(selectVale);
			$("#GOODS_NAME").val(selectText);
		}
		
		//计算总价
		function jisuanz(){
			var OUTCOUNT = Number("" == $("#OUTCOUNT").val()?"0":$("#OUTCOUNT").val());
			var OUTPRICE = Number("" == $("#OUTPRICE").val()?"0":$("#OUTPRICE").val());
			if(0-OUTCOUNT>0){
				$("#OUTCOUNT").tips({
					side:3,
		            msg:'数量不能小于零',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OUTCOUNT").focus();
				return false;
			}
			if(0-OUTPRICE>0){
				$("#OUTPRICE").tips({
					side:3,
		            msg:'单价不能小于零',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OUTPRICE").focus();
				return false;
			}
			$("#ZPRICE").val(OUTCOUNT*OUTPRICE);
		}
		
		//保存
		function save(){
			if($("#GOODS_ID").val()==""){
				$("#xzsp").tips({
					side:3,
		            msg:'请选择商品',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#GOODS_ID").focus();
			return false;
			}
			if($("#OUTCOUNT").val()==""){
				$("#OUTCOUNT").tips({
					side:3,
		            msg:'请输入数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OUTCOUNT").focus();
			return false;
			}
			if($("#OUTPRICE").val()==""){
				$("#OUTPRICE").tips({
					side:3,
		            msg:'请输入单价',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OUTPRICE").focus();
			return false;
			}
			if($("#ZPRICE").val()==""){
				$("#ZPRICE").tips({
					side:3,
		            msg:'请输入总价',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ZPRICE").focus();
			return false;
			}
			if($("#BZ").val()==""){
				$("#BZ").tips({
					side:3,
		            msg:'请输入备注',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BZ").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			$("#ZPRICE").attr("readonly","readonly");
			$("#ZPRICE").css("color","gray");
			//下拉框
			if(!ace.vars['touch']) {
				$('.chosen-select').chosen({allow_single_deselect:true}); 
				$(window)
				.off('resize.chosen')
				.on('resize.chosen', function() {
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				}).trigger('resize.chosen');
				$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
					if(event_name != 'sidebar_collapsed') return;
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				});
				$('#chosen-multiple-style .btn').on('click', function(e){
					var target = $(this).find('input[type=radio]');
					var which = parseInt(target.val());
					if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
					 else $('#form-field-select-4').removeClass('tag-input-style');
				});
			}
		});
		
		//打开选择客户窗口
		function choiceCus(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="选择客户";
			 diag.URL = '<%=basePath%>customer/windowsList.do';
			 diag.Width = 700;
			 diag.Height = 545;
			 diag.Modal = false;			//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 var CUSTOMER_ID = diag.innerFrame.contentWindow.document.getElementById('CUSTOMER_ID').value;
				 if("" != CUSTOMER_ID){
					var NAME = diag.innerFrame.contentWindow.document.getElementById('NAME').value;
					$("#CUSTOMER_ID").val(CUSTOMER_ID); //客户ID
					$("#CUSTOMER_NAME").val(NAME);		//客户姓名
				}
				diag.close();
			 };
			 diag.show();
		}
		</script>
</body>
</html>
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sweet/css/example.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sweet/css/sweet-alert.css">
    <script src="${pageContext.request.contextPath}/sweet/js/sweet-alert.min.js"></script>

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

                        <form action="outku/${msg }.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="GOODS_ID" id="GOODS_ID" value="${pd.GOODS_ID}"/>
                            <input type="hidden" name="CUSTOMER_ID" id="CUSTOMER_ID" value="${pd.CUSTOMER_ID}"/>
                            <div id="zhongxin" style="padding-top: 13px;">
                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;" colspan="2">
                                            <div>
                                                <iframe name="treeFrame" id="treeFrame" frameborder="0"
                                                        src="<%=basePath%>/outku/getChoose.do"
                                                        style="margin:0 auto;width:805px;height:438px;;"></iframe>
                                            </div>

                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">客户:</td>
                                        <td>
                                            <input type="text" name="CUSTOMER_NAME" id="CUSTOMER_NAME"
                                                   value="${pd.CUSTOMER_NAME}" maxlength="32" placeholder="这里输入客户"
                                                   title="客户" style="width:89%;"/>
                                            <a class="btn btn-xs btn-info" title="选择客户" onclick="choiceCus();"
                                               style="margin-top: -3px;">
                                                <i class="ace-icon glyphicon glyphicon-user"></i>
                                            </a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;" colspan="10">
                                            <a class="btn btn-mini btn-primary"
                                               onclick="save('你确定要添加新的订单吗？',window.frames['treeFrame'].document.getElementsByName('ids').length)">保存</a>
                                            <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
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

    //保存
    function save(msg, checkId) {
        swal({
                title: "确定操作吗？",
                text: msg,
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: '#00FF00',
                confirmButtonText: 'sure'
            },
            function () {
                var str = '';
                var successcount = 0;
                var forcount = 0;
                for (var i = 0; i < checkId; i++) {
                    if (window.frames['treeFrame'].document.getElementsByName('ids')[i].checked) {
                        forcount++;
                        if (str == '') str += window.frames['treeFrame'].document.getElementsByName('ids')[i].value;
                        else str += ',' + window.frames['treeFrame'].document.getElementsByName('ids')[i].value;
                        var outkuid = window.frames['treeFrame'].document.getElementsByName('ids')[i].value;
                        $.ajax({
                            type: "POST",
                            url: 'outku/getAllByIds.do',
                            data: {OUTKU_ID: outkuid},
                            dataType: 'json',
                            cache: false,
                            success: function (data) {
                                if ("success" == data.result) {
                                    successcount++;
                                    if (successcount == forcount) {
                                        doItAll(str, $("#CUSTOMER_ID").val());
                                    }
                                } else {
                                    $("#GOODS_ID").tips({
                                        side: 3,
                                        msg: "出货数量不可以大于库存数量,请修改出货数量后重试",
                                        bg: '#FF5080',
                                        time: 3
                                    });
                                    $("#GOODS_ID").focus();
                                    return false;
                                }
                            }
                        });
                    }
                }
                if(str==''){
                    $("#GOODS_ID").tips({
                        side: 3,
                        msg: '您未选择任何内容,请先勾选要操作的选项',
                        bg: '#FF5080',
                        time: 3
                    });
                    return false;
                }
            });
    };

    function doItAll(str, customerId) {
        if (customerId != '') {
            $.ajax({
                type: "POST",
                url: '<%=basePath%>outku/updateAll.do',
                data: {DATA_IDS: str, CUSTOMER_ID: customerId},
                dataType: 'json',
                //beforeSend: validateData,
                cache: false,
                success: function (data) {
                    if (data.msg == "ok") {
                        $("#GOODS_ID").tips({
                            side: 3,
                            msg: "成功添加了新的外销订单！三秒后将自动刷新!",
                            bg: '#AE81FF',
                            time: 3
                        });
                        $("#GOODS_ID").focus();
                        setTimeout(function(){
                            window.location.href = "<%=basePath%>/outku/goAdd.do";
                            },3000);
                    }
                    else {
                        $("#GOODS_ID").tips({
                            side: 3,
                            msg: "操作失败,数据异常，请检查",
                            bg: '#FF5080',
                            time: 3
                        });
                        $("#GOODS_ID").focus();
                        return false;
                    }
                }
            });
        }
        else{
            $("#CUSTOMER_NAME").tips({
                side: 1,
                msg: '请先选择客户！',
                bg: '#FF5080',
                time: 3
            });
            return false;
        }
    }

    $(function () {
        $("#ZPRICE").attr("readonly", "readonly");
        $("#ZPRICE").css("color", "gray");
        //下拉框
        if (!ace.vars['touch']) {
            $('.chosen-select').chosen({allow_single_deselect: true});
            $(window)
                .off('resize.chosen')
                .on('resize.chosen', function () {
                    $('.chosen-select').each(function () {
                        var $this = $(this);
                        $this.next().css({'width': $this.parent().width()});
                    });
                }).trigger('resize.chosen');
            $(document).on('settings.ace.chosen', function (e, event_name, event_val) {
                if (event_name != 'sidebar_collapsed') return;
                $('.chosen-select').each(function () {
                    var $this = $(this);
                    $this.next().css({'width': $this.parent().width()});
                });
            });
            $('#chosen-multiple-style .btn').on('click', function (e) {
                var target = $(this).find('input[type=radio]');
                var which = parseInt(target.val());
                if (which == 2) $('#form-field-select-4').addClass('tag-input-style');
                else $('#form-field-select-4').removeClass('tag-input-style');
            });
        }
    });

    //打开选择客户窗口
    function choiceCus() {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "选择客户";
        diag.URL = '<%=basePath%>customer/windowsList.do';
        diag.Width = 700;
        diag.Height = 545;
        diag.Modal = false;			//有无遮罩窗口
        diag.ShowMaxButton = true;	//最大化按钮
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function () { //关闭事件
            var CUSTOMER_ID = diag.innerFrame.contentWindow.document.getElementById('CUSTOMER_ID').value;
            if ("" != CUSTOMER_ID) {
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
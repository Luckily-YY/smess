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

                        <!-- 检索  -->
                        <form action="kucun/list.do" method="post" name="Form" id="Form">
                            <table style="margin-top:5px;">
                                <tr>
                                    <td>
                                        <div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入关键词" class="nav-search-input"
                                                   id="nav-search-input" autocomplete="off" name="keywords"
                                                   value="${pd.keywords }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
                                        </div>
                                    </td>
                                    <td style="padding-left:5px">
                                        <select class="chosen-select form-control" name="SPBRAND_ID" id="SPBRAND_ID"
                                                data-placeholder="请选择品牌" style="vertical-align:top;width:120px;">
                                            <option value=""></option>
                                            <c:forEach items="${spbrandList}" var="var">
                                                <option value="${var.SPBRAND_ID }"
                                                        <c:if test="${var.SPBRAND_ID == pd.SPBRAND_ID }">selected</c:if>>${var.NAME }</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td style="padding-left:5px">
                                        <select class="chosen-select form-control" name="SPTYPE_ID" id="SPTYPE_ID"
                                                data-placeholder="请选择类别" style="vertical-align:top;width:120px;">
                                            <option value=""></option>
                                            <c:forEach items="${sptypeList}" var="var">
                                                <option value="${var.SPTYPE_ID }"
                                                        <c:if test="${var.SPTYPE_ID == pd.SPTYPE_ID }">selected</c:if>>${var.NAME }</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <c:if test="${QX.cha == 1 }">
                                        <td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs"
                                                                                           onclick="tosearch();"
                                                                                           title="检索"><i
                                                id="nav-search-icon"
                                                class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a>
                                        </td>
                                    </c:if>
                                    <c:if test="${QX.toExcel == 1 }">
                                        <td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs"
                                                                                            onclick="toExcel();"
                                                                                            title="导出到EXCEL"><i
                                                id="nav-search-icon"
                                                class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a>
                                        </td>
                                    </c:if>
                                </tr>
                            </table>
                            <!-- 检索  -->

                            <table id="simple-table" class="table table-striped table-bordered table-hover"
                                   style="margin-top:5px;">
                                <input type="hidden" name="KUCUN_ID" id="KUCUN_ID" value="${pd.KUCUN_ID}"/>
                                <thead>
                                <tr>
                                    <th class="center" style="width:35px;">
                                        <label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox"/><span
                                                class="lbl"></span></label>
                                    </th>
                                    <th class="center" style="width:50px;">序号</th>
                                    <th class="center">商品名称</th>
                                    <th class="center">仓库存量</th>
                                    <th class="center">商品类别</th>
                                    <th class="center">品牌</th>
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
                                                        <label class="pos-rel"><input type='checkbox' name='ids'
                                                                                      value="${var.KUCUN_ID}"
                                                                                      class="ace"/><span
                                                                class="lbl"></span></label>
                                                    </td>
                                                    <td class='center' id="GOODS"
                                                        style="width: 30px;">${vs.index+1}</td>
                                                    <td class='center'>${var.GOODS_NAME}</td>
                                                    <td class='center' id="ZCOUNT">
                                                        <c:if test="${var.ZCOUNT < 6.00}"><font
                                                                color="red"><b>${var.ZCOUNT}</b></font></c:if>
                                                        <c:if test="${var.ZCOUNT < 11.00 && var.ZCOUNT > 5.00}"><font
                                                                color="#FF8000"><b>${var.ZCOUNT}</b></font></c:if>
                                                        <c:if test="${var.ZCOUNT > 10.00}"><font
                                                                color="#008000"><b>${var.ZCOUNT}</b></font></c:if>
                                                        <c:if test="${var.UNAME != null && var.UNAME != ''}">
                                                            &nbsp;&nbsp;(${var.UNAME})
                                                        </c:if>
                                                        <c:if test="${var.UNAME == null || var.UNAME == ''}">
                                                            &nbsp;&nbsp;(暂无单位)
                                                        </c:if>
                                                    </td>
                                                    <td class='center'>${var.TNAME}</td>
                                                    <td class='center'>${var.BNAME}</td>
                                                    <td class='center'>
                                                        <a class="btn btn-mini btn-success"
                                                           onclick="edit('${var.KUCUN_ID}');">
                                                            <i class="ace-icon fa fa-pencil-square-o bigger-120"
                                                               title="编辑"></i>
                                                        </a>
                                                        <c:if test="${QX.del == 1 }">
                                                            <a class="btn btn-mini btn-danger"
                                                               onclick="del('${var.KUCUN_ID}','${var.ZCOUNT}','${var.GOODS_NAME}');">
                                                                <i class="ace-icon fa fa-trash-o bigger-120"
                                                                   title="删除"></i>
                                                            </a>
                                                        </c:if>
                                                    </td>
                                                </tr>

                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${QX.cha == 0 }">
                                            <tr>
                                                <td colspan="100" class="center">您无权查看</td>
                                            </tr>
                                        </c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <tr class="main_info">
                                            <td colspan="100" class="center">没有相关数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                            <div class="page-header position-relative">
                                <table style="width:100%;">
                                    <tr>
                                        <td style="vertical-align:top;">
                                            <a class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');"
                                               title="批量删除"><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
                                        </td>
                                        <td style="vertical-align:top;">
                                            <div class="pagination"
                                                 style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
                                        </td>
                                    </tr>
                                </table>
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

    <!-- 返回顶部 -->
    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>

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
    //检索
    function tosearch() {
        top.jzts();
        $("#Form").submit();
    }
    $(function () {

        //日期框
        $('.date-picker').datepicker({
            autoclose: true,
            todayHighlight: true
        });

        //复选框全选控制
        var active_class = 'active';
        $('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function () {
            var th_checked = this.checked;//checkbox inside "TH" table header
            $(this).closest('table').find('tbody > tr').each(function () {
                var row = this;
                if (th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
                else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
            });
        });

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


    //修改
    function edit(id) {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "库存商品修改";
        diag.URL = '<%=basePath%>kucun/goEdit.do?KUCUN_ID=' + id;
        diag.Width = 460;
        diag.Height = 480;
        diag.Modal = false;			//有无遮罩窗口
        diag.ShowMaxButton = true;	//最大化按钮
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function () { //关闭事件
            if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
                if ('${page.currentPage}' == '0') {
                    top.jzts();
                    setTimeout("self.location=self.location", 100);
                } else {
                    nextPage(${page.currentPage});
                }
            }
            diag.close();
        };
        diag.show();
    }

    //删除
    function del(id, zcount, msg) {
        swal({
                title: "确定操作吗？",
                text: "你确定要删除[" + msg + "]吗？",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: '#00FF00',
                confirmButtonText: 'sure'
            },
            function () {
                $.ajax({
                    type: "POST",
                    url: 'kucun/getById.do',
                    data: {KUCUN_ID: id},
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        if ("success" == data.result) {
                            var a = (zcount - 0.00).toFixed(2);
                            if (a > 0.00) {
                                $("#ZCOUNT").tips({
                                    side: 3,
                                    msg: '商品库存不为0，不能删除',
                                    bg: '#AE81FF',
                                    time: 3
                                });
                                $("#ZCOUNT").focus();
                                return false;
                            }
                            else {
                                var url = "${pageContext.request.contextPath}/kucun/delete?KUCUN_ID=" + id;
                                $.get(url, function (data) {
                                    nextPage(${page.currentPage});
                                });
                            }
                        } else {
                            $("#GOODS").tips({
                                side: 3,
                                msg: "此商品不存在,请刷新后重试",
                                bg: '#FF5080',
                                time: 15
                            });
                            $("#GOODS").focus();
                            return false;
                        }
                    }
                });
            });


    }


    //批量操作
    function makeAll(msg) {
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
                for (var i = 0; i < document.getElementsByName('ids').length; i++) {
                    if (document.getElementsByName('ids')[i].checked) {
                        forcount++;
                        if (str == '') str += document.getElementsByName('ids')[i].value;
                        else str += ',' + document.getElementsByName('ids')[i].value;
                        var kucunid = document.getElementsByName('ids')[i].value;
                        $.ajax({
                            type: "POST",
                            url: 'kucun/getAllByIds.do',
                            data: {KUCUN_ID: kucunid},
                            dataType: 'json',
                            cache: false,
                            success: function (data) {
                                if ("success" == data.result) {
                                    successcount++;
                                    if(successcount==forcount)
                                    {
                                        delthisAll(msg,str);
                                    }
                                } else if ("kucunerror" == data.result) {
                                    $("#GOODS").tips({
                                        side: 3,
                                        msg: "存在商品库存不为0，不能一键删除",
                                        bg: '#FF5080',
                                        time: 3
                                    });
                                    $("#GOODS").focus();
                                    return false;
                                } else {
                                    $("#GOODS").tips({
                                        side: 3,
                                        msg: "此商品不存在,请刷新后重试",
                                        bg: '#FF5080',
                                        time: 3
                                    });
                                    $("#GOODS").focus();
                                    return false;
                                }
                            }
                        });

                    }
                }
                if (str == '') {
                    $("#zcheckbox").tips({
                        side: 1,
                        msg: '您未选择任何内容，点这里全选',
                        bg: '#AE81FF',
                        time: 3
                    });
                    return false;
                }
            });
    };

    function delthisAll(msg,str) {
        if (msg == '确定要删除选中的数据吗?') {
            $.ajax({
                type: "POST",
                url: '<%=basePath%>kucun/deleteAll.do',
                data: {DATA_IDS: str},
                dataType: 'json',
                //beforeSend: validateData,
                cache: false,
                success: function (data) {
                    $.each(data.list, function (i, list) {
                        nextPage(${page.currentPage});
                    });
                }
            });
        }
    }

    //导出excel
    function toExcel() {
        $("#Form").attr("action", "<%=basePath%>kucun/excel.do");
        setTimeout(function () {
            $("#Form").attr("action", "<%=basePath%>kucun/list.do");
        }, 500);
        $("#Form").submit();
    }
</script>


</body>
</html>
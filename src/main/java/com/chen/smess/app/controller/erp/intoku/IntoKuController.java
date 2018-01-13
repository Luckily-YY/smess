package com.chen.smess.app.controller.erp.intoku;

import com.chen.smess.app.controller.base.BaseController;
import com.chen.smess.domain.common.utils.*;
import com.chen.smess.domain.model.Page;
import com.chen.smess.domain.service.erp.goods.GoodsManager;
import com.chen.smess.domain.service.erp.intoku.IntoKuManager;
import com.chen.smess.domain.service.erp.kucun.impl.KucunService;
import com.chen.smess.domain.service.erp.sptype.impl.SptypeService;
import com.sun.tools.doclets.formats.html.SourceToHTMLConverter;
import org.apache.poi.util.SystemOutLogger;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.print.attribute.standard.PDLOverrideSupported;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * 说明：商品入库
 */
@Controller
@RequestMapping(value = "/intoku")
public class IntoKuController extends BaseController {

    String menuUrl = "intoku/list.do"; //菜单地址(权限用)
    @Resource(name = "intokuService")
    private IntoKuManager intokuService;
    @Resource(name = "goodsService")
    private GoodsManager goodsService;
    @Resource(name = "sptypeService")
    private SptypeService sptypeService;
    @Resource(name = "kucunService")
    private KucunService kucunService;

    /**
     * 保存
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/save")
    public ModelAndView save() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "新增IntoKu");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
            return null;
        } //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("INTOKU_ID", this.get32UUID());    //主键
        pd.put("GOODS_ID", this.get32UUID());
        pd.put("INTIME", Tools.date2Str(new Date()));    //入库时间
        pd.put("USERNAME", Jurisdiction.getUsername());    //用户名
        /*pd.put("GOODS_NAME", goodsService.findById(pd).getString("TITLE"));*/    //商品名称
        PageData pd2 = new PageData();
        pd2.put("GOODS_NAME", pd.getString("GOODS_NAME"));
        pd2.put("PRICE", pd.getString("PRICE"));
        intokuService.save(pd);
        List<PageData> pageData = kucunService.findByObject(pd2);
        if (pageData != null && pageData.size() > 0) {
            for (int i = 0; i < pageData.size(); i++) {
                PageData vpd = new PageData();
                vpd.put("KUCUN_ID", pageData.get(i).getString("KUCUN_ID"));
                vpd.put("ZCOUNT", pageData.get(i).getString("ZCOUNT"));
                vpd.put("INCOUNT", pd.getString("INCOUNT"));
                kucunService.editZCOUNT(vpd);
            }
        } else if (pageData == null || pageData.size() == 0) {
            pd.put("KUCUN_ID", this.get32UUID());
            pd.put("ZCOUNT", pd.getString("INCOUNT"));
            kucunService.save(pd);
        }
        //goodsService.editZCOUNT(pd); //修改库存
        mv.addObject("msg", "success");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 删除
     *
     * @param out
     * @throws Exception
     */
    @RequestMapping(value = "/delete")
    public void delete(PrintWriter out) throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "删除IntoKu");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
            return;
        } //校验权限
        PageData pd = new PageData();
        pd = this.getPageData();
        intokuService.delete(pd);
        out.write("success");
        out.close();
    }

    /**
     * 修改
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/edit")
    public ModelAndView edit() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "修改IntoKu");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
            return null;
        } //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        PageData pd2 = intokuService.findById(pd);
        pd2.put("GOODS_NAME", pd.getString("GOODS_NAME"));
        pd2.put("INCOUNT", pd.getString("INCOUNT"));
        pd2.put("PRICE", pd.getString("PRICE"));
        pd2.put("ZPRICE", pd.getString("ZPRICE"));
        pd2.put("BZ", pd.getString("BZ"));
        pd2.put("SPTYPE_ID", pd.getString("SPTYPE_ID"));
        intokuService.edit(pd2);
        mv.addObject("msg", "success");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 列表
     *
     * @param page
     * @throws Exception
     */
    @RequestMapping(value = "/list")
    public ModelAndView list(Page page) throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "列表IntoKu");
        //if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String keywords = pd.getString("keywords");                //关键词检索条件
        if (null != keywords && !"".equals(keywords)) {
            pd.put("keywords", keywords.trim());
        }
        String lastStart = pd.getString("lastStart");    //开始时间
        String lastEnd = pd.getString("lastEnd");        //结束时间
        if (lastStart != null && !"".equals(lastStart)) {
            pd.put("lastStart", lastStart + " 00:00:00");
        }
        if (lastEnd != null && !"".equals(lastEnd)) {
            pd.put("lastEnd", lastEnd + " 00:00:00");
        }
        pd.put("USERNAME", Jurisdiction.getUsername());
        PageData jinepd = intokuService.priceSum(pd);    //总金额
        String zprice = "0";
        if (null != jinepd) {
            zprice = jinepd.get("ZPRICE").toString();
        }
        page.setPd(pd);
        List<PageData> varList = intokuService.list(page);    //列出IntoKu列表
        for (int i = 0; i < varList.size(); i++) {
            String count = varList.get(i).getString("INCOUNT");
            String[] str = count.split("\\.");
            if (str[1].toString().equals("00")) {
                if(!str[0].isEmpty()){
                    varList.get(i).put("INCOUNT", str[0]);
                }
                else {
                    varList.get(i).put("INCOUNT", "0");
                }
            } else {
                if (!str[0].isEmpty()) {
                    varList.get(i).put("INCOUNT", count);
                }
                else
                {
                    varList.get(i).put("INCOUNT", "0"+count);
                }
            }
        }
        mv.setViewName("erp/intoku/intoku_list");
        mv.addObject("varList", varList);
        mv.addObject("pd", pd);
        mv.addObject("zprice", zprice);
        mv.addObject("QX", Jurisdiction.getHC());    //按钮权限
        return mv;
    }

    /**
     * 去新增页面
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/goAdd")
    public ModelAndView goAdd() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("USERNAME", Jurisdiction.getUsername());
        List<PageData> sptypeList = sptypeService.listAll();        //类别列表
        mv.setViewName("erp/intoku/intoku_edit");
        mv.addObject("msg", "save");
        mv.addObject("sptypeList", sptypeList);
        mv.addObject("pd", pd);
        return mv;
    }


    /**
     * 去修改页面
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/goEdit")
    public ModelAndView goEdit() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd = intokuService.findById(pd);    //根据ID读取
        String count = pd.getString("INCOUNT");
        String[] str = count.split("\\.");
        if (str[1].toString().equals("00")) {
            if (!str[0].isEmpty()) {
                pd.put("INCOUNT", str[0]);
            }
            else {
                pd.put("INCOUNT","0");
            }

        } else {
            if(!str[0].isEmpty()){
                pd.put("INCOUNT", count);
            }
            else {
                pd.put("INCOUNT", "0"+count);
            }
        }
        List<PageData> sptypeList = sptypeService.listAll();        //类别列表
        mv.setViewName("erp/intoku/intoku_edit");
        mv.addObject("msg", "edit");
        mv.addObject("sptypeList", sptypeList);
        mv.addObject("pd", pd);
        return mv;
    }


    /**
     * 批量删除
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/deleteAll")
    @ResponseBody
    public Object deleteAll() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "批量删除IntoKu");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
            return null;
        } //校验权限
        PageData pd = new PageData();
        Map<String, Object> map = new HashMap<String, Object>();
        pd = this.getPageData();
        List<PageData> pdList = new ArrayList<PageData>();
        String DATA_IDS = pd.getString("DATA_IDS");
        if (null != DATA_IDS && !"".equals(DATA_IDS)) {
            String ArrayDATA_IDS[] = DATA_IDS.split(",");
            intokuService.deleteAll(ArrayDATA_IDS);
            pd.put("msg", "ok");
        } else {
            pd.put("msg", "no");
        }
        pdList.add(pd);
        map.put("list", pdList);
        return AppUtil.returnObject(pd, map);
    }

    /**
     * 导出到excel
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/excel")
    public ModelAndView exportExcel(Page page) throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "导出入库到excel");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
            return null;
        }
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        Map<String, Object> dataMap = new HashMap<String, Object>();
        List<String> titles = new ArrayList<String>();
        titles.add("商品名称");    //1
        titles.add("数量");        //2
        titles.add("单价");        //3
        titles.add("总价");        //4
        titles.add("入库时间");    //5
        titles.add("备注");        //6
        dataMap.put("titles", titles);
        String keywords = pd.getString("keywords");                //关键词检索条件
        if (null != keywords && !"".equals(keywords)) {
            pd.put("keywords", keywords.trim());
        }
        String lastStart = pd.getString("lastStart");            //开始时间
        String lastEnd = pd.getString("lastEnd");                //结束时间
        if (lastStart != null && !"".equals(lastStart)) {
            pd.put("lastStart", lastStart + " 00:00:00");
        }
        if (lastEnd != null && !"".equals(lastEnd)) {
            pd.put("lastEnd", lastEnd + " 00:00:00");
        }
        pd.put("USERNAME", Jurisdiction.getUsername());
        PageData jinepd = intokuService.priceSum(pd);            //总金额
        String zprice = "0";
        if (null != jinepd) {
            zprice = jinepd.get("ZPRICE").toString();
        }
        page.setShowCount(30000);                                //最大条数 3万条
        page.setPd(pd);
        List<PageData> varOList = intokuService.list(page);    //列出IntoKu列表
        List<PageData> varList = new ArrayList<PageData>();
        for (int i = 0; i < varOList.size(); i++) {
            PageData vpd = new PageData();
            vpd.put("var1", varOList.get(i).getString("GOODS_NAME"));        //1
            String count = varOList.get(i).getString("INCOUNT");
            String[] str = count.split("\\.");
            if (str[1].toString().equals("00")) {
                vpd.put("var2", str[0]);        //2
            } else {
                vpd.put("var2", count);        //2
            }
            vpd.put("var3", varOList.get(i).get("PRICE").toString() + "元");    //3
            vpd.put("var4", varOList.get(i).get("ZPRICE").toString() + "元");    //4
            vpd.put("var5", varOList.get(i).getString("INTIME"));            //5
            vpd.put("var6", varOList.get(i).getString("BZ"));                //6
            varList.add(vpd);
        }
        dataMap.put("varList", varList);
        ObjectExcelView erv = new ObjectExcelView();
        mv = new ModelAndView(erv, dataMap);
        return mv;
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
    }
}

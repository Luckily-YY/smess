package com.chen.smess.app.controller.erp.sale;

import com.chen.smess.app.controller.base.BaseController;
import com.chen.smess.domain.common.utils.*;
import com.chen.smess.domain.model.Page;
import com.chen.smess.domain.service.erp.goods.GoodsManager;
import com.chen.smess.domain.service.erp.goods.impl.GoodsService;
import com.chen.smess.domain.service.erp.sale.SaleManager;
import com.chen.smess.domain.service.erp.sale.impl.SaleService;
import com.chen.smess.domain.service.erp.salereport.SaleReportManager;
import com.chen.smess.domain.service.erp.salereport.impl.SaleReportService;
import com.chen.smess.domain.service.erp.weight.WeightManager;
import com.chen.smess.domain.service.erp.weight.impl.WeightService;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * 说明：商品销售
 */
@Controller
@RequestMapping(value = "/sale")
public class SaleController extends BaseController {

    @Resource(name = "saleService")
    private SaleManager saleService;
    @Resource(name = "saleReportService")
    private SaleReportManager saleReportService;
    @Resource(name = "goodsService")
    private GoodsManager goodsService;
    @Resource(name = "weightService")
    private WeightManager weightService;

    /**
     * 打开前台销售页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/salegood")
    public ModelAndView salegood() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("USERNAME", Jurisdiction.getUsername().toString());
        List<PageData> salelist = saleService.listAll(pd);
        mv.addObject("varList", salelist);
        mv.setViewName("erp/sale/sale_goods_view");
        return mv;
    }

    /**
     * 添加新的销售清单
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addsale")
    public ModelAndView addsale() throws Exception {
        ModelAndView mv = new ModelAndView("redirect:salegood");
        PageData pd = new PageData();
        pd = this.getPageData();
        PageData pageData = new PageData();
        pageData.put("USERNAME", Jurisdiction.getUsername().toString());
        pageData.put("GOODS_ID", pd.getString("GOODS_ID"));
        pageData.put("SALE_ID", this.get32UUID());
        pageData.put("SALECOUNT", pd.getString("GOODS_COUNT"));
        pageData.put("PRICE", pd.getString("PRICE"));
        pageData.put("ZPRICE", pd.getString("Z_PRICE"));
        pageData.put("ZHEKOU", pd.getString("ZHEKOU"));
        pageData.put("GOODS_NAME", pd.getString("GOODS_NAME"));
        pageData.put("SALETIME", Tools.date2Str(new Date()));
        saleService.save(pageData);
        return mv;
    }

    /**
     * 删除清单
     */
    @RequestMapping(value = "/delsale")
    public ModelAndView delsale() throws Exception {
        ModelAndView mv = new ModelAndView("redirect:salegood");
        PageData pd = new PageData();
        pd = this.getPageData();
        saleService.delete(pd);
        return mv;
    }

    /**
     * 通过产品编码
     *
     * @throws Exception
     */
    @RequestMapping(value = "/getGoods")
    @ResponseBody
    public Object getGoods() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "通过产品编码获取信息");
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = new PageData();
        pd = this.getPageData();
        String errInfo = "success";
        //从库存读取数据
        PageData pageData = goodsService.findByBm(pd);
        if (pageData != null) {
            pageData.put("GOODS_NAME", pageData.getString("TITLE"));
            pageData.put("GOODS_ID", pageData.getString("GOODS_ID"));
            pageData.put("PRICE", pageData.getString("GPRICE"));
            map.put("pd", pageData);
        } else {
            errInfo = "error";
        }
        map.put("result", errInfo);
        return AppUtil.returnObject(new PageData(), map);
    }

    /**
     * 通过打称编码
     *
     * @throws Exception
     */
    @RequestMapping(value = "/getWeight")
    @ResponseBody
    public Object getWeight() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "通过打称编码获取信息");
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = new PageData();
        pd = this.getPageData();
        String errInfo = "success";
        //从库存读取数据
        PageData pageData = weightService.findByBm(pd);
        if (pageData != null) {
            pageData.put("GOODS_NAME", pageData.getString("GOODS_NAME"));
            pageData.put("GOODS_ID", pageData.getString("GOODS_ID"));
            pageData.put("GOODS_COUNT", pageData.getString("WEIGHT"));
            pageData.put("PRICE", pageData.getString("WPRICE"));
            pageData.put("Z_PRICE", pageData.getString("WZPRICE"));
            map.put("pd", pageData);
        } else {
            errInfo = "error";
        }
        map.put("result", errInfo);
        return AppUtil.returnObject(new PageData(), map);
    }


    /**
     * 去打印清单页面
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/ddpirnt")
    public ModelAndView ddpirnt() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("USERNAME", Jurisdiction.getUsername().toString());
        List<PageData> salelist = saleService.listAll(pd);
        pd = saleService.priceSum(pd);
        if(pd != null) {
            pd.put("TIME", Tools.date2Str(new Date()));
        }
        mv.addObject("varList", salelist);
        mv.addObject("pd", pd);
        mv.setViewName("erp/sale/sale_goods_ddprint");
        return mv;
    }

    /**
     * 调用打印机
     *
     * @throws Exception
     */
    @RequestMapping(value = "/printSale")
    @ResponseBody
    public Object printSale() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "打印购物清单");
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("USERNAME",Jurisdiction.getUsername().toString());
        String errInfo = "success";
        try {
            List<PageData> list = saleService.listAll(pd);
            String time = Tools.date2Str(new Date());
            for (PageData salePage : list) {
                /*保存购物清单销售报告*/
                PageData report = new PageData();
                report.put("SALEREPORT_ID",this.get32UUID());
                report.put("GOODS_ID",salePage.getString("GOODS_ID"));
                report.put("SALETIME",time);
                report.put("SALECOUNT",salePage.getString("SALECOUNT"));
                report.put("SALEPRICE",salePage.getString("ZPRICE"));
                report.put("GOODS_NAME",salePage.getString("GOODS_NAME"));
                report.put("USERNAME",Jurisdiction.getUsername().toString());
                saleReportService.save(report);

                /*从货架上减去已销售出去的货物*/
                PageData goods = goodsService.findById(salePage);
                String goodscount = goods.getString("GCOUNT");
                BigDecimal gcount = new BigDecimal(goodscount);    //货架上的数量
                String salecount = salePage.getString("SALECOUNT");
                BigDecimal scount = new BigDecimal(salecount);     //销售的数量
                String newgoodscount = gcount.subtract(scount).toString();
                goods.put("GCOUNT",newgoodscount);
                goodsService.edit(goods);

                /*从临时清单列表中删除该清单*/
                saleService.deleteAll(pd);
            }

        } catch (Exception e) {
            errInfo = "error";

        }
        map.put("result", errInfo);
        return AppUtil.returnObject(new PageData(), map);
    }

    /**
     * 商品销售报表
     *
     * @param page
     * @throws Exception
     */
    @RequestMapping(value = "/insaleReport")
    public ModelAndView insalesReport(Page page) throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "销售报表");
        //if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String keywords = pd.getString("keywords");        //关键词检索条件
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
        page.setPd(pd);
        List<PageData> varList = saleReportService.salesReport(page);
        for (int i = 0; i < varList.size(); i++) {
            String count = varList.get(i).getString("SALECOUNT");
            String[] str = count.split("\\.");
            if (str[1].toString().equals("00")) {
                varList.get(i).put("SALECOUNT", str[0]);
            } else {
                varList.get(i).put("SALECOUNT", count);
            }
        }
        mv.setViewName("erp/sale/salesReport");
        mv.addObject("varList", varList);
        mv.addObject("pd", pd);
        mv.addObject("QX", Jurisdiction.getHC());    //按钮权限
        return mv;
    }

    /**
     * 销售报表导出到excel
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/exportExcel")
    public ModelAndView exportExcel(Page page) throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "导出销售报表到excel");
        /*if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
            return null;
        }*/
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        Map<String, Object> dataMap = new HashMap<String, Object>();
        List<String> titles = new ArrayList<String>();
        titles.add("商品名称");    //1
        titles.add("销量");        //2
        titles.add("销售额");    //3
        titles.add("销售时间");    //3
        dataMap.put("titles", titles);
        String keywords = pd.getString("keywords");        //关键词检索条件
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
        page.setShowCount(30000);                            //最大条数 3万条
        page.setPd(pd);
        List<PageData> varOList = saleReportService.salesReport(page);
        List<PageData> varList = new ArrayList<PageData>();
        for (int i = 0; i < varOList.size(); i++) {
            PageData vpd = new PageData();
            vpd.put("var1", varOList.get(i).getString("GOODS_NAME"));        //1
            vpd.put("var2", varOList.get(i).get("SALECOUNT").toString());        //2
            vpd.put("var3", varOList.get(i).get("SALEPRICE").toString() + "元");    //3
            vpd.put("var4", varOList.get(i).get("SALETIME").toString());    //3
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

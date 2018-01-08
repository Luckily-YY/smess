package com.chen.smess.app.controller.erp.kucun;

import com.chen.smess.app.controller.base.BaseController;
import com.chen.smess.domain.common.utils.*;
import com.chen.smess.domain.model.Page;
import com.chen.smess.domain.service.erp.kucun.KucunManager;
import com.chen.smess.domain.service.erp.spbrand.SpbrandManager;
import com.chen.smess.domain.service.erp.sptype.SptypeManager;
import com.chen.smess.domain.service.erp.spunit.SpunitManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.PrintWriter;
import java.util.*;


/**
 * 说明：商品库存
 */
@Controller
@RequestMapping(value = "/kucun")
public class KucunController extends BaseController {

    String menuUrl = "kucun/list.do"; //菜单地址(权限用)
    @Resource(name = "kucunService")
    private KucunManager kucunService;
    @Resource(name = "spbrandService")
    private SpbrandManager spbrandService;
    @Resource(name = "sptypeService")
    private SptypeManager sptypeService;
    @Resource(name = "spunitService")
    private SpunitManager spunitService;

    /**
     * 列表
     *
     * @param page
     * @throws Exception
     */
    @RequestMapping(value = "/list")
    public ModelAndView list(Page page) throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "列表Goods");
        //if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String keywords = pd.getString("keywords");                //关键词检索条件
        if (null != keywords && !"".equals(keywords)) {
            pd.put("keywords", keywords.trim());
        }
        pd.put("isKucun", "yes");
        page.setPd(pd);
        List<PageData> spbrandList = spbrandService.listAll();    //品牌列表
        List<PageData> sptypeList = sptypeService.listAll();
        List<PageData> spunitList = spunitService.listAll();
        List<PageData> varList = kucunService.list(page);
        for (int i = 0; i < varList.size(); i++) {
            String count = varList.get(i).getString("ZCOUNT");
            String[] str = count.split("\\.");
            if (str[1].toString().equals("00")) {
                varList.get(i).put("ZCOUNT", str[0]);
            } else {
                varList.get(i).put("ZCOUNT", count);
            }
        }
        mv.setViewName("erp/kucun/kucun_list");
        mv.addObject("varList", varList);
        mv.addObject("pd", pd);
        mv.addObject("spbrandList", spbrandList);
        mv.addObject("sptypeList", sptypeList);
        mv.addObject("spunitList", spunitList);
        mv.addObject("QX", Jurisdiction.getHC());    //按钮权限
        return mv;
    }

    /**
     * 库存盘点
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/kucunchar")
    public ModelAndView kucunchar() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String USERNAME = pd.getString("USERNAME");
        USERNAME = Tools.notEmpty(USERNAME) ? USERNAME : Jurisdiction.getUsername();
        pd.put("USERNAME", USERNAME);
        List<PageData> goodsList = kucunService.listAll(pd);
        String[] color = {"AFD8F8", "F6BD0F", "8BBA00", "FF8E46", "008E8E", "D64646", "8E468E", "588526", "B3AA00", "008ED6", "9D080D", "A186BE"};
        String strXML = "<graph caption='商品库存盘点' xAxisName='商品名' yAxisName='库存' decimalPrecision='0' formatNumberScale='0' baseFontSize='13'>";
        Random rand = new Random();
        for (int i = 0; i < goodsList.size(); i++) {
            PageData goodsPd = goodsList.get(i);
            strXML += "<set name='" + goodsPd.getString("GOODS_NAME") + "' value='" + goodsPd.get("ZCOUNT").toString() + "' color='" + color[rand.nextInt(11)] + "'/>";
        }
        mv.addObject("strXML", strXML + "</graph>");
        mv.setViewName("erp/kucun/kucun_char");
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
        logBefore(logger, Jurisdiction.getUsername() + "删除库存商品");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
            return;
        } //校验权限
        PageData pd = new PageData();
        pd = this.getPageData();
        kucunService.delete(pd);
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
        logBefore(logger, Jurisdiction.getUsername() + "修改库存商品");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
            return null;
        } //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        PageData pd2 = kucunService.findById(pd);
        pd2.put("GOODS_NAME", pd.getString("GOODS_NAME"));
        pd2.put("ZCOUNT", pd.getString("ZCOUNT"));
        pd2.put("PRICE", pd.getString("PRICE"));
        pd2.put("ZPRICE", pd.getString("ZPRICE"));
        pd2.put("SPBRAND_ID", pd.getString("SPBRAND_ID"));
        pd2.put("SPTYPE_ID", pd.getString("SPTYPE_ID"));
        pd2.put("SPUNIT_ID", pd.getString("SPUNIT_ID"));
        kucunService.edit(pd2);
        mv.addObject("msg", "success");
        mv.setViewName("save_result");
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
        pd = kucunService.findById(pd);    //根据ID读取
        String count = pd.getString("ZCOUNT");
        String[] str = count.split("\\.");
        if (str[1].toString().equals("00")) {
            pd.put("ZCOUNT", str[0]);
        } else {
            pd.put("ZCOUNT", count);
        }
        List<PageData> spbrandList = spbrandService.listAll();    //品牌列表
        List<PageData> sptypeList = sptypeService.listAll();
        List<PageData> spunitList = spunitService.listAll();
        mv.setViewName("erp/kucun/kucun_edit");
        mv.addObject("msg", "edit");
        mv.addObject("spbrandList", spbrandList);
        mv.addObject("sptypeList", sptypeList);
        mv.addObject("spunitList", spunitList);
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
        logBefore(logger, Jurisdiction.getUsername() + "批量删除库存");
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
            kucunService.deleteAll(ArrayDATA_IDS);
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
        logBefore(logger, Jurisdiction.getUsername() + "导出库存到excel");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
            return null;
        }
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        Map<String, Object> dataMap = new HashMap<String, Object>();
        List<String> titles = new ArrayList<String>();
        titles.add("商品名称");    //1
        titles.add("仓库存量");    //2
        titles.add("商品成本");    //3
        titles.add("商品类别");    //4
        titles.add("品牌");    //5
        dataMap.put("titles", titles);
        String keywords = pd.getString("keywords");                    //关键词检索条件
        if (null != keywords && !"".equals(keywords)) {
            pd.put("keywords", keywords.trim());
        }
        pd.put("isKucun", "yes");
        page.setShowCount(30000);                                    //最大条数 3万条
        page.setPd(pd);
        List<PageData> varOList = kucunService.list(page);            //列出Kuncun列表
        List<PageData> varList = new ArrayList<PageData>();
        for (int i = 0; i < varOList.size(); i++) {
            PageData vpd = new PageData();
            vpd.put("var1", varOList.get(i).getString("GOODS_NAME"));        //1
            String count = varOList.get(i).getString("ZCOUNT");
            String[] str = count.split("\\.");
            if (str[1].toString().equals("00")) {
                vpd.put("var2", str[0] + "(" + varOList.get(i).getString("UNAME") + ")");    //2
            } else {
                vpd.put("var2", count + "(" + varOList.get(i).getString("UNAME") + ")");    //2
            }
            vpd.put("var3", varOList.get(i).getString("PRICE"));        //3
            vpd.put("var4", varOList.get(i).getString("TNAME"));        //4
            vpd.put("var5", varOList.get(i).getString("BNAME"));        //5
            varList.add(vpd);
        }
        dataMap.put("varList", varList);
        ObjectExcelView erv = new ObjectExcelView();
        mv = new ModelAndView(erv, dataMap);
        return mv;
    }

}

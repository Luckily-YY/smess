package com.chen.smess.app.controller.erp.sale;

import com.chen.smess.app.controller.base.BaseController;
import com.chen.smess.domain.common.utils.*;
import com.chen.smess.domain.model.Page;
import com.chen.smess.domain.service.erp.goods.GoodsManager;
import com.chen.smess.domain.service.erp.goods.impl.GoodsService;
import com.chen.smess.domain.service.erp.intoku.IntoKuManager;
import com.chen.smess.domain.service.erp.kucun.KucunManager;
import com.chen.smess.domain.service.erp.sale.impl.SaleService;
import com.chen.smess.domain.service.erp.spbrand.SpbrandManager;
import com.chen.smess.domain.service.erp.sptype.SptypeManager;
import com.chen.smess.domain.service.erp.spunit.SpunitManager;
import com.chen.smess.domain.service.erp.weight.impl.WeightService;
import com.chen.smess.domain.service.pictures.PicturesManager;
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
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 说明：商品销售
 */
@Controller
@RequestMapping(value = "/sale")
public class SaleController extends BaseController {

    @Resource(name = "saleService")
    private SaleService saleService;
    @Resource(name = "goodsService")
    private GoodsService goodsService;
    @Resource(name = "weightService")
    private WeightService weightService;

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
     * 删除清单
     */
    @RequestMapping(value = "/delsale")
    public ModelAndView delsale() throws Exception{
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
            pageData.put("GOODS_NAME",pageData.getString("TITLE"));
            pageData.put("GOODS_ID",pageData.getString("GOODS_ID"));
            pageData.put("PRICE",pageData.getString("GPRICE"));
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
            pageData.put("GOODS_NAME",pageData.getString("GOODS_NAME"));
            pageData.put("GOODS_ID",pageData.getString("GOODS_ID"));
            pageData.put("GOODS_COUNT",pageData.getString("WEIGHT"));
            pageData.put("PRICE",pageData.getString("WPRICE"));
            pageData.put("Z_PRICE",pageData.getString("WZPRICE"));
            map.put("pd", pageData);
        } else {
            errInfo = "error";
        }
        map.put("result", errInfo);
        return AppUtil.returnObject(new PageData(), map);
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
    }
}

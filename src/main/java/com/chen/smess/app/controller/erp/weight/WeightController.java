package com.chen.smess.app.controller.erp.weight;

import com.chen.smess.app.controller.base.BaseController;
import com.chen.smess.domain.common.utils.*;
import com.chen.smess.domain.model.Page;
import com.chen.smess.domain.service.erp.goods.GoodsManager;
import com.chen.smess.domain.service.erp.sale.SaleManager;
import com.chen.smess.domain.service.erp.salereport.SaleReportManager;
import com.chen.smess.domain.service.erp.weight.WeightManager;
import com.hazelcast.collection.impl.txnqueue.operations.TxnOfferOperation;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.swing.text.html.FormSubmitEvent;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * 说明：商品称量
 */
@Controller
@RequestMapping(value = "/weight")
public class WeightController extends BaseController {

    @Resource(name = "goodsService")
    private GoodsManager goodsService;
    @Resource(name = "weightService")
    private WeightManager weightService;

    /**
     * 打开前台称量页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/weightShow")
    public ModelAndView weightShow() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("USERNAME", Jurisdiction.getUsername().toString());
        pd.put("keyone", "克");
        pd.put("keytwo", "g");
        pd.put("keythree", "斤");
        PageData bm = new PageData();
        List<PageData> goodsList = goodsService.weightList(pd);
        List<PageData> exitlist = weightService.listAll(pd);
        if (exitlist != null && exitlist.size() > 0) {
            bm = weightService.findBm(pd);
        } else {
            bm.put("WBIANMA", "000000000000");
        }
        mv.addObject("goodsList", goodsList);
        mv.addObject("pd", bm);
        mv.setViewName("erp/weight/weight_view");
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
        pd.put("USERNAME", Jurisdiction.getUsername().toString());

        PageData dataByBm = goodsService.findDataByBm(pd);
        if (!dataByBm.getString("SPUNIT_ID").toString().isEmpty()) {
            pd.put("keyone", "克");
            pd.put("keytwo", "g");
            pd.put("keythree", "斤");
            //从库存读取数据
            List<PageData> list = goodsService.weightList(pd);
            if (list != null && list.size() > 0 && list.size() < 2) {
                for (PageData pageData : list) {
                    pageData.put("GOODS_NAME", pageData.getString("TITLE"));
                    pageData.put("GOODS_ID", pageData.getString("GOODS_ID"));
                    pageData.put("PRICE", pageData.getString("GPRICE"));
                    map.put("pd", pageData);
                }
            } else {
                errInfo = "error";
            }
        } else {
            dataByBm.put("GOODS_NAME", dataByBm.getString("TITLE"));
            dataByBm.put("GOODS_ID", dataByBm.getString("GOODS_ID"));
            dataByBm.put("PRICE", dataByBm.getString("GPRICE"));
            dataByBm.put("UNAME", "kg");
            map.put("pd", dataByBm);
        }
        map.put("result", errInfo);
        return AppUtil.returnObject(new PageData(), map);
    }

    /**
     * 通过产品id
     *
     * @throws Exception
     */
    @RequestMapping(value = "/getGoodsById")
    @ResponseBody
    public Object getGoodsById() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "通过产品id获取信息");
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = new PageData();
        pd = this.getPageData();
        String errInfo = "success";
        PageData pageData = goodsService.findById(pd);
        if (pageData != null) {
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
        pd.put("WEIGHT_ID", this.get32UUID());
        Date date = new Date();
        pd.put("CREATEDTIME", Tools.date2Str(date));
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(calendar.DATE, 1);
        date = calendar.getTime();
        pd.put("LASTTIME", Tools.date2Str(date));
        PageData gpd = goodsService.findByIdToCha(pd);
        PageData goodpd = goodsService.findById(pd);
        if (goodpd.getString("SPUNIT_ID") != null) {
            pd.put("NAME", gpd.getString("UNAME"));
        } else {
            pd.put("NAME", "kg");
        }
        String barcodeImgId = pd.getString("GOODS_ID") + ".png";                                    //barcodeImgId此处条形码的图片名
        String filePath = PathUtil.getClasspath() + Const.FILEPATHTBARCODE + barcodeImgId;        //存放路径
        BarcodeUtil.generateFile(pd.getString("WBIANMA"), filePath);
        mv.addObject("pd", pd);
        mv.setViewName("erp/weight/weight_ddprint");
        return mv;
    }

    /**
     * 通过产品编码
     *
     * @throws Exception
     */
    @RequestMapping(value = "/findsameBm")
    @ResponseBody
    public Object findsameBm() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "通过产品编码获取信息");
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = new PageData();
        pd = this.getPageData();
        String errInfo = "success";
        PageData pageData = weightService.findByBm(pd);
        if (pageData != null) {
            errInfo = "error";
            map.put("result", errInfo);
        } else {
            map.put("result", errInfo);
        }
        return AppUtil.returnObject(new PageData(), map);
    }

    /**
     * 调用打印机
     *
     * @throws Exception
     */
    @RequestMapping(value = "/printWeight")
    @ResponseBody
    public Object printWeight() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "打印购物清单");
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("USERNAME", Jurisdiction.getUsername().toString());
        String errInfo = "success";
        try {
            weightService.save(pd);
        } catch (Exception e) {
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

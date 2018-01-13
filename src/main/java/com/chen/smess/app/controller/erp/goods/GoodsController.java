package com.chen.smess.app.controller.erp.goods;

import com.chen.smess.app.controller.base.BaseController;
import com.chen.smess.domain.common.utils.*;
import com.chen.smess.domain.model.Page;
import com.chen.smess.domain.service.erp.goods.GoodsManager;
import com.chen.smess.domain.service.erp.kucun.KucunManager;
import com.chen.smess.domain.service.erp.spbrand.SpbrandManager;
import com.chen.smess.domain.service.erp.sptype.SptypeManager;
import com.chen.smess.domain.service.erp.spunit.SpunitManager;
import com.chen.smess.domain.service.pictures.PicturesManager;
import org.omg.PortableServer.LIFESPAN_POLICY_ID;
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
 * 说明：商品管理
 */
@Controller
@RequestMapping(value = "/goods")
public class GoodsController extends BaseController {

    String menuUrl = "goods/list.do"; //菜单地址(权限用)
    @Resource(name = "goodsService")
    private GoodsManager goodsService;
    @Resource(name = "picturesService")
    private PicturesManager picturesService;
    @Resource(name = "spbrandService")
    private SpbrandManager spbrandService;
    @Resource(name = "sptypeService")
    private SptypeManager sptypeService;
    @Resource(name = "spunitService")
    private SpunitManager spunitService;
    @Resource(name = "kucunService")
    private KucunManager kucunService;

    /**
     * 保存
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/save")
    public ModelAndView save() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "新增Goods");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
            return null;
        } //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("USERNAME", Jurisdiction.getUsername());    //用户名
        PageData goods = kucunService.findByGoodsId(pd);
        pd.put("TITLE", goods.get("GOODS_NAME"));
        goodsService.save(pd);
        BigDecimal zcount = new BigDecimal(pd.getString("ZCOUNT"));
        BigDecimal gcount = new BigDecimal(pd.getString("GCOUNT"));
        Double newzcount = zcount.subtract(gcount).doubleValue();
        PageData pd2 = new PageData();
        pd2.put("KUCUN_ID", pd.getString("KUCUN_ID"));
        pd2.put("ZCOUNT", newzcount);
        kucunService.editKuCun(pd2);
        mv.addObject("msg", "success");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 修改
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/edit")
    public ModelAndView edit() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "修改Goods");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
            return null;
        } //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        PageData kucunpd = new PageData();
        kucunpd =  kucunService.findByGoodsId(pd);
        PageData oldpd = new PageData();
        oldpd = goodsService.findById(pd);
        pd.put("TITLE", kucunpd.get("GOODS_NAME"));
        System.out.println(pd.getString("GCOUNT")+"-------------------");
        goodsService.edit(pd);

        BigDecimal zcount = new BigDecimal( kucunpd.getString("ZCOUNT"));
        BigDecimal oldcount = new BigDecimal(oldpd.getString("GCOUNT"));
        BigDecimal newcount = new BigDecimal(pd.getString("GCOUNT"));
        DecimalFormat format = new DecimalFormat("#.00");
        Double newZ = newcount.subtract(oldcount).doubleValue();
        String a = format.format(newZ);
        BigDecimal newa = new BigDecimal(a);
        Double newZcount = zcount.subtract(newa).doubleValue();
        PageData pd2 = new PageData();
        pd2.put("KUCUN_ID", kucunpd.getString("KUCUN_ID"));
        pd2.put("ZCOUNT", newZcount);
        kucunService.editKuCun(pd2);

        mv.addObject("msg", "success");
        mv.setViewName("save_result");
        return mv;
    }


    /**
     * 删除
     *
     * @throws Exception
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public Object delete() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "删除Goods");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
            return null;
        } //校验权限
        Map<String, String> map = new HashMap<String, String>();
        PageData pd = new PageData();
        pd = this.getPageData();
        String errInfo = "success";
        //当商品下面有图片 或者 此商品已经上架 或者 库存不为0时 不能删除
        if (Integer.parseInt(picturesService.findCount(pd).get("zs").toString()) > 0 || Integer.parseInt(goodsService.findById(pd).get("GCOUNT").toString()) > 0) {
            errInfo = "false";
        } else {
            goodsService.delete(pd);
        }
        map.put("result", errInfo);
        return AppUtil.returnObject(new PageData(), map);
    }


    /**
     * 二维码页面
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/erweima")
    public ModelAndView erweima() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String encoderImgId = pd.getString("GOODS_ID") + ".png"; //encoderImgId此处二维码的图片名
        String filePath = PathUtil.getClasspath() + Const.FILEPATHTWODIMENSIONCODE + encoderImgId;        //存放路径
        TwoDimensionCode.encoderQRCode(pd.getString("url"), filePath, "png");                            //执行生成二维码
        mv.setViewName("erp/goods/goods_erweima");
        mv.addObject("pd", pd);
        return mv;
    }

    /**
     * 条形码页面
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/barcode")
    public ModelAndView barcode() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String barcodeImgId = pd.getString("GOODS_ID") + ".png";                                    //barcodeImgId此处条形码的图片名
        String filePath = PathUtil.getClasspath() + Const.FILEPATHTBARCODE + barcodeImgId;        //存放路径
        BarcodeUtil.generateFile(pd.getString("BIANMA"), filePath);                                //执行生成条形码
        mv.setViewName("erp/goods/goods_barcode");
        mv.addObject("pd", pd);
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
        logBefore(logger, Jurisdiction.getUsername() + "列表Goods");
        //if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String keywords = pd.getString("keywords");                //关键词检索条件
        if (null != keywords && !"".equals(keywords)) {
            pd.put("keywords", keywords.trim());
        }
        pd.put("USERNAME", "admin".equals(Jurisdiction.getUsername()) ? "" : Jurisdiction.getUsername());
        page.setPd(pd);
        List<PageData> varList = goodsService.list(page);    //列出Goods列表
        for (int i = 0; i < varList.size(); i++) {
            String count = varList.get(i).getString("GCOUNT");
            String[] str = count.split("\\.");
            if (str[1].toString().equals("00")) {
                if(!str[0].isEmpty()) {
                    varList.get(i).put("GCOUNT", str[0]);
                }
                else {
                    varList.get(i).put("GCOUNT", "0");
                }
            } else {
                if(!str[0].isEmpty()) {
                    varList.get(i).put("GCOUNT", count);
                }
                else {
                    varList.get(i).put("GCOUNT", "0"+count);
                }
            }
           // System.out.println("-------------------"+varList.get(i).getString("BIANMA")+"--------------------");
        }
        List<PageData> spbrandList = spbrandService.listAll();    //品牌列表
        List<PageData> sptypeList = sptypeService.listAll();        //类别列表
        List<PageData> spunitList = spunitService.listAll();        //计量单位列表
        mv.setViewName("erp/goods/goods_list");
        mv.addObject("varList", varList);
        mv.addObject("pd", pd);
        mv.addObject("spbrandList", spbrandList);
        mv.addObject("sptypeList", sptypeList);
        mv.addObject("spunitList", spunitList);
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
        List<PageData> list = kucunService.listAll(pd);
        List<PageData> spbrandList = spbrandService.listAll();    //品牌列表
        List<PageData> sptypeList = sptypeService.listAll();        //类别列表
        List<PageData> spunitList = spunitService.listAll();        //计量单位列表
        PageData pd2 = goodsService.findbm();
        pd.put("LASTBIANMA", pd2.getString("BIANMA"));
        mv.setViewName("erp/goods/goods_edit");
        mv.addObject("msg", "save");
        mv.addObject("goodsList", list);
        mv.addObject("pd", pd);
        mv.addObject("spbrandList", spbrandList);
        mv.addObject("sptypeList", sptypeList);
        mv.addObject("spunitList", spunitList);
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
        pd = goodsService.findById(pd);    //根据ID读取
        String count = pd.getString("GCOUNT");
        String[] str = count.split("\\.");
        if (str[1].toString().equals("00")) {
            if(!str[0].isEmpty()) {
                pd.put("GCOUNT", str[0]);
            }
            else {
                pd.put("GCOUNT","0");
            }
        } else {
            if(!str[0].isEmpty()) {
                pd.put("GCOUNT", count);
            }
            else {
                pd.put("GCOUNT", "0"+count);
            }
        }
        PageData list = kucunService.findByGoodsId(pd);
        List<PageData> spbrandList = spbrandService.listAll();    //品牌列表
        List<PageData> sptypeList = sptypeService.listAll();        //类别列表
        List<PageData> spunitList = spunitService.listAll();        //计量单位列表
        String kucuncount = list.getString("ZCOUNT");
        String[] strs = kucuncount.split("\\.");
        if (strs[1].toString().equals("00")) {
            if(!str[0].isEmpty()) {
                pd.put("ZCOUNT", strs[0]);
            }
            else {
                pd.put("ZCOUNT", "0");
            }
        } else {
            if(!str[0].isEmpty()) {
                pd.put("ZCOUNT", kucuncount);
            }
            else {
                pd.put("ZCOUNT", "0"+kucuncount);
            }
        }
        pd.put("PRICE", list.getString("PRICE"));
        mv.setViewName("erp/goods/goods_edit");
        mv.addObject("msg", "edit");
        mv.addObject("pd", pd);
        mv.addObject("spbrandList", spbrandList);
        mv.addObject("sptypeList", sptypeList);
        mv.addObject("spunitList", spunitList);
        return mv;
    }


    /**
     * 去查看商品页面
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/goView")
    public ModelAndView goView() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd = goodsService.findByIdToCha(pd);    //根据ID读取
        mv.setViewName("erp/goods/goods_view");
        mv.addObject("msg", "edit");
        mv.addObject("pd", pd);
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
        PageData pageData = goodsService.findById(pd);
        List<PageData> goodsList = goodsService.listByBm(pd);
        if(pageData != null)
        {
            errInfo = "IDerror";
            map.put("result", errInfo);
            return AppUtil.returnObject(new PageData(), map);
        }
        else if (goodsList.size() > 0) {
            errInfo = "error";
            map.put("result", errInfo);
            return AppUtil.returnObject(new PageData(), map);
        }
        map.put("result", errInfo);
        return AppUtil.returnObject(new PageData(), map);
    }


    /**
     * 产品编码发生更改
     *
     * @throws Exception
     */
    @RequestMapping(value = "/changeBm")
    @ResponseBody
    public Object changeBm() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "通过产品编码获取信息");
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = new PageData();
        pd = this.getPageData();
        String errInfo = "success";
        List<PageData> goodsList = goodsService.listByBm(pd);
        if (goodsList.size() > 0) {
            errInfo = "error";
            map.put("result", errInfo);
            return AppUtil.returnObject(new PageData(), map);
        }
        map.put("result", errInfo);
        return AppUtil.returnObject(new PageData(), map);
    }


    /**
     * 通过产品id
     *
     * @throws Exception
     */
    @RequestMapping(value = "/getById")
    @ResponseBody
    public Object getById() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "通过产品id获取信息");
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = new PageData();
        pd = this.getPageData();
        String errInfo = "success";
        //从库存读取数据
        PageData pageData = kucunService.findByGoodsId(pd);
        if (pageData != null) {
            map.put("pd", pageData);
        } else {
            errInfo = "errer";
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

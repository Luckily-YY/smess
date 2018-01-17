package com.chen.smess.app.controller.erp.outku;

import com.chen.smess.app.controller.base.BaseController;
import com.chen.smess.domain.common.utils.*;
import com.chen.smess.domain.model.Page;
import com.chen.smess.domain.service.erp.customer.CustomerManager;
import com.chen.smess.domain.service.erp.goods.GoodsManager;
import com.chen.smess.domain.service.erp.kucun.KucunManager;
import com.chen.smess.domain.service.erp.outku.OutKuManager;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;


/** 
 * 说明：商品出库
 */
@Controller
@RequestMapping(value="/outku")
public class OutKuController extends BaseController {
	
	String menuUrl = "outku/list.do"; //菜单地址(权限用)
	@Resource(name="outkuService")
	private OutKuManager outkuService;
	@Resource(name="goodsService")
	private GoodsManager goodsService;
	@Resource(name="kucunService")
	private KucunManager kucunService;
	@Resource(name="customerService")
	private CustomerManager customerService;


	/**保存
	 * @param
	 * @throws Exception
	 *//*
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增OutKu");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData goodpd = new PageData();
		goodpd = goodsService.findById(pd);
		pd.put("OUTKU_ID", this.get32UUID());				//主键
		pd.put("OUTTIME", Tools.date2Str(new Date()));		//出库时间
		pd.put("GOODS_NAME", goodpd.getString("TITLE"));	//商品名称
		pd.put("ORDER_NUMBER", "D"+ DateUtil.getSdfTimes()+Tools.getRandomNum());//订单编号
		pd.put("USERNAME", Jurisdiction.getUsername());		//用户名
		outkuService.save(pd);
		//消减库存
		BigDecimal zcount = new BigDecimal(goodpd.get("ZCOUNT").toString());
		BigDecimal incount = new BigDecimal(pd.get("INCOUNT").toString());
		String zs = zcount.subtract(incount).toString();
		goodpd.put("ZCOUNT", zs);
		goodsService.editCountNum(goodpd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}*/
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/chooseSave")
	public ModelAndView chooseSave() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增OutKu");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData goodpd = new PageData();
		goodpd = kucunService.findByGoodsId(pd);
		pd.put("OUTKU_ID", this.get32UUID());				//主键
		pd.put("USERNAME", Jurisdiction.getUsername());		//用户名
		outkuService.save(pd);
		/*mv.setViewName("erp/outku/outku_getChoose");*/
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/chooseEdit")
	public ModelAndView chooseEdit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改OutKu");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USERNAME", Jurisdiction.getUsername());		//用户名
		outkuService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	/**删除
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public Object delete() throws Exception {
		logBefore(logger, Jurisdiction.getUsername()+"删除OutKu");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		outkuService.delete(pd);
		Map<String, String> map = new HashMap<String, String>();
		String errInfo = "success";
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改OutKu");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		outkuService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表OutKu");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String lastStart = pd.getString("lastStart");	//开始时间
		String lastEnd = pd.getString("lastEnd");		//结束时间
		if(lastStart != null && !"".equals(lastStart)){
			pd.put("lastStart", lastStart+" 00:00:00");
		}
		if(lastEnd != null && !"".equals(lastEnd)){
			pd.put("lastEnd", lastEnd+" 00:00:00");
		} 
		pd.put("USERNAME", Jurisdiction.getUsername());
		PageData jinepd = outkuService.priceSum(pd);	//总金额
		String zprice = "0.00";
		if(null != jinepd){
			zprice = jinepd.get("ZPRICE").toString();
		}
		page.setPd(pd);
		List<PageData>	varList = outkuService.list(page);	//列出OutKu列表
		for (int i = 0; i < varList.size(); i++) {
			String count = varList.get(i).getString("OUTCOUNT");
			String[] str = count.split("\\.");
			if (str[1].toString().equals("00")) {
				varList.get(i).put("OUTCOUNT", str[0]);
			} else {
				varList.get(i).put("OUTCOUNT", count);
			}
		}
		mv.setViewName("erp/outku/outku_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("zprice", zprice);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	/**未选择客户的出货列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/getChoose")
	public ModelAndView getChoose(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表OutKu");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> kucunList = kucunService.listAll(pd);
		pd.put("USERNAME", Jurisdiction.getUsername());
		page.setPd(pd);
		List<PageData>	pageList = outkuService.getChoose(page);	//列出OutKu列表
		List<PageData>	varList = new ArrayList<PageData>();
		for(PageData pageData : pageList){
			PageData ps2 = kucunService.findByGoodsId(pageData);
			pageData.put("PRICE",ps2.getString("PRICE"));
			varList.add(pageData);
		}
		for (int i = 0; i < varList.size(); i++) {
			String count = varList.get(i).getString("OUTCOUNT");
			String[] str = count.split("\\.");
			if (str[1].toString().equals("00")) {
				varList.get(i).put("OUTCOUNT", str[0]);
			} else {
				varList.get(i).put("OUTCOUNT", count);
			}
		}
		mv.setViewName("erp/outku/outku_getChoose");
		mv.addObject("kucunList", kucunList);
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}

	/**商品销售报表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/salesReport")
	public ModelAndView salesReport(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"销售报表");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");		//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String lastStart = pd.getString("lastStart");	//开始时间
		String lastEnd = pd.getString("lastEnd");		//结束时间
		if(lastStart != null && !"".equals(lastStart)){
			pd.put("lastStart", lastStart+" 00:00:00");
		}
		if(lastEnd != null && !"".equals(lastEnd)){
			pd.put("lastEnd", lastEnd+" 00:00:00");
		} 
		page.setPd(pd);
		List<PageData>	varList = outkuService.salesReport(page);
		for (int i = 0; i < varList.size(); i++) {
			String count = varList.get(i).getString("ZCOUNT");
			String[] str = count.split("\\.");
			if (str[1].toString().equals("00")) {
					varList.get(i).put("ZCOUNT", str[0]);
			} else {
					varList.get(i).put("ZCOUNT", count);
			}
		}
		mv.setViewName("erp/outku/salesReport");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("erp/outku/outku_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}


	/**
	 * 通过产品id
	 *
	 * @throws Exception
	 */
	@RequestMapping(value = "/goChooseAdd")
	public ModelAndView goChooseAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		logBefore(logger, Jurisdiction.getUsername() + "通过产品id获取信息");
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = kucunService.findByGoodsId(pd);
		String count = pd.getString("ZCOUNT");
		String[] str = count.split("\\.");
		if (str[1].toString().equals("00")) {
				pd.put("ZCOUNT", str[0]);

		} else {
				pd.put("ZCOUNT", count);
		}
		pd.put("ZPRICE","");
		mv.addObject("msg", "chooseSave");
		mv.setViewName("erp/outku/outku_chooseadd");
		mv.addObject("pd", pd);

		return mv;
	}
	/**
	 * 通过产品id
	 *
	 * @throws Exception
	 */
	@RequestMapping(value = "/goChooseEdit")
	public ModelAndView goChooseEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		logBefore(logger, Jurisdiction.getUsername() + "通过产品id获取信息");
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData pageData = new PageData();
		pageData = this.getPageData();
		pageData = kucunService.findByGoodsId(pd);
		pd = outkuService.findById(pd);
		String count = pageData.getString("ZCOUNT");
		String[] str = count.split("\\.");
		if (str[1].toString().equals("00")) {
				pd.put("ZCOUNT", str[0]);
		} else {
				pd.put("ZCOUNT", count);
		}
		pd.put("PRICE",pageData.getString("PRICE"));
		mv.addObject("msg", "chooseEdit");
		mv.setViewName("erp/outku/outku_chooseadd");
		mv.addObject("pd", pd);

		return mv;
	}

	/**
	 * 根据id查询出库单
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getAllByIds")
	@ResponseBody
	public Object getAllByIds() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "查找库存id是否存在");
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String info = "success";
		PageData pageData = outkuService.findById(pd);
		String outCount = pageData.getString("OUTCOUNT");
		PageData goodsDate = kucunService.findByGoodsId(pageData);
		String zCount = goodsDate.getString("ZCOUNT");
		BigDecimal outDecimal = new BigDecimal(outCount);
		BigDecimal countDecimal = new BigDecimal(zCount);
		if (countDecimal.subtract(outDecimal).doubleValue()>=0.00) {
				map.put("result", info);
				return AppUtil.returnObject(new PageData(), map);
		} else {
			info = "error";
			map.put("result", info);
			return AppUtil.returnObject(new PageData(), map);
		}
	}

	/**
	 * 添加客户到订货单
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateAll")
	@ResponseBody
	public Object updateAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername() + "批量添加客户到订单");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return null;
		} //校验权限
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		PageData customerDate = customerService.findById(pd);
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if (null != DATA_IDS && !"".equals(DATA_IDS)) {
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0;i<ArrayDATA_IDS.length;i++)
			{
				pd.put("OUTKU_ID",ArrayDATA_IDS[i]);
				pd = outkuService.findById(pd);
				pd.put("CUSTOMER_NAME",customerDate.getString("NAME"));
				pd.put("CUSTOMER_ID",customerDate.getString("CUSTOMER_ID"));
				pd.put("OUTTIME", Tools.date2Str(new Date()));		//出库时间
				pd.put("ORDER_NUMBER", "D"+ DateUtil.getSdfTimes()+Tools.getRandomNum());//订单编号
				outkuService.edit(pd);
				PageData kucunPd = kucunService.findByGoodsId(pd);
				String kucunCount = kucunPd.getString("ZCOUNT");

				String outCount = pd.getString("OUTCOUNT");

				BigDecimal outDecimal = new BigDecimal(outCount);
				BigDecimal kucuncountDecimal = new BigDecimal(kucunCount);
				String newCount = kucuncountDecimal.subtract(outDecimal).toString();
				String price = kucunPd.getString("PRICE");
				BigDecimal b1 = new BigDecimal(price);
				BigDecimal b2 = new BigDecimal(newCount);
				String zprice = b1.multiply(b2).toString();
				kucunPd.put("ZPRICE",zprice);
				kucunPd.put("ZCOUNT",newCount);
				kucunService.edit(kucunPd);
			}
			map.put("msg", "ok");
		} else {
			map.put("msg", "no");
		}

		return AppUtil.returnObject(new PageData(), map);
	}

	/**去打印出库(订)单页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/ddpirnt")
	public ModelAndView ddpirnt()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = outkuService.findById(pd);	//根据ID读取
		mv.setViewName("erp/outku/outku_ddprint");
		mv.addObject("pd", pd);
		return mv;
	}
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = outkuService.findById(pd);	//根据ID读取
		mv.setViewName("erp/outku/outku_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出出库到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("商品名称");	//1
		titles.add("数量");		//2
		titles.add("单价");		//3
		titles.add("总价");		//4
		titles.add("出库时间");	//5
		titles.add("客户");		//6
		titles.add("订单号");	//8
		dataMap.put("titles", titles);
		String keywords = pd.getString("keywords");			//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String lastStart = pd.getString("lastStart");		//开始时间
		String lastEnd = pd.getString("lastEnd");			//结束时间
		if(lastStart != null && !"".equals(lastStart)){
			pd.put("lastStart", lastStart+" 00:00:00");
		}
		if(lastEnd != null && !"".equals(lastEnd)){
			pd.put("lastEnd", lastEnd+" 00:00:00");
		} 
		pd.put("USERNAME", Jurisdiction.getUsername());
		PageData jinepd = outkuService.priceSum(pd);		//总金额
		String zprice = "0";
		if(null != jinepd){
			zprice = jinepd.get("ZPRICE").toString();
		}
		page.setShowCount(30000);							//最大条数 3万条
		page.setPd(pd);
		List<PageData>	varOList = outkuService.list(page);	//列出OutKu列表
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("GOODS_NAME"));		//1
			vpd.put("var2", varOList.get(i).get("INCOUNT").toString());		//2
			vpd.put("var3", varOList.get(i).get("PRICE").toString()+"元");	//3
			vpd.put("var4", varOList.get(i).get("ZPRICE").toString()+"元");	//4
			vpd.put("var5", varOList.get(i).getString("OUTTIME"));	    	//5
			vpd.put("var6", varOList.get(i).getString("CUSTOMER_NAME"));	//6
			vpd.put("var7", varOList.get(i).getString("ORDER_NUMBER"));		//7
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	/**销售报表导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel2")
	public ModelAndView exportExcel2(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出销售报表到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("商品名称");	//1
		titles.add("销量");		//2
		titles.add("销售额");	//3
		dataMap.put("titles", titles);
		String keywords = pd.getString("keywords");		//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String lastStart = pd.getString("lastStart");	//开始时间
		String lastEnd = pd.getString("lastEnd");		//结束时间
		if(lastStart != null && !"".equals(lastStart)){
			pd.put("lastStart", lastStart+" 00:00:00");
		}
		if(lastEnd != null && !"".equals(lastEnd)){
			pd.put("lastEnd", lastEnd+" 00:00:00");
		} 
		pd.put("USERNAME", Jurisdiction.getUsername());
		page.setShowCount(30000);							//最大条数 3万条
		page.setPd(pd);
		List<PageData>	varOList = outkuService.salesReport(page);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("GOODS_NAME"));		//1
			vpd.put("var2", varOList.get(i).get("ZCOUNT").toString());		//2
			vpd.put("var3", varOList.get(i).get("ZPRICE").toString()+"元");	//3
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}

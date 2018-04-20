package com.chen.smess.domain.service.erp.salereport.impl;

import com.chen.smess.domain.common.utils.PageData;
import com.chen.smess.domain.mapper.DaoSupport;
import com.chen.smess.domain.model.Page;
import com.chen.smess.domain.service.erp.sale.SaleManager;
import com.chen.smess.domain.service.erp.salereport.SaleReportManager;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


/** 
 * 说明： 商品出库
 * @version
 */
@Service("saleReportService")
public class SaleReportService implements SaleReportManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("SaleReportMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("SaleReportMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("SaleReportMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SaleReportMapper.datalistPage", page);
	}
	
	/**商品销售报表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> salesReport(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SaleReportMapper.SalesReportlistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("SaleReportMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("SaleReportMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("SaleReportMapper.deleteAll", ArrayDATA_IDS);
	}

	/**总金额
	 * @param pd
	 * @throws Exception
	 */
	public PageData priceSum(PageData pd) throws Exception {
		return (PageData)dao.findForObject("SaleReportMapper.priceSum", pd);
	}

	/**
	 * 查找未确定出库的订单
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getChoose(Page page) throws Exception{
		return (List<PageData>)dao.findForList("SaleReportMapper.listPage", page);
	}

}


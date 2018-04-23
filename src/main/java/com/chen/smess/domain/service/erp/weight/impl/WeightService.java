package com.chen.smess.domain.service.erp.weight.impl;

import com.chen.smess.domain.common.utils.PageData;
import com.chen.smess.domain.mapper.DaoSupport;
import com.chen.smess.domain.model.Page;
import com.chen.smess.domain.service.erp.sale.SaleManager;
import com.chen.smess.domain.service.erp.weight.WeightManager;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


/** 
 * 说明： 商品出库
 * @version
 */
@Service("weightService")
public class WeightService implements WeightManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("WeightMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("WeightMapper.delete", pd);
	}

	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("WeightMapper.datalistPage", page);
	}

	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("WeightMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("WeightMapper.findById", pd);
	}
	/**通查询最后一个编码
	 * @param pd
	 * @throws Exception
	 */
	public PageData findBm(PageData pd)throws Exception{
		return (PageData)dao.findForObject("WeightMapper.findBm", pd);
	}
	/**通过编码获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByBm(PageData pd)throws Exception{
		return (PageData)dao.findForObject("WeightMapper.findByBm", pd);
	}

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("WeightMapper.deleteAll", ArrayDATA_IDS);
	}

}


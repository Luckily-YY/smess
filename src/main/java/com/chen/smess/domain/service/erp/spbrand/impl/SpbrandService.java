package com.chen.smess.domain.service.erp.spbrand.impl;

import com.chen.smess.domain.common.utils.PageData;
import com.chen.smess.domain.mapper.DaoSupport;
import com.chen.smess.domain.model.Page;
import com.chen.smess.domain.service.erp.spbrand.SpbrandManager;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/** 
 * 说明： 品牌管理
 * @version
 */
@Service("spbrandService")
public class SpbrandService implements SpbrandManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("SpbrandMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("SpbrandMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("SpbrandMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SpbrandMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll()throws Exception{
		return (List<PageData>)dao.findForList("SpbrandMapper.listAll", null);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("SpbrandMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("SpbrandMapper.deleteAll", ArrayDATA_IDS);
	}
	
}


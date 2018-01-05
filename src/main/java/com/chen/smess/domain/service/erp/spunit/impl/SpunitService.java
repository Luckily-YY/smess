package com.chen.smess.domain.service.erp.spunit.impl;

import com.chen.smess.domain.common.utils.PageData;
import com.chen.smess.domain.mapper.DaoSupport;
import com.chen.smess.domain.model.Page;
import com.chen.smess.domain.service.erp.spunit.SpunitManager;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/** 
 * 说明： 计量单位
 */
@Service("spunitService")
public class SpunitService implements SpunitManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("SpunitMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("SpunitMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("SpunitMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("SpunitMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(String USERNAME)throws Exception{
		return (List<PageData>)dao.findForList("SpunitMapper.listAll", USERNAME);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("SpunitMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("SpunitMapper.deleteAll", ArrayDATA_IDS);
	}
	
}


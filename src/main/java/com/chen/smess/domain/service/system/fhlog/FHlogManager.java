package com.chen.smess.domain.service.system.fhlog;

import com.chen.smess.domain.common.utils.PageData;
import com.chen.smess.domain.model.Page;

import java.util.List;


/** 
 * 说明： 操作日志记录接口
 * @version
 */
public interface FHlogManager{

	/**新增
	 * @throws Exception
	 */
	public void save(String USERNAME, String CONTENT)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
}


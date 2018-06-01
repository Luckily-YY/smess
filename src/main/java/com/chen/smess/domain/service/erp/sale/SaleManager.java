package com.chen.smess.domain.service.erp.sale;

import com.chen.smess.domain.common.utils.PageData;
import com.chen.smess.domain.model.Page;

import java.util.List;


/** 
 * 说明： 商品出库接口
 * @version
 */
public interface SaleManager {

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**商品销售报表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> salesReport(Page page)throws Exception;
	
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
	 * @param pd
	 * @throws Exception
	 */
	public void deleteAll(PageData pd)throws Exception;
	
	/**总金额
	 * @param pd
	 * @throws Exception
	 */
	public PageData priceSum(PageData pd) throws Exception;

	/**
	 * 获取未添加客户的出货列表
	 * @param page
	 * @return
	 */
    public List<PageData> getChoose(Page page) throws Exception;

	/**
	 * 通过商品id与销售者查找货物清单
	 * @param pd
	 * @return
	 */
	public PageData findByGoodsId(PageData pd) throws Exception;
}


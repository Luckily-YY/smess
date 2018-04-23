package com.chen.smess.domain.service.erp.goods;

import com.chen.smess.domain.common.utils.PageData;
import com.chen.smess.domain.model.Page;

import java.util.List;


/**
 * 说明： 商品管理接口
 */
public interface GoodsManager{

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

	/**修改库存
	 * @param pd
	 * @throws Exception
	 */
	public void editCountNum(PageData pd)throws Exception;

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

	/**通过产品编码
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listByBm(PageData pd)throws Exception;
	/**通过产品计量单位
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> weightList(PageData pd)throws Exception;

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;

	/**通过id获取数据(查看详细信息)
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByIdToCha(PageData pd)throws Exception;

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;

	/**商品入库，增加库存
	 * @param pd
	 * @throws Exception
	 */
	public void editZCOUNT(PageData pd)throws Exception;

	/**
	 * 查询上一个编码
	 * @throws Exception
	 */
	public PageData findbm() throws Exception;
	/**
	 * 通过编码查询
	 * @throws Exception
	 */
	public PageData findByBm(PageData pd) throws Exception;

}


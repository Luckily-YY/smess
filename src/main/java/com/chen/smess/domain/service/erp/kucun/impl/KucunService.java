package com.chen.smess.domain.service.erp.kucun.impl;

import com.chen.smess.domain.common.utils.PageData;
import com.chen.smess.domain.mapper.DaoSupport;
import com.chen.smess.domain.model.Page;
import com.chen.smess.domain.service.erp.kucun.KucunManager;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 库存管理
 */
@Service("kucunService")
public class KucunService implements KucunManager{
    @Resource(name = "daoSupport")
    private DaoSupport dao;

    /**新增
     * @param pd
     * @throws Exception
     */
    public void save(PageData pd)throws Exception{
        dao.save("KucunMapper.save", pd);
    }

    /**删除
     * @param pd
     * @throws Exception
     */
    public void delete(PageData pd)throws Exception{
        dao.delete("KucunMapper.delete", pd);
    }

    /**修改
     * @param pd
     * @throws Exception
     */
    public void edit(PageData pd)throws Exception{
        dao.update("KucunMapper.edit", pd);
    }

    /**修改库存
     * @param pd
     * @throws Exception
     */
    public void editKuCun(PageData pd)throws Exception{
        dao.update("KucunMapper.editKuCun", pd);
    }

    /**列表
     * @param page
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<PageData> list(Page page)throws Exception{
        return (List<PageData>)dao.findForList("KucunMapper.datalistPage", page);
    }

    public List<PageData> findByObject(PageData pageData)throws Exception{
        return (List<PageData>)dao.findForList("KucunMapper.findforobject", pageData);
    }

    public PageData findByGoodsId(PageData pageData) throws Exception {
        return (PageData) dao.findForObject("KucunMapper.findforgoodsId",pageData);
    }

    /**列表(全部)
     * @param pd
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<PageData> listAll(PageData pd)throws Exception{
        return (List<PageData>)dao.findForList("KucunMapper.listAll", pd);
    }


    /**通过id获取数据
     * @param pd
     * @throws Exception
     */
    public PageData findById(PageData pd)throws Exception{
        return (PageData)dao.findForObject("KucunMapper.findById", pd);
    }

    /**通过id获取数据(查看详细信息)
     * @param pd
     * @throws Exception
     */
    public PageData findByIdToCha(PageData pd)throws Exception{
        return (PageData)dao.findForObject("KucunMapper.findByIdToCha", pd);
    }

    /**批量删除
     * @param ArrayDATA_IDS
     * @throws Exception
     */
    public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
        dao.delete("KucunMapper.deleteAll", ArrayDATA_IDS);
    }

    /**商品入库，增加库存
     * @param pd
     * @throws Exception
     */
    public void editZCOUNT(PageData pd)throws Exception{
        dao.update("KucunMapper.editZCOUNT", pd);
    }
}

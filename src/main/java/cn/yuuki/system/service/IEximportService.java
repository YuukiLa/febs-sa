package cn.yuuki.system.service;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import cn.yuuki.common.domain.QueryRequest;
import cn.yuuki.system.entity.system.Eximport;

import java.util.List;

/**
 * @author MrBird
 */
public interface IEximportService extends IService<Eximport> {
    /**
     * 查询（分页）
     *
     * @param request  QueryRequest
     * @param eximport eximport
     * @return IPage<Eximport>
     */
    IPage<Eximport> findEximports(QueryRequest request, Eximport eximport);


    /**
     * 批量插入
     *
     * @param list List<Eximport>
     */
    void batchInsert(List<Eximport> list);

}

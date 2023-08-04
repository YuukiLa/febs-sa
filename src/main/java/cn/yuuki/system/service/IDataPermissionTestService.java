package cn.yuuki.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import cn.yuuki.common.domain.QueryRequest;
import cn.yuuki.system.entity.system.DataPermissionTest;


/**
 * @author MrBird
 */
public interface IDataPermissionTestService extends IService<DataPermissionTest> {
    /**
     * 查询（分页）
     *
     * @param request            QueryRequest
     * @param dataPermissionTest dataPermissionTest
     * @return IPage<DataPermissionTest>
     */
    IPage<DataPermissionTest> findDataPermissionTests(QueryRequest request, DataPermissionTest dataPermissionTest);
}

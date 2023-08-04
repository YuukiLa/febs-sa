package cn.yuuki.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import cn.yuuki.common.annotation.DataPermission;
import cn.yuuki.system.entity.system.DataPermissionTest;

/**
 * @author MrBird
 */
@DataPermission(methods = {"selectPage"})
public interface DataPermissionTestMapper extends BaseMapper<DataPermissionTest> {

}

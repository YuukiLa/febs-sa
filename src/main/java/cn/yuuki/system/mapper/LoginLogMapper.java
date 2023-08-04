package cn.yuuki.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import cn.yuuki.system.entity.system.LoginLog;
import cn.yuuki.system.entity.system.SystemUser;

import java.util.List;
import java.util.Map;

/**
 * @author MrBird
 */
public interface LoginLogMapper extends BaseMapper<LoginLog> {

    /**
     * 获取系统总访问次数
     *
     * @return Long
     */
    Long findTotalVisitCount();

    /**
     * 获取系统今日访问次数
     *
     * @return Long
     */
    Long findTodayVisitCount();

    /**
     * 获取系统今日访问 IP数
     *
     * @return Long
     */
    Long findTodayIp();

    /**
     * 获取系统近十天来的访问记录
     *
     * @param user 用户
     * @return 系统近十天来的访问记录
     */
    List<Map<String, Object>> findLastTenDaysVisitCount(SystemUser user);

}
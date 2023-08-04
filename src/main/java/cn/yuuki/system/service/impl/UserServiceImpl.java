package cn.yuuki.system.service.impl;

import cn.dev33.satoken.secure.BCrypt;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.yuuki.common.exception.FebsException;
import cn.yuuki.common.service.RedisService;
import cn.yuuki.common.utils.FebsUtil;
import cn.yuuki.common.utils.SortUtil;
import lombok.RequiredArgsConstructor;
import cn.yuuki.common.domain.CurrentUser;
import cn.yuuki.common.domain.QueryRequest;
import cn.yuuki.common.domain.constant.FebsConstant;
import cn.yuuki.common.domain.constant.StringConstant;
import cn.yuuki.system.entity.system.Menu;
import cn.yuuki.system.entity.system.SystemUser;
import cn.yuuki.system.entity.system.UserDataPermission;
import cn.yuuki.system.entity.system.UserRole;
import cn.yuuki.system.mapper.MenuMapper;
import cn.yuuki.system.mapper.UserMapper;
import cn.yuuki.system.service.IUserDataPermissionService;
import cn.yuuki.system.service.IUserRoleService;
import cn.yuuki.system.service.IUserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @author MrBird
 */
@Service
@RequiredArgsConstructor
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class UserServiceImpl extends ServiceImpl<UserMapper, SystemUser> implements IUserService {

    private final IUserRoleService userRoleService;
    private final IUserDataPermissionService userDataPermissionService;

    private final MenuMapper menuMapper;

    private final RedisService redisService;


    @Override
    public SystemUser findByName(String username) {
        LambdaQueryWrapper<SystemUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(SystemUser::getUsername, username);
        return this.baseMapper.selectOne(queryWrapper);
    }

    @Override
    public IPage<SystemUser> findUserDetailList(SystemUser user, QueryRequest request) {
        Page<SystemUser> page = new Page<>(request.getPageNum(), request.getPageSize());
        SortUtil.handlePageSort(request, page, "userId", FebsConstant.ORDER_ASC, false);
        return this.baseMapper.findUserDetailPage(page, user);
    }

    @Override
    public SystemUser findUserDetail(String username) {
        SystemUser param = new SystemUser();
        param.setUsername(username);
        List<SystemUser> users = this.baseMapper.findUserDetail(param);
        return CollectionUtils.isNotEmpty(users) ? users.get(0) : null;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateLoginTime(String username) {
        SystemUser user = new SystemUser();
        user.setLastLoginTime(new Date());

        this.baseMapper.update(user, new LambdaQueryWrapper<SystemUser>().eq(SystemUser::getUsername, username));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void createUser(SystemUser user) {
        // 创建用户
        user.setCreateTime(new Date());
        user.setAvatar(SystemUser.DEFAULT_AVATAR);
        user.setPassword(BCrypt.hashpw(user.getPassword()));
        save(user);
        // 保存用户角色
        String[] roles = StringUtils.splitByWholeSeparatorPreserveAllTokens(user.getRoleId(), StringConstant.COMMA);
        setUserRoles(user, roles);
        // 保存用户数据权限关联关系
        // todo 数据权限先不管
//        String[] deptIds = StringUtils.splitByWholeSeparatorPreserveAllTokens(user.getDeptIds(), StringConstant.COMMA);
//        setUserDataPermissions(user, deptIds);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateUser(SystemUser user) {
        // 更新用户
        user.setPassword(null);
        user.setCreateTime(null);
        user.setModifyTime(new Date());
        updateById(user);

        String[] userIds = {String.valueOf(user.getUserId())};
        userRoleService.deleteUserRolesByUserId(userIds);
        String[] roles = StringUtils.splitByWholeSeparatorPreserveAllTokens(user.getRoleId(), StringConstant.COMMA);
        setUserRoles(user, roles);

        // todo 数据权限先不管
//        userDataPermissionService.deleteByUserIds(userIds);
//        String[] deptIds = StringUtils.splitByWholeSeparatorPreserveAllTokens(user.getDeptIds(), StringConstant.COMMA);
//        setUserDataPermissions(user, deptIds);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteUsers(String[] userIds) {
        List<String> list = Arrays.asList(userIds);
        removeByIds(list);
        // 删除用户角色
        this.userRoleService.deleteUserRolesByUserId(userIds);
//        this.userDataPermissionService.deleteByUserIds(userIds);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateProfile(SystemUser user) throws FebsException {
        user.setPassword(null);
        user.setUsername(null);
        user.setStatus(null);
        if (isCurrentUser(user.getUserId())) {
            updateById(user);
            this.refresh();
        } else {
            throw new FebsException("您无权修改别人的账号信息！");
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateAvatar(String avatar) {
        SystemUser user = new SystemUser();
        user.setAvatar(avatar);
        String currentUsername = FebsUtil.getCurrentUsername();
        this.baseMapper.update(user, new LambdaQueryWrapper<SystemUser>().eq(SystemUser::getUsername, currentUsername));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updatePassword(String password) {
        SystemUser user = new SystemUser();
        user.setPassword(BCrypt.hashpw(password));
        String currentUsername = FebsUtil.getCurrentUsername();
        this.baseMapper.update(user, new LambdaQueryWrapper<SystemUser>().eq(SystemUser::getUsername, currentUsername));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void resetPassword(String[] usernames) {
        SystemUser params = new SystemUser();
        params.setPassword(BCrypt.hashpw(SystemUser.DEFAULT_PASSWORD));

        List<String> list = Arrays.asList(usernames);
        this.baseMapper.update(params, new LambdaQueryWrapper<SystemUser>().in(SystemUser::getUsername, list));

    }

    @Override
    public void updateSidebarTheme(String theme) {
        CurrentUser currentUser = FebsUtil.getCurrentUser();
        if (currentUser != null) {
            Long userId = currentUser.getUserId();
            SystemUser user = new SystemUser();
            user.setUserId(userId);
            user.setTheme(theme);
            baseMapper.updateById(user);
        }
    }

    @Override
    public String findUserPermissions(String username) {
        List<Menu> userPermissions = menuMapper.findUserPermissions(username);
        return userPermissions.stream().map(Menu::getPerms).collect(Collectors.joining(","));
    }

    private void setUserRoles(SystemUser user, String[] roles) {
        List<UserRole> userRoles = new ArrayList<>();
        Arrays.stream(roles).forEach(roleId -> {
            UserRole userRole = new UserRole();
            userRole.setUserId(user.getUserId());
            userRole.setRoleId(Long.valueOf(roleId));
            userRoles.add(userRole);
        });
        userRoleService.saveBatch(userRoles);
    }

    private void setUserDataPermissions(SystemUser user, String[] deptIds) {
        List<UserDataPermission> userDataPermissions = new ArrayList<>();
        Arrays.stream(deptIds).forEach(deptId -> {
            UserDataPermission permission = new UserDataPermission();
            permission.setDeptId(Long.valueOf(deptId));
            permission.setUserId(user.getUserId());
            userDataPermissions.add(permission);
        });
        userDataPermissionService.saveBatch(userDataPermissions);
    }

    private boolean isCurrentUser(Long id) {
        CurrentUser currentUser = FebsUtil.getCurrentUser();
        return currentUser != null && id.equals(currentUser.getUserId());
    }

    @Override
    public void refresh() {
        SystemUser user = this.findUserDetail(FebsUtil.getCurrentUsername());
        this.saveUserToRedis(user);
    }

    @Override
    public CurrentUser saveUserToRedis(SystemUser user) {
        // 构建在线用户
        CurrentUser currentUser = new CurrentUser();
        currentUser.setUsername(user.getUsername());
        String userPermissions = this.findUserPermissions(user.getUsername());
        currentUser.setPermissions(userPermissions);
        BeanUtils.copyProperties(user,currentUser);
        //缓存用户
        redisService.set(FebsConstant.USER_CACHE_VALUE+user.getUsername(),currentUser);
        redisService.set(FebsConstant.USER_PERMISSION_CACHE_VALUE+user.getUsername(),userPermissions);
        return currentUser;
    }
}

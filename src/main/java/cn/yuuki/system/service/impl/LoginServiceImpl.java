package cn.yuuki.system.service.impl;

import cn.dev33.satoken.secure.BCrypt;
import cn.dev33.satoken.stp.StpUtil;
import cn.yuuki.common.exception.FebsException;
import cn.yuuki.common.service.RedisService;
import cn.yuuki.common.utils.FebsUtil;
import lombok.RequiredArgsConstructor;
import cn.yuuki.common.domain.CurrentUser;
import cn.yuuki.common.domain.constant.FebsConstant;
import cn.yuuki.system.entity.system.LoginLog;
import cn.yuuki.system.entity.system.SystemUser;
import cn.yuuki.system.service.ILoginLogService;
import cn.yuuki.system.service.ILoginService;
import cn.yuuki.system.service.IUserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;


@Service
@RequiredArgsConstructor
public class LoginServiceImpl implements ILoginService {

    private final RedisService redisService;
    private final IUserService userService;

    private final ILoginLogService loginLogService;

    @Override
    public Map<String, Object> login(String username,String password) throws Exception {

        username = StringUtils.lowerCase(username);

        final String errorMessage = "用户名或密码错误";
        SystemUser user = this.userService.findUserDetail(username);

        if (user == null)
            throw new FebsException(errorMessage);
        if (!BCrypt.checkpw(password,user.getPassword()))
            throw new FebsException(errorMessage);
        if (SystemUser.STATUS_LOCK.equals(user.getStatus()))
            throw new FebsException("账号已被锁定,请联系管理员！");
        StpUtil.login(user.getUsername());
        //保存用户到redis
        CurrentUser currentUser = userService.saveUserToRedis(user);
        // 更新用户登录时间
        this.userService.updateLoginTime(username);
        // 保存登录记录
        LoginLog loginLog = new LoginLog();
        loginLog.setUsername(username);
        HttpServletRequest request = FebsUtil.getHttpServletRequest();
        loginLog.setSystemBrowserInfo(request.getHeader("user-agent"));
        this.loginLogService.saveLoginLog(loginLog);
        return this.generateUserInfo(currentUser);
    }

    @Override
    public void logout() {

    }

//    public CurrentUser saveUserToRedis(SystemUser user) throws Exception {
//        // 构建在线用户
//        CurrentUser currentUser = new CurrentUser();
//        currentUser.setUsername(user.getUsername());
//        String userPermissions = userService.findUserPermissions(user.getUsername());
//        currentUser.setPermissions(userPermissions);
//        BeanUtils.copyProperties(user,currentUser);
//
//        //缓存用户
//        redisService.set(FebsConstant.USER_CACHE_VALUE+user.getUsername(),currentUser);
//        redisService.set(FebsConstant.USER_PERMISSION_CACHE_VALUE+user.getUsername(),userPermissions);
//        return currentUser;
//    }

    /**
     * 生成前端需要的用户信息，包括：
     * 1. token
     * 2. Vue Router
     * 3. 用户角色
     * 4. 用户权限
     * 5. 前端系统个性化配置信息
     *
     * @param user  用户信息
     * @return UserInfo
     */
    private Map<String, Object> generateUserInfo(CurrentUser user) {
        Map<String, Object> userInfo = new HashMap<>();
        userInfo.put("token", StpUtil.getTokenInfo().getTokenValue());
        userInfo.put("exipreTime", StpUtil.getTokenInfo().getTokenTimeout());
//
//        Set<String> roles = Arrays.stream(user.getRoleId().split(",")).collect(Collectors.toSet());
//        userInfo.put("roles", roles);
//
//        Set<String> permissions = Arrays.stream(user.getPermissions().split(",")).collect(Collectors.toSet());
//        userInfo.put("permissions", permissions);
//
//        UserConfig userConfig = this.userManager.getUserConfig(String.valueOf(user.getUserId()));
//        userInfo.put("config", userConfig);
//
//        user.setPassword("it's a secret");
//        userInfo.put("user", user);
        return userInfo;
    }

}

package cn.yuuki.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.secure.BCrypt;
import cn.yuuki.common.annotation.ControllerEndpoint;
import cn.yuuki.common.exception.FebsException;
import cn.yuuki.common.utils.FebsUtil;
import cn.yuuki.system.controller.req.Profile;
import com.wuwenze.poi.ExcelKit;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import cn.yuuki.common.domain.FebsResponse;
import cn.yuuki.common.domain.QueryRequest;
import cn.yuuki.common.domain.constant.StringConstant;
import cn.yuuki.system.entity.system.SystemUser;
import cn.yuuki.system.service.ILoginLogService;
import cn.yuuki.system.service.IUserDataPermissionService;
import cn.yuuki.system.service.IUserService;
import org.springframework.beans.BeanUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author MrBird
 */
@Slf4j
@Validated
@RestController
@RequiredArgsConstructor
@RequestMapping("user")
public class UserController {

    private final IUserService userService;
    private final IUserDataPermissionService userDataPermissionService;
    private final ILoginLogService loginLogService;


    @GetMapping("info")
    public FebsResponse loginSuccess() {

        return new FebsResponse().success().data(FebsUtil.getCurrentUser());
    }

    @GetMapping("index")
    public FebsResponse index() {
        Map<String, Object> data = new HashMap<>(5);
        // 获取系统访问记录
        Long totalVisitCount = loginLogService.findTotalVisitCount();
        data.put("totalVisitCount", totalVisitCount);
        Long todayVisitCount = loginLogService.findTodayVisitCount();
        data.put("todayVisitCount", todayVisitCount);
        Long todayIp = loginLogService.findTodayIp();
        data.put("todayIp", todayIp);
        // 获取近期系统访问记录
        List<Map<String, Object>> lastTenVisitCount = loginLogService.findLastTenDaysVisitCount(null);
        data.put("lastTenVisitCount", lastTenVisitCount);
        SystemUser param = new SystemUser();
        param.setUsername(FebsUtil.getCurrentUsername());
        List<Map<String, Object>> lastTenUserVisitCount = loginLogService.findLastTenDaysVisitCount(param);
        data.put("lastTenUserVisitCount", lastTenUserVisitCount);
        return new FebsResponse().data(data);
    }


    @GetMapping
    @SaCheckPermission("user:view")
    public FebsResponse userList(QueryRequest queryRequest, SystemUser user) {
        Map<String, Object> dataTable = FebsUtil.getDataTable(userService.findUserDetailList(user, queryRequest));
        return new FebsResponse().data(dataTable);
    }

    @GetMapping("check/{username}")
    public boolean checkUserName(@NotBlank(message = "{required}") @PathVariable String username) {
        return this.userService.findByName(username) == null;
    }

    /**
     * 刷新当前用户信息
     * @throws FebsException
     */
    @GetMapping("refresh")
    public void updateProfile() throws FebsException {
        this.userService.refresh();
    }

    @PostMapping
    @SaCheckPermission("user:add")
    @ControllerEndpoint(operation = "新增用户", exceptionMessage = "新增用户失败")
    public void addUser(@Valid SystemUser user) {
        this.userService.createUser(user);
    }

    @PutMapping
    @SaCheckPermission("user:update")
    @ControllerEndpoint(operation = "修改用户", exceptionMessage = "修改用户失败")
    public void updateUser(@Valid SystemUser user) {
        this.userService.updateUser(user);
    }

    @GetMapping("/{userId}")
    @SaCheckPermission("user:update")
    public FebsResponse findUserDataPermissions(@NotBlank(message = "{required}") @PathVariable String userId) {
        String dataPermissions = this.userDataPermissionService.findByUserId(userId);
        return new FebsResponse().data(dataPermissions);
    }

    @DeleteMapping("/{userIds}")
    @SaCheckPermission("user:delete")
    @ControllerEndpoint(operation = "删除用户", exceptionMessage = "删除用户失败")
    public void deleteUsers(@NotBlank(message = "{required}") @PathVariable String userIds) {
        String[] ids = userIds.split(StringConstant.COMMA);
        this.userService.deleteUsers(ids);
    }

    @PutMapping("profile")
    @ControllerEndpoint(exceptionMessage = "修改个人信息失败")
    public void updateProfile(@Valid Profile user) throws FebsException {
        SystemUser systemUser = new SystemUser();
        BeanUtils.copyProperties(user, systemUser);
        this.userService.updateProfile(systemUser);
    }

    @PutMapping("theme")
    public void updateSidebarTheme(@NotBlank(message = "{required}") String theme) {
        userService.updateSidebarTheme(theme);
    }

    @PutMapping("avatar")
    @ControllerEndpoint(exceptionMessage = "修改头像失败")
    public void updateAvatar(@NotBlank(message = "{required}") String avatar) {
        this.userService.updateAvatar(avatar);
    }

    @GetMapping("password/check")
    public boolean checkPassword(@NotBlank(message = "{required}") String password) {
        String currentUsername = FebsUtil.getCurrentUsername();
        SystemUser user = userService.findByName(currentUsername);
        return BCrypt.checkpw(password,user.getPassword()); // user != null && passwordEncoder.matches(password, user.getPassword());
    }

    @PutMapping("password")
    @ControllerEndpoint(exceptionMessage = "修改密码失败")
    public void updatePassword(@NotBlank(message = "{required}") String newPwd,@NotBlank(message = "{required}") String originPwd) {
        String currentUsername = FebsUtil.getCurrentUsername();
        SystemUser user = userService.findByName(currentUsername);
        if (!BCrypt.checkpw(originPwd,user.getPassword())) {
            throw new FebsException("原密码错误");
        }
        userService.updatePassword(newPwd);
    }

    @PutMapping("password/reset")
    @SaCheckPermission("user:reset")
    @ControllerEndpoint(exceptionMessage = "重置用户密码失败")
    public void resetPassword(@NotBlank(message = "{required}") String usernames) {
        String[] usernameArr = usernames.split(StringConstant.COMMA);
        this.userService.resetPassword(usernameArr);
    }

    @PostMapping("excel")
    @SaCheckPermission("user:export")
    @ControllerEndpoint(operation = "导出用户数据", exceptionMessage = "导出Excel失败")
    public void export(QueryRequest queryRequest, SystemUser user, HttpServletResponse response) {
        List<SystemUser> users = this.userService.findUserDetailList(user, queryRequest).getRecords();
        ExcelKit.$Export(SystemUser.class, response).downXlsx(users, false);
    }
}

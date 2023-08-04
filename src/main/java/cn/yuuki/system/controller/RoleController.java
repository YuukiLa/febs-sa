package cn.yuuki.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.yuuki.common.annotation.ControllerEndpoint;
import cn.yuuki.common.utils.FebsUtil;
import com.wuwenze.poi.ExcelKit;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import cn.yuuki.common.domain.FebsResponse;
import cn.yuuki.common.domain.QueryRequest;
import cn.yuuki.common.domain.constant.StringConstant;
import cn.yuuki.system.entity.system.Role;
import cn.yuuki.system.service.IRoleService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import java.util.List;
import java.util.Map;

/**
 * @author MrBird
 */
@Slf4j
@Validated
@RestController
@RequiredArgsConstructor
@RequestMapping("role")
public class RoleController {

    private final IRoleService roleService;

    @GetMapping
    public FebsResponse roleList(QueryRequest queryRequest, Role role) {
        Map<String, Object> dataTable = FebsUtil.getDataTable(roleService.findRoles(role, queryRequest));
        return new FebsResponse().data(dataTable);
    }

    @GetMapping("options")
    public FebsResponse roles() {
        List<Role> allRoles = roleService.findAllRoles();
        return new FebsResponse().data(allRoles);
    }

    @GetMapping("check/{roleName}")
    public boolean checkRoleName(@NotBlank(message = "{required}") @PathVariable String roleName) {
        Role result = this.roleService.findByName(roleName);
        return result == null;
    }

    @PostMapping
    @SaCheckPermission("role:add")
    @ControllerEndpoint(operation = "新增角色", exceptionMessage = "新增角色失败")
    public void addRole(@Valid Role role) {
        this.roleService.createRole(role);
    }

    @DeleteMapping("/{roleIds}")
    @SaCheckPermission("role:delete")
    @ControllerEndpoint(operation = "删除角色", exceptionMessage = "删除角色失败")
    public void deleteRoles(@NotBlank(message = "{required}") @PathVariable String roleIds) {
        String[] ids = roleIds.split(StringConstant.COMMA);
        this.roleService.deleteRoles(ids);
    }

    @PutMapping
    @SaCheckPermission("role:update")
    @ControllerEndpoint(operation = "修改角色", exceptionMessage = "修改角色失败")
    public void updateRole(@Valid Role role) {
        this.roleService.updateRole(role);
    }

    @PostMapping("excel")
    @SaCheckPermission("role:export")
    @ControllerEndpoint(operation = "导出角色数据", exceptionMessage = "导出Excel失败")
    public void export(QueryRequest queryRequest, Role role, HttpServletResponse response) {
        List<Role> roles = this.roleService.findRoles(role, queryRequest).getRecords();
        ExcelKit.$Export(Role.class, response).downXlsx(roles, false);
    }
}

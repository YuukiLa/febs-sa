package cn.yuuki.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import cn.yuuki.common.annotation.ControllerEndpoint;
import cn.yuuki.common.utils.FebsUtil;
import com.wuwenze.poi.ExcelKit;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import cn.yuuki.common.domain.FebsResponse;
import cn.yuuki.common.domain.constant.StringConstant;
import cn.yuuki.system.entity.router.VueRouter;
import cn.yuuki.system.entity.system.Menu;
import cn.yuuki.system.service.IMenuService;
import org.apache.commons.lang3.StringUtils;
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
@RequestMapping("/menu")
public class MenuController {

    private final IMenuService menuService;

    @GetMapping("/router")
    public FebsResponse getUserRouters() {
        Map<String, Object> result = new HashMap<>(4);
        String username = FebsUtil.getCurrentUsername();
        List<VueRouter<Menu>> userRouters = this.menuService.getUserRouters(username);
        String userPermissions = this.menuService.findUserPermissions(username);
        String[] permissionArray = new String[0];
        if (StringUtils.isNoneBlank(userPermissions)) {
            permissionArray = StringUtils.splitByWholeSeparatorPreserveAllTokens(userPermissions, StringConstant.COMMA);
        }
        result.put("routes", userRouters);
        result.put("permissions", permissionArray);
        return new FebsResponse().data(result);
    }

    @GetMapping
    public FebsResponse menuList() {
        List<Menu> list = this.menuService.list(Wrappers.lambdaQuery(Menu.class).orderByAsc(Menu::getOrderNum));
        return new FebsResponse().data(list);
    }

    @GetMapping("/permissions")
    public String findUserPermissions(String username) {
        return this.menuService.findUserPermissions(FebsUtil.getCurrentUsername());
    }

    @PostMapping
    @SaCheckPermission("menu:add")
    @ControllerEndpoint(operation = "新增菜单/按钮", exceptionMessage = "新增菜单/按钮失败")
    public void addMenu(@Valid Menu menu) {
        this.menuService.createMenu(menu);
    }

    @DeleteMapping("/{menuIds}")
    @SaCheckPermission("menu:delete")
    @ControllerEndpoint(operation = "删除菜单/按钮", exceptionMessage = "删除菜单/按钮失败")
    public void deleteMenus(@NotBlank(message = "{required}") @PathVariable String menuIds) {
        String[] ids = menuIds.split(StringConstant.COMMA);
        this.menuService.deleteMeuns(ids);
    }

    @PutMapping
    @SaCheckPermission("menu:update")
    @ControllerEndpoint(operation = "修改菜单/按钮", exceptionMessage = "修改菜单/按钮失败")
    public void updateMenu(@Valid Menu menu) {
        this.menuService.updateMenu(menu);
    }

    @PostMapping("excel")
    @SaCheckPermission("menu:export")
    @ControllerEndpoint(operation = "导出菜单数据", exceptionMessage = "导出Excel失败")
    public void export(Menu menu, HttpServletResponse response) {
        List<Menu> menus = this.menuService.findMenuList(menu);
        ExcelKit.$Export(Menu.class, response).downXlsx(menus, false);
    }
}
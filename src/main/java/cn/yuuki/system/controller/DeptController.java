package cn.yuuki.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.yuuki.common.annotation.ControllerEndpoint;
import com.wuwenze.poi.ExcelKit;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import cn.yuuki.common.domain.FebsResponse;
import cn.yuuki.common.domain.QueryRequest;
import cn.yuuki.common.domain.constant.StringConstant;
import cn.yuuki.system.entity.system.Dept;
import cn.yuuki.system.service.IDeptService;
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
@RequestMapping("dept")
@RequiredArgsConstructor
public class DeptController {

    private final IDeptService deptService;

    @GetMapping
    public FebsResponse deptList() {
        List<Dept> list = this.deptService.list();
        return new FebsResponse().data(list);
    }

    @PostMapping
    @SaCheckPermission("dept:add")
    @ControllerEndpoint(operation = "新增部门", exceptionMessage = "新增部门失败")
    public void addDept(@Valid Dept dept) {
        this.deptService.createDept(dept);
    }

    @DeleteMapping("/{deptIds}")
    @SaCheckPermission("dept:delete")
    @ControllerEndpoint(operation = "删除部门", exceptionMessage = "删除部门失败")
    public void deleteDepts(@NotBlank(message = "{required}") @PathVariable String deptIds) {
        String[] ids = deptIds.split(StringConstant.COMMA);
        this.deptService.deleteDepts(ids);
    }

    @PutMapping
    @SaCheckPermission("dept:update")
    @ControllerEndpoint(operation = "修改部门", exceptionMessage = "修改部门失败")
    public void updateDept(@Valid Dept dept) {
        this.deptService.updateDept(dept);
    }

    @PostMapping("excel")
    @SaCheckPermission("dept:export")
    @ControllerEndpoint(operation = "导出部门数据", exceptionMessage = "导出Excel失败")
    public void export(Dept dept, QueryRequest request, HttpServletResponse response) {
        List<Dept> depts = this.deptService.findDepts(dept, request);
        ExcelKit.$Export(Dept.class, response).downXlsx(depts, false);
    }
}

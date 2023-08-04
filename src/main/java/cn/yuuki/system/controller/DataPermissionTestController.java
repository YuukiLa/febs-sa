package cn.yuuki.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.yuuki.common.utils.FebsUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import cn.yuuki.common.domain.FebsResponse;
import cn.yuuki.common.domain.QueryRequest;
import cn.yuuki.system.entity.system.DataPermissionTest;
import cn.yuuki.system.service.IDataPermissionTestService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * Controller
 *
 * @author MrBird
 * @date 2020-04-14 15:25:33
 */
@Slf4j
@RestController
@RequestMapping("dataPermissionTest")
@RequiredArgsConstructor
public class DataPermissionTestController {

    private final IDataPermissionTestService dataPermissionTestService;

    @GetMapping("list")
    @SaCheckPermission("others:datapermission")
    public FebsResponse dataPermissionTestList(QueryRequest request, DataPermissionTest dataPermissionTest) {
        Map<String, Object> dataTable = FebsUtil.getDataTable(this.dataPermissionTestService.findDataPermissionTests(request, dataPermissionTest));
        return new FebsResponse().data(dataTable);
    }
}

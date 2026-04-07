package cn.yuuki.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.yuuki.common.annotation.ControllerEndpoint;
import cn.yuuki.common.domain.QueryRequest;
import cn.yuuki.common.domain.constant.StringConstant;
import cn.yuuki.common.utils.FebsUtil;
import cn.yuuki.system.entity.system.Log;
import cn.yuuki.system.service.ILogService;
import jakarta.validation.constraints.NotBlank;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * @author MrBird
 */
@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("log")
public class LogController {

    private final ILogService logService;

    @GetMapping("page")
    public Map<String, Object> logList(Log log, QueryRequest request) {
        Map<String, Object> dataTable = FebsUtil.getDataTable(this.logService.findLogs(log, request));
        return dataTable;
    }

    @DeleteMapping("{ids}")
    @SaCheckPermission("log:delete")
    @ControllerEndpoint(exceptionMessage = "删除日志失败")
    public void deleteLogss(@NotBlank(message = "{required}") @PathVariable String ids) {
        String[] logIds = ids.split(StringConstant.COMMA);
        this.logService.deleteLogs(logIds);
    }

}

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
import cn.yuuki.system.entity.system.Log;
import cn.yuuki.system.service.ILogService;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotBlank;
import java.util.List;
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


    @PostMapping("excel")
    @SaCheckPermission("log:export")
    @ControllerEndpoint(exceptionMessage = "导出Excel失败")
    public void export(QueryRequest request, Log lg, HttpServletResponse response) {
        List<Log> logs = this.logService.findLogs(lg, request).getRecords();
        ExcelKit.$Export(Log.class, response).downXlsx(logs, false);
    }
}

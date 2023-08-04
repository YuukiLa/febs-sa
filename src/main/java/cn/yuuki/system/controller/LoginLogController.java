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
import cn.yuuki.system.entity.system.LoginLog;
import cn.yuuki.system.service.ILoginLogService;
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
@RequestMapping("loginLog")
public class LoginLogController {

    private final ILoginLogService loginLogService;

    @GetMapping
    public FebsResponse loginLogList(LoginLog loginLog, QueryRequest request) {
        Map<String, Object> dataTable = FebsUtil.getDataTable(this.loginLogService.findLoginLogs(loginLog, request));
        return new FebsResponse().data(dataTable);
    }

    @GetMapping("currentUser")
    public FebsResponse getUserLastSevenLoginLogs() {
        String currentUsername = FebsUtil.getCurrentUsername();
        List<LoginLog> userLastSevenLoginLogs = this.loginLogService.findUserLastSevenLoginLogs(currentUsername);
        return new FebsResponse().data(userLastSevenLoginLogs);
    }

    @DeleteMapping("{ids}")
    @SaCheckPermission("loginlog:delete")
    @ControllerEndpoint(operation = "删除登录日志", exceptionMessage = "删除登录日志失败")
    public void deleteLogs(@NotBlank(message = "{required}") @PathVariable String ids) {
        String[] loginLogIds = ids.split(StringConstant.COMMA);
        this.loginLogService.deleteLoginLogs(loginLogIds);
    }

    @PostMapping("excel")
    @SaCheckPermission("loginlog:export")
    @ControllerEndpoint(operation = "导出登录日志数据", exceptionMessage = "导出Excel失败")
    public void export(QueryRequest request, LoginLog loginLog, HttpServletResponse response) {
        List<LoginLog> loginLogs = this.loginLogService.findLoginLogs(loginLog, request).getRecords();
        ExcelKit.$Export(LoginLog.class, response).downXlsx(loginLogs, false);
    }
}

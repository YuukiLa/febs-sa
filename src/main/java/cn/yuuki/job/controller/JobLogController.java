package cn.yuuki.job.controller;


import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.yuuki.common.domain.FebsResponse;
import cn.yuuki.common.domain.QueryRequest;
import cn.yuuki.common.domain.constant.StringConstant;
import cn.yuuki.common.utils.FebsUtil;
import cn.yuuki.job.entity.JobLog;
import cn.yuuki.job.service.IJobLogService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotBlank;
import java.util.List;
import java.util.Map;

/**
 * @author MrBird
 */
@Slf4j
@Validated
@RestController
@RequestMapping("job/log")
@RequiredArgsConstructor
public class JobLogController {

    private final IJobLogService jobLogService;

    @GetMapping
    @SaCheckPermission("job:log:view")
    public FebsResponse jobLogList(QueryRequest request, JobLog log) {
        Map<String, Object> dataTable = FebsUtil.getDataTable(this.jobLogService.findJobLogs(request, log));
        return new FebsResponse().data(dataTable);
    }

    @DeleteMapping("{jobIds}")
    @SaCheckPermission("job:log:delete")
    public void deleteJobLog(@NotBlank(message = "{required}") @PathVariable String jobIds) {
        String[] ids = jobIds.split(StringConstant.COMMA);
        this.jobLogService.deleteJobLogs(ids);
    }

}

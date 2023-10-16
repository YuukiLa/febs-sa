package cn.yuuki.job.controller;


import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.yuuki.common.domain.FebsResponse;
import cn.yuuki.common.domain.QueryRequest;
import cn.yuuki.common.domain.constant.StringConstant;
import cn.yuuki.common.utils.FebsUtil;
import cn.yuuki.job.entity.Job;
import cn.yuuki.job.service.IJobService;
import com.wuwenze.poi.ExcelKit;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.quartz.CronExpression;
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
@RequestMapping("job")
public class JobController {

    private final IJobService jobService;

    @GetMapping
    @SaCheckPermission("job:view")
    public FebsResponse jobList(QueryRequest request, Job job) {
        Map<String, Object> dataTable = FebsUtil.getDataTable(this.jobService.findJobs(request, job));
        return new FebsResponse().data(dataTable);
    }

    @GetMapping("cron/check")
    public boolean checkCron(String cron) {
        try {
            return CronExpression.isValidExpression(cron);
        } catch (Exception e) {
            return false;
        }
    }

    @PostMapping
    @SaCheckPermission("job:add")
    public void addJob(@Valid Job job) {
        this.jobService.createJob(job);
    }

    @DeleteMapping("{jobIds}")
    @SaCheckPermission("job:delete")
    public void deleteJob(@NotBlank(message = "{required}") @PathVariable String jobIds) {
        String[] ids = jobIds.split(StringConstant.COMMA);
        this.jobService.deleteJobs(ids);
    }

    @PutMapping
    @SaCheckPermission("job:update")
    public void updateJob(@Valid Job job) {
        this.jobService.updateJob(job);
    }

    @GetMapping("run/{jobIds}")
    @SaCheckPermission("job:run")
    public void runJob(@NotBlank(message = "{required}") @PathVariable String jobIds) {
        this.jobService.run(jobIds);
    }

    @GetMapping("pause/{jobIds}")
    @SaCheckPermission("job:pause")
    public void pauseJob(@NotBlank(message = "{required}") @PathVariable String jobIds) {
        this.jobService.pause(jobIds);
    }

    @GetMapping("resume/{jobIds}")
    @SaCheckPermission("job:resume")
    public void resumeJob(@NotBlank(message = "{required}") @PathVariable String jobIds) {
        this.jobService.resume(jobIds);
    }

    @PostMapping("excel")
    @SaCheckPermission("job:export")
    public void export(QueryRequest request, Job job, HttpServletResponse response) {
        List<Job> jobs = this.jobService.findJobs(request, job).getRecords();
        ExcelKit.$Export(Job.class, response).downXlsx(jobs, false);
    }
}

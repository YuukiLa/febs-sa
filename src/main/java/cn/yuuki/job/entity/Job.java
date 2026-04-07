package cn.yuuki.job.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author MrBird
 */
@Data
@TableName("t_job")
public class Job implements Serializable {

    /**
     * 任务调度参数 key
     */
    public static final String JOB_PARAM_KEY = "JOB_PARAM_KEY";
    private static final long serialVersionUID = 400066840871805700L;
    @TableId(value = "JOB_ID", type = IdType.AUTO)
    private Long jobId;
    @TableField("bean_name")
    @NotBlank(message = "{required}")
    @Size(max = 50, message = "{noMoreThan}")
    private String beanName;
    @TableField("method_name")
    @NotBlank(message = "{required}")
    @Size(max = 50, message = "{noMoreThan}")
    private String methodName;
    @TableField("params")
    @Size(max = 50, message = "{noMoreThan}")
    private String params;
    @TableField("cron_expression")
    @NotBlank(message = "{required}")
    private String cronExpression;
    @TableField("status")
    private String status;
    @TableField("remark")
    @Size(max = 100, message = "{noMoreThan}")
    private String remark;
    @TableField("create_time")
    private Date createTime;
    private transient String createTimeFrom;
    private transient String createTimeTo;
    public enum ScheduleStatus {
        /**
         * 正常
         */
        NORMAL("0"),
        /**
         * 暂停
         */
        PAUSE("1");

        private String value;

        ScheduleStatus(String value) {
            this.value = value;
        }

        public String getValue() {
            return value;
        }
    }

}

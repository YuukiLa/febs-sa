package cn.yuuki.common.configure;

import com.p6spy.engine.logging.Category;
import com.p6spy.engine.spy.appender.Slf4JLogger;
import org.apache.commons.lang3.StringUtils;

public class P6spyLogger extends Slf4JLogger {

    @Override
    public void logSQL(int connectionId, String now, long elapsed, Category category, String prepared, String sql, String url) {
        if (StringUtils.isNotBlank(sql)) {
            super.logSQL(connectionId, now, elapsed, category, prepared, sql, url);
        }
    }
}

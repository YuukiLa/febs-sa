package cn.yuuki.common.properties;

import lombok.Data;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.PropertySource;

@Data
@SpringBootConfiguration
@PropertySource(value = {"classpath:febs-auth.properties"})
@ConfigurationProperties(prefix = "febs.auth")
public class FebsAuthProperties {
    /**
     * 验证码配置
     */
    private FebsValidateCodeProperties code = new FebsValidateCodeProperties();

    private String anonUrl;
}

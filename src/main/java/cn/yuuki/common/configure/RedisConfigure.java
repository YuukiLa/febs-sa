package cn.yuuki.common.configure;


import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

@Configuration
public class RedisConfigure {


    @Bean(name = "redisTemplate")
    @SuppressWarnings({"rawtypes"})
    @ConditionalOnMissingBean(name = "redisTemplate")
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory redisConnectionFactory) {
        RedisTemplate<String, Object> template = new RedisTemplate<>();
        //使用 jackson 序列化
        Jackson2JsonRedisSerializer jacksonRedisSerializer = new Jackson2JsonRedisSerializer<>(Object.class);
        // value 值的序列化采用 jacksonRedisSerializer
        template.setValueSerializer(jacksonRedisSerializer);
        template.setHashValueSerializer(jacksonRedisSerializer);
        // key 的序列化采用 StringRedisSerializer
        template.setKeySerializer(new StringRedisSerializer());
        template.setHashKeySerializer(new StringRedisSerializer());

        template.setConnectionFactory(redisConnectionFactory);
        return template;
    }

}

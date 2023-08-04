package cn.yuuki.common.annotation;

import com.fasterxml.jackson.annotation.JacksonAnnotationsInside;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import cn.yuuki.common.converter.StringTimeSerialize;

import java.lang.annotation.*;

/**
 * 用于标记字符串时间的字段！
 */
@Documented
@Target({ElementType.FIELD,ElementType.PARAMETER,ElementType.ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
@JacksonAnnotationsInside
@JsonSerialize(using = StringTimeSerialize.class)
public @interface StringTimeFormat {

}

package cn.yuuki.common.annotation;

import com.fasterxml.jackson.annotation.JacksonAnnotationsInside;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import cn.yuuki.common.converter.ImageUrlSerialize;

import java.lang.annotation.*;

@Documented
@Target({ElementType.FIELD,ElementType.PARAMETER,ElementType.ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
@JacksonAnnotationsInside
@JsonSerialize(using = ImageUrlSerialize.class)
public @interface ImageUrl {
}

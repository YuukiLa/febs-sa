package cn.yuuki.common.converter;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.BeanProperty;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.ContextualSerializer;
import cn.yuuki.common.annotation.ImageUrl;
import org.apache.commons.lang3.ClassUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.IOException;
import java.util.Arrays;
import java.util.stream.Collectors;

public class ImageUrlSerialize extends JsonSerializer<String> implements ContextualSerializer {

    @Override
    public void serialize(String text, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
        if (StringUtils.isNotBlank(text)) {
            String collect = Arrays.stream(text.split(","))
                    .map(""::concat)
                    .collect(Collectors.joining(","));
            jsonGenerator.writeString(collect);
        } else {
            jsonGenerator.writeString("");
        }
    }

    @Override
    public JsonSerializer<?> createContextual(SerializerProvider serializerProvider, BeanProperty beanProperty) throws JsonMappingException {
        if (beanProperty != null) {
            if (ClassUtils.isAssignable(beanProperty.getType().getRawClass(), String.class)) {
                ImageUrl sensitive = beanProperty.getAnnotation(ImageUrl.class);
                if (sensitive == null) {
                    sensitive = beanProperty.getContextAnnotation(ImageUrl.class);
                }
                if (sensitive != null) {
                    return new ImageUrlSerialize();
                }
            }
            return serializerProvider.findValueSerializer(beanProperty.getType(), beanProperty);
        }
        return serializerProvider.findNullValueSerializer(null);
    }
}

package cn.yuuki.common.converter;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.BeanProperty;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.ContextualSerializer;
import cn.yuuki.common.annotation.StringTimeFormat;
import cn.yuuki.common.utils.DateUtil;
import org.apache.commons.lang3.ClassUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.IOException;

public class StringTimeSerialize extends JsonSerializer<String> implements ContextualSerializer {
    @Override
    public void serialize(String text, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
        jsonGenerator.writeString(DateUtil.formatFullTimeToFullTimeSplit(text));
    }

    @Override
    public JsonSerializer<?> createContextual(SerializerProvider serializerProvider, BeanProperty beanProperty) throws JsonMappingException {
        if (beanProperty != null) {
            if (ClassUtils.isAssignable(beanProperty.getType().getRawClass(), String.class)) {
                StringTimeFormat sensitive = beanProperty.getAnnotation(StringTimeFormat.class);
                if (sensitive == null) {
                    sensitive = beanProperty.getContextAnnotation(StringTimeFormat.class);
                }
                if (sensitive != null) {
                    return new StringTimeSerialize();
                }
            }
            return serializerProvider.findValueSerializer(beanProperty.getType(), beanProperty);
        }
        return serializerProvider.findNullValueSerializer(null);
    }
}

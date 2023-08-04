package cn.yuuki.common.utils;

import com.google.gson.Gson;
import org.apache.commons.lang3.StringUtils;

import java.util.Objects;

public class JsonUtil {

    private static final Gson gson = new Gson();

    public static String toJsonStr(Object obj) {
        if(Objects.isNull(obj)) {
            return "{}";
        }
        return gson.toJson(obj);

    }


    public static <T> T fromJson(String jsonStr, Class<T> clazz) {
        if(StringUtils.isBlank(jsonStr)) {
            return null;
        }
        return gson.fromJson(jsonStr, clazz);
    }
}

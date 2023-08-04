package cn.yuuki.common.domain;

import java.util.HashMap;

/**
 * @author MrBird
 */
public class FebsResponse extends HashMap<String, Object> {

    private static final long serialVersionUID = -8713837118340960775L;

    public FebsResponse message(String message) {
        this.put("message", message);
        return this;
    }

    public FebsResponse data(Object data) {
        this.put("data", data);
        return this;
    }

    public FebsResponse success() {
        this.put("message", "success");
        this.put("code", 200);
        return this;
    }

    public FebsResponse error() {
        this.put("message", "error");
        this.put("code", 500);
        return this;
    }
    public FebsResponse error(String err) {
        this.put("message", err);
        this.put("code", 500);
        return this;
    }
    @Override
    public FebsResponse put(String key, Object value) {
        super.put(key, value);
        return this;
    }

    public String getMessage() {
        return String.valueOf(get("message"));
    }

    public Object getData() {
        return get("data");
    }
}

package cn.yuuki.common.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author MrBird
 */
public interface ValidateCodeService {

    /**
     * 生成验证码
     *
     * @param request  HttpServletRequest
     * @param response HttpServletResponse
     * @throws IOException           IO异常
     */
    void create(HttpServletRequest request, HttpServletResponse response) throws Exception;

    /**
     * 校验验证码
     *
     * @param key   前端上送 key
     * @param value 前端上送待校验值
     */
    void check(String key, String value) throws Exception;
}
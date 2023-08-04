package cn.yuuki.common.service.impl;

import cn.yuuki.common.exception.FebsException;
import cn.yuuki.common.properties.FebsValidateCodeProperties;
import com.wf.captcha.GifCaptcha;
import com.wf.captcha.SpecCaptcha;
import com.wf.captcha.base.Captcha;
import lombok.RequiredArgsConstructor;
import cn.yuuki.common.properties.FebsAuthProperties;
import cn.yuuki.common.service.ValidateCodeService;
import cn.yuuki.common.service.RedisService;
import cn.yuuki.common.domain.constant.FebsConstant;
import cn.yuuki.common.domain.constant.ParamsConstant;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Service
@RequiredArgsConstructor
public class ValidateCodeServiceImpl implements ValidateCodeService {
    private final RedisService redisService;
    private final FebsAuthProperties properties;

    @Override
    public void create(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String key = request.getParameter(ParamsConstant.VALIDATE_CODE_KEY);
        if (StringUtils.isBlank(key)) {
            throw new RuntimeException("验证码key不能为空");
        }
        FebsValidateCodeProperties code = properties.getCode();
        setHeader(response, code.getType());

        Captcha captcha = createCaptcha(code);
        redisService.set(FebsConstant.CODE_PREFIX + key, StringUtils.lowerCase(captcha.text()), code.getTime());
        captcha.out(response.getOutputStream());
    }

    @Override
    public void check(String key, String value) throws Exception {
        Object codeInRedis = redisService.get(FebsConstant.CODE_PREFIX + key);
        if (StringUtils.isBlank(value)) {
            throw new FebsException("请输入验证码");
        }
        if (codeInRedis == null) {
            throw new FebsException("验证码已过期");
        }
        if (!StringUtils.equalsIgnoreCase(value, String.valueOf(codeInRedis))) {
            redisService.del(FebsConstant.CODE_PREFIX + key);
            throw new FebsException("验证码不正确");
        }
    }

    private Captcha createCaptcha(FebsValidateCodeProperties code) {
        Captcha captcha = null;
        if (StringUtils.equalsIgnoreCase(code.getType(), "gif")) {
            captcha = new GifCaptcha(code.getWidth(), code.getHeight(), code.getLength());
        } else {
            captcha = new SpecCaptcha(code.getWidth(), code.getHeight(), code.getLength());
        }
        captcha.setCharType(code.getCharType());
        return captcha;
    }

    private void setHeader(HttpServletResponse response, String type) {
        if (StringUtils.equalsIgnoreCase(type, "gif")) {
            response.setContentType(MediaType.IMAGE_GIF_VALUE);
        } else {
            response.setContentType(MediaType.IMAGE_PNG_VALUE);
        }
        response.setHeader(HttpHeaders.PRAGMA, "No-cache");
        response.setHeader(HttpHeaders.CACHE_CONTROL, "No-cache");
        response.setDateHeader(HttpHeaders.EXPIRES, 0L);
    }

}

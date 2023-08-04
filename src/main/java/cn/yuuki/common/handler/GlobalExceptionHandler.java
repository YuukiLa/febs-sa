package cn.yuuki.common.handler;

import cn.dev33.satoken.exception.NotLoginException;
import cn.dev33.satoken.exception.NotPermissionException;
import cn.dev33.satoken.exception.SaTokenException;
import com.baomidou.mybatisplus.core.toolkit.StringPool;
import cn.yuuki.common.exception.FebsException;
import lombok.extern.slf4j.Slf4j;
import cn.yuuki.common.domain.FebsResponse;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import javax.validation.Path;
import java.util.List;
import java.util.Set;

@Slf4j
@RestControllerAdvice
@Order(value = Ordered.HIGHEST_PRECEDENCE)
public class GlobalExceptionHandler {



    @ExceptionHandler(value = FebsException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public FebsResponse handleParamsInvalidException(FebsException e) {
        log.error("系统错误：{}", e.getMessage());
        return new FebsResponse().error().message(e.getMessage());
    }

    /**
     * 统一处理请求参数校验(实体对象传参)
     *
     * @param e BindException
     * @return FebsResponse
     */
    @ExceptionHandler(BindException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public FebsResponse validExceptionHandler(BindException e) {
        StringBuilder message = new StringBuilder();
        List<FieldError> fieldErrors = e.getBindingResult().getFieldErrors();
        for (FieldError error : fieldErrors) {
            message.append(error.getField()).append(error.getDefaultMessage()).append(StringPool.COMMA);
        }
        message = new StringBuilder(message.substring(0, message.length() - 1));
        return new FebsResponse().message(message.toString());

    }

    /**
     * 统一处理请求参数校验(普通传参)
     *
     * @param e ConstraintViolationException
     * @return FebsResponse
     */
    @ExceptionHandler(value = ConstraintViolationException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public FebsResponse handleConstraintViolationException(ConstraintViolationException e) {
        StringBuilder message = new StringBuilder();
        Set<ConstraintViolation<?>> violations = e.getConstraintViolations();
        for (ConstraintViolation<?> violation : violations) {
            Path path = violation.getPropertyPath();
            String[] pathArr = StringUtils.splitByWholeSeparatorPreserveAllTokens(path.toString(), StringPool.DOT);
            message.append(pathArr[1]).append(violation.getMessage()).append(StringPool.COMMA);
        }
        message = new StringBuilder(message.substring(0, message.length() - 1));
        return new FebsResponse().message(message.toString());
    }

    @ExceptionHandler(value = NotLoginException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public void handleUnLoginException(Exception e) {

        log.error("请先登录，{}", e.getMessage());
    }

    @ExceptionHandler(value = NotPermissionException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public void handleUnauthorizedException(Exception e) {

        log.error("权限不足，{}", e.getMessage());
    }

    @ExceptionHandler(value = SaTokenException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public void handleSaTokenException(Exception e) {

        log.error("权限校验问题，{}", e.getMessage());
    }

    @ExceptionHandler(value = Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public FebsResponse handleException(Exception e) {
        log.error("系统内部异常，异常信息：", e);
        return new FebsResponse().error().message(StringUtils.defaultIfBlank(e.getMessage(),"系统异常"));
    }
}

package cn.yuuki.system.controller;

import cn.yuuki.common.service.ValidateCodeService;
import lombok.RequiredArgsConstructor;
import cn.yuuki.common.domain.FebsResponse;
import cn.yuuki.system.service.ILoginService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotBlank;
import java.util.Map;

@Validated
@RestController
@RequiredArgsConstructor
public class LoginController {


    private final ILoginService loginService;
    private final ValidateCodeService validateCodeService;


    @GetMapping("/captcha")
    public void captcha(HttpServletRequest request, HttpServletResponse response) throws Exception {
        validateCodeService.create(request, response);
    }

    @PostMapping("/login")
    public FebsResponse login(
            @NotBlank(message = "{required}") String username,
            @NotBlank(message = "{required}") String key,
            @NotBlank(message = "{required}") String code,
            @NotBlank(message = "{required}") String password) throws Exception {

        validateCodeService.check(key, code);
        Map<String, Object> info = loginService.login(username, password);

        return new FebsResponse().message("认证成功").data(info);
    }

//
//
//    @RequiresPermissions("user:online")
//    @GetMapping("online")
//    public FebsResponse userOnline(String username) throws Exception {
//        String now = DateUtil.formatFullTime(LocalDateTime.now());
//        Set<String> userOnlineStringSet = redisService.zrangeByScore(FebsConstant.ACTIVE_USERS_ZSET_PREFIX, now, "+inf");
//        List<ActiveUser> activeUsers = new ArrayList<>();
//        for (String userOnlineString : userOnlineStringSet) {
//            ActiveUser activeUser = mapper.readValue(userOnlineString, ActiveUser.class);
//            activeUser.setToken(null);
//            if (StringUtils.isNotBlank(username)) {
//                if (StringUtils.equalsIgnoreCase(username, activeUser.getUsername()))
//                    activeUsers.add(activeUser);
//            } else {
//                activeUsers.add(activeUser);
//            }
//        }
//        return new FebsResponse().data(activeUsers);
//    }
//
//    @DeleteMapping("kickout/{id}")
//    @RequiresPermissions("user:kickout")
//    public void kickout(@NotBlank(message = "{required}") @PathVariable String id) throws Exception {
//        String now = DateUtil.formatFullTime(LocalDateTime.now());
//        Set<String> userOnlineStringSet = redisService.zrangeByScore(FebsConstant.ACTIVE_USERS_ZSET_PREFIX, now, "+inf");
//        ActiveUser kickoutUser = null;
//        String kickoutUserString = "";
//        for (String userOnlineString : userOnlineStringSet) {
//            ActiveUser activeUser = mapper.readValue(userOnlineString, ActiveUser.class);
//            if (StringUtils.equals(activeUser.getId(), id)) {
//                kickoutUser = activeUser;
//                kickoutUserString = userOnlineString;
//            }
//        }
//        if (kickoutUser != null && StringUtils.isNotBlank(kickoutUserString)) {
//            // 删除 zset中的记录
//            redisService.zrem(FebsConstant.ACTIVE_USERS_ZSET_PREFIX, kickoutUserString);
//            // 删除对应的 token缓存
//            redisService.del(FebsConstant.TOKEN_CACHE_PREFIX + kickoutUser.getToken() + "." + kickoutUser.getIp());
//        }
//    }

    @GetMapping("logout/{id}")
    public void logout(@NotBlank(message = "{required}") @PathVariable String id) throws Exception {
//        this.kickout(id);
    }


}

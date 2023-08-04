package cn.yuuki.common.satoken;

import cn.dev33.satoken.stp.StpInterface;
import lombok.RequiredArgsConstructor;
import cn.yuuki.common.service.RedisService;
import cn.yuuki.common.utils.FebsUtil;
import cn.yuuki.common.domain.CurrentUser;
import cn.yuuki.common.domain.constant.FebsConstant;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Component
@RequiredArgsConstructor
public class SaPermissionImpl implements StpInterface {

	private final RedisService redisService;

	/**
	 * 获取菜单权限列表
	 */
	@Override
	public List<String> getPermissionList(Object loginId, String loginType) {
		String permissions = (String) redisService.get(FebsConstant.USER_PERMISSION_CACHE_VALUE + loginId);
		return Arrays.asList(permissions.split(","));
	}

	/**
	 * 获取角色权限列表
	 */
	@Override
	public List<String> getRoleList(Object loginId, String loginType) {
		CurrentUser currentUser = FebsUtil.getCurrentUser();
		return Arrays.asList(currentUser.getRoleId().split(","));
	}

}
package cn.yuuki.common.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

/**
 * @author MrBird
 */
@Data
@SuppressWarnings("all")
public class FebsAuthUser {

    private static final long serialVersionUID = -6411066541689297219L;

    private Long userId;

    private String avatar;

    private String email;

    private String mobile;

    private String sex;

    private Long deptId;

    private String deptName;

    private String roleId;

    private String roleName;

    private Date lastLoginTime;

    private String description;

    private String status;

    private String deptIds;


}

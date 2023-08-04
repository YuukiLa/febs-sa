package cn.yuuki.common.domain;


import cn.yuuki.system.entity.system.Menu;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author MrBird
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class MenuTree extends Tree<Menu> {

    private String path;
    private String component;
    private String perms;
    private String icon;
    private String type;
    private Integer orderNum;
}

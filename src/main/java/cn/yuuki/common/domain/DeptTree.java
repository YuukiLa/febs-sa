package cn.yuuki.common.domain;

import cn.yuuki.system.entity.system.Dept;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author MrBird
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class DeptTree extends Tree<Dept> {

    private Integer orderNum;
}

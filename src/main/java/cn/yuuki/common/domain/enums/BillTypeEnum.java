package cn.yuuki.common.domain.enums;

/**
 * 推送类型枚举
 */
public enum BillTypeEnum {
    /**
     * 销售订单
     */
    SALE_ORDER(1),
    /**
     * 售后订单
     */
    AFTER_SALE_ORDER(2);


    private final Integer type;

    BillTypeEnum(Integer type) {
        this.type = type;
    }

    public Integer getType() {
        return type;
    }
}

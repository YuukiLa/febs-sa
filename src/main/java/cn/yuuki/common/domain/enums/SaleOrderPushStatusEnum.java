package cn.yuuki.common.domain.enums;


/**
 * 订单推送状态
 * 0 失败 1 成功未提交 2 提交成功审核失败 3 完成
 * 用于订单推送日志记录
 */
public enum SaleOrderPushStatusEnum {

    //0 失败 1 成功未提交 2 提交成功审核失败 3 完成
    FAIL(0, "失败"),
    SUCCESS(1, "成功未提交"),
    SUBMIT_SUCCESS(2, "提交成功审核失败"),
    FINISH(3, "完成");

    private final Integer status;
    private final String desc;

    SaleOrderPushStatusEnum(Integer status, String desc) {
        this.status = status;
        this.desc = desc;
    }

    public Integer getStatus() {
        return status;
    }

    public String getDesc() {
        return desc;
    }

    public static SaleOrderPushStatusEnum getByStatus(Integer status) {
        for (SaleOrderPushStatusEnum saleOrderPushStatusEnum : SaleOrderPushStatusEnum.values()) {
            if (saleOrderPushStatusEnum.getStatus().equals(status)) {
                return saleOrderPushStatusEnum;
            }
        }
        return null;
    }
}

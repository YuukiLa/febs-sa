package cn.yuuki.common.domain.enums;

public enum RefundTypeEnum {

    ONLY_REFUND(1, "仅退款"),
    REFUND_AND_RETURN(2, "THLX01_SYS"),
    CHANGE_GOODS(3, "THLX02_SYS");

    private final Integer type;

    private final String code;

    RefundTypeEnum(int i, String code) {
        this.type = i;
        this.code = code;
    }

    public Integer getType() {
        return type;
    }

    public String getCode() {
        return code;
    }

    public static RefundTypeEnum getEnumByType(Integer type){
        for(RefundTypeEnum refundTypeEnum : RefundTypeEnum.values()){
            if(refundTypeEnum.getType().equals(type)){
                return refundTypeEnum;
            }
        }
        return null;
    }
}

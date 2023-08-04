package cn.yuuki.common.utils;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class MathUtil {

    public static double[] avg(BigDecimal total, int num, int scale) {
        BigDecimal decimalNum = BigDecimal.valueOf(num);
        BigDecimal decimalAvg = total.divide(decimalNum, scale, RoundingMode.DOWN);
        double avg = decimalAvg.doubleValue();
        double[] result = new double[num];
        for (int i = 0; i < num - 1; i++) {
            result[i] = avg;
        }
        result[num - 1] = decimalAvg.add(total).subtract(decimalAvg.multiply(decimalNum)).doubleValue();
        return result;
    }
}

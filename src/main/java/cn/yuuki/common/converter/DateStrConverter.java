package cn.yuuki.common.converter;

import com.alibaba.excel.converters.Converter;
import com.alibaba.excel.metadata.GlobalConfiguration;
import com.alibaba.excel.metadata.data.WriteCellData;
import com.alibaba.excel.metadata.property.ExcelContentProperty;
import cn.yuuki.common.utils.DateUtil;

public class DateStrConverter implements Converter<String> {

    @Override
    public WriteCellData<?> convertToExcelData(String text, ExcelContentProperty contentProperty, GlobalConfiguration globalConfiguration) throws Exception {
        return new WriteCellData<String>(DateUtil.formatFullTimeToFullTimeSplit(text));
    }
}

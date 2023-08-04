package cn.yuuki.common.converter;

import com.alibaba.excel.converters.Converter;
import com.alibaba.excel.metadata.GlobalConfiguration;
import com.alibaba.excel.metadata.data.WriteCellData;
import com.alibaba.excel.metadata.property.ExcelContentProperty;

public class EnableStatusConverter implements Converter<Integer> {

    @Override
    public WriteCellData<?> convertToExcelData(Integer value, ExcelContentProperty contentProperty, GlobalConfiguration globalConfiguration) throws Exception {
        if(value == null || value == 0){
            return new WriteCellData<String>("禁用");
        }
        return new WriteCellData<String>("启用");
    }
}

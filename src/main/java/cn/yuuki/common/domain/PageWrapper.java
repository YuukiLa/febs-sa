package cn.yuuki.common.domain;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

public class PageWrapper<T> extends Page<T> {


    public PageWrapper(QueryRequest queryRequest) {
        super.setCurrent(queryRequest.getPageNum());
        super.setSize(queryRequest.getPageSize());
    }


}
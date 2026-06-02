package com.oracleproject.utils;

import java.util.List;

/**
 * 分页通用工具类
 */
public class PageBean<T> {
    // 当前页码
    private Integer pageNum;
    // 每页条数（固定6）
    private Integer pageSize = 6;
    // 总记录数
    private Long total;
    // 总页数
    private Integer pages;
    // 当前页数据列表
    private List<T> list;

    // 计算总页数
    public Integer getPages() {
        if (total == null || total == 0) {
            return 0;
        }
        return (int) ((total + pageSize - 1) / pageSize);
    }

    // getter & setter
    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }
}
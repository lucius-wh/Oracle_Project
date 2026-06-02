package com.oracleproject.vo;

import java.util.Date;

/**
 * 参观记录查询条件（由 Servlet 手动绑定 request 参数）
 */
public class VisitQueryVO {

    private String keyword;
    private String classname;
    private String areaCode;
    private Date visitTime;


    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getClassname() {
        return classname;
    }

    public void setClassname(String classname) {
        this.classname = classname;
    }

    public String getAreaCode() {
        return areaCode;
    }

    public void setAreaCode(String areaCode) {
        this.areaCode = areaCode;
    }

    public Date getVisitTime() {
        return visitTime;
    }

    public void setVisitTime(Date visitTime) {
        this.visitTime = visitTime;
    }
}
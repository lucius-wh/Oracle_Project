package com.oracleproject.vo;

import java.util.Date;

/*
这个查询是 三表联查：

* student
* building
* rel

所以不能直接返回 StudentBuildRel。
 */
//专门给页面展示。
public class StudentVisitVO {

    private Integer relId;

    private Integer sid;
    private String sname;
    private String className;

    private Integer buildId;
    private String buildingName;

    private Double score;
    private Date visitTime;

    public StudentVisitVO() {
    }

    public StudentVisitVO(Integer relId, Integer sid, String sname, String className, Integer buildId, String buildingName, Double score, Date visitTime) {
        this.relId = relId;
        this.sid = sid;
        this.sname = sname;
        this.className = className;
        this.buildId = buildId;
        this.buildingName = buildingName;
        this.score = score;
        this.visitTime = visitTime;
    }

    public Integer getRelId() {
        return relId;
    }

    public void setRelId(Integer relId) {
        this.relId = relId;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public Integer getBuildId() {
        return buildId;
    }

    public void setBuildId(Integer buildId) {
        this.buildId = buildId;
    }

    public String getBuildingName() {
        return buildingName;
    }

    public void setBuildingName(String buildingName) {
        this.buildingName = buildingName;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public Date getVisitTime() {
        return visitTime;
    }

    public void setVisitTime(Date visitTime) {
        this.visitTime = visitTime;
    }
}
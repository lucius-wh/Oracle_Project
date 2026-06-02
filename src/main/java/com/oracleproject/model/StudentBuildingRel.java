package com.oracleproject.model;

import java.util.Date;

/**
 * 学生-建筑参观关联表实体类
 * 记录学生参观建筑的评分与时间信息
 */
public class StudentBuildingRel {

    /**
     * 关联记录主键ID
     */
    private Integer relId;

    /**
     * 学生ID（外键关联学生表）
     */
    private Integer sid;

    /**
     * 建筑ID（外键关联建筑表）
     */
    private Integer buildId;

    /**
     * 学生评分（支持一位小数，如89.2）
     */
    private Double score;

    /**
     * 参观时间
     */
    private Date visitTime;

    /**
     * 逻辑删除标志：0-未删除（默认），1-已删除
     */
    private Integer isDelete = 0;

    /**
     * 无参构造方法（MyBatis反射实例化必须）
     */
    public StudentBuildingRel() {
    }

    /**
     * 全参构造方法（可选，业务中可按需使用）
     */
    public StudentBuildingRel(Integer relId, Integer sid, Integer buildId, Double score, Date visitTime, Integer isDelete) {
        this.relId = relId;
        this.sid = sid;
        this.buildId = buildId;
        this.score = score;
        this.visitTime = visitTime;
        this.isDelete = isDelete;
    }

    // ------------------- Getter 和 Setter 方法 -------------------

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

    public Integer getBuildId() {
        return buildId;
    }

    public void setBuildId(Integer buildId) {
        this.buildId = buildId;
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

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
    }
}
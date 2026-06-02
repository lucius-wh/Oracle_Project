package com.oracleproject.model;

/**
 * 学生参观记录实体类
 * 对应Oracle数据库学生参观建筑记录表
 */
public class Student {

    /**
     * 学号（主键）
     */
    private int sid;

    /**
     * 学生姓名
     */
    private String sname;

    /**
     * 性别：0-女，1-男
     */
    private String gender;

    /**
     * 班级名称
     */
    private String classname;

    /**
     * 参观的建筑名称
     */

    /**
     * 逻辑删除标志：0-未删除（默认），1-已删除
     */
    private Integer isDelete = 0;

    /**
     * 无参构造方法（MyBatis反射实例化必须）
     */
    public Student() {
    }

    /**
     * 全参构造方法（可选，业务中可按需使用）
     */
    public Student(int sid, String sname, String gender, String classname,  Integer isDelete) {
        this.sid = sid;
        this.sname = sname;
        this.gender = gender;
        this.classname = classname;
        this.isDelete = isDelete;
    }

    // ------------------- Getter 和 Setter 方法 -------------------


    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getClassname() {
        return classname;
    }

    public void setClassname(String classname) {
        this.classname = classname;
    }

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
    }
}
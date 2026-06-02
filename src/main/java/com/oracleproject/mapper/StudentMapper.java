package com.oracleproject.mapper;

import com.oracleproject.model.Student;

public interface StudentMapper {

    // 根据sid查询学生详情
    Student findById(Integer sid);

    // 逻辑删除学生
    int deleteStudent(Integer sid);

    // 逻辑删除该学生所有参观记录
    int deleteStudentRel(Integer sid);

}
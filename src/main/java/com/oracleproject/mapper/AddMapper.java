package com.oracleproject.mapper;

import com.oracleproject.model.Student;
import com.oracleproject.model.StudentBuildingRel;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AddMapper {
    // 新增学生
    int insertStudent(Student student);

    Student selectStudentById(Integer sid);

    Student selectStudentByIdAll(Integer sid);

    // 新增：新增关联记录
    int insertStudentBuildingRel(StudentBuildingRel rel);

    int updateRel(StudentBuildingRel rel);

    int updateStudent(com.oracleproject.model.Student student);
}
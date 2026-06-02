package com.oracleproject.service;

import com.oracleproject.mapper.AddMapper;
import com.oracleproject.model.Student;
import com.oracleproject.model.StudentBuildingRel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AddService {

    @Autowired
    private AddMapper addMapper;

    // 新增学生方法
    public boolean addStudent(Student student) {
        int rows = addMapper.insertStudent(student);
        return rows > 0; // 插入成功返回true，失败返回false
    }
    // 新增：校验学生是否存在
    public boolean isStudentExists(Integer sid) {
        Student student = addMapper.selectStudentById(sid);
        return student != null;
    }

    // 新增：新增关联记录
    public boolean addStudentBuildingRel(StudentBuildingRel rel) {
        rel.setIsDelete(0);
        int rows = addMapper.insertStudentBuildingRel(rel);
        return rows > 0;
    }

    // 修改参观记录
    public boolean updateRel(StudentBuildingRel rel) {
        return addMapper.updateRel(rel) > 0;
    }

    public boolean updateStudent(com.oracleproject.model.Student student) {
        return addMapper.updateStudent(student) > 0;
    }

    public Student getStudentById(Integer sid){
        return addMapper.selectStudentById(sid);
    }
}
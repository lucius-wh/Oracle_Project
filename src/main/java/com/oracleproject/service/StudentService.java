package com.oracleproject.service;

import com.oracleproject.mapper.StudentMapper;
import com.oracleproject.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class StudentService{

    @Autowired
    private StudentMapper studentMapper;

    public Student findById(Integer sid) {
        return studentMapper.findById(sid);
    }

    /**
     * 逻辑删除学生同时删除相关记录
     * @param sid
     * @return
     */
    @Transactional
    public boolean deleteStudent(Integer sid) {

        studentMapper.deleteStudent(sid);

        studentMapper.deleteStudentRel(sid);

        return true;
    }
}
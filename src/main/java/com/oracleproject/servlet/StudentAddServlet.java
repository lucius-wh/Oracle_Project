package com.oracleproject.servlet;

import com.alibaba.fastjson.JSON;
import com.oracleproject.mapper.AddMapper;
import com.oracleproject.model.Student;
import com.oracleproject.service.AddService;
import com.oracleproject.util.ServletUtils;
import com.oracleproject.utils.Result;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 新增学生（JSON REST）
 */
public class StudentAddServlet extends HttpServlet {

    private AddService addService;
    private AddMapper addMapper;

    @Override
    public void init() throws ServletException {
        addService = ServletUtils.getBean(getServletContext(), AddService.class);
        addMapper = ServletUtils.getBean(getServletContext(), AddMapper.class);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String body = ServletUtils.readRequestBody(request);
            Student student = JSON.parseObject(body, Student.class);
            if (student == null) {
                ServletUtils.writeJson(response, Result.error("参数解析失败，student为null"));
                return;
            }

            boolean success;
            if (addMapper.selectStudentByIdAll(student.getSid()) != null) {
                student.setIsDelete(0);
                success = addService.updateStudent(student);
            } else {
                success = addService.addStudent(student);
            }

            if (success) {
                ServletUtils.writeJson(response, Result.success("学生新增成功"));
            } else {
                ServletUtils.writeJson(response, Result.error("学生新增失败"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.writeJson(response, Result.error("服务器异常：" + e.getMessage()));
        }
    }
}

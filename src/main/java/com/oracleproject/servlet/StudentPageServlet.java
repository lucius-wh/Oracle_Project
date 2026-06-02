package com.oracleproject.servlet;

import com.oracleproject.model.Student;
import com.oracleproject.service.AddService;
import com.oracleproject.util.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 跳转修改学生信息页面并回显数据
 */
public class StudentPageServlet extends HttpServlet {

    private AddService addService;

    @Override
    public void init() throws ServletException {
        addService = ServletUtils.getBean(getServletContext(), AddService.class);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer sid = ServletUtils.parseIntegerParam(request.getParameter("sid"));
        if (sid == null || sid <= 0) {
            ServletUtils.redirect(request, response, "/visit/list");
            return;
        }

        Student student = addService.getStudentById(sid);
        if (student == null) {
            ServletUtils.redirect(request, response, "/visit/list");
            return;
        }

        request.setAttribute("student", student);
        ServletUtils.forward(request, response, "/updateStudent.jsp");
    }
}

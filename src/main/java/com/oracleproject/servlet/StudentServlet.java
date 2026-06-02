package com.oracleproject.servlet;

import com.oracleproject.service.StudentService;
import com.oracleproject.util.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 学生详情、逻辑删除（级联删除参观记录）
 */
public class StudentServlet extends HttpServlet {

    private StudentService studentService;

    @Override
    public void init() throws ServletException {
        studentService = ServletUtils.getBean(getServletContext(), StudentService.class);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/student/detail".equals(path)) {
            detail(request, response);
        } else if ("/student/delete".equals(path)) {
            delete(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void detail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer sid = ServletUtils.parseIntegerParam(request.getParameter("sid"));
        if (sid == null) {
            ServletUtils.redirect(request, response, "/visit/list");
            return;
        }
        request.setAttribute("student", studentService.findById(sid));
        ServletUtils.forward(request, response, "/studentDetail.jsp");
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer sid = ServletUtils.parseIntegerParam(request.getParameter("sid"));
        if (sid != null) {
            studentService.deleteStudent(sid);
        }
        ServletUtils.redirect(request, response, "/visit/list");
    }
}

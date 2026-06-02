package com.oracleproject.servlet;

import com.alibaba.fastjson.JSON;
import com.oracleproject.model.Student;
import com.oracleproject.model.StudentBuildingRel;
import com.oracleproject.service.AddService;
import com.oracleproject.util.ServletUtils;
import com.oracleproject.utils.Result;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 参观记录增改、学生信息修改（JSON REST）
 */
public class RelServlet extends HttpServlet {

    private AddService addService;

    @Override
    public void init() throws ServletException {
        addService = ServletUtils.getBean(getServletContext(), AddService.class);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/rel/add".equals(path)) {
            addRel(request, response);
        } else if ("/rel/update".equals(path)) {
            updateRel(request, response);
        } else if ("/rel/updateStudent".equals(path)) {
            updateStudent(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void addRel(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String body = ServletUtils.readRequestBody(request);
            StudentBuildingRel rel = JSON.parseObject(body, StudentBuildingRel.class);
            System.out.println("=== 收到关联新增请求 ===");
            System.out.println("参数：" + rel);

            if (!addService.isStudentExists(rel.getSid())) {
                ServletUtils.writeJson(response, Result.error("学生不存在，请先添加学生"));
                return;
            }

            Integer buildId = rel.getBuildId();
            if (buildId == null || buildId < 1 || buildId > 103) {
                ServletUtils.writeJson(response, Result.error("建筑ID必须在1-103之间"));
                return;
            }

            boolean success = addService.addStudentBuildingRel(rel);
            if (success) {
                ServletUtils.writeJson(response, Result.success("关联记录新增成功"));
            } else {
                ServletUtils.writeJson(response, Result.error("关联记录新增失败"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.writeJson(response, Result.error("服务器异常：" + e.getMessage()));
        }
    }

    private void updateRel(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String body = ServletUtils.readRequestBody(request);
        StudentBuildingRel rel = JSON.parseObject(body, StudentBuildingRel.class);

        if (!addService.isStudentExists(rel.getSid())) {
            ServletUtils.writeJson(response, Result.error("该学号不存在！"));
            return;
        }
        if (rel.getBuildId() < 1 || rel.getBuildId() > 103) {
            ServletUtils.writeJson(response, Result.error("古建ID必须在1-103之间！"));
            return;
        }

        boolean success = addService.updateRel(rel);
        ServletUtils.writeJson(response, success ? Result.success("修改成功！") : Result.error("修改失败！"));
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String body = ServletUtils.readRequestBody(request);
            Student student = JSON.parseObject(body, Student.class);

            if (student == null || student.getSid() <= 0) {
                ServletUtils.writeJson(response, Result.error("无效的学号！"));
                return;
            }

            if (!addService.isStudentExists(student.getSid())) {
                ServletUtils.writeJson(response, Result.error("该学生不存在！"));
                return;
            }

            boolean success = addService.updateStudent(student);
            ServletUtils.writeJson(response, success ? Result.success("修改成功！") : Result.error("修改失败！"));
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.writeJson(response, Result.error("服务器错误：" + e.getMessage()));
        }
    }
}

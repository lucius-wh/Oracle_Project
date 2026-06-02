package com.oracleproject.servlet;

import com.oracleproject.service.StudentVisitService;
import com.oracleproject.util.ServletUtils;
import com.oracleproject.vo.VisitQueryVO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 * 学生参观记录：列表查询、逻辑删除
 */
public class StudentVisitServlet extends HttpServlet {

    private StudentVisitService studentVisitService;

    @Override
    public void init() throws ServletException {
        studentVisitService = ServletUtils.getBean(getServletContext(), StudentVisitService.class);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/visit/list".equals(path)) {
            list(request, response);
        } else if ("/visit/deleteRel".equals(path)) {
            deleteRel(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        VisitQueryVO queryVO = buildQueryVO(request);
        request.setAttribute("visitList", studentVisitService.findVisitList(queryVO));
        ServletUtils.forward(request, response, "/studentVisitList.jsp");
    }

    private void deleteRel(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer relId = ServletUtils.parseIntegerParam(request.getParameter("relId"));
        if (relId != null) {
            studentVisitService.deleteRel(relId);
        }
        ServletUtils.redirect(request, response, "/visit/list");
    }

    private VisitQueryVO buildQueryVO(HttpServletRequest request) {
        VisitQueryVO queryVO = new VisitQueryVO();
        queryVO.setKeyword(request.getParameter("keyword"));
        queryVO.setClassname(request.getParameter("classname"));
        queryVO.setAreaCode(request.getParameter("areaCode"));

        String visitTimeStr = request.getParameter("visitTime");
        if (visitTimeStr != null && !visitTimeStr.trim().isEmpty()) {
            try {
                queryVO.setVisitTime(new SimpleDateFormat("yyyy-MM-dd").parse(visitTimeStr.trim()));
            } catch (ParseException ignored) {
                // 日期格式非法时不设置筛选条件
            }
        }
        return queryVO;
    }
}

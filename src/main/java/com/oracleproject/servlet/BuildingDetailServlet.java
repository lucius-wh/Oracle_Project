package com.oracleproject.servlet;

import com.oracleproject.service.BuildingService;
import com.oracleproject.util.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 古建筑详情
 */
public class BuildingDetailServlet extends HttpServlet {

    private BuildingService buildingService;

    @Override
    public void init() throws ServletException {
        buildingService = ServletUtils.getBean(getServletContext(), BuildingService.class);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer id = ServletUtils.parseIntegerParam(request.getParameter("id"));
        if (id == null) {
            ServletUtils.redirect(request, response, "/visit/list");
            return;
        }
        request.setAttribute("building", buildingService.findById(id));
        ServletUtils.forward(request, response, "/buildingDetail.jsp");
    }
}

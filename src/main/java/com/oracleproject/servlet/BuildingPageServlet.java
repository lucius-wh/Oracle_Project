package com.oracleproject.servlet;

import com.oracleproject.model.Building;
import com.oracleproject.service.PageService;
import com.oracleproject.util.ServletUtils;
import com.oracleproject.utils.PageBean;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * 古建筑分页列表、逻辑删除、恢复
 */
public class BuildingPageServlet extends HttpServlet {

    private PageService pageService;

    @Override
    public void init() throws ServletException {
        pageService = ServletUtils.getBean(getServletContext(), PageService.class);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/building/page".equals(path)) {
            page(request, response);
        } else if ("/building/delete".equals(path)) {
            delete(request, response);
        } else if ("/building/restore".equals(path)) {
            restore(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void page(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer pageNum = ServletUtils.parseIntegerParam(request.getParameter("pageNum"));
        if (pageNum == null || pageNum < 1) {
            pageNum = 1;
        }

        PageBean<Building> pageBean = pageService.getBuildingPage(pageNum);
        List<Building> deletedList = pageService.getAllDeletedBuildings();
        boolean isLastPage = pageNum.equals(pageBean.getPages());

        request.setAttribute("pageBean", pageBean);
        if (isLastPage) {
            request.setAttribute("deletedList", deletedList);
        } else {
            request.setAttribute("deletedList", new ArrayList<Building>());
        }
        request.setAttribute("isLastPage", isLastPage);

        ServletUtils.forward(request, response, "/page.jsp");
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = ServletUtils.parseIntegerParam(request.getParameter("id"));
        if (id != null) {
            pageService.deleteBuilding(id);
        }
        ServletUtils.redirect(request, response, "/building/page");
    }

    private void restore(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = ServletUtils.parseIntegerParam(request.getParameter("id"));
        if (id != null) {
            pageService.restoreBuilding(id);
        }
        ServletUtils.redirect(request, response, "/building/page");
    }
}

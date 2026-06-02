package com.oracleproject.util;

import com.alibaba.fastjson.JSON;
import com.oracleproject.utils.Result;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet 通用工具：Spring Bean 获取、JSON 输出、转发与重定向
 */
public final class ServletUtils {

    private ServletUtils() {
    }

    public static <T> T getBean(ServletContext servletContext, Class<T> clazz) {
        org.springframework.web.context.WebApplicationContext context =
                org.springframework.web.context.support.WebApplicationContextUtils
                        .getWebApplicationContext(servletContext);
        if (context == null) {
            throw new IllegalStateException("Spring WebApplicationContext 未初始化，请检查 ContextLoaderListener");
        }
        return context.getBean(clazz);
    }

    public static void writeJson(HttpServletResponse response, Result result) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(JSON.toJSONString(result));
        out.flush();
    }

    public static void forward(HttpServletRequest request, HttpServletResponse response, String jspPath)
            throws IOException, javax.servlet.ServletException {
        request.getRequestDispatcher(jspPath).forward(request, response);
    }

    public static void redirect(HttpServletRequest request, HttpServletResponse response, String path)
            throws IOException {
        response.sendRedirect(request.getContextPath() + path);
    }

    public static String readRequestBody(HttpServletRequest request) throws IOException {
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }
        return sb.toString();
    }

    public static Integer parseIntegerParam(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }
}

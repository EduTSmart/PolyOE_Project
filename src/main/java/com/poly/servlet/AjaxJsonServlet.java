package com.poly.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ajax-demo")
public class AjaxJsonServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        String json = "{"
                + "\"manv\": \"TeoNV\","
                + "\"hoTen\": \"Nguyễn Văn Tèo\","
                + "\"gioiTinh\": true,"
                + "\"luong\": 950.5"
                + "}";
        resp.getWriter().print(json);
    }
}

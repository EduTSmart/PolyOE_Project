package com.poly.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy session hiện tại (truyền false để không tạo session mới nếu chưa tồn tại)
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Xóa toàn bộ dữ liệu trong session (bao gồm thông tin user)
            session.invalidate();
        }
        
        // Điều hướng người dùng về lại trang chủ
        response.sendRedirect(request.getContextPath() + "/");
    }
}
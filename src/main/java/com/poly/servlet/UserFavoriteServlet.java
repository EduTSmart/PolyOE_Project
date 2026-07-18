package com.poly.servlet;

import com.poly.dao.UserDAO;
import com.poly.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/user-favorites")
public class UserFavoriteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        // Lấy danh sách video yêu thích của Nguyễn Văn Tèo (ID = 'TEONV')
        User user = userDAO.findById("TEONV"); 
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("/views/user_favorites.jsp").forward(request, response);
    }
}

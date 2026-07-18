package com.poly.servlet;

import com.poly.dao.FavoriteDAO;
import com.poly.entity.Favorite;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/all-favorites")
public class AllFavoriteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FavoriteDAO favoriteDAO = new FavoriteDAO();
        // Lấy toàn bộ danh sách lượt thích
        List<Favorite> favorites = favoriteDAO.findAll();
        
        request.setAttribute("favorites", favorites);
        request.getRequestDispatcher("/views/all_favorites.jsp").forward(request, response);
    }
}

package com.poly.servlet;

import com.poly.dao.VideoDAO;
import com.poly.entity.Video;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/video-search")
public class VideoSearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        
        VideoDAO videoDAO = new VideoDAO();
        List<Video> videos;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            videos = videoDAO.findByKeyword(keyword);
        } else {
            videos = videoDAO.findAll(); // Nếu không nhập gì thì hiện tất cả
        }
        
        request.setAttribute("keyword", keyword);
        request.setAttribute("videos", videos);
        request.getRequestDispatcher("/views/video_search.jsp").forward(request, response);
    }
}

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

@WebServlet({
    "/admin/video",
    "/admin/video/edit",
    "/admin/video/create",
    "/admin/video/update",
    "/admin/video/delete",
    "/admin/video/reset"
})
public class VideoAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        VideoDAO dao = new VideoDAO();
        Video video = new Video();
        boolean isEdit = false;

        try {
            if (uri.contains("edit")) {
                String id = req.getParameter("id");
                video = dao.findById(id);
                isEdit = true;
            } else if (uri.contains("delete")) {
                String id = req.getParameter("id");
                dao.deleteById(id);
                video = new Video();
                req.setAttribute("message", "Xóa video thành công!");
            } else if (uri.contains("reset")) {
                video = new Video();
                isEdit = false;
            }

            // Lấy danh sách video hiển thị lên bảng
            List<Video> list = dao.findAll();
            req.setAttribute("video", video);
            req.setAttribute("videos", list);
            req.setAttribute("isEdit", isEdit);

            req.getRequestDispatcher("/views/admin/video-manager.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Lỗi: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/video-manager.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        VideoDAO dao = new VideoDAO();

        try {
            Video video = new Video();
            video.setId(req.getParameter("id"));
            video.setTitle(req.getParameter("title"));
            video.setViews(Integer.parseInt(req.getParameter("views")));
            video.setActive(req.getParameter("active") != null);
            video.setDescription(req.getParameter("description"));
            video.setPoster(req.getParameter("poster")); // Có thể mở rộng upload file sau

            if (uri.contains("create")) {
                dao.create(video);
                req.setAttribute("message", "Thêm mới video thành công!");
            } else if (uri.contains("update")) {
                dao.update(video);
                req.setAttribute("message", "Cập nhật video thành công!");
            }

            req.setAttribute("video", new Video());
            req.setAttribute("videos", dao.findAll());
            req.setAttribute("isEdit", false);
            
            req.getRequestDispatcher("/views/admin/video-manager.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Thất bại: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/video-manager.jsp").forward(req, resp);
        }
    }
}
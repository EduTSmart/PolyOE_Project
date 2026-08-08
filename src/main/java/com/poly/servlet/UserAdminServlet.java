package com.poly.servlet;

import com.poly.dao.UserDAO;
import com.poly.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet({
    "/admin/user",
    "/admin/user/edit",
    "/admin/user/update",
    "/admin/user/delete",
    "/admin/user/reset"
})
public class UserAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        UserDAO dao = new UserDAO();
        User user = new User();
        boolean isEdit = false;

        try {
            if (uri.contains("edit")) {
                String id = req.getParameter("id");
                user = dao.findById(id);
                isEdit = true;
            } else if (uri.contains("delete")) {
                String id = req.getParameter("id");
                dao.deleteById(id);
                user = new User();
                req.setAttribute("message", "Xóa người dùng thành công!");
            } else if (uri.contains("reset")) {
                user = new User();
                isEdit = false;
            }

            List<User> list = dao.findAll();
            req.setAttribute("user", user);
            req.setAttribute("users", list);
            req.setAttribute("isEdit", isEdit);

            req.getRequestDispatcher("/views/admin/user-manager.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Lỗi: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/user-manager.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        UserDAO dao = new UserDAO();

        try {
            User user = new User();
            user.setId(req.getParameter("username"));
            user.setPassword(req.getParameter("password"));
            user.setFullname(req.getParameter("fullname"));
            user.setEmail(req.getParameter("email"));
            user.setAdmin(req.getParameter("admin") != null);

            if (uri.contains("update")) {
                dao.update(user);
                req.setAttribute("message", "Cập nhật người dùng thành công!");
            }

            req.setAttribute("user", new User());
            req.setAttribute("users", dao.findAll());
            req.setAttribute("isEdit", false);
            
            req.getRequestDispatcher("/views/admin/user-manager.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Thất bại: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/user-manager.jsp").forward(req, resp);
        }
    }
}
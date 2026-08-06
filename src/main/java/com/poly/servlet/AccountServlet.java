package com.poly.servlet;

import com.poly.dao.UserDAO;
import com.poly.entity.User;
import com.poly.utils.EmailUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet({
    "/account/sign-up", 
    "/account/forgot-password", 
    "/account/change-password", 
    "/account/edit-profile"
})
public class AccountServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("sign-up")) {
            req.getRequestDispatcher("/views/sign-up.jsp").forward(req, resp);
        } else if (uri.contains("forgot-password")) {
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
        } else if (uri.contains("change-password")) {
            req.getRequestDispatcher("/views/change-password.jsp").forward(req, resp);
        } else if (uri.contains("edit-profile")) {
            req.getRequestDispatcher("/views/edit-profile.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        UserDAO dao = new UserDAO();
        HttpSession session = req.getSession();

        try {
            if (uri.contains("sign-up")) {
                User user = new User();
                user.setId(req.getParameter("username"));
                user.setPassword(req.getParameter("password"));
                user.setFullname(req.getParameter("fullname"));
                user.setEmail(req.getParameter("email"));
                user.setAdmin(false); // Mặc định là user thường
                
                dao.create(user);
                
                // Gửi email chào mừng
                EmailUtils.send(user.getEmail(), "Welcome to PolyOE", "Chào " + user.getFullname() + ", chúc mừng bạn đã đăng ký thành công!");
                req.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                
            } else if (uri.contains("forgot-password")) {
                String id = req.getParameter("username");
                String email = req.getParameter("email");
                User user = dao.findById(id);
                
                if (user != null && user.getEmail().equals(email)) {
                    EmailUtils.send(email, "PolyOE - Recover Password", "Mật khẩu của bạn là: " + user.getPassword());
                    req.setAttribute("message", "Mật khẩu đã được gửi vào email của bạn.");
                } else {
                    req.setAttribute("message", "Sai Username hoặc Email!");
                }
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
                
            } else if (uri.contains("change-password")) {
                String id = req.getParameter("username");
                String currentPass = req.getParameter("currentPassword");
                String newPass = req.getParameter("newPassword");
                String confirmPass = req.getParameter("confirmPassword");
                
                User user = dao.findById(id);
                if (user != null && user.getPassword().equals(currentPass) && newPass.equals(confirmPass)) {
                    user.setPassword(newPass);
                    dao.update(user);
                    req.setAttribute("message", "Đổi mật khẩu thành công!");
                } else {
                    req.setAttribute("message", "Thông tin không chính xác hoặc mật khẩu mới không khớp!");
                }
                req.getRequestDispatcher("/views/change-password.jsp").forward(req, resp);
                
            } else if (uri.contains("edit-profile")) {
                User currentUser = (User) session.getAttribute("user");
                currentUser.setFullname(req.getParameter("fullname"));
                currentUser.setEmail(req.getParameter("email"));
                
                dao.update(currentUser);
                session.setAttribute("user", currentUser); // Cập nhật lại session
                req.setAttribute("message", "Cập nhật hồ sơ thành công!");
                req.getRequestDispatcher("/views/edit-profile.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
            req.getRequestDispatcher("/page.jsp").forward(req, resp);
        }
    }
}

package com.poly.servlet;

import com.poly.dao.UserDAO;
import com.poly.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("username");
        String pass = request.getParameter("password");
        
        UserDAO dao = new UserDAO();
        User user = dao.findById(id);
        
        if (user == null) {
            request.setAttribute("message", "Sai username!");
        } else if (!user.getPassword().equals(pass)) {
            request.setAttribute("message", "Sai password!");
        } else {
            // Đăng nhập thành công, lưu vào session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Chuyển hướng (redirect) về lại trang chủ thay vì ở lại trang login
            response.sendRedirect(request.getContextPath() + "/");
            return; // Bắt buộc phải có return để dừng hàm, không chạy lệnh forward bên dưới
        }
        
        // Nếu rơi vào các trường hợp báo lỗi (user null hoặc sai pass) thì mới forward lại trang login
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }
}

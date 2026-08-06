package com.poly.servlet;
import com.poly.dao.UserDAO;
import com.poly.entity.User;
import com.poly.filter.AuthFilter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    Cookie[] cookies = req.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("remember_user")) {
	                req.setAttribute("savedUser", cookie.getValue());
	            }
	            if (cookie.getName().equals("remember_pass")) {
	                req.setAttribute("savedPass", cookie.getValue());
	            }
	        }
	    }
	    req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
	}

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        
        // Sử dụng class UserDAO đã có sẵn từ các Lab trước
        UserDAO dao = new UserDAO(); 
        User user = dao.findById(username);
        
        if (user == null) {
            req.setAttribute("message", "Invalid username");
        } else if (!user.getPassword().equals(password)) {
            req.setAttribute("message", "Invalid password");
        } else {
            // Đăng nhập thành công
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            req.setAttribute("message", "Login successfully");
            String remember = req.getParameter("remember");
            if (remember != null) {
                Cookie userCookie = new Cookie("remember_user", username);
                Cookie passCookie = new Cookie("remember_pass", password);
                userCookie.setMaxAge(60 * 60 * 24 * 30); // 30 ngày
                passCookie.setMaxAge(60 * 60 * 24 * 30);
                resp.addCookie(userCookie);
                resp.addCookie(passCookie);
            } else {
                // Xóa cookie nếu không check
                Cookie userCookie = new Cookie("remember_user", "");
                Cookie passCookie = new Cookie("remember_pass", "");
                userCookie.setMaxAge(0);
                passCookie.setMaxAge(0);
                resp.addCookie(userCookie);
                resp.addCookie(passCookie);
            }

            // Lấy lại đường dẫn bị chặn trước đó từ Session
            String securityUri = (String) session.getAttribute(AuthFilter.SECURITY_URI);
            
            if (securityUri != null) {
                // Xóa uri khỏi session sau khi đã dùng để tránh lỗi cho các lần sau
                session.removeAttribute(AuthFilter.SECURITY_URI); 
                resp.sendRedirect(securityUri);
                return; // Kết thúc hàm tại đây
            } else {
                // Nếu không có securityUri, chuyển về trang chủ
                resp.sendRedirect(req.getContextPath() + "/");
                return;
            }
        }
        // Nếu đăng nhập thất bại thì nạp lại trang login kèm thông báo lỗi
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }
}

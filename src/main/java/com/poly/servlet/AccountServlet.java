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
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@WebServlet({
    "/account/sign-up", 
    "/account/forgot-password", 
    "/account/change-password", 
    "/account/edit-profile",
    "/account/reset-password" // Bổ sung đường dẫn mới
})
public class AccountServlet extends HttpServlet {
    
    // Sử dụng Map tĩnh để lưu trữ tạm thời token khôi phục mật khẩu (Key: Token, Value: Username)
    private static Map<String, String> resetTokens = new HashMap<>();

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
        } else if (uri.contains("reset-password")) {
            // Logic khi người dùng click vào link từ Email
            String token = req.getParameter("token");
            if (token != null && resetTokens.containsKey(token)) {
                // Token hợp lệ, chuyển hướng đến trang nhập mật khẩu mới
                req.setAttribute("token", token);
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            } else {
                // Token sai hoặc đã được sử dụng/hết hạn
                req.setAttribute("message", "Đường dẫn khôi phục không hợp lệ hoặc đã hết hạn!");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            }
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
                    // 1. Sinh ra một mã token ngẫu nhiên không trùng lặp
                    String token = UUID.randomUUID().toString();
                    
                    // 2. Lưu token vào bộ nhớ Map gắn với username
                    resetTokens.put(token, user.getId());
                    
                    // 3. Tạo đường dẫn chứa token
                    String appUrl = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + req.getContextPath();
                    String resetLink = appUrl + "/account/reset-password?token=" + token;
                    
                    // 4. Gửi email chứa đường dẫn khôi phục
                    String emailContent = "Chào " + user.getFullname() + ",<br><br>"
                                        + "Vui lòng click vào đường dẫn sau để đặt lại mật khẩu của bạn:<br>"
                                        + "<a href='" + resetLink + "'><b>ĐẶT LẠI MẬT KHẨU</b></a><br><br>"
                                        + "Nếu bạn không yêu cầu, vui lòng bỏ qua email này.";
                    EmailUtils.send(email, "PolyOE - Đặt lại mật khẩu", emailContent);
                    
                    req.setAttribute("message", "Một đường link khôi phục đã được gửi vào email của bạn. Vui lòng kiểm tra!");
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
                
            } else if (uri.contains("reset-password")) {
                // Logic xử lý khi người dùng Submit form mật khẩu mới
                String token = req.getParameter("token");
                String newPass = req.getParameter("newPassword");
                String confirmPass = req.getParameter("confirmPassword");
                
                if (token != null && resetTokens.containsKey(token)) {
                    if (newPass.equals(confirmPass)) {
                        // Lấy username từ bộ nhớ Map thông qua token
                        String username = resetTokens.get(token);
                        User user = dao.findById(username);
                        
                        // Cập nhật mật khẩu mới
                        user.setPassword(newPass);
                        dao.update(user);
                        
                        // Xóa token khỏi bộ nhớ để không dùng lại được nữa (bảo mật 1 lần dùng)
                        resetTokens.remove(token);
                        
                        // Chuyển về trang đăng nhập kèm thông báo
                        req.setAttribute("message", "Đổi mật khẩu thành công! Vui lòng đăng nhập lại.");
                        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                    } else {
                        req.setAttribute("message", "Mật khẩu xác nhận không khớp!");
                        req.setAttribute("token", token); // Giữ lại token trên form để thử lại
                        req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
                    }
                } else {
                    req.setAttribute("message", "Yêu cầu không hợp lệ hoặc token đã hết hạn!");
                    req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
            req.getRequestDispatcher("/page.jsp").forward(req, resp);
        }
    }
}
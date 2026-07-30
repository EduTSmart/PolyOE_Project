package com.poly.filter;

import com.poly.entity.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter({
    "/admin/*", 
    "/account/change-password", 
    "/account/edit-profile", 
    "/video/like/*", 
    "/video/share/*"
})
public class AuthFilter implements Filter {
    
    public static final String SECURITY_URI = "securityUri";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException { }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession();
        
        // Lấy thông tin user từ session (giả định bạn lưu user vào session với key là "user")
        User user = (User) session.getAttribute("user");
        String uri = req.getRequestURI();
        
        // Kiểm tra điều kiện: Chưa đăng nhập HOẶC (Truy cập trang admin mà không phải admin)
        if (user == null || (uri.contains("/admin/") && !user.getAdmin())) {
            // Lưu lại đường dẫn người dùng đang muốn truy cập vào session
            session.setAttribute(AuthFilter.SECURITY_URI, uri);
            // Chuyển hướng sang trang đăng nhập
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            // Hợp lệ, cho phép request đi tiếp
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() { }
}

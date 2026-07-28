package com.poly.filter;

import com.poly.dao.LogDAO;
import com.poly.entity.Log;
import com.poly.entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

@WebFilter("/*")
public class AppFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        // 1. Thiết lập chế độ mã hóa UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 2. Ghi nhận thông tin truy cập
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            String uri = req.getRequestURI();
            Date time = new Date();
            String username = user.getId(); // Hoặc user.getFullname() tùy ý
            
            // Lưu vào DB
            LogDAO dao = new LogDAO();
            dao.create(new Log(uri, time, username));
        }

        // Cho phép request đi tiếp
        chain.doFilter(request, response);
    }
}

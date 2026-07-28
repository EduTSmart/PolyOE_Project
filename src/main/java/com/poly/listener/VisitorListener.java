package com.poly.listener;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;

@WebListener
public class VisitorListener implements ServletContextListener, HttpSessionListener {
    // Đường dẫn lưu file đếm (lưu ở thư mục tạm của hệ thống để tránh lỗi quyền truy cập)
    private static final String FILE_PATH = System.getProperty("java.io.tmpdir") + File.separator + "visitors.txt";

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext application = sce.getServletContext();
        long visitors = 0;
        try {
            if (new File(FILE_PATH).exists()) {
                String content = Files.readString(Paths.get(FILE_PATH));
                visitors = Long.parseLong(content.trim());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // Chia sẻ qua application scope
        application.setAttribute("visitors", visitors);
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        ServletContext application = se.getSession().getServletContext();
        Long visitors = (Long) application.getAttribute("visitors");
        if (visitors == null) visitors = 0L;
        
        // Tăng số đếm lên 1
        visitors++;
        application.setAttribute("visitors", visitors);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext application = sce.getServletContext();
        Long visitors = (Long) application.getAttribute("visitors");
        try {
            // Lưu số đếm trở lại file
            if (visitors != null) {
                Files.writeString(Paths.get(FILE_PATH), String.valueOf(visitors));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

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

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext application = sce.getServletContext();
        // Lấy đường dẫn thực tế của file visitors.txt trong thư mục webapp
        String filePath = application.getRealPath("/visitors.txt");
        application.setAttribute("FILE_PATH", filePath); // Lưu lại để dùng lúc destroy
        
        long visitors = 0;
        try {
            if (filePath != null && new File(filePath).exists()) {
                String content = Files.readString(Paths.get(filePath));
                visitors = Long.parseLong(content.trim());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        application.setAttribute("visitors", visitors);
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        ServletContext application = se.getSession().getServletContext();
        Long visitors = (Long) application.getAttribute("visitors");
        if (visitors == null) visitors = 0L;
        
        visitors++;
        application.setAttribute("visitors", visitors);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext application = sce.getServletContext();
        Long visitors = (Long) application.getAttribute("visitors");
        String filePath = (String) application.getAttribute("FILE_PATH");
        
        try {
            if (visitors != null && filePath != null) {
                Files.writeString(Paths.get(filePath), String.valueOf(visitors));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
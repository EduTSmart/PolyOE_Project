package com.poly.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;

@MultipartConfig // Bắt buộc phải có để nhận file
@WebServlet("/upload-ajax")
public class UploadAjaxServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part filePart = req.getPart("file");
        String fileName = filePart.getSubmittedFileName();
        String fileType = filePart.getContentType();
        long fileSize = filePart.getSize();

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        String json = String.format("{\"name\": \"%s\", \"type\": \"%s\", \"size\": %d}", fileName, fileType, fileSize);
        resp.getWriter().print(json);
    }
}


package com.poly.servlet;

import com.poly.dao.ShareDAO;
import com.poly.dto.ShareReport;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/share-report")
public class ShareReportServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ShareDAO shareDAO = new ShareDAO();
        List<ShareReport> reports = shareDAO.getShareReports();
        
        request.setAttribute("reports", reports);
        request.getRequestDispatcher("/views/share_report.jsp").forward(request, response);
    }
}

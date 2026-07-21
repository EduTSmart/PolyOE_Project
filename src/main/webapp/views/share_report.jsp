<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thống kê chia sẻ Video</title>
    <style>
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #5b9bd5; color: white; }
    </style>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>BÀI 4: THỐNG KÊ LƯỢT CHIA SẺ VIDEO</h2>
    
    <table>
        <thead>
            <tr>
                <th>Tiêu đề video</th>
                <th>Số lượt chia sẻ</th>
                <th>Ngày chia sẻ đầu tiên</th>
                <th>Ngày chia sẻ cuối cùng</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="report" items="${reports}">
                <tr>
                    <td>${report.videoTitle}</td>
                    <td>${report.shareCount}</td>
                    <td>${report.firstShareDate}</td>
                    <td>${report.lastShareDate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>

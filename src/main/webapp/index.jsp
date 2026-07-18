<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lab 3 - Lập trình Java 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .menu { margin-top: 20px; }
        .menu a { display: block; margin-bottom: 10px; font-size: 18px; text-decoration: none; color: blue; }
        .menu a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <h2>PolyOE - Hệ thống Quản lý Video Online</h2>
    <div class="menu">
        <a href="${pageContext.request.contextPath}/user-favorites">Bài 3: Xem Video Yêu Thích Của Nguyễn Văn Tèo</a>
        <a href="${pageContext.request.contextPath}/all-favorites">Bài 4: Danh Sách Tất Cả Video Được Yêu Thích</a>
    </div>
</body>
</html>

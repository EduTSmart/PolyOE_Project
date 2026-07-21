<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lab 3 & Lab 4 - Lập trình Java 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .menu { margin-top: 20px; }
        .menu a { display: block; margin-bottom: 10px; font-size: 18px; text-decoration: none; color: blue; margin-left: 15px; }
        .menu a:hover { text-decoration: underline; color: darkblue; }
        h3 { margin-top: 30px; color: #d32f2f; border-bottom: 1px solid #ccc; padding-bottom: 5px; width: 60%; }
    </style>
</head>
<body>
    <h2>PolyOE - Hệ thống Quản lý Video Online</h2>
    
    <div class="menu">
        <!-- CÁC CHỨC NĂNG CỦA LAB 3 -->
        <h3>LAB 3: Khai thác thực thể kết hợp</h3>
        <a href="${pageContext.request.contextPath}/user-favorites">&#128279; Bài 3: Xem Video Yêu Thích Của Nguyễn Văn Tèo</a>
        <a href="${pageContext.request.contextPath}/all-favorites">&#128279; Bài 4: Danh Sách Tất Cả Video Được Yêu Thích</a>
        
        <!-- CÁC CHỨC NĂNG CỦA LAB 4 MỚI THÊM -->
        <h3>LAB 4: Câu lệnh JPQL</h3>
        <a href="${pageContext.request.contextPath}/video-search">&#128269; Bài 3: Tìm kiếm Video theo từ khóa</a>
        <a href="${pageContext.request.contextPath}/share-report">&#128202; Bài 4: Thống kê lượt chia sẻ Video</a>
    </div>
</body>
</html>

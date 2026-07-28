<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        
        /* Style cho thanh thông báo đầu trang */
        .header-bar {
            background-color: #e0f7fa; 
            padding: 15px; 
            margin-bottom: 20px; 
            border-radius: 5px; 
            width: 60%; 
            display: flex; 
            justify-content: space-between;
            align-items: center;
            border: 1px solid #b2ebf2;
        }
        .login-btn {
            background-color: #1976d2;
            color: white;
            padding: 6px 12px;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: bold;
        }
        .login-btn:hover { background-color: #1565c0; }
        
        /* Style riêng cho nút đăng xuất */
        .logout-btn {
            background-color: #d32f2f;
            color: white;
            padding: 6px 12px;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: bold;
            margin-left: 15px;
        }
        .logout-btn:hover { background-color: #b71c1c; }
    </style>
</head>
<body>
    
    <!-- THANH THÔNG BÁO -->
    <div class="header-bar">
        <span>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    Xin chào: <strong>${sessionScope.user.fullname}</strong>
                    <!-- Nút đăng xuất hiển thị khi đã đăng nhập -->
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Đăng xuất</a>
                </c:when>
                <c:otherwise>
                    <i>Bạn chưa đăng nhập</i> 
                    <!-- Nút đăng nhập hiển thị khi chưa đăng nhập -->
                    <a href="${pageContext.request.contextPath}/login" class="login-btn" style="margin-left: 10px;">Đăng nhập</a>
                </c:otherwise>
            </c:choose>
        </span>
        <span>
            Lượt truy cập hệ thống: <strong>${applicationScope.visitors != null ? applicationScope.visitors : 0}</strong>
        </span>
    </div>

    <h2>PolyOE - Hệ thống Quản lý Video Online</h2>
    
    <div class="menu">
        <!-- CÁC CHỨC NĂNG CỦA LAB 3 -->
        <h3>LAB 3: Khai thác thực thể kết hợp</h3>
        <a href="${pageContext.request.contextPath}/user-favorites">&#128279; Bài 3: Xem Video Yêu Thích Của Nguyễn Văn Tèo</a>
        <a href="${pageContext.request.contextPath}/all-favorites">&#128279; Bài 4: Danh Sách Tất Cả Video Được Yêu Thích</a>
        
        <!-- CÁC CHỨC NĂNG CỦA LAB 4 -->
        <h3>LAB 4: Câu lệnh JPQL</h3>
        <a href="${pageContext.request.contextPath}/video-search">&#128269; Bài 3: Tìm kiếm Video theo từ khóa</a>
        <a href="${pageContext.request.contextPath}/share-report">&#128202; Bài 4: Thống kê lượt chia sẻ Video</a>
    </div>
</body>
</html>
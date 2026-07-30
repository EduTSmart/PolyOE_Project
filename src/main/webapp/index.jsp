<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PolyOE - Hệ thống Quản lý Video</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .menu { margin-top: 20px; }
        .menu a { display: block; margin-bottom: 10px; font-size: 16px; text-decoration: none; color: #1976d2; margin-left: 15px; }
        .menu a:hover { text-decoration: underline; color: darkblue; }
        h3 { margin-top: 15px; margin-bottom: 10px; font-size: 18px; }
        
        /* Style cho thanh thông báo đầu trang */
        .header-bar { background-color: #e0f7fa; padding: 15px; margin-bottom: 20px; border-radius: 5px; width: 60%; display: flex; justify-content: space-between; align-items: center; border: 1px solid #b2ebf2; }
        .btn { padding: 6px 12px; text-decoration: none; border-radius: 4px; font-size: 14px; font-weight: bold; color: white; margin-left: 10px; }
        .btn-login { background-color: #1976d2; }
        .btn-login:hover { background-color: #1565c0; }
        .btn-logout { background-color: #d32f2f; }
        .btn-logout:hover { background-color: #b71c1c; }

        /* Style phân nhóm Menu */
        .menu-section { border-radius: 5px; padding: 10px 20px 20px 20px; margin-bottom: 20px; width: 60%; }
        .public-menu { background-color: #f1f8e9; border-left: 5px solid #689f38; } /* Xanh lá */
        .public-menu h3 { color: #33691e; }
        .user-menu { background-color: #e3f2fd; border-left: 5px solid #1976d2; }   /* Xanh dương */
        .user-menu h3 { color: #0d47a1; }
        .admin-menu { background-color: #ffebee; border-left: 5px solid #d32f2f; }  /* Đỏ */
        .admin-menu h3 { color: #b71c1c; }
    </style>
</head>
<body>
    
    <!-- THANH THÔNG BÁO & ĐĂNG NHẬP -->
    <div class="header-bar">
        <span>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    Xin chào: <strong>${sessionScope.user.fullname}</strong> 
                    <c:if test="${sessionScope.user.admin}">
                        <span style="color: red; font-weight: bold;">[ADMIN]</span>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout">Đăng xuất</a>
                </c:when>
                <c:otherwise>
                    <i>Bạn chưa đăng nhập</i> 
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-login">Đăng nhập</a>
                </c:otherwise>
            </c:choose>
        </span>
        <span>Lượt truy cập: <strong>${applicationScope.visitors != null ? applicationScope.visitors : 0}</strong></span>
    </div>

    <h2>Hệ thống Quản lý Video - PolyOE</h2>
    
    <div class="menu">
        <!-- MENU 1: CHỨC NĂNG CÔNG KHAI (Ai cũng xem được) -->
        <div class="menu-section public-menu">
            <h3>&#127760; CHỨC NĂNG CÔNG KHAI</h3>
            <a href="${pageContext.request.contextPath}/video/list">Danh sách Video</a>
            <a href="${pageContext.request.contextPath}/video-search">Tìm kiếm Video theo từ khóa</a>
        </div>

        <!-- MENU 2: CHỨC NĂNG NGƯỜI DÙNG (Chỉ hiện khi đã đăng nhập) -->
        <c:if test="${not empty sessionScope.user}">
            <div class="menu-section user-menu">
                <h3>&#128100; CHỨC NĂNG CÁ NHÂN (USER)</h3>
                <a href="${pageContext.request.contextPath}/account/edit-profile">Cập nhật hồ sơ cá nhân</a>
                <a href="${pageContext.request.contextPath}/account/change-password">Đổi mật khẩu</a>
                <a href="${pageContext.request.contextPath}/user-favorites">Xem Video yêu thích của tôi</a>
            </div>
        </c:if>

        <!-- MENU 3: CHỨC NĂNG QUẢN TRỊ (Chỉ hiện khi đã đăng nhập VÀ là Admin) -->
        <!-- Logic: sessionScope.user.admin tương đương với việc gọi hàm getAdmin() trả về true/false -->
        <c:if test="${not empty sessionScope.user and sessionScope.user.admin}">
            <div class="menu-section admin-menu">
                <h3>&#9881;&#65039; CHỨC NĂNG QUẢN TRỊ (ADMIN)</h3>
                <a href="${pageContext.request.contextPath}/admin/video">Quản lý Video</a>
                <a href="${pageContext.request.contextPath}/admin/user">Quản lý Người dùng</a>
                <a href="${pageContext.request.contextPath}/all-favorites">Thống kê tất cả lượt thích</a>
                <a href="${pageContext.request.contextPath}/share-report">Báo cáo lượt chia sẻ Video</a>
            </div>
        </c:if>
    </div>

</body>
</html>
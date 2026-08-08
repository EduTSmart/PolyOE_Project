<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head><title>Trang Chủ</title></head>
<body style="margin: 20px;">
    <!-- Include Menu -->
    <jsp:include page="menu.jsp" />

    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-top: 20px;">
        <c:forEach var="v" items="${videos}">
            <div style="border: 1px solid #ffcc80; text-align: center; padding: 10px;">
                <!-- Click vào Poster sẽ gọi URL xem chi tiết -->
                <a href="${pageContext.request.contextPath}/video/detail/${v.id}">
                    <!-- Code mới (thêm đường dẫn Context Path và thư mục images) -->
<img src="${pageContext.request.contextPath}/images/${v.poster}" alt="POSTER" style="width: 100%; height: 200px; object-fit: cover; border-bottom: 1px solid #ffcc80;">
                </a>
                <h4 style="background-color: #e8f5e9; margin: 5px 0; padding: 5px;">${v.title}</h4>
                <div>
                    <a href="${pageContext.request.contextPath}/video/like/${v.id}" style="background-color: #8bc34a; color: white; padding: 5px 10px; text-decoration: none; border-radius: 3px;">Like</a>
                    <a href="${pageContext.request.contextPath}/video/share/${v.id}" style="background-color: #ff9800; color: white; padding: 5px 10px; text-decoration: none; border-radius: 3px;">Share</a>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Phân trang -->
    <div style="text-align: center; margin-top: 20px;">
        <a href="?page=1" style="padding: 5px 15px; background: #ccc; text-decoration: none; color: black;">|&lt;</a>
        <a href="?page=${currentPage - 1}" style="padding: 5px 15px; background: #ccc; text-decoration: none; color: black;">&lt;&lt;</a>
        <a href="?page=${currentPage + 1}" style="padding: 5px 15px; background: #ccc; text-decoration: none; color: black;">&gt;&gt;</a>
        <a href="?page=${totalPages}" style="padding: 5px 15px; background: #ccc; text-decoration: none; color: black;">&gt;|</a>
    </div>
</body>
</html>
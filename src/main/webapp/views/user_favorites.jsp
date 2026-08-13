<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Favorites - PolyOE</title>
</head>
<body style="margin: 20px; font-family: Arial, sans-serif; background-color: #fcfcfc;">
    
    <!-- Nhúng thanh Menu chung -->
    <jsp:include page="menu.jsp" />

    <div style="margin-top: 20px; text-align: center;">
        <h2 style="color: #d32f2f; text-transform: uppercase; border-bottom: 2px solid #ffca28; padding-bottom: 10px; display: inline-block;">
            VIDEO YÊU THÍCH CỦA BẠN
        </h2>
    </div>

    <!-- Hiển thị thông báo nếu chưa có video yêu thích -->
    <c:if test="${empty sessionScope.user.favorites}">
        <div style="text-align: center; padding: 50px; font-size: 18px; color: #666; background: #fff; border: 1px dashed #ccc; border-radius: 8px; margin-top: 20px;">
            <i>Bạn chưa có video yêu thích nào. Hãy ra trang chủ và thêm vài video nhé!</i>
        </div>
    </c:if>

    <!-- Hiển thị danh sách dạng Grid 3 cột giống trang chủ -->
    <c:if test="${not empty sessionScope.user.favorites}">
        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; margin-top: 20px;">
            <c:forEach var="favorite" items="${sessionScope.user.favorites}">
                <!-- Gán biến v để gọi code cho ngắn gọn -->
                <c:set var="v" value="${favorite.video}" />
                
                <div style="border: 1px solid #ffcc80; text-align: center; padding: 15px; background-color: #fff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.05);">
                    <a href="${pageContext.request.contextPath}/video/detail/${v.id}" style="display: block;">
                        
                        <!-- Xử lý hiển thị ảnh Poster thông minh -->
                        <c:choose>
                            <c:when test="${fn:startsWith(v.poster, 'http')}">
                                <img src="${v.poster}" alt="POSTER" style="width: 100%; height: 280px; object-fit: cover; border-radius: 4px; border-bottom: 1px solid #ffcc80;">
                            </c:when>
                            <c:when test="${fn:contains(v.poster, '.png') or fn:contains(v.poster, '.jpg')}">
                                <img src="${pageContext.request.contextPath}/images/${v.poster}" alt="POSTER" style="width: 100%; height: 280px; object-fit: cover; border-radius: 4px; border-bottom: 1px solid #ffcc80;">
                            </c:when>
                            <c:otherwise>
                                <img src="https://img.youtube.com/vi/${v.id}/hqdefault.jpg" alt="POSTER" style="width: 100%; height: 280px; object-fit: cover; border-radius: 4px; border-bottom: 1px solid #ffcc80;">
                            </c:otherwise>
                        </c:choose>
                        
                    </a>
                    
                    <h4 style="background-color: #e8f5e9; margin: 15px 0; padding: 10px; font-size: 16px; color: #333; height: 50px; overflow: hidden; display: flex; align-items: center; justify-content: center; border-radius: 4px;">
                        ${v.title}
                    </h4>
                    
                    <div style="margin-top: 15px; margin-bottom: 5px;">
                        <!-- Nút đổi thành Bỏ Thích (Unlike) -->
                        <a href="${pageContext.request.contextPath}/video/unlike/${v.id}" style="background-color: #e53935; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px; font-weight: bold; margin-right: 10px;">Bỏ thích</a>
                        
                        <a href="${pageContext.request.contextPath}/video/share/${v.id}" style="background-color: #ff9800; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px; font-weight: bold;">Chia sẻ</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

</body>
</html>
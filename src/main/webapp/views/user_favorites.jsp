<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Video Yêu Thích của ${user.fullname}</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>${user.fullname != null ? user.fullname : 'Người dùng không tồn tại'}</h2>
    <p>Các video đã yêu thích:</p>
    
    <c:if test="${not empty user.favorites}">
        <ul style="list-style-type: none; padding-left: 0;">
            <c:forEach var="favorite" items="${user.favorites}">
                <li>&#10003; ${favorite.video.title}</li>
            </c:forEach>
        </ul>
    </c:if>
    
    <c:if test="${empty user.favorites}">
        <p><i>Chưa có video yêu thích nào.</i></p>
    </c:if>

    <br>
    <a href="${pageContext.request.contextPath}/">Quay lại trang chủ</a>
</body>
</html>

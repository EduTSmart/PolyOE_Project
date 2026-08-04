<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head><title>Chi Tiết Video</title></head>
<body style="margin: 20px;">
    <jsp:include page="menu.jsp" />

    <div style="display: flex; gap: 20px; margin-top: 20px;">
        <!-- Cột trái: Chi tiết Video -->
        <div style="flex: 7; border: 1px solid #ffcc80;">
            <div style="height: 400px; background-color: #f5f5f5; text-align: center; line-height: 400px;">
                <!-- Có thể thay bằng thẻ <video> thực tế -->
                [ VIDEO PLAYER: ${video.id} ] 
            </div>
            <h3 style="background-color: #e8f5e9; margin: 0; padding: 10px;">${video.title}</h3>
            <p style="padding: 10px; min-height: 50px;">${video.description}</p>
            <div style="text-align: center; padding: 10px; border-top: 1px solid #ffcc80;">
                <!-- Sự kiện Like/Share yêu cầu Login -->
                <a href="${pageContext.request.contextPath}/video/like/${video.id}" style="background-color: #4285f4; color: white; padding: 8px 20px; text-decoration: none; border-radius: 3px;">Like</a>
                <a href="${pageContext.request.contextPath}/video/share/${video.id}" style="background-color: #ff9800; color: white; padding: 8px 20px; text-decoration: none; border-radius: 3px;">Share</a>
            </div>
        </div>

        <!-- Cột phải: Video đã xem (Từ Cookie) -->
        <div style="flex: 3; display: flex; flex-direction: column; gap: 10px;">
            <c:forEach var="vv" items="${viewedList}">
                <div style="display: flex; border: 1px solid #a5d6a7; padding: 5px;">
                    <img src="${vv.poster}" alt="POSTER" style="width: 80px; height: 60px; object-fit: cover;">
                    <span style="margin-left: 10px; text-decoration: underline; font-weight: bold;">${vv.title}</span>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
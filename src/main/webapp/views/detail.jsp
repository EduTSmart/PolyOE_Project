<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head><title>Chi Tiết Video - PolyOE</title></head>
<body style="margin: 20px; font-family: Arial, sans-serif; background-color: #fcfcfc;">
    
    <!-- Nhúng thanh Menu -->
    <jsp:include page="menu.jsp" />

    <div style="display: flex; gap: 20px; margin-top: 20px;">
        <!-- Cột trái: Chi tiết Video -->
        <div style="flex: 7; border: 1px solid #ffcc80; background-color: #fff;">
            
            <!-- TRÌNH PHÁT YOUTUBE THỰC TẾ (Đã tăng chiều cao lên 600px) -->
            <div style="height: 600px; background-color: #000;">
                <iframe width="100%" height="100%" 
                        src="https://www.youtube.com/embed/${video.id}?autoplay=1" 
                        title="YouTube video player" 
                        frameborder="0" 
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
                        allowfullscreen>
                </iframe>
            </div>

            <h3 style="background-color: #e8f5e9; margin: 0; padding: 15px; border-bottom: 1px solid #ffcc80;">${video.title}</h3>
            
            <p style="padding: 15px; min-height: 80px; line-height: 1.5; color: #333;">${video.description}</p>
            
            <div style="text-align: center; padding: 15px; border-top: 1px solid #ffcc80; background-color: #fafafa;">
                <!-- Sự kiện Like/Share yêu cầu Login -->
                <a href="${pageContext.request.contextPath}/video/like/${video.id}" style="background-color: #4285f4; color: white; padding: 10px 25px; text-decoration: none; border-radius: 4px; font-weight: bold; margin-right: 10px;">Thích</a>
                <a href="${pageContext.request.contextPath}/video/share/${video.id}" style="background-color: #ff9800; color: white; padding: 10px 25px; text-decoration: none; border-radius: 4px; font-weight: bold;">Chia sẻ</a>
            </div>
        </div>

        <!-- Cột phải: Video đã xem (Từ Cookie) -->
        <div style="flex: 3; display: flex; flex-direction: column; gap: 10px;">
            <div style="background-color: #ff9800; color: white; padding: 10px; font-weight: bold; text-align: center;">
                VIDEO ĐÃ XEM
            </div>
            
            <c:forEach var="vv" items="${viewedList}">
                <a href="${pageContext.request.contextPath}/video/detail/${vv.id}" style="text-decoration: none; color: black; display: flex; border: 1px solid #a5d6a7; padding: 5px; background-color: #fff; transition: background-color 0.3s;" onmouseover="this.style.backgroundColor='#e8f5e9'" onmouseout="this.style.backgroundColor='#fff'">
                    
                    <!-- Xử lý thông minh để hiện thị Poster chính xác ở cột phải -->
                    <c:choose>
                        <%-- Nếu chuỗi poster bắt đầu bằng http (đã là URL hoàn chỉnh) --%>
                        <c:when test="${fn:startsWith(vv.poster, 'http')}">
                            <img src="${vv.poster}" alt="POSTER" style="width: 100px; height: 70px; object-fit: cover; border: 1px solid #eee;">
                        </c:when>
                        <%-- Ngược lại, tự động sinh link lấy ảnh thumbnail gốc từ YouTube dựa vào ID --%>
                        <c:otherwise>
                            <img src="https://img.youtube.com/vi/${vv.id}/hqdefault.jpg" alt="POSTER" style="width: 100px; height: 70px; object-fit: cover; border: 1px solid #eee;">
                        </c:otherwise>
                    </c:choose>

                    <span style="margin-left: 10px; font-weight: bold; font-size: 14px; line-height: 1.4;">${vv.title}</span>
                </a>
            </c:forEach>
        </div>
    </div>
</body>
</html>
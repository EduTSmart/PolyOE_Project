<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head><title>Trang Chủ - PolyOE</title></head>
<body style="margin: 20px; font-family: Arial, sans-serif; background-color: #fcfcfc;">
    
    <!-- Include Menu -->
    <jsp:include page="menu.jsp" />

    <!-- Tăng khoảng cách margin-top và gap để các ô thoáng hơn -->
    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; margin-top: 30px;">
        <c:forEach var="v" items="${videos}">
            <!-- Thêm đổ bóng (box-shadow) và bo góc (border-radius) cho toàn bộ ô -->
            <div style="border: 1px solid #ffcc80; text-align: center; padding: 15px; background-color: #fff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.05);">
                <a href="${pageContext.request.contextPath}/video/detail/${v.id}" style="display: block;">
                    
                    <c:choose>
                        <c:when test="${fn:startsWith(v.poster, 'http')}">
                            <!-- Tăng chiều cao lên 280px -->
                            <img src="${v.poster}" alt="POSTER" style="width: 100%; height: 280px; object-fit: cover; border-radius: 4px; border-bottom: 1px solid #ffcc80;">
                        </c:when>
                        <c:when test="${fn:contains(v.poster, '.png') or fn:contains(v.poster, '.jpg')}">
                            <!-- Tăng chiều cao lên 280px -->
                            <img src="${pageContext.request.contextPath}/images/${v.poster}" alt="POSTER" style="width: 100%; height: 280px; object-fit: cover; border-radius: 4px; border-bottom: 1px solid #ffcc80;">
                        </c:when>
                        <c:otherwise>
                            <!-- Tăng chiều cao lên 280px -->
                            <img src="https://img.youtube.com/vi/${v.id}/hqdefault.jpg" alt="POSTER" style="width: 100%; height: 280px; object-fit: cover; border-radius: 4px; border-bottom: 1px solid #ffcc80;">
                        </c:otherwise>
                    </c:choose>
                    
                </a>
                
                <!-- Tăng chiều cao tiêu đề và căn giữa nội dung -->
                <h4 style="background-color: #e8f5e9; margin: 15px 0; padding: 10px; font-size: 16px; color: #333; height: 50px; overflow: hidden; display: flex; align-items: center; justify-content: center; border-radius: 4px;">${v.title}</h4>
                
                <!-- Nới rộng khoảng cách của nút Like và Share -->
                <div style="margin-top: 15px; margin-bottom: 5px;">
                    <a href="${pageContext.request.contextPath}/video/like/${v.id}" style="background-color: #4285f4; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px; font-weight: bold; margin-right: 10px;">Thích</a>
                    <a href="${pageContext.request.contextPath}/video/share/${v.id}" style="background-color: #ff9800; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px; font-weight: bold;">Chia sẻ</a>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Phân trang -->
    <div style="text-align: center; margin-top: 40px; margin-bottom: 20px;">
        <a href="?page=1" style="padding: 10px 15px; background: #e0e0e0; text-decoration: none; color: black; font-weight: bold; border-radius: 4px; margin: 0 5px;">|&lt;</a>
        <a href="?page=${currentPage > 1 ? currentPage - 1 : 1}" style="padding: 10px 15px; background: #e0e0e0; text-decoration: none; color: black; font-weight: bold; border-radius: 4px; margin: 0 5px;">&lt;&lt;</a>
        <a href="?page=${currentPage < totalPages ? currentPage + 1 : totalPages}" style="padding: 10px 15px; background: #e0e0e0; text-decoration: none; color: black; font-weight: bold; border-radius: 4px; margin: 0 5px;">&gt;&gt;</a>
        <a href="?page=${totalPages}" style="padding: 10px 15px; background: #e0e0e0; text-decoration: none; color: black; font-weight: bold; border-radius: 4px; margin: 0 5px;">&gt;|</a>
    </div>
</body>
</html>
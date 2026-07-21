<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm Video</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #5b9bd5; color: white; }
    </style>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>LAB 4: TÌM KIẾM VIDEO</h2>
    
    <form action="${pageContext.request.contextPath}/video-search" method="GET">
        <label for="keyword">Từ khóa: </label>
        <input type="text" id="keyword" name="keyword" value="${keyword}" style="padding: 5px; width: 300px;">
        <button type="submit" style="padding: 5px 15px;">Tìm</button>
    </form>

    <p>Kết quả:</p>
    <table>
        <thead>
            <tr>
                <th>Tiêu đề video</th>
                <th>Số lượt thích</th>
                <th>Còn hiệu lực</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="video" items="${videos}">
                <tr>
                    <td>${video.title}</td>
                    <!-- Sử dụng JSTL functions để đếm số lượng phần tử trong danh sách favorites -->
                    <td>${fn:length(video.favorites)}</td>
                    <td>${video.active ? 'Có' : 'Không'}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>

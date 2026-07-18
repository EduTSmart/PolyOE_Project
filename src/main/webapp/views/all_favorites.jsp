<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách Video được yêu thích</title>
    <style>
        table { border-collapse: collapse; width: 60%; margin-top: 20px; }
        th, td { border: 1px solid black; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Danh sách các video được yêu thích</h2>
    
    <table>
        <thead>
            <tr>
                <th>Video Title</th>
                <th>Người thích</th>
                <th>Ngày thích</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="favorite" items="${favorites}">
                <tr>
                    <td>${favorite.video.title}</td>
                    <td>${favorite.user.fullname}</td>
                    <td>${favorite.likeDate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
    <a href="${pageContext.request.contextPath}/">Quay lại trang chủ</a>
</body>
</html>

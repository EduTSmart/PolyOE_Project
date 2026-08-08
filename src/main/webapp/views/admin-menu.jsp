<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div style="background-color: #000; color: #fff; padding: 15px 25px; display: flex; justify-content: space-between; align-items: center; border-radius: 4px; margin-bottom: 20px; font-family: Arial, sans-serif;">
    <span style="font-size: 22px; font-weight: bold; color: #ffeb3b; text-shadow: 1px 1px 2px rgba(0,0,0,0.5);">ADMINISTRATION TOOL</span>
    <div style="display: flex; gap: 25px; font-weight: bold; font-size: 16px;">
        <a href="${pageContext.request.contextPath}/video/list" style="color: #8bc34a; text-decoration: none;">HOME</a>
        <a href="${pageContext.request.contextPath}/admin/video" style="color: #8bc34a; text-decoration: none;">VIDEOS</a>
        <a href="${pageContext.request.contextPath}/admin/user" style="color: #8bc34a; text-decoration: none;">USERS</a>
        <a href="${pageContext.request.contextPath}/admin/reports" style="color: #8bc34a; text-decoration: none;">REPORTS</a>
    </div>
</div>
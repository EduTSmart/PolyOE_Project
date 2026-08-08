<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Người dùng - Admin</title>
    <style>
        .box { border: 1px solid #ff9800; padding: 20px; margin-bottom: 20px; background: #fff; }
        .tabs { display: flex; gap: 5px; margin-bottom: -1px; }
        .tab { padding: 10px 20px; border: 1px solid #ff9800; border-bottom: none; background: #f5f5f5; font-weight: bold; cursor: pointer; text-decoration: none; color: #d32f2f; }
        .tab.active { background: #fff; border-bottom: 1px solid #fff; }
        .form-group { margin-bottom: 15px; flex: 1; }
        .form-control { width: 100%; padding: 8px; border: 1px solid #ff9800; box-sizing: border-box; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background: #f2f2f2; }
        .btn { padding: 8px 15px; font-weight: bold; cursor: pointer; border: none; border-radius: 3px; color: white; }
        .btn-update { background: #2196f3; }
        .btn-delete { background: #f44336; }
    </style>
</head>
<body style="margin: 20px; font-family: Arial, sans-serif;">

    <!-- Nhúng Menu Admin -->
    <jsp:include page="admin-menu.jsp" />

    <div style="color: red; font-style: italic; margin-bottom: 10px;">${message}</div>

    <!-- TABS -->
    <div class="tabs">
        <a class="tab active" href="#">USER EDITION</a>
        <a class="tab" href="#">USER LIST</a>
    </div>

    <!-- FORM EDITION -->
    <div class="box">
        <form action="${pageContext.request.contextPath}/admin/user/update" method="post">
            <div style="display: flex; gap: 20px;">
                <div class="form-group">
                    <label><b>USERNAME?</b></label>
                    <input type="text" name="username" value="${user.id}" class="form-control" readonly style="background:#eee;">
                </div>
                <div class="form-group">
                    <label><b>PASSWORD?</b></label>
                    <input type="password" name="password" value="${user.password}" class="form-control" required>
                </div>
            </div>

            <div style="display: flex; gap: 20px;">
                <div class="form-group">
                    <label><b>FULLNAME?</b></label>
                    <input type="text" name="fullname" value="${user.fullname}" class="form-control" required>
                </div>
                <div class="form-group">
                    <label><b>EMAIL ADDRESS?</b></label>
                    <input type="email" name="email" value="${user.email}" class="form-control" required>
                </div>
            </div>

            <div class="form-group">
                <label><b>ROLE:</b></label>
                <input type="checkbox" name="admin" value="true" ${user.admin ? 'checked' : ''}> Administrator
            </div>

            <div style="text-align: right; border-top: 1px solid #ff9800; padding-top: 15px;">
                <button type="submit" class="btn btn-update" ${!isEdit ? 'disabled style="opacity:0.5; cursor:not-allowed;"' : ''}>Update</button>
                <a href="${pageContext.request.contextPath}/admin/user/delete?id=${user.id}" class="btn btn-delete" onclick="return confirm('Bạn có chắc muốn xóa user này?');" style="text-decoration:none; display:inline-block; ${!isEdit ? 'pointer-events:none; opacity:0.5;' : ''}">Delete</a>
            </div>
        </form>
    </div>

    <!-- TABLE LIST -->
    <div class="box">
        <table>
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Fullname</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${users}">
                    <tr>
                        <td>${u.id}</td>
                        <td>******</td>
                        <td>${u.fullname}</td>
                        <td>${u.email}</td>
                        <td>${u.admin ? 'Admin' : 'User'}</td>
                        <td><a href="${pageContext.request.contextPath}/admin/user/edit?id=${u.id}">Edit</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</body>
</html>
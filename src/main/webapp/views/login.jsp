<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập</title>
</head>
<body>
<div class="form-container">
    <div class="form-header">Login</div>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-body">
            <div class="message-alert">${message}</div>
            <div class="form-group">
                <label class="form-label">Username?</label>
                <input type="text" name="username" value="${savedUser}" class="form-control" required>
            </div>
            <div class="form-group">
                <label class="form-label">Password?</label>
                <input type="password" name="password" value="${savedPass}" class="form-control" required>
            </div>
            <div class="form-group">
                <input type="checkbox" name="remember" value="true" ${not empty savedUser ? 'checked' : ''}> 
                <label style="text-transform: uppercase; font-size: 14px;">Remember Me?</label>
            </div>
        </div>
        <div class="form-footer">
            <button type="submit" class="btn-orange">Login</button>
        </div>
    </form>
</div>

</body>
</html>

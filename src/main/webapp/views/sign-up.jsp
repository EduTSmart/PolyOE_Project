<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập</title>
</head>
<body>
 <div class="form-container">
    <div class="form-header">Registration</div>
    <form action="${pageContext.request.contextPath}/account/sign-up" method="post">
        <div class="form-body">
            <div class="message-alert">${message}</div>
            <div style="display: flex; gap: 20px;">
                <div class="form-group" style="flex: 1;">
                    <label class="form-label">Username?</label>
                    <input type="text" name="username" class="form-control" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label class="form-label">Password?</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
            </div>
            <div style="display: flex; gap: 20px;">
                <div class="form-group" style="flex: 1;">
                    <label class="form-label">Fullname?</label>
                    <input type="text" name="fullname" class="form-control" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label class="form-label">Email Address?</label>
                    <input type="email" name="email" class="form-control" required>
                </div>
            </div>
        </div>
        <div class="form-footer">
            <button type="submit" class="btn-orange">Sign Up</button>
        </div>
    </form>
</div>

</body>
</html>




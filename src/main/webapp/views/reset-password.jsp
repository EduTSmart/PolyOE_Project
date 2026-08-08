<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu - PolyOE</title>
</head>
<body style="margin: 20px; background-color: #fcfcfc;">

    <!-- Nhúng thanh Menu và CSS dùng chung -->
    <jsp:include page="menu.jsp" />

    <!-- Form Đặt Lại Mật Khẩu -->
    <div class="form-container">
        <div class="form-header">Reset Password</div>
        
        <form action="${pageContext.request.contextPath}/account/reset-password" method="post">
            <div class="form-body">
                <div class="message-alert" style="margin-bottom: 15px;">${message}</div>
                
                <!-- Input ẩn để truyền token về Server -->
                <input type="hidden" name="token" value="${token}">
                
                <div class="form-group">
                    <label class="form-label">New Password?</label>
                    <input type="password" name="newPassword" class="form-control" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Confirm New Password?</label>
                    <input type="password" name="confirmPassword" class="form-control" required>
                </div>
            </div>
            
            <div class="form-footer">
                <button type="submit" class="btn-orange">Reset</button>
            </div>
        </form>
    </div>

</body>
</html>
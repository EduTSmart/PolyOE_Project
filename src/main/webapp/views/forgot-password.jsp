<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Khôi phục mật khẩu - PolyOE</title>
</head>
<body style="margin: 20px; background-color: #fcfcfc;">

    <!-- Nhúng thanh Menu và CSS dùng chung -->
    <jsp:include page="menu.jsp" />

    <!-- Form Quên Mật Khẩu -->
    <div class="form-container">
        <div class="form-header">Forgot Password</div>
        
        <form action="${pageContext.request.contextPath}/account/forgot-password" method="post">
            <div class="form-body">
                <!-- Vùng hiển thị thông báo lỗi hoặc thành công từ Servlet -->
                <div class="message-alert" style="margin-bottom: 15px;">${message}</div>
                
                <div class="form-group">
                    <label class="form-label">Username?</label>
                    <input type="text" name="username" class="form-control" placeholder="Nhập tên đăng nhập..." required>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Email?</label>
                    <input type="email" name="email" class="form-control" placeholder="Nhập email đã đăng ký..." required>
                </div>
            </div>
            
            <div class="form-footer">
                <button type="submit" class="btn-orange">Retrieve</button>
            </div>
        </form>
    </div>

</body>
</html>
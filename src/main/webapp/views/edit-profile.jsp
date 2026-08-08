<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cập nhật hồ sơ - PolyOE</title>
</head>
<body style="margin: 20px; background-color: #fcfcfc;">

    <!-- Nhúng thanh Menu và CSS dùng chung -->
    <jsp:include page="menu.jsp" />

    <!-- Form Cập nhật tài khoản -->
    <div class="form-container">
        <div class="form-header">Edit Profile</div>
        
        <form action="${pageContext.request.contextPath}/account/edit-profile" method="post">
            <div class="form-body">
                <!-- Vùng hiển thị thông báo thành công hoặc lỗi -->
                <div class="message-alert" style="margin-bottom: 15px;">${message}</div>
                
                <!-- Hàng 1: Username & Password (Readonly) -->
                <div style="display: flex; gap: 20px;">
                    <div class="form-group" style="flex: 1;">
                        <label class="form-label">Username?</label>
                        <!-- Lấy dữ liệu từ sessionScope.user -->
                        <input type="text" value="${sessionScope.user.id}" class="form-control" readonly style="background-color: #f0f0f0; color: #666; cursor: not-allowed;">
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label class="form-label">Password?</label>
                        <input type="password" value="${sessionScope.user.password}" class="form-control" readonly style="background-color: #f0f0f0; color: #666; cursor: not-allowed;">
                    </div>
                </div>
                
                <!-- Hàng 2: Fullname & Email (Cho phép chỉnh sửa) -->
                <div style="display: flex; gap: 20px;">
                    <div class="form-group" style="flex: 1;">
                        <label class="form-label">Fullname?</label>
                        <input type="text" name="fullname" value="${sessionScope.user.fullname}" class="form-control" required>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label class="form-label">Email Address?</label>
                        <input type="email" name="email" value="${sessionScope.user.email}" class="form-control" required>
                    </div>
                </div>
            </div>
            
            <div class="form-footer">
                <button type="submit" class="btn-orange">Update</button>
            </div>
        </form>
    </div>

</body>
</html>
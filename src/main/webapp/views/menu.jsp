<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
/* Style chuẩn form của dự án */
.form-container { border: 1px solid #f57c00; width: 50%; margin: 20px auto; font-family: Arial, sans-serif; }
.form-header { background-color: #e8f5e9; padding: 12px; font-weight: bold; font-size: 18px; border-bottom: 1px solid #f57c00; text-transform: uppercase; }
.form-body { padding: 20px; background: white; }
.form-group { margin-bottom: 15px; }
.form-label { text-transform: uppercase; font-size: 14px; margin-bottom: 5px; display: block; }
.form-control { width: 100%; padding: 8px; border: 1px solid #f57c00; box-sizing: border-box; }
.form-footer { background-color: #f5f5f5; padding: 10px; text-align: right; border-top: 1px solid #f57c00; }
.btn-orange { background-color: #f57c00; color: white; padding: 8px 20px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 14px; }
.btn-orange:hover { background-color: #e65100; }
.message-alert { text-align: center; color: red; font-style: italic; }

</style>
<!-- 1. Thanh thông báo Đăng nhập & Lượt truy cập (Giữ lại từ bài cũ) -->
<div style="background-color: #e0f7fa; padding: 10px 20px; border-radius: 5px; margin-bottom: 10px; display: flex; justify-content: space-between; border: 1px solid #b2ebf2;">
    <span>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                Xin chào: <strong>${sessionScope.user.fullname}</strong>
                <c:if test="${sessionScope.user.admin}">
                    <span style="color: red; font-weight: bold;">[ADMIN]</span>
                </c:if>
            </c:when>
            <c:otherwise>
                <i>Bạn chưa đăng nhập</i>
            </c:otherwise>
        </c:choose>
    </span>
    <span>
        Lượt truy cập hệ thống: <strong>${applicationScope.visitors != null ? applicationScope.visitors : 0}</strong>
    </span>
</div>

<!-- 2. Thanh Menu Chính (Giao diện Layout mới) -->
<div style="background-color: #ffca28; padding: 15px 20px; border-radius: 5px; display: flex; align-items: center; gap: 30px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
    
    <!-- Nút Trang chủ -->
    <a href="${pageContext.request.contextPath}/" style="font-size: 22px; font-weight: bold; color: #d32f2f; text-decoration: none;">
        ONLINE ENTERTAINMENT
    </a>
    
    <!-- Nút Video Yêu Thích -->
    <a href="${pageContext.request.contextPath}/user-favorites" style="font-size: 16px; font-weight: bold; color: #1976d2; text-decoration: none;">
        MY FAVORITES
    </a>
    
    <!-- Dropdown Tài khoản -->
    <div style="position: relative; display: inline-block;">
        <span style="font-size: 16px; font-weight: bold; color: #1976d2; cursor: pointer; padding: 5px 0;">
            MY ACCOUNT &#9662;
        </span>
        
        <!-- Nội dung Dropdown -->
        <div style="position: absolute; top: 100%; left: 0; background-color: white; min-width: 180px; box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); z-index: 10; border: 1px solid #ff7043; border-radius: 4px; overflow: hidden; display: none;" id="accountDropdown">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/login" style="display: block; padding: 10px 15px; text-decoration: none; color: black; border-bottom: 1px solid #eee;">Login</a>
                    <a href="${pageContext.request.contextPath}/account/forgot-password" style="display: block; padding: 10px 15px; text-decoration: none; color: black; border-bottom: 1px solid #eee;">Forgot Password</a>
                    <a href="${pageContext.request.contextPath}/account/sign-up" style="display: block; padding: 10px 15px; text-decoration: none; color: black;">Registration</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/account/change-password" style="display: block; padding: 10px 15px; text-decoration: none; color: black; border-bottom: 1px solid #eee;">Change Password</a>
                    <a href="${pageContext.request.contextPath}/account/edit-profile" style="display: block; padding: 10px 15px; text-decoration: none; color: black; border-bottom: 1px solid #eee;">Edit Profile</a>
                    <a href="${pageContext.request.contextPath}/logout" style="display: block; padding: 10px 15px; text-decoration: none; color: black;">Logoff</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- Script nhỏ để bật/tắt Dropdown My Account -->
<script>
    const accountBtn = document.querySelector('span:contains("MY ACCOUNT")') || document.querySelector('.menu-dropdown-btn');
    const dropdown = document.getElementById('accountDropdown');
    
    // Tìm thẻ span bằng Javascript thuần thay cho jQuery
    const spans = document.querySelectorAll('span');
    spans.forEach(span => {
        if(span.innerText.includes('MY ACCOUNT')) {
            span.addEventListener('click', function(e) {
                e.stopPropagation(); // Ngăn sự kiện click lan ra ngoài
                dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
            });
        }
    });

    // Click ra ngoài thì ẩn dropdown đi
    window.addEventListener('click', function() {
        if (dropdown.style.display === 'block') {
            dropdown.style.display = 'none';
        }
    });
</script>
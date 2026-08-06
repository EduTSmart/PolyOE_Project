<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập & Đăng Ký</title>
    <style>
        /* === RESET & BIẾN CSS TÙY CHỈNH === */
        :root {
            --primary-orange: #f39c12;
            --hover-orange: #e67e22;
            --bg-color: #f4f7f6;
            --text-color: #333;
            --border-color: #ddd;
            --header-bg: #2c3e50;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding: 50px 20px;
        }

        /* === TAB CONTAINER (Gộp chung 2 form) === */
        .tab-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 450px; /* Giới hạn chiều rộng nhỏ gọn */
            display: flex;
            flex-direction: column;
        }

        /* === TAB HEADER (Chứa các nút chuyển Tab) === */
        .tab-header {
            display: flex;
            background-color: var(--header-bg);
        }

        .tab-btn {
            flex: 1;
            padding: 20px;
            font-size: 16px;
            font-weight: 600;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: rgba(255, 255, 255, 0.5); /* Chữ mờ cho tab không active */
            background-color: transparent;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .tab-btn:hover {
            color: #fff;
        }

        /* Nút Tab đang được chọn sẽ sáng lên với màu cam */
        .tab-btn.active {
            color: #fff;
            background-color: var(--primary-orange);
        }

        /* === TAB CONTENT (Nội dung Form) === */
        .tab-content {
            display: none; /* Mặc định ẩn tất cả các tab */
            padding: 30px 25px;
        }

        /* Tab nào có class 'active' sẽ được hiển thị */
        .tab-content.active {
            display: block;
            animation: fadeIn 0.4s ease; /* Hiệu ứng mờ dần vào */
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(5px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* === CÁC THÀNH PHẦN TRONG FORM (Giữ nguyên) === */
        .form-group { margin-bottom: 20px; }
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
            font-size: 14px;
        }
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 5px;
            font-size: 15px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .form-control:focus {
            outline: none;
            border-color: var(--primary-orange);
            box-shadow: 0 0 5px rgba(243, 156, 18, 0.3);
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }
        .checkbox-group input[type="checkbox"] { width: 16px; height: 16px; cursor: pointer; }
        .checkbox-group label {
            text-transform: uppercase;
            font-size: 13px;
            font-weight: 600;
            color: #666;
            cursor: pointer;
        }

        .form-row { display: flex; gap: 15px; margin-bottom: 20px; }
        .form-row .form-group { flex: 1; margin-bottom: 0; }

        .message-alert {
            color: #e74c3c;
            font-size: 14px;
            text-align: center;
            margin-bottom: 15px;
            font-weight: 500;
            min-height: 20px;
        }

        .btn-orange {
            background-color: var(--primary-orange);
            color: #fff;
            border: none;
            width: 100%;
            padding: 14px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            text-transform: uppercase;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.1s ease;
        }
        .btn-orange:hover { background-color: var(--hover-orange); }
        .btn-orange:active { transform: scale(0.98); }

        @media (max-width: 768px) {
            .form-row { flex-direction: column; gap: 20px; }
        }
    </style>
</head>
<body>

<div class="tab-container">
    
    <!-- THANH ĐIỀU HƯỚNG TAB -->
    <div class="tab-header">
        <button class="tab-btn active" onclick="switchTab(event, 'loginTab')">Login</button>
        <button class="tab-btn" onclick="switchTab(event, 'registerTab')">Registration</button>
    </div>

    <!-- FORM ĐĂNG NHẬP -->
    <div id="loginTab" class="tab-content active">
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="message-alert">${message}</div>
            
            <div class="form-group">
                <label class="form-label">Username</label>
                <input type="text" name="username" value="${savedUser}" class="form-control" placeholder="Enter your username" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Password</label>
                <input type="password" name="password" value="${savedPass}" class="form-control" placeholder="Enter your password" required>
            </div>
            
            <div class="checkbox-group">
                <input type="checkbox" id="rememberMe" name="remember" value="true" ${not empty savedUser ? 'checked' : ''}> 
                <label for="rememberMe">Remember Me</label>
            </div>
            
            <button type="submit" class="btn-orange">Login</button>
        </form>
    </div>

    <!-- FORM ĐĂNG KÝ -->
    <div id="registerTab" class="tab-content">
        <form action="${pageContext.request.contextPath}/account/sign-up" method="post">
            <div class="message-alert">${message}</div>
            
            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" class="form-control" placeholder="Choose a username" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Create a password" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Fullname</label>
                    <input type="text" name="fullname" class="form-control" placeholder="John Doe" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Email Address</label>
                    <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                </div>
            </div>
            
            <button type="submit" class="btn-orange">Sign Up</button>
        </form>
    </div>

</div>

<!-- SCRIPT XỬ LÝ CHUYỂN ĐỔI TAB -->
<script>
    function switchTab(evt, tabId) {
        // 1. Tắt trạng thái 'active' của tất cả các nút Tab
        let tabButtons = document.querySelectorAll('.tab-btn');
        tabButtons.forEach(btn => btn.classList.remove('active'));

        // 2. Ẩn tất cả các khối nội dung Form
        let tabContents = document.querySelectorAll('.tab-content');
        tabContents.forEach(content => content.classList.remove('active'));

        // 3. Kích hoạt nút Tab vừa được click và Form tương ứng
        evt.currentTarget.classList.add('active');
        document.getElementById(tabId).classList.add('active');
    }
</script>

</body>
</html>
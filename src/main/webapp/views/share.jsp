<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chia sẻ Video</title>
    <style>
        /* === KẾT THỪA BIẾN CSS TỪ TRANG LOGIN === */
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

        .page-wrapper {
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
            max-width: 1000px;
            width: 100%;
            justify-content: center;
        }

        /* === BỐ CỤC CARD === */
        .form-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 450px;
            display: flex;
            flex-direction: column;
        }

        .form-header {
            /* Đổi màu nền Header thành màu cam để phân biệt với form Login (Xanh đen) */
            background-color: var(--primary-orange); 
            color: #fff;
            padding: 20px;
            font-size: 20px;
            font-weight: 600;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-body {
            padding: 30px 25px 20px;
            flex: 1;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
            font-size: 14px;
        }

        /* Form Control cho ô Input */
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

        .message-alert {
            color: #e74c3c;
            font-size: 14px;
            text-align: center;
            margin-bottom: 15px;
            font-weight: 500;
            min-height: 20px;
        }

        .text-muted {
            font-size: 13px;
            color: #7f8c8d;
            margin-top: 6px;
            display: block;
        }

        /* Nút Send */
        .form-footer {
            padding: 0 25px 30px;
        }

        .btn-orange {
            background-color: var(--header-bg); /* Đổi màu nút thành xanh đen cho nổi bật */
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

        .btn-orange:hover {
            background-color: #1a252f;
        }

        .btn-orange:active {
            transform: scale(0.98);
        }
    </style>
</head>
<body>

<div class="page-wrapper">
    <div class="form-container">
        
        <!-- 1. ĐÃ SỬA: Tiêu đề Form thành SHARE VIDEO -->
        <div class="form-header">Share Video</div>
        
        <!-- Action trỏ đúng về VideoServlet kèm ID video -->
        <form action="${pageContext.request.contextPath}/video/share/${videoId}" method="POST">
            <div class="form-body">
                
                <!-- Vùng hiển thị thông báo lỗi/thành công -->
                <div class="message-alert">${message}</div>
                
                <!-- Truyền ngầm videoId về Server -->
                <input type="hidden" name="videoId" value="${videoId}">
                
                <div class="form-group">
                    <label class="form-label">Your friend's email?</label>
                    
                    <!-- 2. ĐÃ SỬA: Thêm class "form-control" để bắt style CSS -->
                    <input type="email" name="email" class="form-control" placeholder="example@gmail.com, test@fpt.edu.vn" required>
                    
                    <span class="text-muted">Có thể gửi nhiều email, phân cách bằng dấu phẩy (,)</span>
                </div>
            </div>
            
            <div class="form-footer">
                <!-- 3. ĐÃ SỬA: Thêm class "btn-orange" để bắt style CSS -->
                <button type="submit" class="btn-orange">Send</button>
            </div>
        </form>
        
    </div>
</div>

</body>
</html>
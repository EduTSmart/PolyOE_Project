package com.poly.servlet;

import com.poly.dao.VideoDAO;
import com.poly.entity.User;
import com.poly.entity.Video;
import com.poly.utils.EmailUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet({"/video/list", "/video/detail/*", "/video/like/*", "/video/share/*"})
public class VideoServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        VideoDAO dao = new VideoDAO();

        try {
            // ==========================================
            // 1. CHỨC NĂNG: XEM DANH SÁCH VIDEO (TRANG CHỦ)
            // ==========================================
            if (uri.contains("/video/list")) {
                // Nhận tham số page từ URL (ví dụ: ?page=2). Nếu không có thì mặc định là trang 1
                String pageStr = request.getParameter("page");
                int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
                int pageSize = 6; // Hiển thị 6 video mỗi trang theo yêu cầu thiết kế
                
                // Lấy danh sách video và tính toán số trang
                List<Video> videos = dao.findTopVideos(page, pageSize);
                long totalVideos = dao.countActiveVideos();
                int totalPages = (int) Math.ceil((double) totalVideos / pageSize);
                
                // Đẩy dữ liệu sang View
                request.setAttribute("videos", videos);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                
                // Điều hướng về giao diện trang chủ
                request.getRequestDispatcher("/views/home.jsp").forward(request, response);
                
            } 
            // ==========================================
            // 2. CHỨC NĂNG: XEM CHI TIẾT VIDEO
            // ==========================================
            else if (uri.contains("/video/detail/")) {
                // Lấy ID video từ chuỗi URL (nằm sau dấu / cuối cùng)
                String id = uri.substring(uri.lastIndexOf("/") + 1);
                Video video = dao.findById(id);

                if (video != null) {
                    // A. Tăng số lượt xem (Views) lên 1 và cập nhật vào CSDL
                    video.setViews(video.getViews() + 1);
                    dao.update(video);

                    // B. Xử lý Cookie để lưu lại lịch sử video đã xem
                    Cookie[] cookies = request.getCookies();
                    String viewedIds = "";
                    if (cookies != null) {
                        for (Cookie c : cookies) {
                            if (c.getName().equals("viewedVideos")) {
                                viewedIds = c.getValue();
                                break;
                            }
                        }
                    }
                    
                    // Nếu video này chưa có trong chuỗi ID đã xem thì nối thêm vào
                    if (!viewedIds.contains(id)) {
                        viewedIds = viewedIds.isEmpty() ? id : viewedIds + "," + id;
                        Cookie cookie = new Cookie("viewedVideos", viewedIds);
                        cookie.setMaxAge(60 * 60 * 24 * 30); // Giữ Cookie trong 30 ngày
                        cookie.setPath("/");
                        response.addCookie(cookie);
                    }

                    // C. Đọc lại danh sách video từ chuỗi ID trong Cookie để hiển thị cột bên phải
                    List<Video> viewedVideosList = new ArrayList<>();
                    if (!viewedIds.isEmpty()) {
                        viewedVideosList = dao.findByIds(viewedIds.split(","));
                    }

                    request.setAttribute("video", video);
                    request.setAttribute("viewedList", viewedVideosList);
                    request.getRequestDispatcher("/views/detail.jsp").forward(request, response);
                } else {
                    // Nếu người dùng nhập sai ID video, đưa họ về lại trang chủ
                    response.sendRedirect(request.getContextPath() + "/video/list");
                }
                
            } 
            // ==========================================
            // 3. CHỨC NĂNG: LIKE VIDEO
            // ==========================================
            else if (uri.contains("/video/like/")) {
                String id = uri.substring(uri.lastIndexOf("/") + 1);
                // Lưu ý: Cần AuthFilter chặn chưa đăng nhập trước khi vào đây
                // (Logic Insert bảng Favorite có thể viết bổ sung tại đây)
                
                // Tạm thời chuyển hướng người dùng quay lại đúng trang chi tiết video đó
                response.sendRedirect(request.getContextPath() + "/video/detail/" + id);
                
            } 
            // ==========================================
            // 4. CHỨC NĂNG: SHARE VIDEO
            // ==========================================
            else if (uri.contains("/video/share/")) {
                // 1. Kiểm tra xem người dùng đã đăng nhập chưa
                User user = (User) request.getSession().getAttribute("user");
                
                if (user == null) {
                    // Chưa đăng nhập: Lưu lại đường dẫn hiện tại để sau khi đăng nhập xong sẽ tự động quay lại đây
                    request.getSession().setAttribute("securityUri", request.getRequestURI());
                    
                    // Chuyển hướng người dùng sang trang đăng nhập
                    response.sendRedirect(request.getContextPath() + "/login");
                    return; // Dừng thực thi các lệnh bên dưới
                }

                // Đã đăng nhập: Cho phép hiển thị form Share
                String id = uri.substring(uri.lastIndexOf("/") + 1);
                request.setAttribute("videoId", id);
                request.getRequestDispatcher("/views/share.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            // Nếu có lỗi bất ngờ, hiển thị trang page.jsp mặc định
            request.getRequestDispatcher("/page.jsp").forward(request, response);
        }
    }
    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        
        if (uri.contains("/video/share/")) {
            // Kiểm tra bảo mật lần 2: Đảm bảo đã đăng nhập
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            try {
                String videoId = request.getParameter("videoId");
                String friendEmail = request.getParameter("email");
                
                // Validate cơ bản
                if (videoId == null || videoId.isEmpty() || friendEmail == null || friendEmail.isEmpty()) {
                    throw new Exception("Vui lòng điền đầy đủ thông tin!");
                }

                // Xây dựng đường dẫn (URL) tuyệt đối của video để người nhận click vào xem trực tiếp
                String videoLink = request.getScheme() + "://" + request.getServerName() + ":" 
                                 + request.getServerPort() + request.getContextPath() 
                                 + "/video/detail/" + videoId;
                
                // Xử lý tách chuỗi nếu người dùng nhập nhiều email cách nhau bằng dấu phẩy (,)
                String[] emails = friendEmail.split(",");
                for (String email : emails) {
                    String cleanEmail = email.trim();
                    if (!cleanEmail.isEmpty()) {
                        // Gọi hàm tiện ích EmailUtils đã được định nghĩa sẵn
                        EmailUtils.send(
                            cleanEmail, 
                            "Someone shared a video with you!", 
                            "<h3>Xin chào!</h3><p>Bạn bè của bạn đã chia sẻ một video thú vị trên hệ thống .</p><p>Click vào liên kết sau để xem ngay: <a href='" + videoLink + "'>" + videoLink + "</a></p>"
                        );
                    }
                }
                
                // (Tùy chọn) Ghi nhận lịch sử chia sẻ vào Database thông qua ShareDAO nếu có
                // ShareDAO shareDao = new ShareDAO();
                // shareDao.insert(new Share(user, videoId, new Date()));
                
                request.setAttribute("message", "Đã gửi video thành công qua email!");
            } catch (Exception e) {
                e.printStackTrace();
                // Hiển thị chi tiết lỗi nếu kết nối SMTP hoặc App Password gặp sự cố
                request.setAttribute("message", "Gửi thất bại: " + e.getMessage());
            }
            
            // Giữ lại videoId để form JSP không bị mất dữ liệu khi load lại trang hiển thị thông báo
            String id = uri.substring(uri.lastIndexOf("/") + 1);
            request.setAttribute("videoId", id);
            
            request.getRequestDispatcher("/views/share.jsp").forward(request, response);
        }
    }
    
}
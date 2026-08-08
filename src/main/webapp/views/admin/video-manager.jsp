<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Video - Admin</title>
    <style>
        .box { border: 1px solid #ff9800; padding: 20px; margin-bottom: 20px; background: #fff; }
        .tabs { display: flex; gap: 5px; margin-bottom: -1px; }
        .tab { padding: 10px 20px; border: 1px solid #ff9800; border-bottom: none; background: #f5f5f5; font-weight: bold; cursor: pointer; text-decoration: none; color: #d32f2f; }
        .tab.active { background: #fff; border-bottom: 1px solid #fff; z-index: 1; position: relative; }
        .form-group { margin-bottom: 15px; }
        .form-control { width: 100%; padding: 8px; border: 1px solid #ff9800; box-sizing: border-box; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background: #f2f2f2; }
        .btn { padding: 8px 15px; font-weight: bold; cursor: pointer; border: none; border-radius: 3px; color: white; text-decoration: none; display: inline-block; }
        .btn-create { background: #4caf50; }
        .btn-update { background: #2196f3; }
        .btn-delete { background: #f44336; }
        .btn-reset { background: #9e9e9e; }
        .tab-content { display: none; }
        .tab-content.active { display: block; }
    </style>
</head>
<body style="margin: 20px; font-family: Arial, sans-serif; background-color: #fcfcfc;">

    <!-- Nhúng Menu Admin -->
   <jsp:include page="../admin-menu.jsp" />

    <div style="color: red; font-style: italic; margin-bottom: 10px;">${message}</div>

    <!-- TABS -->
    <div class="tabs">
        <a class="tab ${!isEdit && empty videos ? 'active' : 'active'}" onclick="openTab(event, 'Edition')">VIDEO EDITION</a>
        <a class="tab" onclick="openTab(event, 'List')">VIDEO LIST</a>
    </div>

    <!-- NỘI DUNG TAB: EDITION -->
    <div id="Edition" class="box tab-content active">
        <form action="${pageContext.request.contextPath}/admin/video/${isEdit ? 'update' : 'create'}" method="post">
            <div style="display: flex; gap: 20px;">
                <!-- Cột trái: Poster -->
                <div style="flex: 3; text-align: center;">
                    <div style="border: 2px dashed #ccc; height: 220px; display: flex; align-items: center; justify-content: center; background: #fafafa; margin-bottom: 10px;">
                        <img src="${not empty video.poster ? pageContext.request.contextPath.concat('/images/').concat(video.poster) : ''}" alt="POSTER" style="max-width: 100%; max-height: 210px; object-fit: contain; ${empty video.poster ? 'display:none;' : ''}" id="posterImg">
                        <span style="color: #888; ${not empty video.poster ? 'display:none;' : ''}" id="posterText">POSTER</span>
                    </div>
                    <input type="text" name="poster" value="${video.poster}" class="form-control" placeholder="Tên file ảnh (vd: poster.png)..." oninput="document.getElementById('posterImg').src='${pageContext.request.contextPath}/images/' + this.value; document.getElementById('posterImg').style.display='block'; document.getElementById('posterText').style.display='none';">
                </div>

                <!-- Cột phải: Thông tin -->
                <div style="flex: 7;">
                    <div class="form-group">
                        <label><b>YOUTUBE ID?</b></label>
                        <input type="text" name="id" value="${video.id}" class="form-control" ${isEdit ? 'readonly style="background:#eee;"' : 'required'}>
                    </div>
                    <div class="form-group">
                        <label><b>VIDEO TITLE?</b></label>
                        <input type="text" name="title" value="${video.title}" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label><b>VIEW COUNT?</b></label>
                        <input type="number" name="views" value="${empty video.views ? 0 : video.views}" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label><b>STATUS:</b></label>
                        <input type="checkbox" name="active" value="true" ${video.active ? 'checked' : ''}> Active
                    </div>
                </div>
            </div>

            <div class="form-group" style="margin-top: 15px;">
                <label><b>DESCRIPTION?</b></label>
                <textarea name="description" class="form-control" rows="4">${video.description}</textarea>
            </div>

            <div style="text-align: right; border-top: 1px solid #ff9800; padding-top: 15px;">
                <button type="submit" class="btn btn-create" ${isEdit ? 'disabled style="opacity:0.5;"' : ''}>Create</button>
                <button type="submit" formaction="${pageContext.request.contextPath}/admin/video/update" class="btn btn-update" ${!isEdit ? 'disabled style="opacity:0.5;"' : ''}>Update</button>
                <a href="${pageContext.request.contextPath}/admin/video/delete?id=${video.id}" class="btn btn-delete" onclick="return confirm('Xác nhận xóa video này?');" style="${!isEdit ? 'pointer-events:none; opacity:0.5;' : ''}">Delete</a>
                <a href="${pageContext.request.contextPath}/admin/video/reset" class="btn btn-reset">Reset</a>
            </div>
        </form>
    </div>

    <!-- NỘI DUNG TAB: LIST -->
    <div id="List" class="box tab-content">
        <table>
            <thead>
                <tr>
                    <th>Youtube Id</th>
                    <th>Video Title</th>
                    <th>View Count</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="v" items="${videos}">
                    <tr>
                        <td>${v.id}</td>
                        <td>${v.title}</td>
                        <td>${v.views}</td>
                        <td>${v.active ? 'Active' : 'Inactive'}</td>
                        <td><a href="${pageContext.request.contextPath}/admin/video/edit?id=${v.id}">Edit</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script>
        function openTab(evt, tabName) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tab-content");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tab");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(tabName).style.display = "block";
            evt.currentTarget.className += " active";
        }
    </script>
</body>
</html>
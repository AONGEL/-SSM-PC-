<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>编辑帖子 - ${post.title}</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Helvetica Neue', 'Microsoft YaHei', Arial, sans-serif;
            background-color: #f6f6f6;
            color: #121212;
            line-height: 1.6;
            min-height: 100vh;
        }
        .navbar {
            background: #fff;
            height: 56px;
            position: fixed;
            top: 0; left: 0; right: 0;
            z-index: 1000;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .navbar-content {
            width: 100%;
            max-width: 1200px;
            padding: 0 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .navbar-logo {
            font-size: 20px;
            font-weight: 700;
            color: #0066ff;
            text-decoration: none;
        }
        .navbar-links { display: flex; gap: 20px; }
        .navbar-links a {
            color: #121212;
            text-decoration: none;
            font-size: 15px;
            transition: color 0.2s;
        }
        .navbar-links a:hover { color: #0066ff; }
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 80px 20px 40px;
        }
        .page-title {
            font-size: 24px;
            font-weight: 600;
            color: #121212;
            margin-bottom: 24px;
        }
        .card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            padding: 24px;
            margin-bottom: 20px;
            transition: box-shadow 0.2s;
        }
        .card:hover { box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        .alert {
            padding: 12px 16px;
            border-radius: 4px;
            margin-bottom: 16px;
            font-size: 14px;
            border-left: 3px solid;
        }
        .alert-error { background: #fff3e8; color: #ea4d3e; border-left-color: #ea4d3e; }
        .form-group { margin-bottom: 20px; }
        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #121212;
            margin-bottom: 8px;
        }
        .form-control {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            font-size: 15px;
            color: #121212;
            background: #fff;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-control:focus {
            outline: none;
            border-color: #0066ff;
            box-shadow: 0 0 0 2px rgba(0,102,255,0.1);
        }
        .form-control::placeholder { color: #b0b0b0; }
        textarea.form-control { min-height: 200px; resize: vertical; line-height: 1.8; }
        .form-error { color: #ea4d3e; font-size: 13px; margin-top: 6px; }
        .button-bar { display: flex; gap: 12px; margin-bottom: 16px; flex-wrap: wrap; }
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
        }
        .btn-primary { background: #0066ff; color: #fff; }
        .btn-primary:hover { background: #0059e6; }
        .btn-secondary { background: #f0f0f0; color: #121212; }
        .btn-secondary:hover { background: #e0e0e0; }
        .btn-success { background: #00a854; color: #fff; }
        .btn-success:hover { background: #009145; }
        .btn-submit { background: #0066ff; color: #fff; padding: 12px 32px; font-size: 15px; }
        .btn-submit:hover { background: #0059e6; }
        .btn-cancel { background: #f0f0f0; color: #121212; }
        .btn-cancel:hover { background: #e0e0e0; }
        #imageFileInput { display: none; }
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0,0,0,0.5);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }
        .modal-overlay.active { display: flex; }
        .modal {
            background: #fff;
            border-radius: 8px;
            width: 90%;
            max-width: 600px;
            max-height: 80vh;
            overflow-y: auto;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        .modal-header {
            padding: 20px 24px;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .modal-title { font-size: 18px; font-weight: 600; color: #121212; }
        .modal-close {
            background: none;
            border: none;
            font-size: 28px;
            color: #999;
            cursor: pointer;
            padding: 0;
            line-height: 1;
        }
        .modal-close:hover { color: #121212; }
        .modal-body { padding: 24px; }
        .hardware-list { max-height: 300px; overflow-y: auto; }
        .hardware-item {
            padding: 12px 16px;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
            transition: background 0.2s;
        }
        .hardware-item:last-child { border-bottom: none; }
        .hardware-item:hover { background: #f6f6f6; }
        .hardware-item-name { font-size: 14px; color: #121212; }
        .bottom-nav { display: flex; gap: 12px; margin-top: 24px; flex-wrap: wrap; }
        .bottom-nav a {
            color: #0066ff;
            text-decoration: none;
            font-size: 14px;
            padding: 8px 16px;
            border-radius: 4px;
            transition: background 0.2s;
        }
        .bottom-nav a:hover { background: #f0f0f0; }
        @media (max-width: 768px) {
            .navbar-content { padding: 0 12px; }
            .main-container { padding: 70px 12px 24px; }
            .card { padding: 16px; }
            .button-bar { flex-direction: column; }
            .btn { width: 100%; justify-content: center; }
            .bottom-nav { flex-direction: column; }
            .bottom-nav a { text-align: center; }
        }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="navbar-content">
        <a href="${pageContext.request.contextPath}/" class="navbar-logo">PC 硬件论坛</a>
        <div class="navbar-links">
            <c:if test="${sessionScope.currentUser != null}">
                <a href="${pageContext.request.contextPath}/user/profile">${sessionScope.currentUser.username}</a>
                <a href="${pageContext.request.contextPath}/user/logout">退出</a>
            </c:if>
            <c:if test="${sessionScope.currentUser == null}">
                <a href="${pageContext.request.contextPath}/user/login">登录</a>
                <a href="${pageContext.request.contextPath}/user/register">注册</a>
            </c:if>
        </div>
    </div>
</nav>

<div class="main-container">
    <h1 class="page-title">编辑：${post.title}</h1>

    <div class="card">
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">${errorMessage}</div>
        </c:if>

        <form:form modelAttribute="post" method="post" action="${pageContext.request.contextPath}/post/${post.id}/edit" enctype="multipart/form-data">
            <div class="form-group">
                <label class="form-label" for="title">标题</label>
                <form:input path="title" id="title" type="text" class="form-control" required="required"/>
                <form:errors path="title" cssClass="form-error"/>
            </div>

            <div class="form-group">
                <label class="form-label" for="content">内容</label>

                <div class="button-bar">
                    <button type="button" id="uploadBtn" class="btn btn-secondary">📤 上传图片</button>
                    <input type="file" id="imageFileInput" accept="image/*">

                    <c:if test="${sessionScope.currentUser.role == 'CERTIFIED' || sessionScope.currentUser.role == 'ADMIN'}">
                        <button type="button" id="insertReferenceBtn" class="btn btn-success">🔍 插入硬件引用</button>
                    </c:if>
                </div>

                <form:textarea path="content" id="content" class="form-control" placeholder="编辑帖子内容..." required="required"/>
                <form:errors path="content" cssClass="form-error"/>
            </div>

            <div style="margin-top: 24px; display: flex; gap: 12px;">
                <input type="submit" value="💾 保存" class="btn btn-submit"/>
                <a href="${pageContext.request.contextPath}/post/${post.id}" class="btn btn-cancel">❌ 取消</a>
            </div>
        </form:form>
    </div>

    <div class="bottom-nav">
        <a href="${pageContext.request.contextPath}/post/${post.id}">↩️ 返回帖子详情</a>
        <a href="${pageContext.request.contextPath}/forum/section/${post.sectionId}/posts">📁 返回板块</a>
        <a href="${pageContext.request.contextPath}/">🏠 返回首页</a>
    </div>
</div>

<div id="hardwareSearchModal" class="modal-overlay">
    <div class="modal">
        <div class="modal-header">
            <h3 class="modal-title">选择硬件</h3>
            <button class="modal-close">&times;</button>
        </div>
        <div class="modal-body">
            <select id="hardwareSearchTypeSelect" class="form-control" style="margin-bottom: 16px;">
                <option value="cpu_info">CPU</option>
                <option value="gpu_info">GPU</option>
                <option value="motherboard_info">主板</option>
            </select>
            <input type="text" id="hardwareSearchInput" class="form-control" placeholder="搜索硬件型号..." style="margin-bottom: 16px;">
            <div id="hardwareSearchList" class="hardware-list"></div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $('#uploadBtn').click(function() { $('#imageFileInput').click(); });

        $('#imageFileInput').change(function() {
            var file = this.files[0];
            if (file) {
                if (!file.type.startsWith('image/')) { alert('请选择图片文件！'); return; }
                var maxSize = 5 * 1024 * 1024;
                if (file.size > maxSize) { alert('文件大小不能超过 5MB！'); return; }
                var formData = new FormData();
                formData.append('file', file);
                $.ajax({
                    url: '${pageContext.request.contextPath}/upload/image',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        if (response && response.url) {
                            insertTextAtCursor($('#content'), '![](' + response.url + ')');
                        } else {
                            alert('上传失败：' + (response.message || '未知错误'));
                        }
                    },
                    error: function(xhr, status, error) {
                        alert('上传失败：' + error);
                    }
                });
            }
        });

        function insertTextAtCursor(textarea, text) {
            var start = textarea[0].selectionStart;
            var end = textarea[0].selectionEnd;
            var content = textarea.val();
            var newContent = content.substring(0, start) + text + content.substring(end);
            textarea.val(newContent);
            textarea[0].selectionStart = textarea[0].selectionEnd = start + text.length;
            textarea.focus();
        }

        var hardwareModal = $('#hardwareSearchModal');
        var hardwareModalClose = $('.modal-close');
        var hardwareSearchInput = $('#hardwareSearchInput');
        var hardwareSearchTypeSelect = $('#hardwareSearchTypeSelect');
        var hardwareSearchList = $('#hardwareSearchList');

        $('#insertReferenceBtn').click(function() {
            hardwareModal.addClass('active');
            hardwareSearchInput.val('');
            hardwareSearchTypeSelect.val('cpu_info');
            hardwareSearchList.empty();
        });

        hardwareModalClose.click(function() { hardwareModal.removeClass('active'); });
        hardwareModal.click(function(event) { if (event.target === hardwareModal[0]) { hardwareModal.removeClass('active'); } });

        hardwareSearchInput.on('input', function() {
            var keyword = $(this).val().trim();
            var table = hardwareSearchTypeSelect.val();
            if (keyword.length >= 1 && table) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/hardware/search',
                    type: 'GET',
                    data: { term: keyword, table: table },
                    success: function(data) {
                        hardwareSearchList.empty();
                        if (data && data.length > 0) {
                            data.forEach(function(item) {
                                var itemDiv = $('<div class="hardware-item" data-id="' + item.id + '"><span class="hardware-item-name">' + item.brand + ' ' + item.model + '</span></div>');
                                itemDiv.click(function() {
                                    var id = $(this).data('id');
                                    var table = hardwareSearchTypeSelect.val();
                                    var referenceText = '[' + table + ':' + id + ']';
                                    insertTextAtCursor($('#content'), referenceText);
                                    hardwareModal.removeClass('active');
                                });
                                hardwareSearchList.append(itemDiv);
                            });
                        } else {
                            hardwareSearchList.append('<div class="hardware-item">未找到匹配项</div>');
                        }
                    },
                    error: function(xhr, status, error) {
                        hardwareSearchList.html('<div class="hardware-item">搜索失败：' + error + '</div>');
                    }
                });
            } else {
                hardwareSearchList.empty();
            }
        });
    });
</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>编辑帖子 - ${post.title}</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
    <style>
        /* 整体布局 - 白色背景 */
        body {
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            min-height: 100vh;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 标题美化 */
        h1 {
            text-align: center;
            color: #2c3e50;
            font-size: 36px;
            margin-bottom: 30px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.05);
            letter-spacing: 1px;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            position: relative;
        }

        h1::after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 120px;
            height: 4px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 2px;
        }

        /* 错误提示美化 */
        .error-message {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            padding: 15px 20px;
            border-radius: 15px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.25);
            border-left: 5px solid #bd2130;
            font-size: 16px;
            font-weight: 500;
            text-align: center;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .error-message p {
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .error-message p::before {
            content: '⚠️';
            font-size: 24px;
        }

        /* 表单卡片美化 */
        .form-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 25px;
            padding: 45px;
            margin-bottom: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .form-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(102, 126, 234, 0.05) 0%, transparent 70%);
            z-index: 0;
        }

        .form-card:hover {
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.12);
            transform: translateY(-5px);
        }

        /* 表单字段美化 */
        .form-group {
            margin-bottom: 30px;
            position: relative;
            z-index: 1;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #2c3e50;
            font-size: 17px;
            margin-bottom: 12px;
            padding-left: 8px;
            text-align: left;
            position: relative;
            transition: all 0.3s ease;
        }

        .form-group label::before {
            content: '•';
            color: #667eea;
            font-weight: bold;
            margin-right: 10px;
            font-size: 20px;
            position: absolute;
            left: -25px;
            top: -2px;
        }

        /* 输入框美化 */
        .form-control {
            width: 100%;
            padding: 16px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 20px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #fff;
            color: #333;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        .form-control::placeholder {
            color: #9e9e9e;
            font-style: italic;
            opacity: 1;
        }

        /* 文本域美化 */
        #content {
            width: 100%;
            padding: 18px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 20px;
            font-size: 16px;
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
            resize: vertical;
            min-height: 300px;
            max-height: 600px;
            transition: all 0.3s ease;
            background: #fff;
            color: #333;
            line-height: 1.6;
            box-sizing: border-box;
        }

        #content:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        /* 按钮组美化 */
        .button-group {
            display: flex;
            gap: 20px;
            margin-top: 30px;
            flex-wrap: wrap;
            justify-content: center;
            position: relative;
            z-index: 1;
        }

        /* 统一按钮基础样式 */
        .btn,
        input[type="submit"],
        button {
            padding: 12px 24px !important;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            gap: 8px;
            min-width: 110px;
            height: 48px;
            line-height: 1;
            box-sizing: border-box !important;
        }

        .btn::before,
        input[type="submit"]::before,
        button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before,
        input[type="submit"]:hover::before,
        button:hover::before {
            left: 100%;
        }

        .btn:hover,
        input[type="submit"]:hover,
        button:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .btn:active,
        input[type="submit"]:active,
        button:active {
            transform: translateY(1px);
        }

        /* 保存按钮 - 紫色渐变 */
        input[type="submit"] {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 14px 32px !important;
            font-size: 16px;
        }

        input[type="submit"]:hover {
            background: linear-gradient(135deg, #5568d3 0%, #653a8f 100%);
        }

        /* 取消按钮 - 灰色渐变 */
        .btn-cancel {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            color: white;
        }

        .btn-cancel:hover {
            background: linear-gradient(135deg, #5a6268 0%, #4e555b 100%);
        }

        /* 底部链接美化 */
        .page-footer {
            margin-top: 50px;
            display: flex;
            justify-content: center;
            gap: 25px;
            padding: 25px;
        }

        .back-link {
            display: inline-block;
            padding: 12px 30px;
            background: rgba(255, 255, 255, 0.2);
            color: #667eea !important;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255, 255, 255, 0.3);
        }

        .back-link:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
            background: rgba(255, 255, 255, 0.3);
            color: #764ba2 !important;
            border-color: rgba(255, 255, 255, 0.5);
        }

        /* 硬件引用按钮美化 */
        #insertReferenceBtn {
            padding: 12px 28px !important;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-bottom: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
        }

        #insertReferenceBtn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        #insertReferenceBtn:hover::before {
            left: 100%;
        }

        #insertReferenceBtn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            background: linear-gradient(135deg, #218838 0%, #1e7e34 100%);
        }

        /* 上传按钮美化 */
        #uploadBtn {
            padding: 12px 28px !important;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-bottom: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }

        #uploadBtn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        #uploadBtn:hover::before {
            left: 100%;
        }

        #uploadBtn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            background: linear-gradient(135deg, #0069d9 0%, #004494 100%);
        }

        /* 隐藏的文件输入框 */
        #imageFileInput {
            display: none;
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            h1 {
                font-size: 28px;
                margin-bottom: 25px;
            }

            h1::after {
                width: 100px;
                height: 3px;
            }

            .form-card {
                padding: 30px 20px;
            }

            .button-group {
                flex-direction: column;
                align-items: center;
            }

            .btn,
            input[type="submit"],
            button {
                width: 100%;
                max-width: 350px;
                margin-bottom: 12px;
            }

            .page-footer {
                flex-direction: column;
                gap: 15px;
            }

            .back-link {
                width: 100%;
                max-width: 300px;
                text-align: center;
            }
        }

        /* 表单验证错误提示 */
        .error {
            color: #dc3545;
            font-size: 14px;
            margin-top: 10px;
            display: block;
            font-weight: 500;
            padding-left: 8px;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-5px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* ========== 保留原有模态框样式 - 不要改动 ========== */

        /* 简单的模态框样式 (用于显示硬件详情) */
        .hardware-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .hardware-modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 5px;
        }

        .hardware-modal-close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .hardware-modal-close:hover,
        .hardware-modal-close:focus {
            color: black;
        }

        .hardware-detail {
            margin-top: 10px;
        }

        .hardware-detail p {
            margin: 5px 0;
        }

        /* 硬件引用搜索模态框样式 - 保留原有功能 */
        .hardware-search-modal {
            display: none;
            position: fixed;
            z-index: 2001;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(8px);
        }

        .hardware-search-modal-content {
            background: rgba(255, 255, 255, 0.99);
            backdrop-filter: blur(15px);
            margin: 8% auto;
            padding: 40px;
            border-radius: 25px;
            width: 90%;
            max-width: 650px;
            box-shadow: 0 15px 60px rgba(0, 0, 0, 0.35);
            border: 2px solid rgba(255, 255, 255, 0.5);
            animation: modalFadeIn 0.4s ease;
        }

        @keyframes modalFadeIn {
            from {
                opacity: 0;
                transform: translateY(-30px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .hardware-search-modal-close {
            color: #6c757d;
            float: right;
            font-size: 36px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            z-index: 10;
            background: none;
            border: none;
            padding: 0;
            line-height: 1;
        }

        .hardware-search-modal-close:hover,
        .hardware-search-modal-close:focus {
            color: #dc3545;
            transform: rotate(90deg) scale(1.2);
            text-shadow: 0 0 10px rgba(220, 53, 69, 0.3);
        }

        /* 模态框标题美化 */
        .hardware-search-modal-content h3 {
            color: #2c3e50;
            font-size: 26px;
            margin-bottom: 25px;
            font-weight: 700;
            text-align: center;
            position: relative;
        }

        .hardware-search-modal-content h3::after {
            content: '';
            position: absolute;
            bottom: -12px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 2px;
        }

        /* 硬件类型选择美化 */
        #hardwareSearchTypeSelect {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e0e0e0;
            border-radius: 20px;
            font-size: 16px;
            margin-bottom: 20px;
            background: #fff;
            color: #333;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        #hardwareSearchTypeSelect:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        /* 搜索输入框美化 */
        #hardwareSearchInput {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e0e0e0;
            border-radius: 20px;
            font-size: 16px;
            margin-bottom: 25px;
            background: #fff;
            color: #333;
            transition: all 0.3s ease;
        }

        #hardwareSearchInput::placeholder {
            color: #9e9e9e;
            font-style: italic;
        }

        #hardwareSearchInput:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        /* 硬件列表美化 */
        #hardwareSearchList {
            max-height: 350px;
            overflow-y: auto;
            padding: 10px 0;
        }

        #hardwareSearchList::-webkit-scrollbar {
            width: 10px;
        }

        #hardwareSearchList::-webkit-scrollbar-track {
            background: #f5f5f5;
            border-radius: 10px;
        }

        #hardwareSearchList::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            border: 2px solid #f5f5f5;
        }

        #hardwareSearchList::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, #5568d3 0%, #653a8f 100%);
        }

        /* 硬件项美化 */
        .hardware-search-item {
            padding: 16px 20px;
            cursor: pointer;
            border-bottom: 1px solid #e0e0e0;
            transition: all 0.3s ease;
            border-radius: 15px;
            margin-bottom: 8px;
            background: rgba(255, 255, 255, 0.5);
        }

        .hardware-search-item:hover {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            transform: translateX(8px);
            border-left: 5px solid #667eea;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.15);
            padding-left: 25px;
        }

        .hardware-search-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }
    </style>
</head>
<body>
<h1>编辑: ${post.title}</h1>

<div class="form-card">
    <c:if test="${not empty errorMessage}">
        <div class="error-message">
            <p>${errorMessage}</p>
        </div>
    </c:if>

    <form:form modelAttribute="post" method="post" action="${pageContext.request.contextPath}/post/${post.id}" enctype="multipart/form-data">
        <div class="form-group">
            <label for="title">标题:</label>
            <form:input path="title" id="title" type="text" class="form-control" required="required"/>
            <form:errors path="title" cssClass="error" />
        </div>

        <div class="form-group">
            <label for="content">内容:</label>
            <div style="margin-bottom: 15px;">
                <button type="button" id="uploadBtn" class="btn">📤 上传图片</button>
                <input type="file" id="imageFileInput" accept="image/*" style="display:none;">

                <c:if test="${sessionScope.currentUser.role == 'CERTIFIED' || sessionScope.currentUser.role == 'ADMIN'}">
                    <button type="button" id="insertReferenceBtn" class="btn">🔍 插入硬件引用</button>
                </c:if>
            </div>
            <form:textarea path="content" id="content" class="form-control" placeholder="编辑帖子内容..." required="required"/>
            <form:errors path="content" cssClass="error" />
        </div>

        <div class="button-group">
            <input type="submit" value="💾 保存" />
            <a href="${pageContext.request.contextPath}/post/${post.id}" class="btn btn-cancel">❌ 取消</a>
        </div>
    </form:form>
</div>

<div class="page-footer">
    <a href="${pageContext.request.contextPath}/post/${post.id}" class="back-link">↩️ 返回帖子详情</a>
    <a href="${pageContext.request.contextPath}/forum/section/${post.sectionId}/posts" class="back-link">📁 返回板块</a>
    <a href="${pageContext.request.contextPath}/" class="back-link">🏠 返回首页</a>
</div>

<!-- 硬件详情模态框 -->
<div id="hardwareModal" class="hardware-modal">
    <div class="hardware-modal-content">
        <span class="hardware-modal-close">&times;</span>
        <h3>硬件详情</h3>
        <div id="hardwareDetailContent" class="hardware-detail">
            <!-- 硬件详情将在这里动态加载 -->
        </div>
    </div>
</div>

<!-- 硬件引用搜索模态框 -->
<div id="hardwareSearchModal" class="hardware-search-modal">
    <div class="hardware-search-modal-content">
        <span class="hardware-search-modal-close">&times;</span>
        <h3>选择硬件</h3>

        <!-- 硬件类型选择 -->
        <select id="hardwareSearchTypeSelect">
            <option value="cpu_info">CPU</option>
            <option value="gpu_info">GPU</option>
            <option value="motherboard_info">主板</option>
        </select>

        <!-- 搜索框 -->
        <input type="text" id="hardwareSearchInput" placeholder="搜索硬件型号...">

        <div id="hardwareSearchList"></div>
    </div>
</div>

<!-- JavaScript 保持原样，不修改 -->
<script>
    $(document).ready(function() {
        console.log("Edit Document ready fired");
    });

    // - 图片上传功能 -
    $('#uploadBtn').click(function() {
        console.log("Upload button clicked");
        $('#imageFileInput').click();
    });

    $('#imageFileInput').change(function() {
        console.log("File selected");
        var file = this.files[0];
        if (file) {
            if (!file.type.startsWith('image/')) {
                alert('请选择图片文件！');
                return;
            }
            var maxSize = 5 * 1024 * 1024; // 5MB
            if (file.size > maxSize) {
                alert('文件大小不能超过 5MB！');
                return;
            }
            var formData = new FormData();
            formData.append('file', file);
            $.ajax({
                url: '${pageContext.request.contextPath}/upload/image',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    console.log("Upload success:", response);
                    if (response && response.url) {
                        var imageUrl = response.url;
                        var markdown = '![](' + imageUrl + ')';
                        insertTextAtCursor($('#content'), markdown);
                    } else {
                        alert('上传失败：' + (response.message || '未知错误'));
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Upload error:", status, error);
                    alert('上传失败：' + error);
                }
            });
        }
    });

    // - 硬件引用功能 -
    var hardwareModal = $('#hardwareSearchModal');
    var hardwareModalClose = $('.hardware-search-modal-close');
    var hardwareSearchInput = $('#hardwareSearchInput');
    var hardwareSearchTypeSelect = $('#hardwareSearchTypeSelect');
    var hardwareSearchList = $('#hardwareSearchList');

    // 点击插入硬件引用按钮
    $('#insertReferenceBtn').click(function() {
        console.log("Insert Reference button clicked");
        hardwareModal.show();
        hardwareSearchInput.val('');
        hardwareSearchTypeSelect.val('cpu_info');
        hardwareSearchList.empty();
    });

    // 点击关闭按钮
    hardwareModalClose.click(function() {
        hardwareModal.hide();
    });

    // 点击模态框外部区域
    $(window).click(function(event) {
        if (event.target === hardwareModal[0]) {
            hardwareModal.hide();
        }
    });

    // 搜索功能
    hardwareSearchInput.on('input', function() {
        var keyword = $(this).val().trim();
        var table = hardwareSearchTypeSelect.val();
        if (keyword.length >= 1 && table) {
            $.ajax({
                url: '${pageContext.request.contextPath}/hardware/search',
                type: 'GET',
                data: { term: keyword, table: table },
                success: function(data) {
                    console.log("Hardware search API returned:", data);
                    hardwareSearchList.empty();
                    if (data && data.length > 0) {
                        data.forEach(function(item) {
                            var itemDiv = $('<div class="hardware-search-item" data-id="' + item.id + '">' + item.brand + ' ' + item.model + '</div>');
                            itemDiv.click(function() {
                                var id = $(this).data('id');
                                var table = hardwareSearchTypeSelect.val();
                                var referenceText = '[' + table + ':' + id + ']';
                                insertTextAtCursor($('#content'), referenceText);
                                hardwareModal.hide();
                            });
                            hardwareSearchList.append(itemDiv);
                        });
                    } else {
                        hardwareSearchList.append('<div class="hardware-search-item">未找到匹配项</div>');
                    }
                    hardwareSearchList.show();
                },
                error: function(xhr, status, error) {
                    console.error("Hardware search API failed:", status, error);
                    hardwareSearchList.html('<div class="hardware-search-item">搜索失败: ' + error + '</div>');
                }
            });
        } else {
            hardwareSearchList.empty().hide();
        }
    });

    // 插入文本函数
    function insertTextAtCursor(textarea, text) {
        var start = textarea[0].selectionStart;
        var end = textarea[0].selectionEnd;
        var content = textarea.val();
        var newContent = content.substring(0, start) + text + content.substring(end);
        textarea.val(newContent);
        textarea[0].selectionStart = textarea[0].selectionEnd = start + text.length;
        textarea.focus();
    }

    // 处理硬件详情模态框关闭
    $('.hardware-modal-close').click(function() {
        $('#hardwareModal').hide();
    });

    $(window).click(function(event) {
        if (event.target === document.getElementById('hardwareModal')) {
            $('#hardwareModal').hide();
        }
    });
</script>
</body>
</html>
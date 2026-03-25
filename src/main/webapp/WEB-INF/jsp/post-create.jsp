<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>创建帖子</title>
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

        /* 标题美化 - 居中、渐变 */
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
        }

        .error-message p {
            margin: 0;
        }

        /* 表单卡片美化 */
        form {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 25px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        /* 表单字段美化 */
        label {
            display: block;
            font-weight: 600;
            color: #2c3e50;
            font-size: 17px;
            margin-bottom: 10px;
            padding-left: 8px;
        }

        /* 输入框美化 - 大圆角 */
        input[type="text"],
        textarea {
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
            margin-bottom: 15px;
        }

        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        input[type="text"]::placeholder,
        textarea::placeholder {
            color: #9e9e9e;
            font-style: italic;
        }

        /* 文本域美化 */
        textarea {
            min-height: 250px;
            max-height: 500px;
            resize: vertical;
            line-height: 1.6;
        }

        /* 按钮美化 - 现代风格 */
        input[type="submit"],
        button {
            padding: 14px 32px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            font-size: 17px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
            position: relative;
            overflow: hidden;
            gap: 8px;
            margin: 5px;
        }

        input[type="submit"]::before,
        button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            transition: left 0.6s;
        }

        input[type="submit"]:hover::before,
        button:hover::before {
            left: 100%;
        }

        input[type="submit"]:hover,
        button:hover {
            transform: translateY(-4px) scale(1.02);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.18);
        }

        input[type="submit"]:active,
        button:active {
            transform: translateY(2px) scale(0.98);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.12);
        }

        /* 提交按钮 - 紫色渐变 */
        input[type="submit"] {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 16px 45px;
            font-size: 18px;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }

        input[type="submit"]:hover {
            background: linear-gradient(135deg, #5568d3 0%, #653a8f 100%);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }

        /* 上传按钮 - 蓝色渐变 */
        #uploadBtn {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }

        #uploadBtn:hover {
            background: linear-gradient(135deg, #0069d9 0%, #004494 100%);
        }

        /* 硬件引用按钮 - 绿色渐变 */
        #insertReferenceBtn {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
        }

        #insertReferenceBtn:hover {
            background: linear-gradient(135deg, #218838 0%, #1e7e34 100%);
        }

        /* 隐藏的文件输入框 */
        #imageFileInput {
            display: none;
        }

        /* 底部链接美化 */
        a[href="javascript:history.back()"],
        a[href="${pageContext.request.contextPath}/"] {
            display: inline-block;
            padding: 10px 25px;
            background: rgba(255, 255, 255, 0.2);
            color: #667eea !important;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 15px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255, 255, 255, 0.3);
            margin: 5px;
        }

        a[href="javascript:history.back()"]:hover,
        a[href="${pageContext.request.contextPath}/"]:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
            background: rgba(255, 255, 255, 0.3);
            color: #764ba2 !important;
            border-color: rgba(255, 255, 255, 0.5);
        }

        /* 硬件搜索模态框美化 */
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

        /* 认证提示美化 */
        p[style*="color: green"] {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white !important;
            padding: 15px 20px;
            border-radius: 15px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.25);
            border-left: 5px solid #1e7e34;
            font-size: 16px;
            font-weight: 500;
        }

        /* 表单验证错误提示 */
        .error {
            color: #dc3545;
            font-size: 14px;
            margin-top: 10px;
            display: block;
            font-weight: 500;
            padding-left: 8px;
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            h1 {
                font-size: 28px;
                margin-bottom: 25px;
            }

            form {
                padding: 30px 20px;
            }

            input[type="submit"],
            button {
                width: 100%;
                max-width: 350px;
                margin-bottom: 10px;
            }

            .hardware-search-modal-content {
                margin: 15% auto;
                padding: 30px 20px;
                width: 95%;
            }

            a[href="javascript:history.back()"],
            a[href="${pageContext.request.contextPath}/"] {
                width: 100%;
                max-width: 300px;
                text-align: center;
                display: block;
                margin: 10px auto;
            }
        }

        .hint-info {
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            color: #1976d2;
            padding: 15px 20px;
            border-radius: 15px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(25, 118, 210, 0.15);
            border-left: 5px solid #2196f3;
            font-size: 16px;
            font-weight: 500;
            position: relative;
            overflow: hidden;
            text-align: center;
        }

        .hint-info::before {
            content: '💡';
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 24px;
        }

        .hint-info strong {
            color: #0d47a1;
            font-weight: 700;
        }

        .hint-info a {
            color: #0d47a1;
            text-decoration: underline;
            font-weight: 600;
        }

        .hint-info a:hover {
            color: #1565c0;
        }

        .login-required {
            background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
            color: #c62828;
            padding: 15px 20px;
            border-radius: 15px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(198, 40, 40, 0.15);
            border-left: 5px solid #f44336;
            font-size: 16px;
            font-weight: 500;
            text-align: center;
            position: relative;
            overflow: hidden;
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

        .login-required::before {
            content: '⚠️';
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 24px;
        }

        .login-required a {
            color: #b71c1c;
            text-decoration: underline;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .login-required a:hover {
            color: #c62828;
            text-decoration: none;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <h1>创建帖子</h1>
    <c:if test="${not empty errorMessage}">
    <p style="color: red;">${errorMessage}</p>
</c:if>
    <c:if test="${sessionScope.currentUser == null}">
    <p style="color: red;" class="login-required">请先 <a href="${pageContext.request.contextPath}/user/login">登录</a> 后再发帖。</p>
</c:if>
    <c:if test="${sessionScope.currentUser != null}">
    <c:if test="${sessionScope.currentUser.role == 'CERTIFIED' || sessionScope.currentUser.role == 'ADMIN'}">
        <p class="hint-info">提示：您可以使用 <strong>插入硬件引用</strong> 功能来引用硬件参数。</p>
    </c:if>
    <form:form action="${pageContext.request.contextPath}/post/create" method="post" modelAttribute="post">
        <input type="hidden" name="sectionId" value="${sectionId}"/>
        <label for="title">标题:</label><br>
        <form:input path="title" id="title" type="text" size="50" required="required"/><br>
        <form:errors path="title" cssClass="error" /><br>
        <label for="content">内容:</label><br>
        <!-- 添加上传按钮和隐藏的file input -->
        <div>
            <button type="button" id="uploadBtn">上传图片</button>
            <input type="file" id="imageFileInput" accept="image/*" style="display:none;">
            <!-- 新增：插入硬件引用按钮 (仅认证用户) -->
            <c:if test="${sessionScope.currentUser.role == 'CERTIFIED' || sessionScope.currentUser.role == 'ADMIN'}">
                <button type="button" id="insertReferenceBtn">插入硬件引用</button>
            </c:if>
        </div>
        <form:textarea path="content" id="content" rows="10" cols="50" required="required"/><br>
        <form:errors path="content" cssClass="error" /><br>
        <input type="submit" value="发布帖子">
    </form:form>
</c:if>

    <!-- 硬件选择模态框 -->
    <div id="hardwareModal" class="hardware-search-modal">
    <div class="hardware-search-modal-content">
        <span class="hardware-search-modal-close">&times;</span>
        <h3>选择硬件</h3>
        <select id="hardwareSearchTypeSelect">
            <option value="cpu_info">CPU</option>
            <option value="gpu_info">GPU</option>
            <option value="motherboard_info">主板</option>
            <!-- 移除 storage 和 memory 选项 -->
        </select>
        <input type="text" id="hardwareSearchInput" placeholder="搜索硬件型号..." style="width: 100%; padding: 5px; margin-bottom: 10px;">
        <div id="hardwareSearchList"></div>
    </div>
</div>

    <a href="javascript:history.back()">返回上一页</a> |
    <a href="${pageContext.request.contextPath}/">返回首页</a>

    <script>
    $(document).ready(function() {
        console.log("Create Document ready fired"); // 调试日志

        // 点击上传按钮，触发隐藏的文件选择框
        $('#uploadBtn').click(function() {
            console.log("Upload button clicked"); // 调试日志
            $('#imageFileInput').click();
        });

        // 监听文件选择事件
        $('#imageFileInput').change(function() {
            console.log("File selected"); // 调试日志
            var file = this.files[0];
            if (file) {
                // 检查文件类型
                if (!file.type.startsWith('image/')) {
                    alert('请选择图片文件！');
                    return;
                }
                // 检查文件大小 (例如 5MB)
                var maxSize = 5 * 1024 * 1024; // 5MB in bytes
                if (file.size > maxSize) {
                    alert('文件大小不能超过 5MB！');
                    return;
                }
            // 创建 FormData 对象
                var formData = new FormData();
                formData.append('file', file);
                // 发起异步上传请求
                $.ajax({
                    url: '${pageContext.request.contextPath}/upload/image',
                    type: 'POST',
                    data: formData, // 修正：使用 formData 对象，与 post-detail.jsp 保持一致
                    processData: false, // 不处理数据
                    contentType: false, // 不设置内容类型
                    success: function(response) {
                        console.log("Upload success:", response); // 调试日志
                        if (response.success) {
                            // 上传成功，获取图片URL
                            var imageUrl = response.url;
                            // 将图片URL插入到文本域的光标位置
                            insertTextAtCursor($('#content'), '![](' + imageUrl + ')');
                            // 清空文件选择框
                            $('#imageFileInput').val('');
                        } else {
                            alert('上传失败: ' + response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Upload error:", status, error); // 调试日志
                        console.error("XHR Status:", xhr.status); // 添加状态码日志
                        console.error("Response Text:", xhr.responseText); // 添加响应内容日志
                        alert('上传请求失败，请检查网络或服务器状态。');
                    }
                });
            }
        });

        // 插入文本到文本域光标位置的函数
        function insertTextAtCursor(textarea, text) {
            var start = textarea[0].selectionStart;
            var end = textarea[0].selectionEnd;
            var content = textarea.val();
            var newContent = content.substring(0, start) + text + content.substring(end);
            textarea.val(newContent);
            // 将光标移动到插入文本的末尾
            textarea[0].selectionStart = textarea[0].selectionEnd = start + text.length;
            // 聚焦到文本域，确保光标可见
            textarea.focus();
        }

        // ---硬件引用功能 ---
        // 模态框元素
        var modal = $('#hardwareModal');
        var span = $('.hardware-search-modal-close');
        var searchInput = $('#hardwareSearchInput');
        var searchTypeSelect = $('#hardwareSearchTypeSelect'); // 新增：类型选择下拉框
        var listDiv = $('#hardwareSearchList');

        // 点击插入硬件引用按钮
        $('#insertReferenceBtn').click(function() {
            console.log("Insert Reference button clicked");
            modal.show(); // 显示模态框
            searchInput.val(''); // 清空搜索框
            searchTypeSelect.val('cpu_info'); // 重置下拉框
            listDiv.empty(); // 清空列表
        });

        // 点击关闭按钮
        span.click(function() {
            modal.hide(); // 隐藏模态框
        });

        // 点击模态框外部区域
        $(window).click(function(event) {
            if (event.target === modal[0]) {
                modal.hide();
            }
        });

        // 搜索功能
        searchInput.on('input', function() {
            var keyword = $(this).val().trim();
            var selectedTable = searchTypeSelect.val(); // 获取选择的表名
            console.log("Search input changed. Keyword:", keyword, "Selected Table:", selectedTable); // 调试日志

            if (keyword.length > 0 && selectedTable) { // 确保有关键词和表名
                // --- 调用真实的后端 API ---
                $.ajax({
                    url: '${pageContext.request.contextPath}/hardware/search', // 使用真实的 API 地址
                    type: 'GET',
                    data: { term: keyword, table: selectedTable }, // 发送关键词和表名
                    success: function(data) {
                        console.log("API call success. Received ", data, "for table:", selectedTable, "and keyword:", keyword); // 调试日志
                        displayHardwareList(data, selectedTable); // 传递真实数据和表名
                    },
                    error: function(xhr, status, error) {
                        console.error("API call failed for table:", selectedTable, "keyword:", keyword, "Status:", status, "Error:", error); // 调试日志
                        listDiv.empty();
                        listDiv.append('<p>搜索硬件失败: ' + status + ' ' + error + '</p>');
                    }
                });
            } else {
                listDiv.empty(); // 清空列表
            }
        });

        // 显示硬件列表
        function displayHardwareList(data, table) { // 修正：接收 table 参数
            console.log("Displaying hardware list for table:", table, "with ", data); // 调试日志
            listDiv.empty(); // 清空现有内容
            if (data.length === 0) {
                listDiv.append('<p>未找到匹配的硬件</p>');
                return;
            }
            data.forEach(function(item) {
                // 使用传入的 table 参数，而不是硬编码 "cpu_info"
                var itemDiv = $('<div class="hardware-search-item" data-id="' + item.id + '" data-table="' + table + '">' + item.brand + ' ' + item.model + '</div>');
                itemDiv.click(function() {
                    var id = $(this).data('id');
                    var table = $(this).data('table');
                    console.log("Hardware item clicked. ID:", id, "Table:", table); // 调试日志
                    var referenceText = '[' + table + ':' + id + ']';
                    insertTextAtCursor($('#content'), referenceText);
                    modal.hide(); // 选择后隐藏模态框
                });
                listDiv.append(itemDiv);
            });
        }
    });
</script>
</body>
</html>
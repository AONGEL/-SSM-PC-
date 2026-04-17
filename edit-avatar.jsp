<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改头像</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
    <style>
        /* 整体布局 - 白色渐变背景 */
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

        /* 当前头像信息美化 */
        .current-avatar-info {
            text-align: center;
            padding: 20px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 15px;
            margin-bottom: 30px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        .current-avatar-info p {
            color: #6c757d;
            font-size: 18px;
            margin: 10px 0;
        }

        .current-avatar-info img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            border: 3px solid #667eea;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
            object-fit: cover;
        }

        /* 头像容器美化 */
        .avatar-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
            gap: 20px;
            margin: 30px 0;
            padding: 25px;
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        /* 头像项美化 */
        .avatar-item {
            text-align: center;
            cursor: pointer;
            border: 3px solid transparent;
            padding: 8px;
            border-radius: 15px;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.3);
            position: relative;
            overflow: hidden;
        }

        .avatar-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, transparent 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .avatar-item:hover::before {
            opacity: 1;
        }

        .avatar-item:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            border-color: rgba(102, 126, 234, 0.3);
        }

        .avatar-item.selected {
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.15);
            transform: scale(1.08);
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.2);
        }

        .avatar-item.selected::before {
            opacity: 1;
        }

        /* 头像图片美化 */
        .avatar-img {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #e0e0e0;
            transition: all 0.3s ease;
            display: block;
            margin: 0 auto 10px;
        }

        .avatar-item:hover .avatar-img {
            border-color: #667eea;
            transform: scale(1.1);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .avatar-item.selected .avatar-img {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.4);
        }

        /* 头像标签美化 */
        .avatar-label {
            display: block;
            margin-top: 8px;
            font-size: 14px;
            color: #495057;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .avatar-item:hover .avatar-label,
        .avatar-item.selected .avatar-label {
            color: #667eea;
        }

        /* 消息提示美化 */
        #messageContainer {
            padding: 15px 20px;
            border-radius: 15px;
            margin-bottom: 20px;
            font-weight: 500;
            display: none;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        #messageContainer.success {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
            border-left: 5px solid #28a745;
        }

        #messageContainer.error {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
            border-left: 5px solid #dc3545;
        }

        /* 按钮组美化 */
        .actions {
            display: flex;
            gap: 20px;
            margin-top: 30px;
            justify-content: center;
            flex-wrap: wrap;
        }

        /* 统一按钮样式 */
        .btn {
            padding: 14px 32px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
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
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .btn:active {
            transform: translateY(1px);
        }

        /* 保存按钮 - 蓝色渐变 */
        #saveAvatarBtn {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }

        #saveAvatarBtn:hover {
            background: linear-gradient(135deg, #0069d9 0%, #004494 100%);
        }

        /* 返回按钮 - 灰色渐变 */
        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            color: white;
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #5a6268 0%, #4e555b 100%);
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            h1 {
                font-size: 28px;
                margin-bottom: 20px;
            }

            h1::after {
                width: 100px;
                height: 3px;
            }

            .avatar-container {
                grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
                padding: 20px 15px;
            }

            .avatar-img {
                width: 60px;
                height: 60px;
            }

            .avatar-label {
                font-size: 13px;
            }

            .actions {
                flex-direction: column;
                align-items: stretch;
            }

            .btn {
                width: 100%;
                max-width: 300px;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>🖼️ 修改头像</h1>

    <div class="current-avatar-info">
        <p>👤 <strong>当前头像:</strong></p>
        <!-- 添加时间戳参数 ?v=${systemCurrentTime} 或随机数，这里使用 JSP 变量 -->
        <img src="${pageContext.request.contextPath}${sessionScope.currentUser.avatar}?t=${System.currentTimeMillis()}"
             alt="当前头像"
             onerror="this.src='${pageContext.request.contextPath}/static/avatar/1.png'">
    </div>

    <div id="messageContainer"></div>

    <div class="avatar-container">
        <c:forEach begin="1" end="10" var="i">
            <c:set var="avatarPath" value="/static/avatar/${i}.png" />
            <div class="avatar-item ${sessionScope.currentUser.avatar == avatarPath ? 'selected' : ''}"
                 data-avatar="${avatarPath}"
                 onclick="selectAvatar(this, '${avatarPath}')">
                <img src="${pageContext.request.contextPath}${avatarPath}"
                     alt="头像 ${i}"
                     class="avatar-img"
                     onerror="this.src='${pageContext.request.contextPath}/static/avatar/1.png'">
                <span class="avatar-label">头像 ${i}</span>
            </div>
        </c:forEach>
    </div>

    <div class="actions">
        <button id="saveAvatarBtn" class="btn">💾 保存头像</button>
        <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">🏠 返回个人中心</a>
    </div>
</div>

<script>
    // 存储选中的头像路径
    let selectedAvatar = "${sessionScope.currentUser.avatar}";

    // 选择头像函数
    function selectAvatar(element, avatarPath) {
        // 移除所有选中状态
        document.querySelectorAll('.avatar-item').forEach(item => {
            item.classList.remove('selected');
        });

        // 添加当前选中状态
        element.classList.add('selected');

        // 更新选中头像路径
        selectedAvatar = avatarPath;
        console.log("Selected avatar:", selectedAvatar);
    }

    // 保存头像按钮点击事件
    document.getElementById('saveAvatarBtn').addEventListener('click', function() {
        console.log("Save avatar button clicked. Selected avatar:", selectedAvatar);

        // 显示加载状态
        this.disabled = true;
        this.textContent = "⏳ 保存中...";

        // 使用AJAX提交
        fetch('${pageContext.request.contextPath}/user/update-avatar', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: new URLSearchParams({
                'avatarPath': selectedAvatar
            })
        })
            .then(response => response.json())
            .then(data => {
                console.log("Response data:", data);
                if (data.success) {
                    showMessage("✅ 头像更新成功！", "success");
                    // 更新页面上的当前头像时，也添加时间戳防止缓存
                    const newAvatarSrc = '${pageContext.request.contextPath}' + data.avatarPath + '?t=' + new Date().getTime();
                    document.querySelector('.current-avatar-info img').src =
                        '${pageContext.request.contextPath}' + data.avatarPath + '?t=' + new Date().getTime();
                    // 2秒后自动跳转到个人中心
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/user/profile';
                    }, 2000);
                } else {
                    showMessage("❌ 头像更新失败: " + (data.message || "未知错误"), "error");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                showMessage("❌ 请求失败: " + error.message, "error");
            })
            .finally(() => {
                // 恢复按钮状态
                this.disabled = false;
                this.textContent = "💾 保存头像";
            });
    });

    // 显示消息函数
    function showMessage(message, type) {
        const container = document.getElementById('messageContainer');
        container.className = `message ${type}`;
        container.textContent = message;
        container.style.display = 'block';

        // 5秒后自动隐藏
        if (type === 'success') {
            setTimeout(() => {
                container.style.display = 'none';
            }, 5000);
        }
    }

    // 页面加载时设置初始选中状态
    window.addEventListener('DOMContentLoaded', function() {
        const currentAvatar = "${sessionScope.currentUser.avatar}";
        console.log("Current avatar on page load:", currentAvatar);

        // 确保默认选中当前头像
        const currentItem = document.querySelector(`.avatar-item[data-avatar="${currentAvatar}"]`);
        if (currentItem) {
            currentItem.classList.add('selected');
            selectedAvatar = currentAvatar;
        } else {
            console.log("Current avatar not found in items. Using default.");
            // 如果找不到当前头像，使用第一个
            const firstItem = document.querySelector('.avatar-item');
            if (firstItem) {
                firstItem.classList.add('selected');
                selectedAvatar = firstItem.getAttribute('data-avatar');
            }
        }
    });
</script>
</body>
</html>
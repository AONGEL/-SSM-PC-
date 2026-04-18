<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改头像</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei', sans-serif; background: #f6f6f6; color: #121212; line-height: 1.6; min-height: 100vh; }

        .header { background: #fff; box-shadow: 0 1px 3px rgba(0,0,0,0.1); position: sticky; top: 0; z-index: 1000; padding: 0 20px; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; height: 56px; }
        .logo { font-size: 22px; font-weight: 700; color: #0066ff; text-decoration: none; display: flex; align-items: center; gap: 8px; }
        .logo:hover { color: #0055dd; }
        .nav-links { display: flex; align-items: center; gap: 20px; }
        .nav-links a { color: #121212; text-decoration: none; font-size: 15px; padding: 8px 16px; border-radius: 20px; transition: all 0.3s ease; }
        .nav-links a:hover { background: #f0f0f0; color: #0066ff; }

        .nav-tabs { background: #fff; border-bottom: 1px solid #e6e6e6; }
        .tabs-container { max-width: 1200px; margin: 0 auto; display: flex; padding: 0 20px; }
        .tab-item { padding: 15px 20px; cursor: pointer; border-bottom: 2px solid transparent; color: #646464; transition: all 0.3s; font-size: 15px; }
        .tab-item:hover { color: #0066ff; }
        .tab-item.active { border-bottom: 2px solid #0066ff; color: #0066ff; }

        .main-container { max-width: 800px; margin: 20px auto; padding: 0 20px; }
        .card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); overflow: hidden; margin-bottom: 20px; }
        .card-header { padding: 20px; border-bottom: 1px solid #f0f0f0; }
        .card-title { font-size: 18px; font-weight: 600; color: #121212; }
        .card-body { padding: 20px; }

        .current-avatar-info { text-align: center; padding: 20px; background: #fafafa; border-radius: 8px; margin-bottom: 20px; }
        .current-avatar-info p { color: #646464; font-size: 14px; margin-bottom: 12px; }
        .current-avatar-info img { width: 100px; height: 100px; border-radius: 50%; object-fit: cover; border: 3px solid #e6e6e6; }

        .avatar-container { display: grid; grid-template-columns: repeat(auto-fill, minmax(100px, 1fr)); gap: 16px; padding: 20px 0; }
        .avatar-item { text-align: center; cursor: pointer; border: 3px solid transparent; padding: 8px; border-radius: 8px; transition: all 0.3s ease; background: #fafafa; }
        .avatar-item:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); border-color: #e0e0e0; }
        .avatar-item.selected { border-color: #0066ff; background: #e6f0ff; }
        .avatar-img { width: 70px; height: 70px; border-radius: 50%; object-fit: cover; border: 2px solid #e0e0e0; transition: all 0.3s ease; display: block; margin: 0 auto 8px; }
        .avatar-item:hover .avatar-img { border-color: #0066ff; }
        .avatar-item.selected .avatar-img { border-color: #0066ff; box-shadow: 0 0 0 3px rgba(0,102,255,0.2); }
        .avatar-label { display: block; font-size: 13px; color: #646464; font-weight: 500; }
        .avatar-item.selected .avatar-label { color: #0066ff; }

        #messageContainer { padding: 15px 20px; border-radius: 8px; margin-bottom: 20px; font-weight: 500; display: none; }
        #messageContainer.success { background: #d4edda; color: #155724; border-left: 4px solid #28a745; }
        #messageContainer.error { background: #f8d7da; color: #721c24; border-left: 4px solid #dc3545; }

        .actions { display: flex; gap: 12px; justify-content: center; margin-top: 20px; }
        .btn { padding: 12px 28px; border: none; border-radius: 8px; cursor: pointer; font-size: 15px; font-weight: 500; transition: all 0.3s ease; text-decoration: none; display: inline-flex; align-items: center; justify-content: center; gap: 8px; }
        .btn-primary { background: #0066ff; color: #fff; }
        .btn-primary:hover { background: #0055dd; }
        .btn-secondary { background: #fafafa; color: #121212; border: 1px solid #e0e0e0; }
        .btn-secondary:hover { background: #f0f0f0; }

        @media (max-width: 600px) {
            .header-content { flex-wrap: wrap; height: auto; padding: 10px 0; gap: 10px; }
            .nav-links { width: 100%; justify-content: center; }
            .avatar-container { grid-template-columns: repeat(auto-fill, minmax(80px, 1fr)); }
            .avatar-img { width: 60px; height: 60px; }
            .actions { flex-direction: column; }
            .btn { width: 100%; }
        }
    </style>
</head>
<body>
<header class="header">
    <div class="header-content">
        <a href="${pageContext.request.contextPath}/" class="logo">💻 PC 硬件交流论坛</a>
        <nav class="nav-links">
            <c:choose>
                <c:when test="${sessionScope.currentUser != null}">
                    <span style="color: #646464; font-size: 14px;">欢迎, ${sessionScope.currentUser.username}</span>
                    <a href="${pageContext.request.contextPath}/user/profile">👤 个人中心</a>
                    <a href="${pageContext.request.contextPath}/user/logout">🚪 退出</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/login">🔑 登录</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </div>
</header>

<div class="main-container">
    <div class="card">
        <div class="card-header">
            <h1 class="card-title">🖼️ 修改头像</h1>
        </div>
        <div class="card-body">
            <div class="current-avatar-info">
                <p>👤 <strong>当前头像:</strong></p>
                <img src="${pageContext.request.contextPath}${sessionScope.currentUser.avatar}?t=${System.currentTimeMillis()}" alt="当前头像" onerror="this.src='${pageContext.request.contextPath}/static/avatar/1.png'">
            </div>

            <div id="messageContainer"></div>

            <div class="avatar-container">
                <c:forEach begin="1" end="10" var="i">
                    <c:set var="avatarPath" value="/static/avatar/${i}.png" />
                    <div class="avatar-item ${sessionScope.currentUser.avatar == avatarPath ? 'selected' : ''}" data-avatar="${avatarPath}" onclick="selectAvatar(this, '${avatarPath}')">
                        <img src="${pageContext.request.contextPath}${avatarPath}" alt="头像 ${i}" class="avatar-img" onerror="this.src='${pageContext.request.contextPath}/static/avatar/1.png'">
                        <span class="avatar-label">头像 ${i}</span>
                    </div>
                </c:forEach>
            </div>

            <div class="actions">
                <button id="saveAvatarBtn" class="btn btn-primary">💾 保存头像</button>
                <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">🏠 返回个人中心</a>
            </div>
        </div>
    </div>
</div>

<script>
    let selectedAvatar = "${sessionScope.currentUser.avatar}";

    function selectAvatar(element, avatarPath) {
        document.querySelectorAll('.avatar-item').forEach(item => {
            item.classList.remove('selected');
        });
        element.classList.add('selected');
        selectedAvatar = avatarPath;
        console.log("Selected avatar:", selectedAvatar);
    }

    document.getElementById('saveAvatarBtn').addEventListener('click', function() {
        console.log("Save avatar button clicked. Selected avatar:", selectedAvatar);
        this.disabled = true;
        this.textContent = "⏳ 保存中...";

        fetch('${pageContext.request.contextPath}/user/update-avatar', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: new URLSearchParams({ 'avatarPath': selectedAvatar })
        })
            .then(response => response.json())
            .then(data => {
                console.log("Response data:", data);
                if (data.success) {
                    showMessage("✅ 头像更新成功！", "success");
                    document.querySelector('.current-avatar-info img').src = '${pageContext.request.contextPath}' + data.avatarPath + '?t=' + new Date().getTime();
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/user/profile';
                    }, 2000);
                } else {
                    showMessage("❌ 头像更新失败：" + (data.message || "未知错误"), "error");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                showMessage("❌ 请求失败：" + error.message, "error");
            })
            .finally(() => {
                this.disabled = false;
                this.textContent = "💾 保存头像";
            });
    });

    function showMessage(message, type) {
        const container = document.getElementById('messageContainer');
        container.className = `message ${type}`;
        container.textContent = message;
        container.style.display = 'block';
        if (type === 'success') {
            setTimeout(() => { container.style.display = 'none'; }, 5000);
        }
    }

    window.addEventListener('DOMContentLoaded', function() {
        const currentAvatar = "${sessionScope.currentUser.avatar}";
        const currentItem = document.querySelector(`.avatar-item[data-avatar="${currentAvatar}"]`);
        if (currentItem) {
            currentItem.classList.add('selected');
            selectedAvatar = currentAvatar;
        } else {
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
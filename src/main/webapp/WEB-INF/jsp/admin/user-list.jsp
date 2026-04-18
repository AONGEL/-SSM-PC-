<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%// 服务器端获取 contextPath
    String contextPath = request.getContextPath();
%>
<html>
<head>
    <title>管理员 - 认证用户管理</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei', sans-serif; background: #f6f6f6; color: #121212; line-height: 1.6; min-height: 100vh; }

        /* 顶部 Header 栏 */
        .header { background: #fff; box-shadow: 0 1px 3px rgba(0,0,0,0.1); position: sticky; top: 0; z-index: 1000; padding: 0 20px; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; height: 56px; }
        .logo { font-size: 22px; font-weight: 700; color: #0066ff; text-decoration: none; display: flex; align-items: center; gap: 8px; }
        .logo:hover { color: #0055dd; }
        .nav-links { display: flex; align-items: center; gap: 20px; }
        .nav-links a { color: #121212; text-decoration: none; font-size: 15px; padding: 8px 16px; border-radius: 20px; transition: all 0.3s ease; }
        .nav-links a:hover { background: #f0f0f0; color: #0066ff; }
        .nav-links .highlight { background: #0066ff; color: #fff; }
        .nav-links .highlight:hover { background: #0055dd; }

        /* 主容器 */
        .main-container { max-width: 1200px; margin: 20px auto; padding: 0 20px; }

        /* 页面标题卡片 */
        .page-header-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 20px 24px; margin-bottom: 20px; }
        .page-title { font-size: 24px; font-weight: 700; color: #121212; display: flex; align-items: center; gap: 10px; }

        /* 当前用户信息卡片 */
        .current-user-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 16px 20px; margin-bottom: 20px; text-align: center; }
        .current-user-text { color: #666; font-size: 15px; margin: 0; }
        .current-user-text strong { color: #0066ff; font-weight: 600; }

        /* 用户列表卡片 */
        .user-list-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); overflow: hidden; }
        .user-list-header { padding: 20px 24px; border-bottom: 1px solid #f0f0f0; }
        .user-list-title { font-size: 18px; font-weight: 600; color: #121212; margin: 0; }

        /* 用户项 */
        .user-item { display: flex; justify-content: space-between; align-items: center; padding: 16px 24px; border-bottom: 1px solid #f0f0f0; transition: all 0.3s ease; }
        .user-item:last-child { border-bottom: none; }
        .user-item:hover { background: #fafafa; }

        .user-info { display: flex; align-items: center; gap: 16px; }
        .user-id { font-weight: 600; color: #121212; font-size: 14px; }
        .user-username { font-weight: 500; color: #121212; font-size: 16px; }

        .certified-badge { display: inline-block; background: #e6f7ed; color: #28a745; padding: 4px 12px; border-radius: 12px; font-size: 13px; font-weight: 500; }

        /* 按钮样式 */
        .btn { padding: 8px 18px; border: none; border-radius: 20px; cursor: pointer; font-size: 14px; font-weight: 500; transition: all 0.3s ease; display: inline-flex; align-items: center; justify-content: center; text-decoration: none; gap: 6px; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .btn-revoke { background: #dc3545; color: white; }
        .btn-revoke:hover { background: #c82333; }

        /* 返回按钮 */
        .btn-back { display: inline-block; padding: 10px 24px; background: #fafafa; color: #121212; text-decoration: none; border-radius: 20px; font-weight: 500; font-size: 14px; transition: all 0.3s ease; border: 1px solid #e0e0e0; margin: 20px auto; display: block; width: fit-content; }
        .btn-back:hover { background: #f0f0f0; }

        /* 空状态 */
        .empty-state { text-align: center; padding: 60px 30px; background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin: 20px 0; }
        .empty-icon { font-size: 64px; margin-bottom: 20px; opacity: 0.4; }
        .empty-state h3 { color: #121212; font-size: 20px; margin-bottom: 12px; font-weight: 600; }
        .empty-state p { color: #8a8a8a; font-size: 15px; margin: 8px 0; }

        /* 响应式 */
        @media (max-width: 768px) {
            .header-content { flex-wrap: wrap; height: auto; padding: 10px 0; gap: 10px; }
            .nav-links { width: 100%; justify-content: center; }
            .main-container { padding: 0 15px; }
            .page-header-card { padding: 16px 18px; }
            .page-title { font-size: 20px; }
            .user-item { flex-direction: column; align-items: flex-start; gap: 15px; }
            .user-info { flex-direction: column; align-items: flex-start; gap: 8px; }
            .btn { width: 100%; }
            .btn-back { width: 100%; text-align: center; }
        }
    </style>
</head>
<body>
<!-- 顶部 Header 栏 -->
<header class="header">
    <div class="header-content">
        <a href="${pageContext.request.contextPath}/" class="logo">💻 PC 硬件交流论坛</a>
        <nav class="nav-links">
            <a href="${pageContext.request.contextPath}/forum/section">📁 论坛分区</a>
            <a href="${pageContext.request.contextPath}/hardware-library">🔧 硬件参数库</a>
            <c:choose>
                <c:when test="${sessionScope.currentUser != null}">
                    <a href="${pageContext.request.contextPath}/user/notifications">🔔 消息</a>
                    <a href="${pageContext.request.contextPath}/user/profile" class="highlight">👤 个人中心</a>
                    <a href="${pageContext.request.contextPath}/user/logout">🚪 退出</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/login">🔑 登录</a>
                    <a href="${pageContext.request.contextPath}/user/register" class="highlight">📝 注册</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </div>
</header>

<div class="main-container">
    <div class="page-header-card">
        <h1 class="page-title">🎓 认证用户管理</h1>
    </div>

    <div class="current-user-card">
        <p class="current-user-text">👑 当前管理员：<strong>${sessionScope.currentUser.username}</strong> (${sessionScope.currentUser.role})</p>
    </div>

    <div class="user-list-card">
        <div class="user-list-header">
            <h2 class="user-list-title">📋 认证用户列表</h2>
        </div>

        <c:choose>
            <c:when test="${not empty users}">
                <div id="usersContainer">
                    <c:forEach items="${users}" var="user">
                        <c:if test="${user.role == 'CERTIFIED'}">
                            <div class="user-item">
                                <div class="user-info">
                                    <span class="user-id">ID: ${user.id}</span>
                                    <span class="user-username">👤 ${user.username}</span>
                                    <span class="certified-badge">🎓 认证用户</span>
                                </div>

                                <button class="btn btn-revoke"
                                        onclick="revokeCertification(parseInt(${user.id}), '${user.username}')">
                                    🚫 撤销认证
                                </button>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">📭</div>
                    <h3>暂无认证用户</h3>
                    <p>当前系统中还没有认证用户</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <a href="${pageContext.request.contextPath}/" class="btn-back">
        🏠 返回首页
    </a>
</div>

<script>
    function revokeCertification(userId, username) {
        console.log("revokeCertification called with userId:", userId, "type:", typeof userId, "and username:", username);
        if (userId == null || userId === '' || isNaN(userId)) {
            console.error("Invalid userId provided:", userId, "Type:", typeof userId);
            alert("无效的用户 ID，无法撤销认证。");
            return;
        }
        const reason = prompt(`确定要撤销用户 "${username}" 的认证吗？\n请输入原因（可选）:`);
        if (reason !== null) {
            const jspContextPath = "${pageContext.request.contextPath}";
            console.log("JSP Context Path inside function:", jspContextPath);
            const constructedUrl = jspContextPath + "/certification/admin/revoke/" + userId;
            console.log("Final constructed URL for fetch:", constructedUrl);
            fetch(constructedUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({ reason: reason })
            })
                .then(response => {
                    console.log("Fetch response received with status:", response.status);
                    return response.text();
                })
                .then(result => {
                    console.log("Raw response text:", result);
                    try {
                        const parsedResult = JSON.parse(result);
                        if (parsedResult.status === 'success') {
                            alert('✅ 认证撤销成功！');
                            location.reload();
                        } else {
                            alert('❌ 认证撤销失败！服务器返回：' + parsedResult.message);
                        }
                    } catch (e) {
                        console.error("Failed to parse response as JSON:", e);
                        console.error("Response text was:", result);
                        alert('操作失败，服务器返回非 JSON 格式响应。请检查网络或稍后重试。');
                    }
                })
                .catch(error => {
                    console.error('Error revoking certification:', error);
                    alert('操作失败，请检查网络或稍后重试。');
                });
        }
    }
</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>论坛分区 - PC 硬件交流论坛</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei', sans-serif; background: #f6f6f6; color: #121212; line-height: 1.6; min-height: 100vh; }

        /* 顶部导航栏 */
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

        /* 页面标题 */
        .page-title { font-size: 24px; font-weight: 600; color: #121212; margin-bottom: 20px; display: flex; align-items: center; gap: 8px; }

        /* 卡片样式 */
        .card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); overflow: hidden; margin-bottom: 20px; }
        .card-header { padding: 16px 20px; border-bottom: 1px solid #f0f0f0; display: flex; justify-content: space-between; align-items: center; }
        .card-title { font-size: 18px; font-weight: 600; color: #121212; display: flex; align-items: center; gap: 8px; }
        .card-body { padding: 20px; }

        /* 分区网格 */
        .sections-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 16px; }
        .section-item { display: block; padding: 20px; background: #fafafa; border-radius: 8px; text-decoration: none; color: #121212; transition: all 0.3s ease; border: 1px solid #f0f0f0; }
        .section-item:hover { background: #f0f0f0; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); border-color: #e0e0e0; }
        .section-icon { font-size: 32px; margin-bottom: 12px; display: block; }
        .section-name { font-size: 18px; font-weight: 600; margin-bottom: 8px; color: #0066ff; }
        .section-desc { font-size: 14px; color: #8a8a8a; line-height: 1.5; }

        /* 空状态 */
        .empty-state { text-align: center; padding: 60px 20px; color: #8a8a8a; }
        .empty-icon { font-size: 48px; margin-bottom: 12px; opacity: 0.5; }
        .empty-text { font-size: 15px; }

        /* 底部操作栏 */
        .page-footer { margin-top: 20px; display: flex; justify-content: center; gap: 12px; flex-wrap: wrap; }
        .btn { display: inline-flex; align-items: center; gap: 6px; padding: 10px 24px; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.2s; }
        .btn-primary { background: #0066ff; color: #fff; }
        .btn-primary:hover { background: #0052cc; }
        .btn-secondary { background: #f5f5f5; color: #121212; }
        .btn-secondary:hover { background: #e8e8e8; }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .header-content { flex-wrap: wrap; height: auto; padding: 10px 0; gap: 10px; }
            .nav-links { width: 100%; justify-content: center; }
            .sections-grid { grid-template-columns: 1fr; }
            .main-container { padding: 0 12px; }
        }
    </style>
</head>
<body>
<!-- 顶部导航栏 -->
<header class="header">
    <div class="header-content">
        <a href="${pageContext.request.contextPath}/" class="logo">💻 PC 硬件交流论坛</a>
        <nav class="nav-links">
            <a href="${pageContext.request.contextPath}/">🏠 首页</a>
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
    <h1 class="page-title">📁 论坛分区</h1>

    <div class="card">
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty sections}">
                    <div class="sections-grid">
                        <c:forEach items="${sections}" var="section">
                            <a href="${pageContext.request.contextPath}/forum/section/${section.id}/posts" class="section-item">
                                <span class="section-icon">📂</span>
                                <div class="section-name">${section.name}</div>
                                <div class="section-desc">${section.description}</div>
                            </a>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">📭</div>
                        <div class="empty-text">暂无分区信息</div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="page-footer">
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">🏠 返回首页</a>
        <a href="${pageContext.request.contextPath}/post/create" class="btn btn-secondary">✏️ 发布帖子</a>
    </div>
</div>
</body>
</html>
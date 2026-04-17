<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>PC 硬件交流论坛 - 首页</title>
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
        .nav-links .highlight { background: #0066ff; color: #fff; }
        .nav-links .highlight:hover { background: #0055dd; }
        .main-container { max-width: 1200px; margin: 20px auto; padding: 0 20px; display: grid; grid-template-columns: 1fr 320px; gap: 20px; }
        .left-column { display: flex; flex-direction: column; gap: 20px; }
        .right-column { display: flex; flex-direction: column; gap: 20px; }
        .card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); overflow: hidden; }
        .card-header { padding: 16px 20px; border-bottom: 1px solid #f0f0f0; display: flex; justify-content: space-between; align-items: center; }
        .card-title { font-size: 18px; font-weight: 600; color: #121212; display: flex; align-items: center; gap: 8px; }
        .card-body { padding: 16px 20px; }
        .sections-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 12px; }
        .section-item { display: block; padding: 16px; background: #fafafa; border-radius: 8px; text-decoration: none; color: #121212; transition: all 0.3s ease; border: 1px solid #f0f0f0; }
        .section-item:hover { background: #f0f0f0; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .section-name { font-size: 16px; font-weight: 600; margin-bottom: 4px; color: #0066ff; }
        .section-desc { font-size: 13px; color: #8a8a8a; line-height: 1.4; }
        .post-list { list-style: none; }
        .post-item { padding: 16px 0; border-bottom: 1px solid #f0f0f0; transition: all 0.3s ease; }
        .post-item:last-child { border-bottom: none; }
        .post-item:hover { background: #fafafa; margin: 0 -20px; padding-left: 20px; padding-right: 20px; }
        .post-title-link { display: block; font-size: 16px; font-weight: 500; color: #121212; text-decoration: none; margin-bottom: 8px; line-height: 1.5; word-break: break-word; }
        .post-title-link:hover { color: #0066ff; text-decoration: underline; }
        .post-meta { display: flex; flex-wrap: wrap; gap: 12px; font-size: 13px; color: #8a8a8a; }
        .post-meta-item { display: flex; align-items: center; gap: 4px; }
        .post-badge { display: inline-block; padding: 2px 8px; background: #e6f0ff; color: #0066ff; border-radius: 4px; font-size: 12px; font-weight: 500; margin-right: 8px; }
        .user-card { text-align: center; }
        .user-avatar { width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #0066ff 0%, #00ccff 100%); display: flex; align-items: center; justify-content: center; margin: 0 auto 12px; font-size: 36px; color: #fff; font-weight: 700; }
        .user-avatar-img { width: 80px; height: 80px; border-radius: 50%; object-fit: cover; margin: 0 auto 12px; border: 3px solid #f0f0f0; }
        .user-name { font-size: 18px; font-weight: 600; color: #121212; margin-bottom: 4px; }
        .user-role { display: inline-block; padding: 2px 12px; background: #e6f0ff; color: #0066ff; border-radius: 12px; font-size: 12px; font-weight: 500; margin-bottom: 16px; }
        .user-stats { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; margin-bottom: 16px; }
        .stat-item { text-align: center; padding: 12px 8px; background: #fafafa; border-radius: 8px; }
        .stat-value { font-size: 20px; font-weight: 700; color: #0066ff; display: block; }
        .stat-label { font-size: 12px; color: #8a8a8a; margin-top: 4px; }
        .user-actions { display: flex; flex-direction: column; gap: 8px; }
        .user-btn { display: block; width: 100%; padding: 12px; text-align: center; border-radius: 8px; text-decoration: none; font-size: 15px; font-weight: 500; transition: all 0.3s ease; }
        .user-btn-primary { background: #0066ff; color: #fff; }
        .user-btn-primary:hover { background: #0055dd; }
        .user-btn-secondary { background: #fafafa; color: #121212; border: 1px solid #e0e0e0; }
        .user-btn-secondary:hover { background: #f0f0f0; }
        .quick-links { display: grid; grid-template-columns: repeat(2, 1fr); gap: 12px; }
        .quick-link { display: flex; flex-direction: column; align-items: center; padding: 16px; background: #fafafa; border-radius: 8px; text-decoration: none; color: #121212; transition: all 0.3s ease; text-align: center; }
        .quick-link:hover { background: #f0f0f0; transform: translateY(-2px); }
        .quick-link-icon { font-size: 28px; margin-bottom: 8px; }
        .quick-link-text { font-size: 14px; font-weight: 500; }
        .empty-state { text-align: center; padding: 40px 20px; color: #8a8a8a; }
        .empty-icon { font-size: 48px; margin-bottom: 12px; opacity: 0.5; }
        .empty-text { font-size: 15px; }
        @media (max-width: 900px) { .main-container { grid-template-columns: 1fr; } .right-column { order: -1; } .sections-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 600px) { .header-content { flex-wrap: wrap; height: auto; padding: 10px 0; gap: 10px; } .nav-links { width: 100%; justify-content: center; } .sections-grid { grid-template-columns: 1fr; } }
    </style>
</head>
<body>
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
    <div class="left-column">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">📁 论坛分区</h2>
                <a href="${pageContext.request.contextPath}/forum/section" style="font-size: 14px; color: #0066ff; text-decoration: none;">查看全部 →</a>
            </div>
            <div class="card-body">
                <div class="sections-grid">
                    <c:choose>
                        <c:when test="${not empty sections}">
                            <c:forEach items="${sections}" var="section" begin="0" end="5">
                                <a href="${pageContext.request.contextPath}/forum/section/${section.id}/posts" class="section-item">
                                    <div class="section-name">${section.name}</div>
                                    <div class="section-desc">${section.description}</div>
                                </a>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state"><div class="empty-icon">📭</div><div class="empty-text">暂无论坛分区</div></div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header"><h2 class="card-title">🔥 热门帖子</h2></div>
            <div class="card-body">
                <ul class="post-list">
                    <c:choose>
                        <c:when test="${not empty latestPosts}">
                            <c:forEach items="${latestPosts}" var="post">
                                <li class="post-item">
                                    <a href="${pageContext.request.contextPath}/post/${post.id}" class="post-title-link">
                                        <c:if test="${post.pinLevel > 0}"><span class="post-badge">📌 置顶</span></c:if>
                                            ${post.title}
                                    </a>
                                    <div class="post-meta">
                                        <span class="post-meta-item">👤 ${post.authorUsername}</span>
                                        <span class="post-meta-item">📁 ${post.sectionName}</span>
                                        <span class="post-meta-item">💬 ${post.replyCount} 回复</span>
                                        <span class="post-meta-item">👁️ ${post.viewCount} 浏览</span>
                                        <span class="post-meta-item">📅 <fmt:formatDate value="${post.createTime}" pattern="MM-dd HH:mm"/></span>
                                    </div>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state"><div class="empty-icon">📭</div><div class="empty-text">暂无帖子</div></div>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </div>

    <div class="right-column">
        <c:choose>
            <c:when test="${currentUser != null}">
                <div class="card user-card">
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty currentUser.avatar && currentUser.avatar != ''}">
                                <img src="${currentUser.avatar}" alt="头像" class="user-avatar-img" />
                            </c:when>
                            <c:otherwise>
                                <div class="user-avatar">${fn:substring(currentUser.username, 0, 1)}</div>
                            </c:otherwise>
                        </c:choose>
                        <div class="user-name">${currentUser.username}</div>
                        <c:choose>
                            <c:when test="${currentUser.role == 'ADMIN'}"><span class="user-role">👑 管理员</span></c:when>
                            <c:when test="${currentUser.role == 'CERTIFIED'}"><span class="user-role">✅ 认证用户</span></c:when>
                            <c:otherwise><span class="user-role">👤 普通用户</span></c:otherwise>
                        </c:choose>
                        <div class="user-stats">
                            <div class="stat-item"><span class="stat-value">${postCount != null ? postCount : 0}</span><div class="stat-label">发帖数</div></div>
                            <div class="stat-item"><span class="stat-value">${replyCount != null ? replyCount : 0}</span><div class="stat-label">回复数</div></div>
                            <div class="stat-item"><span class="stat-value">${favoriteCount != null ? favoriteCount : 0}</span><div class="stat-label">收藏数</div></div>
                        </div>
                        <div class="user-actions">
                            <a href="${pageContext.request.contextPath}/user/profile" class="user-btn user-btn-primary">👤 个人中心</a>
                            <a href="${pageContext.request.contextPath}/user/notifications" class="user-btn user-btn-secondary">🔔 我的消息</a>
                            <a href="${pageContext.request.contextPath}/user/favorites" class="user-btn user-btn-secondary">⭐ 我的收藏</a>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card">
                    <div class="card-body" style="text-align: center; padding: 30px 20px;">
                        <div style="font-size: 48px; margin-bottom: 12px;">👋</div>
                        <h3 style="font-size: 18px; margin-bottom: 8px; color: #121212;">欢迎游客</h3>
                        <p style="color: #8a8a8a; font-size: 14px; margin-bottom: 20px;">登录后享受更多功能</p>
                        <div style="display: flex; flex-direction: column; gap: 10px;">
                            <a href="${pageContext.request.contextPath}/user/login" class="user-btn user-btn-primary">🔑 立即登录</a>
                            <a href="${pageContext.request.contextPath}/user/register" class="user-btn user-btn-secondary">📝 免费注册</a>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
        <div class="card">
            <div class="card-header"><h2 class="card-title">⚡ 快捷入口</h2></div>
            <div class="card-body">
                <div class="quick-links">
                    <a href="${pageContext.request.contextPath}/hardware-library" class="quick-link">
                        <span class="quick-link-icon">🔧</span><span class="quick-link-text">硬件参数库</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/post/create?sectionId=1" class="quick-link">
                        <span class="quick-link-icon">✏️</span><span class="quick-link-text">发布帖子</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/forum/section" class="quick-link">
                        <span class="quick-link-icon">📁</span><span class="quick-link-text">所有分区</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
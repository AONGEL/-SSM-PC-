<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>${section.name} - 帖子列表</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei', sans-serif; background: #f6f6f6; color: #121212; line-height: 1.6; min-height: 100vh; }

        /* 顶部导航栏 - 与首页统一 */
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
        .main-container { max-width: 1200px; margin: 20px auto; padding: 0 20px; display: grid; grid-template-columns: 1fr 320px; gap: 20px; }
        .content-left { display: flex; flex-direction: column; gap: 20px; }
        .sidebar-right { display: flex; flex-direction: column; gap: 20px; }

        /* 卡片样式 */
        .card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); overflow: hidden; }
        .card-header { padding: 16px 20px; border-bottom: 1px solid #f0f0f0; display: flex; justify-content: space-between; align-items: center; }
        .card-title { font-size: 18px; font-weight: 600; color: #121212; display: flex; align-items: center; gap: 8px; }
        .card-body { padding: 16px 20px; }

        /* 版块头部 */
        .section-header { background: #fff; border-radius: 8px; padding: 20px; margin-bottom: 16px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .section-title { font-size: 24px; font-weight: 600; color: #121212; margin-bottom: 8px; }
        .section-description { color: #646464; font-size: 15px; }

        /* 帖子卡片 */
        .post-card { background: #fff; border-radius: 8px; padding: 20px 24px; margin-bottom: 12px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); transition: all 0.2s ease; border: 1px solid transparent; }
        .post-card:hover { box-shadow: 0 2px 8px rgba(0,0,0,0.15); border-color: #ebebeb; }
        .post-card-header { display: flex; align-items: flex-start; gap: 12px; margin-bottom: 12px; }
        .post-title-link { flex: 1; text-decoration: none; color: #121212; font-size: 18px; font-weight: 500; line-height: 1.5; word-break: break-word; }
        .post-title-link:hover { color: #0066ff; }
        .post-tags { display: flex; gap: 8px; flex-shrink: 0; }
        .tag-pinned { background: #e8f3ff; color: #0066ff; padding: 2px 8px; border-radius: 4px; font-size: 12px; font-weight: 500; }
        .tag-locked { background: #fff3e8; color: #ff6b00; padding: 2px 8px; border-radius: 4px; font-size: 12px; font-weight: 500; }
        .post-meta { display: flex; align-items: center; gap: 16px; color: #969696; font-size: 13px; margin-bottom: 12px; }
        .meta-item { display: flex; align-items: center; gap: 4px; }
        .author-name { color: #646464; font-weight: 500; }
        .user-badge { display: inline-block; padding: 1px 6px; border-radius: 3px; font-size: 11px; font-weight: 500; margin-left: 6px; }
        .badge-certified { background: #e6f7ed; color: #00a854; }
        .badge-admin { background: #ffe8e8; color: #ff4d4f; }
        .badge-regular { background: #f5f5f5; color: #666; }
        .post-stats { display: flex; gap: 20px; padding-top: 12px; border-top: 1px solid #f0f0f0; }
        .stat-item { display: flex; align-items: center; gap: 4px; color: #969696; font-size: 13px; }
        .stat-item strong { color: #646464; font-weight: 600; }
        .stat-replies { color: #0066ff; }

        /* 操作按钮 */
        .post-actions { display: flex; gap: 12px; margin-top: 16px; flex-wrap: wrap; }
        .post-actions form { display: inline; }
        .btn-action { padding: 6px 16px; border: none; border-radius: 4px; font-size: 13px; font-weight: 500; cursor: pointer; transition: all 0.2s; text-decoration: none; display: inline-flex; align-items: center; gap: 4px; }
        .btn-edit { background: #e8f3ff; color: #0066ff; }
        .btn-edit:hover { background: #d0e7ff; }
        .btn-delete { background: #ffe8e8; color: #ff4d4f; }
        .btn-delete:hover { background: #ffd0d0; }
        .btn-pin { background: #f3e8ff; color: #722ed1; }
        .btn-pin:hover { background: #e6d0ff; }
        .btn-unpin { background: #f5f5f5; color: #666; }
        .btn-unpin:hover { background: #e8e8e8; }
        .btn-lock { background: #fff3e8; color: #ff6b00; }
        .btn-lock:hover { background: #ffe8d0; }
        .btn-unlock { background: #e6f7ed; color: #00a854; }
        .btn-unlock:hover { background: #ccfadd; }

        /* 空状态 */
        .empty-state { background: #fff; border-radius: 8px; padding: 60px 24px; text-align: center; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .empty-icon { font-size: 48px; margin-bottom: 16px; opacity: 0.5; }
        .empty-text { color: #646464; font-size: 15px; }

        /* 底部操作栏 */
        .page-footer { background: #fff; border-radius: 8px; padding: 20px 24px; margin-top: 20px; display: flex; gap: 12px; flex-wrap: wrap; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .btn-primary { background: #0066ff; color: white; padding: 10px 24px; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.2s; display: inline-flex; align-items: center; gap: 6px; }
        .btn-primary:hover { background: #0052cc; }
        .btn-secondary { background: #f5f5f5; color: #121212; padding: 10px 24px; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.2s; display: inline-flex; align-items: center; gap: 6px; }
        .btn-secondary:hover { background: #e8e8e8; }
        .btn-full { width: 100%; justify-content: center; }

        /* 右侧边栏 */
        .sidebar-card { background: #fff; border-radius: 8px; padding: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .sidebar-title { font-size: 16px; font-weight: 600; color: #121212; margin-bottom: 16px; padding-bottom: 12px; border-bottom: 1px solid #f0f0f0; }
        .user-info-card { text-align: center; }
        .user-avatar { width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #0066ff 0%, #00ccff 100%); display: flex; align-items: center; justify-content: center; margin: 0 auto 12px; font-size: 36px; color: #fff; font-weight: 700; }
        .user-avatar-img { width: 80px; height: 80px; border-radius: 50%; object-fit: cover; margin: 0 auto 12px; border: 3px solid #f0f0f0; }
        .user-name { font-size: 18px; font-weight: 600; color: #121212; margin-bottom: 4px; }
        .user-role { display: inline-block; padding: 2px 12px; background: #e6f0ff; color: #0066ff; border-radius: 12px; font-size: 12px; font-weight: 500; margin-bottom: 16px; }
        .user-stats { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; margin-bottom: 16px; }
        .stat-box { text-align: center; padding: 12px; background: #fafafa; border-radius: 6px; }
        .stat-value { font-size: 18px; font-weight: 600; color: #0066ff; }
        .stat-label { font-size: 12px; color: #8a8a8a; margin-top: 4px; }
        .user-actions { display: flex; flex-direction: column; gap: 8px; }
        .user-btn { display: block; width: 100%; padding: 12px; text-align: center; border-radius: 8px; text-decoration: none; font-size: 15px; font-weight: 500; transition: all 0.3s ease; }
        .user-btn-primary { background: #0066ff; color: #fff; }
        .user-btn-primary:hover { background: #0055dd; }
        .user-btn-secondary { background: #fafafa; color: #121212; border: 1px solid #e0e0e0; }
        .user-btn-secondary:hover { background: #f0f0f0; }

        /* 快捷入口 */
        .quick-links { display: grid; grid-template-columns: repeat(2, 1fr); gap: 12px; }
        .quick-link { display: flex; flex-direction: column; align-items: center; padding: 16px; background: #fafafa; border-radius: 8px; text-decoration: none; color: #121212; transition: all 0.3s ease; text-align: center; }
        .quick-link:hover { background: #f0f0f0; transform: translateY(-2px); }
        .quick-link-icon { font-size: 28px; margin-bottom: 8px; }
        .quick-link-text { font-size: 14px; font-weight: 500; }

        /* 翻页样式 - 知乎风格 */
        .pagination { display: flex; justify-content: center; align-items: center; gap: 8px; margin-top: 20px; flex-wrap: wrap; }
        .pagination a, .pagination span { display: inline-flex; align-items: center; justify-content: center; min-width: 36px; height: 36px; padding: 0 12px; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.2s; border: 1px solid #e8e8e8; }
        .pagination a { color: #121212; background: #fff; }
        .pagination a:hover { color: #0066ff; border-color: #0066ff; background: #f0f7ff; }
        .pagination .current { color: #fff; background: #0066ff; border-color: #0066ff; cursor: default; }
        .pagination .disabled { color: #c0c0c0; background: #f5f5f5; border-color: #e8e8e8; cursor: not-allowed; }
        .pagination-info { color: #8a8a8a; font-size: 13px; margin: 0 8px; }

        /* 响应式设计 */
        @media (max-width: 900px) {
            .main-container { grid-template-columns: 1fr; }
            .sidebar-right { order: -1; }
        }
        @media (max-width: 600px) {
            .header-content { flex-wrap: wrap; height: auto; padding: 10px 0; gap: 10px; }
            .nav-links { width: 100%; justify-content: center; }
            .main-container { padding: 0 12px; }
            .section-header { padding: 16px; }
            .post-card { padding: 16px; }
            .post-title-link { font-size: 16px; }
            .post-stats { flex-wrap: wrap; gap: 12px; }
        }
    </style>
</head>
<body>
<!-- 顶部导航栏 -->
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
    <!-- 左侧主内容区 -->
    <div class="content-left">
        <!-- 版块头部 -->
        <div class="section-header">
            <h1 class="section-title">${section.name}</h1>
            <p class="section-description">${section.description}</p>
        </div>

        <c:choose>
            <c:when test="${not empty posts}">
                <c:forEach items="${posts}" var="post">
                    <div class="post-card">
                        <div class="post-card-header">
                            <a href="${pageContext.request.contextPath}/post/${post.id}" class="post-title-link">
                                    ${post.title}
                            </a>
                            <div class="post-tags">
                                <c:if test="${post.pinLevel > 0}">
                                    <span class="tag-pinned">📌 置顶</span>
                                </c:if>
                                <c:if test="${post.isLocked}">
                                    <span class="tag-locked">🔒 锁定</span>
                                </c:if>
                            </div>
                        </div>

                        <div class="post-meta">
                                <span class="meta-item">
                                    <span class="author-name">${post.authorUsername}</span>
                                    <c:choose>
                                        <c:when test="${post.authorRole == 'CERTIFIED'}">
                                            <span class="user-badge badge-certified">✓ 认证用户</span>
                                        </c:when>
                                        <c:when test="${post.authorRole == 'ADMIN'}">
                                            <span class="user-badge badge-admin">★ 管理员</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="user-badge badge-regular">普通用户</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            <span class="meta-item">
                                    📅 <fmt:formatDate value="${post.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                </span>
                        </div>

                        <div class="post-stats">
                                <span class="stat-item stat-replies">
                                    💬 <strong>${post.replyCount != null ? post.replyCount : 0}</strong> 回复
                                </span>
                            <span class="stat-item">
                                    👁️ <strong>${post.viewCount}</strong> 浏览
                                </span>
                        </div>

                        <!-- 管理员和作者操作按钮 -->
                        <c:if test="${sessionScope.currentUser != null && (sessionScope.currentUser.role == 'ADMIN' || sessionScope.currentUser.id == post.userId)}">
                            <div class="post-actions">
                                <c:if test="${sessionScope.currentUser.id == post.userId}">
                                    <a href="${pageContext.request.contextPath}/post/${post.id}/edit" class="btn-action btn-edit">
                                        ✏️ 编辑
                                    </a>
                                    <form action="${pageContext.request.contextPath}/post/${post.id}/delete" method="post" style="display:inline;">
                                        <button type="submit" class="btn-action btn-delete" onclick="return confirm('确定要删除此帖子吗？');">
                                            🗑️ 删除
                                        </button>
                                    </form>
                                </c:if>

                                <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                                    <c:if test="${post.pinLevel > 0}">
                                        <form action="${pageContext.request.contextPath}/post/${post.id}/unpin" method="post" style="display:inline;">
                                            <button type="submit" class="btn-action btn-unpin">📌 取消置顶</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${post.pinLevel == 0}">
                                        <form action="${pageContext.request.contextPath}/post/${post.id}/pin" method="post" style="display:inline;">
                                            <input type="hidden" name="level" value="1">
                                            <button type="submit" class="btn-action btn-pin">📌 置顶</button>
                                        </form>
                                    </c:if>

                                    <c:if test="${post.isLocked}">
                                        <form action="${pageContext.request.contextPath}/post/${post.id}/unlock" method="post" style="display:inline;">
                                            <button type="submit" class="btn-action btn-unlock">🔓 解锁</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${!post.isLocked}">
                                        <form action="${pageContext.request.contextPath}/post/${post.id}/lock" method="post" style="display:inline;">
                                            <button type="submit" class="btn-action btn-lock">🔒 锁定</button>
                                        </form>
                                    </c:if>
                                </c:if>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">📭</div>
                    <p class="empty-text">该分区下暂无帖子</p>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- 翻页功能 -->
        <c:if test="${totalPages > 1}">
            <div class="card" style="margin-top: 20px;">
                <div class="card-body">
                    <div class="pagination">
                        <!-- 上一页 -->
                        <c:choose>
                            <c:when test="${pageNum > 1}">
                                <a href="${pageContext.request.contextPath}/forum/section/${section.id}/posts?pageNum=${pageNum - 1}&pageSize=${pageSize}">← 上一页</a>
                            </c:when>
                            <c:otherwise>
                                <span class="disabled">← 上一页</span>
                            </c:otherwise>
                        </c:choose>

                        <!-- 页码列表 -->
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:choose>
                                <c:when test="${i == pageNum}">
                                    <span class="current">${i}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/forum/section/${section.id}/posts?pageNum=${i}&pageSize=${pageSize}">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <!-- 下一页 -->
                        <c:choose>
                            <c:when test="${pageNum < totalPages}">
                                <a href="${pageContext.request.contextPath}/forum/section/${section.id}/posts?pageNum=${pageNum + 1}&pageSize=${pageSize}">下一页 →</a>
                            </c:when>
                            <c:otherwise>
                                <span class="disabled">下一页 →</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div style="text-align: center; margin-top: 12px; color: #8a8a8a; font-size: 13px;">
                        共 ${totalPosts} 条帖子，当前第 ${pageNum}/${totalPages} 页
                    </div>
                </div>
            </div>
        </c:if>

        <!-- 底部操作栏 -->
        <div class="page-footer">
            <a href="${pageContext.request.contextPath}/post/create?sectionId=${section.id}" class="btn-primary">
                ✏️ 创建帖子
            </a>
            <a href="${pageContext.request.contextPath}/forum/section" class="btn-secondary">
                📁 返回分区列表
            </a>
            <a href="${pageContext.request.contextPath}/" class="btn-secondary">
                🏠 返回首页
            </a>
        </div>
    </div>

    <!-- 右侧边栏 - 个人中心 -->
    <div class="sidebar-right">
        <c:choose>
            <c:when test="${not empty sessionScope.currentUser}">
                <div class="card user-info-card">
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty sessionScope.currentUser.avatar && sessionScope.currentUser.avatar != ''}">
                                <img src="${sessionScope.currentUser.avatar}" alt="头像" class="user-avatar-img" />
                            </c:when>
                            <c:otherwise>
                                <div class="user-avatar">${fn:substring(sessionScope.currentUser.username, 0, 1)}</div>
                            </c:otherwise>
                        </c:choose>
                        <div class="user-name">${sessionScope.currentUser.username}</div>
                        <c:choose>
                            <c:when test="${sessionScope.currentUser.role == 'ADMIN'}"><span class="user-role">👑 管理员</span></c:when>
                            <c:when test="${sessionScope.currentUser.role == 'CERTIFIED'}"><span class="user-role">✅ 认证用户</span></c:when>
                            <c:otherwise><span class="user-role">👤 普通用户</span></c:otherwise>
                        </c:choose>

                        <div class="user-stats">
                            <div class="stat-box">
                                <div class="stat-value">${postCount != null ? postCount : 0}</div>
                                <div class="stat-label">发帖数</div>
                            </div>
                            <div class="stat-box">
                                <div class="stat-value">${replyCount != null ? replyCount : 0}</div>
                                <div class="stat-label">回复数</div>
                            </div>
                            <div class="stat-box">
                                <div class="stat-value">${favoriteCount != null ? favoriteCount : 0}</div>
                                <div class="stat-label">收藏数</div>
                            </div>
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

        <!-- 快捷入口 -->
        <div class="card">
            <div class="card-header"><h2 class="card-title">⚡ 快捷入口</h2></div>
            <div class="card-body">
                <div class="quick-links">
                    <a href="${pageContext.request.contextPath}/hardware-library" class="quick-link">
                        <span class="quick-link-icon">🔧</span><span class="quick-link-text">硬件参数库</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/post/create?sectionId=${section.id}" class="quick-link">
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
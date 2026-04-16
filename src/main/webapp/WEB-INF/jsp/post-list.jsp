<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${section.name} - 帖子列表</title>
    <style>
        /* 知乎风格全局变量 */
        :root {
            --zhihu-blue: #0066ff;
            --zhihu-bg: #f6f6f6;
            --zhihu-white: #ffffff;
            --zhihu-text-primary: #121212;
            --zhihu-text-secondary: #646464;
            --zhihu-text-tertiary: #969696;
            --zhihu-border: #ebebeb;
            --zhihu-shadow: 0 1px 3px rgba(0,0,0,0.1);
            --zhihu-radius: 8px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
            background-color: var(--zhihu-bg);
            color: var(--zhihu-text-primary);
            line-height: 1.6;
        }

        /* 顶部导航栏 */
        .navbar {
            background: var(--zhihu-white);
            height: 52px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
        }

        .navbar-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 100%;
            padding: 0 20px;
        }

        .navbar-logo {
            font-size: 20px;
            font-weight: bold;
            color: var(--zhihu-blue);
            text-decoration: none;
        }

        .navbar-links {
            display: flex;
            gap: 20px;
        }

        .navbar-links a {
            color: var(--zhihu-text-primary);
            text-decoration: none;
            font-size: 15px;
            transition: color 0.2s;
        }

        .navbar-links a:hover {
            color: var(--zhihu-blue);
        }

        /* 主容器 */
        .main-container {
            max-width: 1200px;
            margin: 72px auto 20px;
            padding: 0 20px;
            display: grid;
            grid-template-columns: 1fr 320px;
            gap: 24px;
        }

        /* 左侧内容区 */
        .content-left {
            min-width: 0;
        }

        /* 版块头部 */
        .section-header {
            background: var(--zhihu-white);
            border-radius: var(--zhihu-radius);
            padding: 24px;
            margin-bottom: 16px;
            box-shadow: var(--zhihu-shadow);
        }

        .section-title {
            font-size: 24px;
            font-weight: 600;
            color: var(--zhihu-text-primary);
            margin-bottom: 8px;
        }

        .section-description {
            color: var(--zhihu-text-secondary);
            font-size: 15px;
        }

        /* 帖子卡片 - 知乎风格 */
        .post-card {
            background: var(--zhihu-white);
            border-radius: var(--zhihu-radius);
            padding: 20px 24px;
            margin-bottom: 12px;
            box-shadow: var(--zhihu-shadow);
            transition: all 0.2s ease;
            border: 1px solid transparent;
        }

        .post-card:hover {
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            border-color: var(--zhihu-border);
        }

        .post-card-header {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 12px;
        }

        .post-title-link {
            flex: 1;
            text-decoration: none;
            color: var(--zhihu-text-primary);
            font-size: 18px;
            font-weight: 500;
            line-height: 1.5;
            word-break: break-word;
        }

        .post-title-link:hover {
            color: var(--zhihu-blue);
        }

        .post-tags {
            display: flex;
            gap: 8px;
            flex-shrink: 0;
        }

        .tag-pinned {
            background: #e8f3ff;
            color: var(--zhihu-blue);
            padding: 2px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }

        .tag-locked {
            background: #fff3e8;
            color: #ff6b00;
            padding: 2px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }

        .post-meta {
            display: flex;
            align-items: center;
            gap: 16px;
            color: var(--zhihu-text-tertiary);
            font-size: 13px;
            margin-bottom: 12px;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .author-name {
            color: var(--zhihu-text-secondary);
            font-weight: 500;
        }

        .user-badge {
            display: inline-block;
            padding: 1px 6px;
            border-radius: 3px;
            font-size: 11px;
            font-weight: 500;
            margin-left: 6px;
        }

        .badge-certified {
            background: #e6f7ed;
            color: #00a854;
        }

        .badge-admin {
            background: #ffe8e8;
            color: #ff4d4f;
        }

        .badge-regular {
            background: #f5f5f5;
            color: #666;
        }

        /* 帖子统计信息 */
        .post-stats {
            display: flex;
            gap: 20px;
            padding-top: 12px;
            border-top: 1px solid var(--zhihu-border);
        }

        .stat-item {
            display: flex;
            align-items: center;
            gap: 4px;
            color: var(--zhihu-text-tertiary);
            font-size: 13px;
        }

        .stat-item strong {
            color: var(--zhihu-text-secondary);
            font-weight: 600;
        }

        .stat-replies {
            color: var(--zhihu-blue);
        }

        /* 操作按钮区域 */
        .post-actions {
            display: flex;
            gap: 12px;
            margin-top: 16px;
            flex-wrap: wrap;
        }

        .post-actions form {
            display: inline;
        }

        .btn-action {
            padding: 6px 16px;
            border: none;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .btn-edit {
            background: #e8f3ff;
            color: var(--zhihu-blue);
        }

        .btn-edit:hover {
            background: #d0e7ff;
        }

        .btn-delete {
            background: #ffe8e8;
            color: #ff4d4f;
        }

        .btn-delete:hover {
            background: #ffd0d0;
        }

        .btn-pin {
            background: #f3e8ff;
            color: #722ed1;
        }

        .btn-pin:hover {
            background: #e6d0ff;
        }

        .btn-unpin {
            background: #f5f5f5;
            color: #666;
        }

        .btn-unpin:hover {
            background: #e8e8e8;
        }

        .btn-lock {
            background: #fff3e8;
            color: #ff6b00;
        }

        .btn-lock:hover {
            background: #ffe8d0;
        }

        .btn-unlock {
            background: #e6f7ed;
            color: #00a854;
        }

        .btn-unlock:hover {
            background: #ccfadd;
        }

        /* 空状态 */
        .empty-state {
            background: var(--zhihu-white);
            border-radius: var(--zhihu-radius);
            padding: 60px 24px;
            text-align: center;
            box-shadow: var(--zhihu-shadow);
        }

        .empty-icon {
            font-size: 48px;
            margin-bottom: 16px;
            opacity: 0.5;
        }

        .empty-text {
            color: var(--zhihu-text-secondary);
            font-size: 15px;
        }

        /* 底部操作栏 */
        .page-footer {
            background: var(--zhihu-white);
            border-radius: var(--zhihu-radius);
            padding: 20px 24px;
            margin-top: 20px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            box-shadow: var(--zhihu-shadow);
        }

        .btn-primary {
            background: var(--zhihu-blue);
            color: white;
            padding: 10px 24px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-primary:hover {
            background: #0052cc;
        }

        .btn-secondary {
            background: #f5f5f5;
            color: var(--zhihu-text-primary);
            padding: 10px 24px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-secondary:hover {
            background: #e8e8e8;
        }

        /* 右侧边栏 */
        .sidebar-right {
            position: sticky;
            top: 72px;
            height: fit-content;
        }

        .sidebar-card {
            background: var(--zhihu-white);
            border-radius: var(--zhihu-radius);
            padding: 20px;
            margin-bottom: 16px;
            box-shadow: var(--zhihu-shadow);
        }

        .sidebar-title {
            font-size: 16px;
            font-weight: 600;
            color: var(--zhihu-text-primary);
            margin-bottom: 16px;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--zhihu-border);
        }

        .user-info-card {
            text-align: center;
        }

        .user-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: #f0f0f0;
            margin: 0 auto 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            color: var(--zhihu-text-tertiary);
        }

        .user-name {
            font-size: 18px;
            font-weight: 600;
            color: var(--zhihu-text-primary);
            margin-bottom: 4px;
        }

        .user-role-badge {
            display: inline-block;
            padding: 2px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
            margin-bottom: 16px;
        }

        .role-badge-certified {
            background: #e6f7ed;
            color: #00a854;
        }

        .role-badge-admin {
            background: #ffe8e8;
            color: #ff4d4f;
        }

        .role-badge-regular {
            background: #f5f5f5;
            color: #666;
        }

        .user-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
            margin-bottom: 16px;
        }

        .stat-box {
            text-align: center;
            padding: 12px;
            background: #fafafa;
            border-radius: 6px;
        }

        .stat-value {
            font-size: 18px;
            font-weight: 600;
            color: var(--zhihu-text-primary);
        }

        .stat-label {
            font-size: 12px;
            color: var(--zhihu-text-tertiary);
            margin-top: 4px;
        }

        .user-actions {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .btn-full {
            width: 100%;
            justify-content: center;
        }

        /* 响应式设计 */
        @media (max-width: 900px) {
            .main-container {
                grid-template-columns: 1fr;
            }

            .sidebar-right {
                position: static;
            }
        }

        @media (max-width: 600px) {
            .navbar-content {
                padding: 0 12px;
            }

            .main-container {
                padding: 0 12px;
            }

            .section-header {
                padding: 16px;
            }

            .post-card {
                padding: 16px;
            }

            .post-title-link {
                font-size: 16px;
            }

            .post-stats {
                flex-wrap: wrap;
                gap: 12px;
            }
        }
    </style>
</head>
<body>
    <!-- 顶部导航栏 -->
    <nav class="navbar">
        <div class="navbar-content">
            <a href="${pageContext.request.contextPath}/" class="navbar-logo">硬件论坛</a>
            <div class="navbar-links">
                <a href="${pageContext.request.contextPath}/">首页</a>
                <a href="${pageContext.request.contextPath}/forum/section">分区</a>
                <a href="${pageContext.request.contextPath}/hardware/library">硬件库</a>
                <c:if test="${not empty sessionScope.currentUser}">
                    <a href="${pageContext.request.contextPath}/user/profile">个人中心</a>
                </c:if>
                <c:if test="${empty sessionScope.currentUser}">
                    <a href="${pageContext.request.contextPath}/user/login">登录</a>
                </c:if>
            </div>
        </div>
    </nav>

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
                    <div class="sidebar-card user-info-card">
                        <h3 class="sidebar-title">个人中心</h3>
                        <div class="user-avatar">
                            ${sessionScope.currentUser.username.substring(0, 1)}
                        </div>
                        <div class="user-name">${sessionScope.currentUser.username}</div>
                        <c:choose>
                            <c:when test="${sessionScope.currentUser.role == 'CERTIFIED'}">
                                <span class="user-role-badge role-badge-certified">✓ 认证用户</span>
                            </c:when>
                            <c:when test="${sessionScope.currentUser.role == 'ADMIN'}">
                                <span class="user-role-badge role-badge-admin">★ 管理员</span>
                            </c:when>
                            <c:otherwise>
                                <span class="user-role-badge role-badge-regular">普通用户</span>
                            </c:otherwise>
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
                            <a href="${pageContext.request.contextPath}/user/profile" class="btn-action btn-primary btn-full">
                                查看个人主页
                            </a>
                            <a href="${pageContext.request.contextPath}/user/logout" class="btn-action btn-secondary btn-full">
                                退出登录
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="sidebar-card">
                        <h3 class="sidebar-title">欢迎来到硬件论坛</h3>
                        <p style="color: var(--zhihu-text-secondary); font-size: 14px; margin-bottom: 16px; text-align: center;">
                            登录后享受更多功能
                        </p>
                        <div class="user-actions">
                            <a href="${pageContext.request.contextPath}/user/login" class="btn-action btn-primary btn-full">
                                登录
                            </a>
                            <a href="${pageContext.request.contextPath}/user/register" class="btn-action btn-secondary btn-full">
                                注册账号
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

            <!-- 快捷入口 -->
            <div class="sidebar-card">
                <h3 class="sidebar-title">快捷入口</h3>
                <div class="user-actions">
                    <a href="${pageContext.request.contextPath}/hardware/library" class="btn-action btn-secondary btn-full">
                        🔧 硬件参数库
                    </a>
                    <a href="${pageContext.request.contextPath}/forum/section" class="btn-action btn-secondary btn-full">
                        📁 所有分区
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>${fn:escapeXml(post.title)} - 帖子详情</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
    <style>
        /* ================= 全局重置 (与 index.jsp 保持一致) ================= */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei', sans-serif; background: #f6f6f6; color: #121212; line-height: 1.6; min-height: 100vh; }
        a { text-decoration: none; color: inherit; }
        ul { list-style: none; }

        /* ================= 顶部 Header (与 index.jsp 一致) ================= */
        .header { background: #fff; box-shadow: 0 1px 3px rgba(0,0,0,0.1); position: sticky; top: 0; z-index: 1000; padding: 0 20px; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; height: 56px; }
        .logo { font-size: 22px; font-weight: 700; color: #0066ff; display: flex; align-items: center; gap: 8px; }
        .logo:hover { color: #0055dd; }
        .nav-links { display: flex; align-items: center; gap: 20px; }
        .nav-links a { color: #121212; font-size: 15px; padding: 8px 16px; border-radius: 20px; transition: all 0.3s ease; }
        .nav-links a:hover { background: #f0f0f0; color: #0066ff; }
        .nav-links .highlight { background: #0066ff; color: #fff; }
        .nav-links .highlight:hover { background: #0055dd; }

        /* ================= 核心布局 (完全模仿 index.jsp) ================= */
        .main-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
            display: flex;
            gap: 20px;
            align-items: flex-start; /* 关键：防止侧边栏被拉伸 */
        }

        .left-column {
            flex: 1; /* 占据剩余空间 */
            min-width: 0; /* 防止内容溢出 */
        }

        .right-column {
            width: 300px; /* 固定宽度，与 index.jsp 一致 */
            flex-shrink: 0; /* 防止被压缩 */
        }

        /* ================= 通用卡片样式 (知乎风格) ================= */
        .card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); overflow: hidden; margin-bottom: 20px; }
        .card-body { padding: 20px; }
        .card-title { font-size: 16px; font-weight: 600; color: #121212; margin-bottom: 16px; padding-bottom: 12px; border-bottom: 1px solid #f0f0f0; }

        /* ================= 帖子区域特有样式 ================= */
        h1.post-title { font-size: 24px; font-weight: 700; color: #121212; margin-bottom: 15px; line-height: 1.4; }

        .post-meta-bar { display: flex; flex-wrap: wrap; gap: 15px; font-size: 14px; color: #8a8a8a; margin-bottom: 20px; padding-bottom: 20px; border-bottom: 1px solid #f0f0f0; }
        .meta-item { display: flex; align-items: center; gap: 5px; }
        .meta-item strong { color: #121212; font-weight: 600; }
        .meta-item a { color: #0066ff; font-weight: 500; }
        .meta-item a:hover { text-decoration: underline; }
        .status-tag { padding: 2px 8px; border-radius: 4px; font-size: 12px; font-weight: 600; background: #ffebee; color: #dc3545; }

        /* 操作栏 */
        .action-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 10px; background: #fafafa; padding: 12px 16px; border-radius: 8px; border: 1px solid #f0f0f0; }
        .action-left, .action-right { display: flex; gap: 10px; flex-wrap: wrap; align-items: center; }

        .btn { display: inline-block; padding: 8px 16px; border: none; border-radius: 20px; font-size: 14px; font-weight: 500; cursor: pointer; transition: all 0.3s ease; text-align: center; color: #fff; background: #0066ff; }
        .btn:hover { transform: translateY(-1px); box-shadow: 0 2px 8px rgba(0,102,255,0.2); opacity: 0.9; }
        .btn-fav { background: #ffc107; color: #212529; }
        .btn-fav.active { background: #ffb300; }
        .btn-edit { background: #0066ff; }
        .btn-del { background: #dc3545; }
        .btn-admin { background: #6c757d; }
        .btn-back { background: #f0f0f0; color: #121212; }
        .btn-back:hover { background: #e0e0e0; }
        .btn-info { background: #17a2b8; }
        .btn-primary { background: #0066ff; }

        /* 帖子正文 */
        .post-body { font-size: 16px; line-height: 1.8; color: #121212; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin-bottom: 25px; white-space: pre-wrap; word-wrap: break-word; }
        .post-body img { max-width: 100%; height: auto; border-radius: 8px; margin: 15px 0; }

        /* 回复区域 */
        .section-title { font-size: 18px; font-weight: 700; color: #121212; margin: 30px 0 20px 0; padding-left: 10px; border-left: 4px solid #0066ff; }

        .reply-item { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin-bottom: 15px; }
        .reply-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; font-size: 14px; color: #8a8a8a; border-bottom: 1px solid #f9f9f9; padding-bottom: 10px; flex-wrap: wrap; gap: 8px; }
        .reply-author { color: #121212; font-weight: 600; margin-right: 8px; }
        .role-badge { font-size: 12px; padding: 1px 6px; border-radius: 4px; margin-left: 5px; background: #f0f0f0; color: #666; }
        .role-cert { background: #e6f7ed; color: #28a745; }
        .role-admin { background: #ffebee; color: #dc3545; }

        .reply-content { font-size: 15px; line-height: 1.7; color: #121212; white-space: pre-wrap; }
        .reply-content img { max-width: 100%; border-radius: 6px; margin-top: 10px; }

        .reply-actions { margin-top: 12px; text-align: right; }
        .btn-sm { padding: 4px 12px; font-size: 12px; border-radius: 12px; }

        /* 回复表单 */
        .reply-form-box { background: #fff; padding: 24px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin-top: 20px; }
        .form-toolbar { display: flex; gap: 10px; margin-bottom: 12px; }
        textarea.form-control { width: 100%; padding: 12px; border: 1px solid #e0e0e0; border-radius: 8px; font-size: 14px; font-family: inherit; resize: vertical; min-height: 120px; outline: none; transition: border-color 0.3s; box-sizing: border-box; }
        textarea.form-control:focus { border-color: #0066ff; box-shadow: 0 0 0 3px rgba(0,102,255,0.1); }
        .error-msg { color: #dc3545; font-size: 13px; margin-top: 5px; }
        input[type="submit"] { background: #0066ff; color: #fff; border: none; padding: 10px 24px; border-radius: 20px; font-size: 14px; font-weight: 500; cursor: pointer; transition: all 0.3s; float: right; }
        input[type="submit"]:hover { background: #0055dd; transform: translateY(-1px); }

        /* 分页 */
        .pagination { display: flex; justify-content: center; gap: 8px; margin: 30px 0; }
        .page-link { display: inline-block; padding: 8px 14px; border: 1px solid #e0e0e0; border-radius: 20px; color: #121212; font-size: 14px; transition: all 0.2s; background: #fff; }
        .page-link:hover { background: #0066ff; color: #fff; border-color: #0066ff; }
        .page-active { background: #0066ff; color: #fff; border-color: #0066ff; }

        /* 模态框 */
        .modal { display: none; position: fixed; z-index: 2000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); }
        .modal-content { background: #fff; margin: 5% auto; padding: 30px; border-radius: 12px; width: 90%; max-width: 700px; position: relative; animation: slideDown 0.3s ease; max-height: 85vh; overflow-y: auto; }
        @keyframes slideDown { from { transform: translateY(-50px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }
        .close-modal { float: right; font-size: 28px; font-weight: bold; color: #aaa; cursor: pointer; line-height: 1; }
        .close-modal:hover { color: #000; }

        .hw-detail-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 15px; margin-top: 20px; }
        .hw-item { background: #f9f9f9; padding: 10px; border-radius: 6px; border-left: 3px solid #0066ff; }
        .hw-label { font-size: 12px; color: #8a8a8a; margin-bottom: 4px; }
        .hw-value { font-size: 14px; color: #121212; font-weight: 600; word-break: break-all; }

        /* 搜索列表项 */
        .search-result-item { padding: 10px; border-bottom: 1px solid #f0f0f0; cursor: pointer; transition: background 0.2s; }
        .search-result-item:hover { background: #f6f6f6; }

        /* 响应式 */
        @media (max-width: 768px) {
            .header-content { flex-wrap: wrap; height: auto; padding: 10px 0; }
            .nav-links { width: 100%; justify-content: center; padding: 10px 0; }
            .main-container { flex-direction: column; }
            .right-column { width: 100%; }
            .action-bar { flex-direction: column; align-items: stretch; }
            .action-left, .action-right { justify-content: center; }
            .btn { width: 100%; }
            .post-body { padding: 20px; }
        }
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

<!-- 顶部 Header -->
<header class="header">
    <div class="header-content">
        <a href="${pageContext.request.contextPath}/" class="logo">💻 PC 硬件交流论坛</a>
        <nav class="nav-links">
            <a href="${pageContext.request.contextPath}/forum/section">📁 论坛分区</a>
            <a href="${pageContext.request.contextPath}/hardware-library">🔧 硬件参数库</a>
            <c:choose>
                <c:when test="${not empty sessionScope.currentUser}">
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

<!-- 主容器：模仿 index.jsp 的布局结构 -->
<div class="main-container">

    <!-- 左侧列：包含帖子所有内容 -->
    <div class="left-column">

        <!-- 标题 -->
        <h1 class="post-title">${fn:escapeXml(post.title)}</h1>

        <!-- 元数据 -->
        <div class="post-meta-bar">
            <div class="meta-item">
                <strong>👤</strong> ${fn:escapeXml(post.authorUsername)}
            </div>
            <div class="meta-item">
                <strong>📅</strong> <fmt:formatDate value="${post.createTime}" pattern="yyyy-MM-dd HH:mm"/>
            </div>
            <div class="meta-item">
                <strong>👁️</strong> ${post.viewCount}
            </div>
            <div class="meta-item">
                <strong>📁</strong> <a href="${pageContext.request.contextPath}/forum/section/${post.sectionId}/posts">${fn:escapeXml(post.sectionName)}</a>
            </div>
            <c:if test="${post.isLocked}">
                <span class="status-tag">🔒 已锁定</span>
            </c:if>
        </div>

        <!-- 操作按钮栏 -->
        <div class="action-bar">
            <div class="action-left">
                <c:if test="${not empty sessionScope.currentUser}">
                    <button id="favoriteBtn" class="btn btn-fav ${isFavorited ? 'active' : ''}"
                            onclick="toggleFavorite(${post.id})">
                            ${isFavorited ? '⭐ 已收藏' : '⭐ 收藏'} (<span id="favoriteCount">${favoriteCount}</span>)
                    </button>
                </c:if>
            </div>
            <div class="action-right">
                <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.id == post.userId}">
                    <a href="${pageContext.request.contextPath}/post/${post.id}/edit" class="btn btn-edit">✏️ 编辑</a>
                    <form action="${pageContext.request.contextPath}/post/${post.id}/delete" method="post" style="display:inline;">
                        <input type="submit" value="🗑️ 删除" class="btn btn-del"
                               onclick="return confirm('确定删除此帖子吗？');"/>
                    </form>
                </c:if>

                <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.role == 'ADMIN'}">
                    <c:if test="${post.pinLevel > 0}">
                        <form action="${pageContext.request.contextPath}/post/${post.id}/unpin" method="post" style="display:inline;">
                            <input type="submit" value="📌 取消置顶" class="btn btn-admin"/>
                        </form>
                    </c:if>
                    <c:if test="${post.pinLevel == 0}">
                        <form action="${pageContext.request.contextPath}/post/${post.id}/pin" method="post" style="display:inline;">
                            <input type="hidden" name="level" value="1"/>
                            <input type="submit" value="📌 置顶" class="btn btn-admin"/>
                        </form>
                    </c:if>
                    <c:if test="${post.isLocked}">
                        <form action="${pageContext.request.contextPath}/post/${post.id}/unlock" method="post" style="display:inline;">
                            <input type="submit" value="🔓 解锁" class="btn btn-admin"/>
                        </form>
                    </c:if>
                    <c:if test="${!post.isLocked}">
                        <form action="${pageContext.request.contextPath}/post/${post.id}/lock" method="post" style="display:inline;">
                            <input type="submit" value="🔒 锁定" class="btn btn-admin"/>
                        </form>
                    </c:if>
                </c:if>

                <a href="${pageContext.request.contextPath}/forum/section/${post.sectionId}/posts" class="btn btn-back">🔙 返回列表</a>
            </div>
        </div>

        <c:if test="${post.isLocked}">
            <div style="background:#ffebee; color:#c62828; padding:15px; border-radius:8px; margin-bottom:20px; font-weight:500; border-left: 4px solid #dc3545;">
                🔒 此帖子已被管理员锁定，禁止普通用户回复。
            </div>
        </c:if>

        <!-- 帖子正文 -->
        <div class="post-body">
            <div id="postContentRaw" style="display:none;">${post.content}</div>
            <div id="postContentRendered"></div>
        </div>

        <!-- 回复列表 -->
        <h2 class="section-title">💬 回复 (<c:out value="${totalReplies}"/>)</h2>

        <c:choose>
            <c:when test="${not empty replies}">
                <ul id="repliesList">
                    <c:forEach items="${replies}" var="reply">
                        <li class="reply-item" id="reply-${reply.id}">
                            <div class="reply-header">
                                <div>
                                    <span class="reply-author">${fn:escapeXml(reply.authorUsername)}</span>
                                    <c:choose>
                                        <c:when test="${reply.authorRole == 'CERTIFIED'}">
                                            <span class="role-badge role-cert">🎓 认证</span>
                                        </c:when>
                                        <c:when test="${reply.authorRole == 'ADMIN'}">
                                            <span class="role-badge role-admin">⚙️ 管理</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="role-badge role-user">👤 用户</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <span><fmt:formatDate value="${reply.createTime}" pattern="MM-dd HH:mm"/></span>
                            </div>
                            <div class="reply-content">
                                <div class="reply-raw" style="display:none;">${reply.content}</div>
                                <div class="reply-rendered"></div>
                            </div>
                            <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.id == reply.userId}">
                                <div class="reply-actions">
                                    <button class="btn btn-del btn-sm" onclick="deleteReply(${reply.id})">删除</button>
                                </div>
                            </c:if>
                        </li>
                    </c:forEach>
                </ul>

                <!-- 分页 -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <c:if test="${pageNum > 1}">
                            <a href="${pageContext.request.contextPath}/post/${post.id}?pageNum=${pageNum - 1}&pageSize=6" class="page-link">&laquo;</a>
                        </c:if>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:choose>
                                <c:when test="${i == pageNum}">
                                    <span class="page-link page-active">${i}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/post/${post.id}?pageNum=${i}&pageSize=6" class="page-link">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${pageNum < totalPages}">
                            <a href="${pageContext.request.contextPath}/post/${post.id}?pageNum=${pageNum + 1}&pageSize=6" class="page-link">&raquo;</a>
                        </c:if>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <div style="text-align:center; color:#8a8a8a; padding:40px; background:#fff; border-radius:8px;">暂无回复，快来抢沙发吧！</div>
            </c:otherwise>
        </c:choose>

        <!-- 回复表单 -->
        <c:choose>
            <c:when test="${post.isLocked and sessionScope.currentUser.role != 'ADMIN'}">
                <div style="text-align:center; color:#8a8a8a; padding:20px; background:#fff; border-radius:8px; margin-top:20px;">
                    帖子已锁定，无法回复。
                </div>
            </c:when>
            <c:otherwise>
                <c:if test="${not empty sessionScope.currentUser}">
                    <div class="reply-form-box">
                        <h3 style="margin-bottom:15px; font-size:16px; font-weight:600;">发表回复</h3>
                        <form action="${pageContext.request.contextPath}/post/${post.id}/reply" method="post">
                            <input type="hidden" name="postId" value="${post.id}"/>
                            <input type="hidden" name="userId" value="${sessionScope.currentUser.id}"/>

                            <div class="form-toolbar">
                                <button type="button" id="replyUploadBtn" class="btn btn-primary" style="padding:6px 15px; font-size:13px; background:#17a2b8;">📷 上传图片</button>
                                <input type="file" id="replyImageFileInput" accept="image/*" style="display:none;">
                                <c:if test="${sessionScope.currentUser.role == 'CERTIFIED' || sessionScope.currentUser.role == 'ADMIN'}">
                                    <button type="button" id="replyInsertReferenceBtn" class="btn btn-primary" style="padding:6px 15px; font-size:13px; background:#28a745;">📊 插入硬件引用</button>
                                </c:if>
                            </div>

                            <textarea name="content" id="replyContent" class="form-control" rows="5" required></textarea>
                            <c:if test="${not empty error}">
                                <div class="error-msg">${error}</div>
                            </c:if>

                            <div style="clear:both;"></div>
                            <input type="submit" value="✅ 提交回复"/>
                        </form>
                    </div>
                </c:if>
                <c:if test="${empty sessionScope.currentUser}">
                    <div style="text-align:center; padding:30px; background:#fff; border-radius:8px; margin-top:20px;">
                        <p style="margin-bottom:15px; color:#666;">登录后即可参与讨论</p>
                        <a href="${pageContext.request.contextPath}/user/login" class="btn btn-primary">去登录</a>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>

    </div>

    <!-- 右侧列：直接复用 index.jsp 的右侧卡片结构 -->
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

<!-- 硬件详情模态框 -->
<div id="hardwareModal" class="modal">
    <div class="modal-content">
        <span class="close-modal">&times;</span>
        <h3 style="margin-bottom:20px; font-size:20px; border-bottom:2px solid #f0f0f0; padding-bottom:10px;">📊 硬件详细参数</h3>
        <div id="hardwareDetailContent" class="hw-detail-grid"></div>
    </div>
</div>

<!-- 硬件搜索模态框 -->
<div id="replyHardwareModal" class="modal">
    <div class="modal-content">
        <span class="close-modal">&times;</span>
        <h3 style="margin-bottom:20px; font-size:20px;">📊 选择硬件引用</h3>
        <div style="margin-bottom:15px;">
            <label style="display:block; margin-bottom:5px; font-weight:500; color:#666;">硬件类型:</label>
            <select id="replyHardwareTypeSelect" style="width:100%; padding:10px; border:1px solid #e0e0e0; border-radius:6px; font-size:14px;">
                <option value="">-- 请选择 --</option>
                <option value="cpu_info">CPU</option>
                <option value="gpu_info">显卡</option>
                <option value="motherboard_info">主板</option>
            </select>
        </div>
        <div style="margin-bottom:15px;">
            <label style="display:block; margin-bottom:5px; font-weight:500; color:#666;">型号关键词:</label>
            <input type="text" id="replyHardwareSearchInput" placeholder="例如：i5, RTX 4060, B760..." style="width:100%; padding:10px; border:1px solid #e0e0e0; border-radius:6px; font-size:14px;">
        </div>
        <button id="replyHardwareSearchBtn" class="btn btn-primary" style="width:100%; padding:12px;">🔍 搜索硬件</button>
        <div id="replyHardwareList" style="max-height:300px; overflow-y:auto; margin-top:15px; border:1px solid #f0f0f0; border-radius:6px; background:#fff;"></div>
    </div>
</div>

<script>
    // 页面加载完成后执行
    $(document).ready(function() {
        // 1. 渲染帖子内容
        var rawPost = $('#postContentRaw').text();
        rawPost = rawPost.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&amp;/g, '&').replace(/&quot;/g, '"');
        $('#postContentRendered').html(renderContentWithReferences(rawPost));

        // 2. 渲染所有回复内容
        $('.reply-item').each(function() {
            var $item = $(this);
            var raw = $item.find('.reply-raw').text();
            raw = raw.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&amp;/g, '&').replace(/&quot;/g, '"');
            $item.find('.reply-rendered').html(renderContentWithReferences(raw));
        });

        // 3. 模态框关闭逻辑
        $('.close-modal').click(function() { $(this).closest('.modal').hide(); });
        $(window).click(function(e) { if($(e.target).hasClass('modal')) $(e.target).hide(); });

        // 4. 删除回复逻辑
        $('.btn-sm').click(function() {
            var rid = $(this).attr('onclick').match(/\d+/)[0];
            if(confirm('确定删除此回复吗？')) {
                $.post('${pageContext.request.contextPath}/reply/' + rid + '/delete', function(res) {
                    if(res && res.success) {
                        $('#reply-' + rid).fadeOut(300, function() { $(this).remove(); });
                    } else {
                        alert('删除失败：' + (res ? res.message : '未知错误'));
                    }
                }).fail(function() { alert('网络错误，删除失败'); });
            }
        });

        // 5. 图片上传逻辑 (回复)
        $('#replyUploadBtn').click(function() { $('#replyImageFileInput').click(); });
        $('#replyImageFileInput').change(function(e) {
            if(e.target.files && e.target.files[0]) {
                var fd = new FormData();
                fd.append('file', e.target.files[0]);
                $.ajax({
                    url: '${pageContext.request.contextPath}/upload/image',
                    type: 'POST',
                    fd,
                    processData: false,
                    contentType: false,
                    success: function(res) {
                        if(res && res.success) {
                            insertTextAtCursor($('#replyContent'), '![](' + res.url + ')');
                        } else {
                            alert('上传失败：' + (res ? res.message : '未知错误'));
                        }
                    },
                    error: function() { alert('网络错误，上传失败'); }
                });
            }
        });

        // 6. 打开硬件搜索模态框
        $('#replyInsertReferenceBtn').click(function() {
            $('#replyHardwareModal').show();
            $('#replyHardwareList').empty();
            $('#replyHardwareTypeSelect').val('');
            $('#replyHardwareSearchInput').val('');
        });

        // 7. 硬件搜索逻辑
        $('#replyHardwareSearchBtn').click(function() {
            var type = $('#replyHardwareTypeSelect').val();
            var kw = $('#replyHardwareSearchInput').val().trim();

            if(!type) { alert('请先选择硬件类型'); return; }
            if(!kw) { alert('请输入搜索关键词'); return; }

            var searchUrl = '${pageContext.request.contextPath}/hardware/search/' + type + '?keyword=' + encodeURIComponent(kw);

            $.ajax({
                url: searchUrl,
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    var html = '<ul style="list-style:none; padding:0; margin:0;">';
                    if(!data || data.length === 0) {
                        html += '<li style="padding:15px; text-align:center; color:#888;">未找到相关硬件</li>';
                    } else {
                        data.forEach(function(item) {
                            var displayName = (item.brand ? item.brand + ' ' : '') + item.model;
                            html += '<li class="search-result-item" onclick="insertHardwareReference(\'' + type + '\', ' + item.id + ', \'' + displayName.replace(/'/g, "\\'") + '\')">' +
                                '<strong>' + displayName + '</strong>' +
                                '</li>';
                        });
                    }
                    html += '</ul>';
                    $('#replyHardwareList').html(html);
                },
                error: function(xhr, status, error) {
                    console.error("Search Error:", status, error);
                    alert('搜索失败，请检查网络或控制台日志。\n尝试路径：' + searchUrl);
                }
            });
        });
    });

    // 插入硬件引用到文本框
    function insertHardwareReference(table, id, name) {
        var refText = '[' + table + ':' + id + ']';
        insertTextAtCursor($('#replyContent'), refText);
        $('#replyHardwareModal').hide();
    }

    // 收藏/取消收藏逻辑
    function toggleFavorite(postId) {
        var url = '${pageContext.request.contextPath}/post/' + postId + '/toggle-favorite';
        var btn = $('#favoriteBtn');
        var countSpan = $('#favoriteCount');

        $.ajax({
            url: url,
            type: 'POST',
            dataType: 'json',
            success: function(response) {
                if(response && response.success) {
                    countSpan.text(response.favoriteCount);
                    if(response.favorited) {
                        btn.addClass('active').text('⭐ 已收藏 (' + response.favoriteCount + ')');
                    } else {
                        btn.removeClass('active').text('⭐ 收藏 (' + response.favoriteCount + ')');
                    }
                } else {
                    alert('操作失败：' + (response ? response.message : '未知错误'));
                }
            },
            error: function(xhr, status, error) {
                console.error("Favorite Error:", status, error);
                alert('收藏失败：' + error);
            }
        });
    }

    // 渲染内容中的图片和硬件引用标签
    function renderContentWithReferences(text) {
        if(!text) return '';
        var paragraphs = text.split(/\n\s*\n/);
        var html = '';
        for(var i=0; i<paragraphs.length; i++) {
            var p = paragraphs[i].trim();
            if(p) {
                p = p.replace(/\n/g, '<br>');
                html += '<p style="margin-bottom:1em;">' + p + '</p>';
            }
        }

        html = html.replace(/!\[([^\]]*)\]\(([^)]+)\)/g, function(match, alt, url) {
            return '<img src="' + url + '" alt="' + alt + '" style="max-width:100%; height:auto; border-radius:8px; margin:10px 0; display:block;">';
        });

        html = html.replace(/\[([a-zA-Z_]+):(\d+)\]/g, function(match, table, id) {
            var typeName = getHardwareTypeName(table);
            return '<a href="#" class="hardware-ref-link" data-table="' + table + '" data-id="' + id + '" ' +
                'style="color:#0066ff; background:#e6f0ff; padding:2px 8px; border-radius:4px; text-decoration:none; font-weight:500; display:inline-block; margin:0 2px;">' +
                '📊 查看' + typeName + '详情</a>';
        });

        return html;
    }

    function getHardwareTypeName(table) {
        if(table === 'cpu_info') return 'CPU';
        if(table === 'gpu_info') return '显卡';
        if(table === 'motherboard_info') return '主板';
        return '硬件';
    }

    function insertTextAtCursor($el, text) {
        var el = $el[0];
        if(!el) return;
        var start = el.selectionStart;
        var end = el.selectionEnd;
        var val = $el.val();
        $el.val(val.substring(0, start) + text + val.substring(end));
        el.selectionStart = el.selectionEnd = start + text.length;
        el.focus();
    }

    // 点击硬件引用链接显示详情
    $(document).on('click', '.hardware-ref-link', function(e) {
        e.preventDefault();
        var table = $(this).data('table');
        var id = $(this).data('id');

        $('#hardwareDetailContent').html('<p style="grid-column:1/-1;text-align:center;padding:20px;">加载中...</p>');
        $('#hardwareModal').show();

        $.ajax({
            url: '${pageContext.request.contextPath}/hardware/detail/' + table + '/' + id,
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                if(!data) { $('#hardwareDetailContent').html('<p>未找到数据</p>'); return; }

                var html = '';
                if(data.model) html += '<div class="hw-item"><div class="hw-label">型号</div><div class="hw-value">' + data.model + '</div></div>';
                if(data.brand) html += '<div class="hw-item"><div class="hw-label">品牌</div><div class="hw-value">' + data.brand + '</div></div>';

                if(table === 'cpu_info') {
                    if(data.interfaceType) html += '<div class="hw-item"><div class="hw-label">接口类型</div><div class="hw-value">' + data.interfaceType + '</div></div>';
                    if(data.cores) html += '<div class="hw-item"><div class="hw-label">核心数</div><div class="hw-value">' + data.cores + '</div></div>';
                    if(data.threads) html += '<div class="hw-item"><div class="hw-label">线程数</div><div class="hw-value">' + data.threads + '</div></div>';
                    if(data.baseFrequency) html += '<div class="hw-item"><div class="hw-label">基础频率</div><div class="hw-value">' + data.baseFrequency + ' GHz</div></div>';
                    if(data.maxFrequency) html += '<div class="hw-item"><div class="hw-label">最大频率</div><div class="hw-value">' + data.maxFrequency + ' GHz</div></div>';
                    if(data.tdp) html += '<div class="hw-item"><div class="hw-label">TDP</div><div class="hw-value">' + data.tdp + ' W</div></div>';
                }
                else if(table === 'gpu_info') {
                    if(data.memorySize) html += '<div class="hw-item"><div class="hw-label">显存容量</div><div class="hw-value">' + data.memorySize + ' GB</div></div>';
                    if(data.memoryType) html += '<div class="hw-item"><div class="hw-label">显存类型</div><div class="hw-value">' + data.memoryType + '</div></div>';
                    if(data.baseClock) html += '<div class="hw-item"><div class="hw-label">基础频率</div><div class="hw-value">' + data.baseClock + ' MHz</div></div>';
                    if(data.boostClock) html += '<div class="hw-item"><div class="hw-label">加速频率</div><div class="hw-value">' + data.boostClock + ' MHz</div></div>';
                    if(data.tdp) html += '<div class="hw-item"><div class="hw-label">TDP</div><div class="hw-value">' + data.tdp + ' W</div></div>';
                }
                else if(table === 'motherboard_info') {
                    if(data.chipset) html += '<div class="hw-item"><div class="hw-label">芯片组</div><div class="hw-value">' + data.chipset + '</div></div>';
                    if(data.cpuInterface) html += '<div class="hw-item"><div class="hw-label">CPU 接口</div><div class="hw-value">' + data.cpuInterface + '</div></div>';
                    if(data.memorySlots) html += '<div class="hw-item"><div class="hw-label">内存插槽</div><div class="hw-value">' + data.memorySlots + '</div></div>';
                    if(data.maxMemory) html += '<div class="hw-item"><div class="hw-label">最大内存</div><div class="hw-value">' + data.maxMemory + ' GB</div></div>';
                }

                if(html === '') html = '<p>暂无详细参数</p>';
                $('#hardwareDetailContent').html(html);
            },
            error: function() {
                $('#hardwareDetailContent').html('<p style="color:red; grid-column:1/-1; text-align:center;">加载失败</p>');
            }
        });
    });
</script>
</body>
</html>
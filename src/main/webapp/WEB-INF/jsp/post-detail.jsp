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
        /* ================= 全局重置 ================= */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei', sans-serif; background: #f6f6f6; color: #121212; line-height: 1.6; min-height: 100vh; }
        a { text-decoration: none; color: inherit; }
        ul { list-style: none; }

        /* ================= 顶部 Header (恢复原状) ================= */
        .header { background: #fff; box-shadow: 0 1px 3px rgba(0,0,0,0.1); position: sticky; top: 0; z-index: 1000; padding: 0 20px; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; height: 56px; }
        .logo { font-size: 22px; font-weight: 700; color: #0066ff; display: flex; align-items: center; gap: 8px; text-decoration: none; }
        .logo:hover { color: #0055dd; }
        .nav-links { display: flex; align-items: center; gap: 20px; }
        .nav-links a { color: #121212; text-decoration: none; font-size: 15px; padding: 8px 16px; border-radius: 20px; transition: all 0.3s ease; }
        .nav-links a:hover { background: #f0f0f0; color: #0066ff; }
        .nav-links .highlight { background: #0066ff; color: #fff; }
        .nav-links .highlight:hover { background: #0055dd; }

        /* ================= 主容器 ================= */
        .main-container { max-width: 1200px; margin: 20px auto; padding: 0 20px; display: grid; grid-template-columns: 1fr 320px; gap: 20px; }
        .left-column { display: flex; flex-direction: column; gap: 20px; }
        .right-column { display: flex; flex-direction: column; gap: 20px; }

        /* ================= 通用卡片与排版 ================= */
        h1 { font-size: 24px; font-weight: 700; color: #121212; margin-bottom: 20px; line-height: 1.4; }
        h2 { font-size: 18px; font-weight: 600; color: #121212; margin: 30px 0 15px 0; padding-left: 10px; border-left: 4px solid #0066ff; }
        h3 { font-size: 16px; font-weight: 600; color: #121212; margin-bottom: 15px; }

        .card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); overflow: hidden; margin-bottom: 20px; }
        .card-header { padding: 16px 20px; border-bottom: 1px solid #f0f0f0; display: flex; justify-content: space-between; align-items: center; }
        .card-title { font-size: 18px; font-weight: 600; color: #121212; display: flex; align-items: center; gap: 8px; }
        .card-body { padding: 16px 20px; }

        /* 帖子信息卡片 */
        .post-info-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 20px; margin-bottom: 20px; }
        .post-meta { display: flex; flex-wrap: wrap; gap: 16px; font-size: 14px; color: #8a8a8a; }
        .post-meta-item { display: flex; align-items: center; gap: 6px; }
        .post-meta-item strong { color: #121212; font-weight: 600; }
        .post-meta-item a { color: #0066ff; font-weight: 500; }
        .post-meta-item a:hover { text-decoration: underline; }
        .post-status.locked { color: #dc3545; font-weight: 600; background: #ffebee; padding: 2px 8px; border-radius: 4px; }

        /* 操作栏 */
        .post-actions { justify-content: center; align-items: center;display: flex; gap: 10px; margin-bottom: 20px; flex-wrap: wrap; background: #fff; padding: 15px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); align-items: center; }

        /* 游客提示样式 */
        .guest-action-tip {
            width: 100%;
            text-align: center;
            color: #666;
            font-size: 14px;
            padding: 10px 0;
        }
        .guest-action-tip a {
            color: #0066ff;
            font-weight: 600;
            margin: 0 5px;
        }
        .guest-action-tip a:hover {
            text-decoration: underline;
        }

        /* 按钮样式 (方正设计，知乎风格) */
        .btn, .action-btn, input[type="submit"] {
            padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; font-size: 14px; font-weight: 500; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px; text-decoration: none; color: #fff; box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .btn:hover, .action-btn:hover, input[type="submit"]:hover { opacity: 0.9; box-shadow: 0 2px 6px rgba(0,0,0,0.15); transform: translateY(-1px); }

        .btn-favorite { background: #f5a623; color: #fff; } /* 知乎黄/橙 */
        .btn-favorite.favorited { background: #e09600; }
        .btn-edit { background: #0066ff; } /* 品牌蓝 */
        .btn-delete, .action-btn.btn-delete, input[type="submit"].btn-delete { background: #d32f2f; } /* 警示红 */
        .btn-pin, .action-btn.btn-pin { background: #388e3c; } /* 成功绿 */
        .btn-unpin, .action-btn.btn-unpin { background: #757575; }
        .btn-lock, .action-btn.btn-lock { background: #0097a7; } /* 青色 */
        .btn-unlock, .action-btn.btn-unlock { background: #757575; }
        .btn-info { background: #1976d2; } /* 信息蓝 */
        .btn-primary { background: #0066ff; }

        /* 锁定提示 */
        .locked-post-message { background: #ffebee; border-left: 4px solid #dc3545; padding: 16px 20px; border-radius: 4px; margin-bottom: 20px; }
        .locked-post-message p { margin: 0; color: #c62828; font-size: 14px; font-weight: 500; }

        /* 帖子内容 (加粗，美观) */
        .post-content { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 24px; margin-bottom: 20px; line-height: 1.8; font-size: 16px; color: #1a1a1a; white-space: pre-wrap; word-wrap: break-word; font-weight: 500; }
        .post-content img { max-width: 100%; height: auto; margin: 16px 0; border-radius: 4px; }

        /* 硬件引用链接 (突出化) */
        .hardware-ref {
            display: inline-block;
            background-color: #e6f0ff;
            color: #0066ff;
            border: 1px solid #0066ff;
            padding: 2px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 0.9em;
            margin: 0 4px;
            text-decoration: none;
            transition: all 0.2s;
            cursor: pointer;
        }
        .hardware-ref:hover {
            background-color: #0066ff;
            color: #fff;
            box-shadow: 0 2px 4px rgba(0,102,255,0.3);
        }
        .hardware-loading {
            color: #999;
            font-style: italic;
            font-size: 0.9em;
            background: #f5f5f5;
            padding: 2px 8px;
            border-radius: 4px;
            border: 1px dashed #ddd;
        }

        /* 回复列表 */
        .reply-list { margin-bottom: 20px; }
        .reply-item { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 20px; margin-bottom: 16px; }
        .reply-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; padding-bottom: 12px; border-bottom: 1px solid #f0f0f0; flex-wrap: wrap; gap: 10px; }
        .reply-header p { margin: 0; font-size: 14px; color: #8a8a8a; display: flex; align-items: center; flex-wrap: wrap; gap: 8px; }
        .user-role { display: inline-block; padding: 2px 8px; border-radius: 4px; font-size: 12px; font-weight: 500; }
        .role-certified { background: #e6f7ed; color: #28a745; }
        .role-admin { background: #ffebee; color: #dc3545; }
        .role-regular { background: #f0f0f0; color: #666; }

        /* 回复内容 (标准字重，区别于帖子) */
        .reply-content-rendered { font-size: 15px; color: #333; line-height: 1.7; white-space: pre-wrap; font-weight: 400; }
        .reply-content-rendered img { max-width: 100%; height: auto; margin: 12px 0; border-radius: 4px; }
        .reply-actions { margin-top: 12px; padding-top: 12px; border-top: 1px solid #f0f0f0; text-align: right; }

        /* 回复表单 */
        .reply-form-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 24px; margin-bottom: 20px; }
        .form-group { margin-bottom: 16px; }
        .form-button-group { display: flex; gap: 10px; margin-bottom: 12px; flex-wrap: wrap; }
        #replyContent { width: 100%; padding: 12px 16px; border: 1px solid #e0e0e0; border-radius: 4px; font-size: 14px; resize: vertical; min-height: 120px; font-family: inherit; transition: all 0.3s ease; box-sizing: border-box; }
        #replyContent:focus { outline: none; border-color: #0066ff; box-shadow: 0 0 0 3px rgba(0,102,255,0.1); }
        .error { color: #dc3545; font-size: 13px; margin-top: 6px; }

        /* 字数限制样式 */
        .char-count {
            display: block;
            text-align: right;
            font-size: 12px;
            color: #999;
            margin-top: 5px;
            margin-bottom: 10px;
        }
        .char-count.limit-exceeded {
            color: #dc3545;
            font-weight: bold;
        }

        /* 分页 */
        .pagination { margin: 30px 0; text-align: center; padding: 20px; background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .pagination a, .pagination span.current-page { display: inline-block; padding: 8px 16px; margin: 0 4px; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.3s ease; }
        .pagination a { background: #fafafa; color: #121212; border: 1px solid #e0e0e0; }
        .pagination a:hover { background: #0066ff; color: #fff; border-color: #0066ff; }
        .pagination span.current-page { background: #0066ff; color: #fff; border: 1px solid #0066ff; }
        .page-info { margin-top: 15px; color: #8a8a8a; font-size: 13px; padding-top: 15px; border-top: 1px solid #f0f0f0; }

        /* 底部导航 */
        .page-footer { margin-top: 30px; display: flex; justify-content: center; gap: 15px; flex-wrap: wrap; padding: 20px; }
        .back-link { display: inline-block; padding: 10px 24px; background: #fff; color: #121212; text-decoration: none; border-radius: 4px; font-weight: 500; font-size: 14px; transition: all 0.3s ease; border: 1px solid #e0e0e0; }
        .back-link:hover { background: #f0f0f0; }

        /* 模态框 */
        .hardware-modal { display: none; position: fixed; z-index: 2000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); }
        .hardware-modal-content { background: #fff; margin: 5% auto; padding: 30px; border-radius: 8px; width: 90%; max-width: 600px; box-shadow: 0 10px 40px rgba(0,0,0,0.2); position: relative; max-height: 85vh; overflow-y: auto; }
        .hardware-modal-close { color: #8a8a8a; float: right; font-size: 32px; font-weight: bold; cursor: pointer; transition: all 0.3s ease; background: none; border: none; padding: 0; line-height: 1; }
        .hardware-modal-close:hover { color: #dc3545; transform: rotate(90deg); }
        .hardware-modal h3 { color: #121212; font-size: 20px; margin-bottom: 20px; font-weight: 600; border-bottom: 2px solid #f0f0f0; padding-bottom: 10px; }

        /* 硬件详情网格布局 */
        .hardware-detail-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            margin-top: 15px;
        }
        .hardware-detail-item {
            background: #f9f9f9;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #eee;
        }
        .hardware-detail-item strong {
            display: block;
            color: #555;
            font-size: 12px;
            margin-bottom: 4px;
        }
        .hardware-detail-item span {
            color: #0066ff;
            font-weight: 600;
            font-size: 14px;
        }
        .hardware-full-width {
            grid-column: 1 / -1;
        }

        /* 搜索结果项 */
        .search-result-item { padding: 10px; border-bottom: 1px solid #f0f0f0; cursor: pointer; transition: background 0.2s; }
        .search-result-item:hover { background: #f6f6f6; }

        /* ================= 用户卡片样式 ================= */
        .user-card { text-align: center; }
        .user-avatar { width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #0066ff 0%, #00ccff 100%); display: flex; align-items: center; justify-content: center; margin: 0 auto 12px; font-size: 36px; color: #fff; font-weight: 700; }
        .user-avatar-img { width: 80px; height: 80px; border-radius: 50%; object-fit: cover; margin: 0 auto 12px; border: 3px solid #f0f0f0; }
        .user-name { font-size: 18px; font-weight: 600; color: #121212; margin-bottom: 4px; }
        .user-role-badge { display: inline-block; padding: 2px 12px; background: #e6f0ff; color: #0066ff; border-radius: 12px; font-size: 12px; font-weight: 500; margin-bottom: 16px; }
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

        /* ================= 快捷入口样式 ================= */
        .quick-links { display: grid; grid-template-columns: repeat(2, 1fr); gap: 12px; }
        .quick-link { display: flex; flex-direction: column; align-items: center; padding: 16px; background: #fafafa; border-radius: 8px; text-decoration: none; color: #121212; transition: all 0.3s ease; text-align: center; }
        .quick-link:hover { background: #f0f0f0; transform: translateY(-2px); }
        .quick-link-icon { font-size: 28px; margin-bottom: 8px; }
        .quick-link-text { font-size: 14px; font-weight: 500; }

        /* 响应式 */
        @media (max-width: 900px) {
            .main-container { grid-template-columns: 1fr; }
            .right-column { order: -1; }
        }
        @media (max-width: 768px) {
            .header-content { flex-wrap: wrap; height: auto; padding: 10px 0; gap: 10px; }
            .nav-links { width: 100%; justify-content: center; }
            .post-actions { flex-direction: column; }
            .btn, .action-btn { width: 100%; justify-content: center; }
            .form-button-group { flex-direction: column; }
            .form-button-group .btn { width: 100%; }
            .hardware-detail-grid { grid-template-columns: 1fr; }
        }
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
    <!-- 左侧列：帖子详情内容 -->
    <div class="left-column">
        <h1>${fn:escapeXml(post.title)}</h1>

        <!-- 帖子信息卡片 -->
        <div class="post-info-card">
            <div class="post-meta">
                <span class="post-meta-item">
                    <strong>👤</strong> 作者：${fn:escapeXml(post.authorUsername)}
                </span>
                <span class="post-meta-item">
                    <strong>📅</strong> <fmt:formatDate value="${post.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                </span>
                <span class="post-meta-item">
                    <strong>💬</strong> 回复：${post.replyCount}
                </span>
                <span class="post-meta-item">
                    <strong>👁️</strong> 浏览：${post.viewCount}
                </span>
                <span class="post-meta-item">
                    <strong>📁</strong> 板块：<a href="${pageContext.request.contextPath}/forum/section/${post.sectionId}/posts">${fn:escapeXml(post.sectionName)}</a>
                </span>
                <c:if test="${post.isLocked}">
                    <span class="post-meta-item post-status locked">🔒 已锁定</span>
                </c:if>
            </div>
        </div>

        <!-- 帖子操作按钮区域 -->
        <div class="post-actions">
            <c:choose>
                <c:when test="${sessionScope.currentUser != null}">
                    <!-- 收藏按钮 -->
                    <button id="favoriteBtn" class="btn btn-favorite ${isFavorited ? 'favorited' : ''}" data-post-id="${post.id}">
                            ${isFavorited ? '⭐ 已收藏' : '⭐ 收藏'} (<span id="favoriteCount">${favoriteCount}</span>)
                    </button>

                    <!-- 编辑按钮 -->
                    <c:if test="${sessionScope.currentUser.id == post.userId}">
                        <a href="${pageContext.request.contextPath}/post/${post.id}/edit" class="btn btn-edit">✏️ 编辑</a>
                    </c:if>

                    <!-- 删除按钮 -->
                    <c:if test="${sessionScope.currentUser.id == post.userId || sessionScope.currentUser.role == 'ADMIN'}">
                        <form action="${pageContext.request.contextPath}/post/${post.id}/delete" method="post" style="display:inline;">
                            <input type="submit" value="🗑️ 删除" class="action-btn btn-delete" onclick="return confirm('确定要删除此帖子吗？删除后无法恢复！');">
                        </form>
                    </c:if>

                    <!-- 管理员操作 -->
                    <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                        <c:if test="${post.pinLevel > 0}">
                            <form action="${pageContext.request.contextPath}/post/${post.id}/unpin" method="post" style="display:inline;">
                                <input type="submit" value="📌 取消置顶" class="action-btn btn-unpin">
                            </form>
                        </c:if>
                        <c:if test="${post.pinLevel == 0}">
                            <form action="${pageContext.request.contextPath}/post/${post.id}/pin" method="post" style="display:inline;">
                                <input type="hidden" name="level" value="1">
                                <input type="submit" value="📌 置顶" class="action-btn btn-pin">
                            </form>
                        </c:if>
                        <c:if test="${post.isLocked}">
                            <form action="${pageContext.request.contextPath}/post/${post.id}/unlock" method="post" style="display:inline;">
                                <input type="submit" value="🔓 解锁" class="action-btn btn-unlock">
                            </form>
                        </c:if>
                        <c:if test="${!post.isLocked}">
                            <form action="${pageContext.request.contextPath}/post/${post.id}/lock" method="post" style="display:inline;">
                                <input type="submit" value="🔒 锁定" class="action-btn btn-lock">
                            </form>
                        </c:if>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <!-- 游客提示 -->
                    <div class="guest-action-tip">
                        登录后即可收藏、编辑或管理帖子 <a href="${pageContext.request.contextPath}/user/login">立即登录</a> 或 <a href="${pageContext.request.contextPath}/user/register">免费注册</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div><br>

        <!-- 锁定提示 -->
        <c:if test="${post.isLocked}">
            <div class="locked-post-message">
                <p><strong>🔒 此帖子已被锁定</strong>，只有管理员可以进行回复操作。</p>
            </div>
        </c:if>

        <!-- 帖子内容 (确保游客可见) -->
        <div class="post-content">
            <div id="postContentRaw" style="display: none;">${post.content}</div>
            <div id="postContentRendered"></div>
        </div>

        <!-- 回复列表 -->
        <div class="reply-list">
            <h2>💬 回复 (<c:out value="${totalReplies}"/>)</h2>
            <c:choose>
                <c:when test="${not empty replies}">
                    <ul id="repliesList">
                        <c:forEach items="${replies}" var="reply" varStatus="status">
                            <li class="reply-item" id="reply-${reply.id}">
                                <div class="reply-header">
                                    <p>👤 用户：${fn:escapeXml(reply.authorUsername)}
                                        <c:if test="${reply.authorRole == 'CERTIFIED'}">
                                            <span class="user-role role-certified">[认证用户]</span>
                                        </c:if>
                                        <c:if test="${reply.authorRole == 'ADMIN'}">
                                            <span class="user-role role-admin">[管理员]</span>
                                        </c:if>
                                        <c:if test="${reply.authorRole == 'USER' || reply.authorRole == null}">
                                            <span class="user-role role-regular">[普通用户]</span>
                                        </c:if>
                                        📅 时间：<fmt:formatDate value="${reply.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </p>
                                </div>
                                <div class="reply-content">
                                    <div class="reply-content-raw" style="display: none;">${reply.content}</div>
                                    <div class="reply-content-rendered"></div>
                                </div>
                                <c:if test="${sessionScope.currentUser != null && sessionScope.currentUser.id == reply.userId}">
                                    <div class="reply-actions">
                                        <button class="btn btn-primary delete-reply-btn" data-reply-id="${reply.id}">🗑️ 删除</button>
                                    </div>
                                </c:if>
                            </li>
                        </c:forEach>
                    </ul>

                    <!-- 分页 -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <c:if test="${pageNum > 1}">
                                <a href="${pageContext.request.contextPath}/post/${post.id}?pageNum=${pageNum - 1}&pageSize=6">&laquo; <span class="page-text">上一页</span></a>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i eq pageNum}">
                                        <span class="current-page">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/post/${post.id}?pageNum=${i}&pageSize=6">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <c:if test="${pageNum < totalPages}">
                                <a href="${pageContext.request.contextPath}/post/${post.id}?pageNum=${pageNum + 1}&pageSize=6"><span class="page-text">下一页</span> &raquo;</a>
                            </c:if>
                            <div class="page-info">
                                <strong>第 ${pageNum} 页</strong> / 共 <strong>${totalPages} 页</strong> (共 <strong>${totalReplies} 条</strong> 回复)
                            </div>
                        </div>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <p>暂无回复。</p>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 回复表单 (仅登录用户可见) -->
        <c:choose>
            <c:when test="${post.isLocked && (!sessionScope.currentUser.role.equals('ADMIN'))}">
                <div class="locked-post-message">
                    <p>此帖子已被锁定，只有管理员可以回复。</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:if test="${sessionScope.currentUser != null}">
                    <div class="reply-form-card">
                        <h3>💬 发表回复</h3>
                        <form:form action="${pageContext.request.contextPath}/post/${post.id}/reply" method="post" modelAttribute="reply" onsubmit="return validateReplyLength()">
                            <form:hidden path="postId" value="${post.id}"/>
                            <form:hidden path="userId" value="${sessionScope.currentUser.id}"/>
                            <div class="form-group">
                                <div class="form-button-group">
                                    <button type="button" id="replyUploadBtn" class="btn btn-info">📝 上传图片</button>
                                    <input type="file" id="replyImageFileInput" accept="image/*" style="display:none;">
                                    <c:if test="${sessionScope.currentUser.role == 'CERTIFIED' || sessionScope.currentUser.role == 'ADMIN'}">
                                        <button type="button" id="replyInsertReferenceBtn" class="btn btn-info">📊 插入硬件引用</button>
                                    </c:if>
                                </div><br>
                                <form:textarea path="content" id="replyContent" rows="5" cols="50" required="required" oninput="updateCharCount()"/><br>
                                <span id="replyCharCount" class="char-count">0 / 1000</span>
                                <form:errors path="content" cssClass="error" /><br>
                                <input type="submit" value="✅ 回复" class="btn btn-primary">
                            </div>
                        </form:form>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>

        <!-- 底部导航 -->
        <div class="page-footer">
            <a href="${pageContext.request.contextPath}/forum/section/${post.sectionId}/posts" class="back-link">📁 返回帖子列表</a>
            <a href="${pageContext.request.contextPath}/" class="back-link">🏠 返回首页</a>
        </div>

        <!-- 硬件详情模态框 -->
        <div id="hardwareModal" class="hardware-modal">
            <div class="hardware-modal-content">
                <span class="hardware-modal-close">&times;</span>
                <h3>📊 硬件详情</h3>
                <div id="hardwareDetailContent" class="hardware-detail"></div>
            </div>
        </div>

        <!-- 硬件搜索模态框 -->
        <div id="replyHardwareModal" class="hardware-modal">
            <div class="hardware-modal-content">
                <span class="hardware-modal-close">&times;</span>
                <h3>📊 选择硬件</h3>
                <select id="replyHardwareTypeSelect" style="width: 100%; padding: 10px; margin-bottom: 10px; border: 1px solid #e0e0e0; border-radius: 4px;">
                    <option value="cpu_info">CPU</option>
                    <option value="gpu_info">GPU</option>
                    <option value="motherboard_info">主板</option>
                </select>
                <input type="text" id="replyHardwareSearch" placeholder="搜索硬件型号..." style="width: 100%; padding: 10px; margin-bottom: 10px; border: 1px solid #e0e0e0; border-radius: 4px;">
                <div id="replyHardwareList"></div>
            </div>
        </div>
    </div>

    <!-- 右侧列：用户信息和快捷入口 -->
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
                            <c:when test="${currentUser.role == 'ADMIN'}"><span class="user-role-badge">👑 管理员</span></c:when>
                            <c:when test="${currentUser.role == 'CERTIFIED'}"><span class="user-role-badge">✅ 认证用户</span></c:when>
                            <c:otherwise><span class="user-role-badge">👤 普通用户</span></c:otherwise>
                        </c:choose>
                        <div class="user-stats">
                            <div class="stat-item"><span class="stat-value">${postCount != null ? postCount : 0}</span><div class="stat-label">发帖数</div></div>
                            <div class="stat-item"><span class="stat-value">${replyCount != null ? replyCount : 0}</span><div class="stat-label">回复数</div></div>
                            <div class="stat-item"><span class="stat-value">${userFavoriteCount != null ? userFavoriteCount : 0}</span><div class="stat-label">收藏数</div></div>
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

<script>
    $(document).ready(function() {
        console.log("Detail Document ready fired");

        // 1. 渲染帖子内容 (确保对所有用户执行)
        var postContentRaw = $('#postContentRaw').text();
        // 简单解码防止双重转义
        postContentRaw = postContentRaw.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&amp;/g, '&').replace(/&quot;/g, '"');
        var postContentRendered = renderContentWithReferences(postContentRaw);
        $('#postContentRendered').html(postContentRendered);

        // 2. 渲染回复内容
        $('.reply-content-raw').each(function() {
            var rawContent = $(this).text();
            rawContent = rawContent.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&amp;/g, '&').replace(/&quot;/g, '"');
            var renderedContent = renderContentWithReferences(rawContent);
            $(this).next('.reply-content-rendered').html(renderedContent);
        });

        // 3. 删除回复功能
        $(document).on('click', '.delete-reply-btn', function() {
            var replyId = $(this).data('reply-id');
            if (confirm('确定要删除这条回复吗？')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/reply/' + replyId,
                    type: 'DELETE',
                    success: function(response) {
                        if (response === 'success') {
                            $('#reply-' + replyId).fadeOut('fast', function() { $(this).remove(); });
                        } else {
                            alert('删除回复失败：' + response);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Delete reply failed:", status, error);
                        alert('删除请求失败，请检查网络或稍后重试。');
                    }
                });
            }
        });

        // 4. 收藏功能
        $("#favoriteBtn").click(function() {
            var postId = $(this).data("post-id");
            var button = $(this);
            var isCurrentlyFavorited = button.hasClass("favorited");

            $.post("${pageContext.request.contextPath}/post/" + postId + "/toggle-favorite",
                function(response) {
                    if(response.success) {
                        if(!isCurrentlyFavorited) {
                            button.addClass("favorited");
                            button.html('⭐ 已收藏 (<span id="favoriteCount">' + response.favoriteCount + '</span>)');
                        } else {
                            button.removeClass("favorited");
                            button.html('⭐ 收藏 (<span id="favoriteCount">' + response.favoriteCount + '</span>)');
                        }
                    } else {
                        alert('操作失败：' + response.message);
                    }
                }).fail(function() {
                alert('网络错误，收藏操作失败');
            });
        });

        // 5. 硬件引用搜索功能
        var replyHardwareModal = $('#replyHardwareModal');
        var replyHardwareModalClose = replyHardwareModal.find('.hardware-modal-close');
        var replyHardwareSearchInput = $('#replyHardwareSearch');
        var replyHardwareTypeSelect = $('#replyHardwareTypeSelect');
        var replyHardwareSearchList = $('#replyHardwareList');

        $('#replyInsertReferenceBtn').click(function() {
            replyHardwareModal.show();
            replyHardwareSearchInput.val('');
            replyHardwareTypeSelect.val('cpu_info');
            replyHardwareSearchList.empty();
            replyHardwareSearchInput.focus();
        });

        replyHardwareModalClose.click(function() {
            replyHardwareModal.hide();
        });

        $(window).click(function(event) {
            if (event.target === replyHardwareModal[0]) {
                replyHardwareModal.hide();
            }
        });

        replyHardwareSearchInput.on('input', function() {
            var keyword = $(this).val().trim();
            var table = replyHardwareTypeSelect.val();

            if (keyword.length >= 1 && table) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/hardware/search',
                    type: 'GET',
                    data: { term: keyword, table: table },
                    success: function(data) {
                        replyHardwareSearchList.empty();
                        if (data && data.length > 0) {
                            data.forEach(function(item) {
                                var displayName = (item.brand ? item.brand + ' ' : '') + item.model;
                                var itemDiv = $('<div class="search-result-item" data-id="' + item.id + '">' + displayName + '</div>');
                                itemDiv.click(function() {
                                    var id = $(this).data('id');
                                    var table = replyHardwareTypeSelect.val();
                                    var referenceText = '[' + table + ':' + id + ']';
                                    insertTextAtCursor($('#replyContent'), referenceText);
                                    replyHardwareModal.hide();
                                });
                                replyHardwareSearchList.append(itemDiv);
                            });
                        } else {
                            replyHardwareSearchList.append('<div class="search-result-item">未找到匹配项</div>');
                        }
                        replyHardwareSearchList.show();
                    },
                    error: function(xhr, status, error) {
                        console.error("Hardware search failed:", status, error);
                        replyHardwareSearchList.html('<div class="search-result-item">搜索失败：' + error + '</div>');
                    }
                });
            } else {
                replyHardwareSearchList.empty().hide();
            }
        });

        // 6. 图片上传功能
        $('#replyUploadBtn').click(function() {
            $('#replyImageFileInput').click();
        });

        $('#replyImageFileInput').change(function() {
            var file = this.files[0];
            if (file) {
                if (!file.type.startsWith('image/')) {
                    alert('请选择图片文件！');
                    return;
                }
                var maxSize = 5 * 1024 * 1024;
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
                        if (response.success) {
                            var imageUrl = response.url;
                            insertTextAtCursor($('#replyContent'), '![](' + imageUrl + ')');
                            $('#replyImageFileInput').val('');
                        } else {
                            alert('上传失败：' + response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Upload error:", status, error);
                        alert('上传请求失败，请检查网络或服务器状态。');
                    }
                });
            }
        });

        // 7. 硬件详情模态框关闭
        $('.hardware-modal-close').click(function() {
            $('#hardwareModal').hide();
        });
        $(window).click(function(event) {
            if (event.target === document.getElementById('hardwareModal')) {
                $('#hardwareModal').hide();
            }
        });

        // 8. 渲染辅助函数
        function renderContentWithReferences(text) {
            if(!text) return '';
            var paragraphs = text.split(/\n\s*\n/);
            var processedParagraphs = [];
            for (var i = 0; i < paragraphs.length; i++) {
                var para = paragraphs[i].trim();
                if (para) {
                    para = para.replace(/\n/g, '<br>');
                    processedParagraphs.push('<p>' + para + '</p>');
                }
            }
            if (processedParagraphs.length === 0) return '';
            var textWithParagraphs = processedParagraphs.join('');

            var imageRegex = /!\[([^\]]*)\]\(([^)]+)\)/g;
            textWithParagraphs = textWithParagraphs.replace(imageRegex, function(match, alt, url) {
                if (url.startsWith('${pageContext.request.contextPath}/uploads/') || url.startsWith('http')) {
                    return '<img src="' + url + '" alt="' + (alt || 'Image') + '" style="max-width: 100%; height: auto; display: block; margin: 15px 0;">';
                } else {
                    return match;
                }
            });

            var referenceRegex = /\[([a-zA-Z_]+):(\d+)\]/g;
            var hardwareRefs = [];
            textWithParagraphs = textWithParagraphs.replace(referenceRegex, function(match, table, id) {
                if (isValidTableName(table)) {
                    hardwareRefs.push({table: table, id: id, match: match});
                    return '<span class="hardware-loading" data-table="' + table + '" data-id="' + id + '">加载中...</span>';
                } else {
                    return match;
                }
            });

            if (hardwareRefs.length > 0) {
                setTimeout(function() {
                    hardwareRefs.forEach(function(ref) {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/api/hardware/detail/' + ref.table + '/' + ref.id,
                            type: 'GET',
                            success: function(data) {
                                var displayText = (data.brand || '') + ' ' + (data.model || '');
                                var linkHtml = '<a href="#" class="hardware-ref" data-table="' + ref.table + '" data-id="' + ref.id + '">' + displayText + '</a>';
                                $('.hardware-loading[data-table="' + ref.table + '"][data-id="' + ref.id + '"]').replaceWith(linkHtml);
                            },
                            error: function() {
                                $('.hardware-loading[data-table="' + ref.table + '"][data-id="' + ref.id + '"]').text('硬件信息不可用');
                            }
                        });
                    });
                }, 0);
            }

            return textWithParagraphs;
        }

        function isValidTableName(tableName) {
            var validTables = ["cpu_info", "gpu_info", "motherboard_info"];
            return validTables.includes(tableName);
        }

        function getHardwareTypeName(tableName) {
            var typeNames = {
                "cpu_info": "CPU",
                "gpu_info": "显卡",
                "motherboard_info": "主板"
            };
            return typeNames[tableName] || "硬件";
        }

        function insertTextAtCursor(textarea, text) {
            var start = textarea[0].selectionStart;
            var end = textarea[0].selectionEnd;
            var content = textarea.val();
            var newContent = content.substring(0, start) + text + content.substring(end);
            textarea.val(newContent);
            textarea[0].selectionStart = textarea[0].selectionEnd = start + text.length;
            textarea.focus();
        }

        // 9. 点击硬件链接显示详情 (包含核显和发布信息)
        $(document).on('click', '.hardware-ref', function(e) {
            e.preventDefault();
            var table = $(this).data('table');
            var id = $(this).data('id');
            $('#hardwareModal').show();
            $('#hardwareDetailContent').html('<p>加载中...</p>');

            $.ajax({
                url: '${pageContext.request.contextPath}/api/hardware/detail/' + table + '/' + id,
                type: 'GET',
                success: function(data) {
                    var displayTitle = (data.brand || '') + ' ' + (data.model || '');
                    var detailHtml = '<h3>' + displayTitle + '</h3><hr>';

                    detailHtml += '<div class="hardware-detail-grid">';

                    if (table === 'cpu_info') {
                        detailHtml += '<div class="hardware-detail-item"><strong>接口类型</strong><span>' + (data.interfaceType || '-') + '</span></div>';
                        detailHtml += '<div class="hardware-detail-item"><strong>核心数</strong><span>' + (data.cores || '-') + '</span></div>';
                        detailHtml += '<div class="hardware-detail-item"><strong>线程数</strong><span>' + (data.threads || '-') + '</span></div>';
                        detailHtml += '<div class="hardware-detail-item"><strong>基础频率</strong><span>' + (data.baseFrequency || '-') + ' GHz</span></div>';
                        detailHtml += '<div class="hardware-detail-item"><strong>最大频率</strong><span>' + (data.maxFrequency || '-') + ' GHz</span></div>';
                        detailHtml += '<div class="hardware-detail-item"><strong>TDP</strong><span>' + (data.tdp || '-') + ' W</span></div>';
                        detailHtml += '<div class="hardware-detail-item"><strong>核显</strong><span>' + (data.integratedGraphics || '无') + '</span></div>';
                    } else if (table === 'gpu_info') {
                        detailHtml += '<div class="hardware-detail-item"><strong>显存容量</strong><span>' + (data.memorySize || '-') + ' GB</span></div>';
                        detailHtml += '<div class="hardware-detail-item"><strong>显存类型</strong><span>' + (data.memoryType || '-') + '</span></div>';
                        detailHtml += '<div class="hardware-detail-item"><strong>基础频率</strong><span>' + (data.baseClock || '-') + ' MHz</span></div>';
                        detailHtml += '<div class="hardware-detail-item"><strong>加速频率</strong><span>' + (data.boostClock || '-') + ' MHz</span></div>';
                        detailHtml += '<div class="hardware-detail-item"><strong>TDP</strong><span>' + (data.tdp || '-') + ' W</span></div>';
                    } else if (table === 'motherboard_info') {
                        detailHtml += '<div class="hardware-detail-item"><strong>芯片组</strong><span>' + (data.chipset || '-') + '</span></div>';
                        detailHtml += '<div class="hardware-detail-item"><strong>CPU 接口</strong><span>' + (data.cpuInterface || '-') + '</span></div>';
                        detailHtml += '<div class="hardware-detail-item"><strong>内存插槽</strong><span>' + (data.memorySlots || '-') + '</span></div>';
                        detailHtml += '<div class="hardware-detail-item"><strong>最大内存</strong><span>' + (data.maxMemory || '-') + ' GB</span></div>';
                        detailHtml += '<div class="hardware-detail-item"><strong>内存类型</strong><span>' + (data.memoryType || '-') + '</span></div>';
                    }

                    detailHtml += '</div>'; // Close grid
                    $('#hardwareDetailContent').html(detailHtml);
                },
                error: function(xhr, status, error) {
                    $('#hardwareDetailContent').html('<p>获取硬件详情失败：' + error + '</p>');
                }
            });
        });
    });

    // 字数统计与验证函数
    function updateCharCount() {
        var textarea = document.getElementById('replyContent');
        var countSpan = document.getElementById('replyCharCount');
        var currentLength = textarea.value.length;
        var maxLength = 1000;

        countSpan.textContent = currentLength + ' / ' + maxLength;

        if (currentLength > maxLength) {
            countSpan.classList.add('limit-exceeded');
        } else {
            countSpan.classList.remove('limit-exceeded');
        }
    }

    function validateReplyLength() {
        var textarea = document.getElementById('replyContent');
        var currentLength = textarea.value.length;
        var maxLength = 1000;

        if (currentLength === 0) {
            alert('回复内容不能为空！');
            return false;
        }
        if (currentLength > maxLength) {
            alert('回复内容过长，请控制在 ' + maxLength + ' 字以内！');
            return false;
        }
        return true;
    }
</script>
</body>
</html>
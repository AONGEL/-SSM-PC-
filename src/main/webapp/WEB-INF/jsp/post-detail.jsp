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
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Helvetica Neue', 'Microsoft YaHei', sans-serif; background: #f6f6f6; color: #121212; line-height: 1.6; }
        a { text-decoration: none; color: inherit; cursor: pointer; }
        ul { list-style: none; }
        button { font-family: inherit; }

        /* ================= 顶部 Header (知乎风格) ================= */
        .header { background: #fff; box-shadow: 0 1px 3px rgba(0,0,0,0.1); position: sticky; top: 0; z-index: 1000; height: 52px; display: flex; align-items: center; }
        .header-content { max-width: 1100px; margin: 0 auto; width: 100%; padding: 0 15px; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 20px; font-weight: 700; color: #0066ff; display: flex; align-items: center; gap: 6px; }
        .nav-links { display: flex; gap: 4px; }
        .nav-links a { color: #252933; font-size: 14px; padding: 6px 12px; border-radius: 4px; transition: background 0.2s; font-weight: 500; }
        .nav-links a:hover { background: #f6f6f6; }
        .nav-links .highlight { background: #0066ff; color: #fff; }
        .nav-links .highlight:hover { background: #0055dd; }

        /* ================= 主容器 ================= */
        .main-container { max-width: 1100px; margin: 20px auto; padding: 0 15px; display: flex; gap: 20px; }
        .content-column { flex: 1; min-width: 0; }

        /* ================= 卡片通用样式 ================= */
        .card { background: #fff; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin-bottom: 15px; border: 1px solid #e9e9e9; }
        .card-body { padding: 20px; }

        /* ================= 帖子头部区域 ================= */
        .post-title { font-size: 22px; font-weight: 700; color: #121212; line-height: 1.4; margin-bottom: 12px; word-break: break-word; }

        .post-meta { display: flex; align-items: center; gap: 12px; font-size: 13px; color: #8a8a8a; margin-bottom: 16px; }
        .meta-item { display: flex; align-items: center; gap: 4px; }
        .meta-link { color: #0066ff; font-weight: 500; }
        .meta-link:hover { text-decoration: underline; }
        .status-badge { background: #ffebee; color: #dc3545; padding: 2px 8px; border-radius: 10px; font-size: 12px; font-weight: 600; }

        /* ================= 操作工具栏 (知乎风格布局) ================= */
        .action-toolbar { display: flex; justify-content: space-between; align-items: center; padding: 12px 20px; background: #fafafa; border-top: 1px solid #f0f0f0; border-bottom: 1px solid #f0f0f0; margin: 0 -20px 20px -20px; }

        .toolbar-left, .toolbar-right { display: flex; gap: 8px; align-items: center; }

        .btn-tool { display: inline-flex; align-items: center; gap: 6px; padding: 6px 12px; border-radius: 4px; font-size: 13px; font-weight: 500; cursor: pointer; transition: all 0.2s; border: 1px solid transparent; background: transparent; color: #252933; }
        .btn-tool:hover { background: #f0f0f0; }
        .btn-tool svg { width: 16px; height: 16px; fill: currentColor; }

        .btn-fav { color: #b5b5b5; }
        .btn-fav.active { color: #f5a623; background: #fff8e6; }
        .btn-fav.active:hover { background: #fff3d6; }

        .btn-primary-sm { background: #0066ff; color: #fff; }
        .btn-primary-sm:hover { background: #0055dd; }

        .btn-danger-sm { color: #dc3545; }
        .btn-danger-sm:hover { background: #ffebee; }

        .btn-admin-sm { color: #252933; border: 1px solid #ddd; background: #fff; }
        .btn-admin-sm:hover { border-color: #bbb; background: #f6f6f6; }

        form.d-inline { display: inline; }

        /* ================= 帖子正文 ================= */
        .post-content { font-size: 16px; line-height: 1.8; color: #121212; white-space: pre-wrap; word-wrap: break-word; }
        .post-content img { max-width: 100%; height: auto; border-radius: 4px; margin: 16px 0; box-shadow: 0 2px 8px rgba(0,0,0,0.05); }
        .post-content p { margin-bottom: 16px; }

        /* ================= 回复列表 ================= */
        .section-header { font-size: 16px; font-weight: 700; color: #121212; margin: 24px 0 16px 0; display: flex; align-items: center; gap: 8px; }
        .reply-count { color: #8a8a8a; font-weight: 400; font-size: 14px; }

        .reply-item { border-bottom: 1px solid #f0f0f0; padding: 20px 0; }
        .reply-item:last-child { border-bottom: none; }

        .reply-header { display: flex; justify-content: space-between; margin-bottom: 10px; }
        .reply-author-line { display: flex; align-items: center; gap: 8px; font-size: 14px; }
        .author-name { font-weight: 600; color: #252933; }
        .role-tag { font-size: 12px; padding: 1px 6px; border-radius: 3px; background: #f0f0f0; color: #666; }
        .role-cert { background: #e6f7ed; color: #28a745; }
        .role-admin { background: #ffebee; color: #dc3545; }
        .reply-time { font-size: 13px; color: #8a8a8a; }

        .reply-body { font-size: 15px; line-height: 1.7; color: #121212; white-space: pre-wrap; }
        .reply-body img { max-width: 100%; border-radius: 4px; margin-top: 10px; }

        .reply-actions { margin-top: 10px; display: flex; gap: 15px; }
        .action-link { font-size: 13px; color: #8a8a8a; cursor: pointer; background: none; border: none; padding: 0; }
        .action-link:hover { color: #0066ff; }
        .action-link.delete { color: #dc3545; }

        /* ================= 回复表单 ================= */
        .reply-editor { margin-top: 20px; }
        .editor-toolbar { display: flex; gap: 8px; margin-bottom: 10px; }
        .btn-upload { background: #f6f6f6; border: 1px solid #ddd; color: #252933; padding: 6px 12px; border-radius: 4px; font-size: 13px; cursor: pointer; }
        .btn-upload:hover { background: #e9e9e9; }

        textarea.editor-input { width: 100%; min-height: 120px; padding: 12px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; resize: vertical; outline: none; font-family: inherit; }
        textarea.editor-input:focus { border-color: #0066ff; box-shadow: 0 0 0 2px rgba(0,102,255,0.1); }

        .submit-row { margin-top: 12px; text-align: right; }
        .btn-submit { background: #0066ff; color: #fff; border: none; padding: 8px 24px; border-radius: 4px; font-size: 14px; font-weight: 600; cursor: pointer; }
        .btn-submit:hover { background: #0055dd; }
        .error-msg { color: #dc3545; font-size: 13px; margin-top: 6px; }

        /* ================= 分页 ================= */
        .pagination { display: flex; justify-content: center; gap: 8px; margin: 30px 0; }
        .page-item { display: inline-block; padding: 6px 12px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; color: #252933; background: #fff; }
        .page-item:hover { border-color: #0066ff; color: #0066ff; }
        .page-item.active { background: #0066ff; color: #fff; border-color: #0066ff; }

        /* ================= 硬件引用链接 ================= */
        .hardware-ref { color: #0066ff; background: #e6f0ff; padding: 2px 6px; border-radius: 3px; font-size: 0.9em; font-weight: 500; display: inline-block; margin: 0 2px; }
        .hardware-ref:hover { background: #cce0ff; text-decoration: none; }

        /* ================= 模态框 (恢复完整样式) ================= */
        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 2000; align-items: center; justify-content: center; }
        .modal-panel { background: #fff; width: 90%; max-width: 600px; border-radius: 8px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); position: relative; animation: slideUp 0.3s ease; max-height: 90vh; overflow-y: auto; }
        @keyframes slideUp { from { transform: translateY(20px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }

        .modal-header { padding: 20px; border-bottom: 1px solid #f0f0f0; display: flex; justify-content: space-between; align-items: center; }
        .modal-title { font-size: 18px; font-weight: 700; color: #121212; }
        .modal-close { font-size: 24px; color: #8a8a8a; cursor: pointer; background: none; border: none; line-height: 1; }
        .modal-close:hover { color: #121212; }

        .modal-body { padding: 20px; }
        .hw-detail-grid { display: grid; grid-template-columns: 1fr; gap: 12px; }
        .hw-row { display: flex; font-size: 14px; border-bottom: 1px dashed #f0f0f0; padding-bottom: 8px; }
        .hw-row:last-child { border-bottom: none; }
        .hw-label { width: 100px; color: #8a8a8a; flex-shrink: 0; }
        .hw-value { color: #121212; font-weight: 500; word-break: break-all; }

        .search-box { margin-bottom: 15px; }
        .search-select, .search-input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; margin-bottom: 10px; font-size: 14px; }
        .search-list { max-height: 300px; overflow-y: auto; border: 1px solid #f0f0f0; border-radius: 4px; }
        .search-item { padding: 10px; border-bottom: 1px solid #f9f9f9; cursor: pointer; transition: background 0.2s; }
        .search-item:hover { background: #f6f6f6; }
        .search-item strong { color: #121212; }
        .search-item span { color: #8a8a8a; font-size: 13px; margin-left: 8px; }

        /* 响应式 */
        @media (max-width: 768px) {
            .action-toolbar { flex-direction: column; gap: 10px; align-items: stretch; }
            .toolbar-left, .toolbar-right { justify-content: space-between; }
            .nav-links { display: none; } /* 移动端简化 */
        }
    </style>
</head>
<body>

<!-- 顶部 Header -->
<header class="header">
    <div class="header-content">
        <a href="${pageContext.request.contextPath}/" class="logo">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z"/></svg>
            PC 硬件论坛
        </a>
        <nav class="nav-links">
            <a href="${pageContext.request.contextPath}/forum/section">论坛分区</a>
            <a href="${pageContext.request.contextPath}/hardware-library">硬件参数库</a>
            <c:choose>
                <c:when test="${not empty sessionScope.currentUser}">
                    <a href="${pageContext.request.contextPath}/user/notifications">消息</a>
                    <a href="${pageContext.request.contextPath}/user/profile" class="highlight">个人中心</a>
                    <a href="${pageContext.request.contextPath}/user/logout">退出</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/login">登录</a>
                    <a href="${pageContext.request.contextPath}/user/register" class="highlight">注册</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </div>
</header>

<div class="main-container">
    <div class="content-column">

        <!-- 帖子卡片 -->
        <div class="card">
            <div class="card-body">
                <h1 class="post-title">${fn:escapeXml(post.title)}</h1>

                <div class="post-meta">
                    <span class="meta-item">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/></svg>
                        ${fn:escapeXml(post.authorUsername)}
                    </span>
                    <span class="meta-item">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><path d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm.5-13H11v6l5.25 3.15.75-1.23-4.5-2.67z"/></svg>
                        <fmt:formatDate value="${post.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                    </span>
                    <span class="meta-item">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><path d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z"/></svg>
                        ${post.viewCount} 浏览
                    </span>
                    <span class="meta-item">
                        📁 <a href="${pageContext.request.contextPath}/forum/section/${post.sectionId}/posts" class="meta-link">${fn:escapeXml(post.sectionName)}</a>
                    </span>
                    <c:if test="${post.isLocked}">
                        <span class="status-badge">🔒 已锁定</span>
                    </c:if>
                </div>

                <!-- 操作工具栏 -->
                <div class="action-toolbar">
                    <div class="toolbar-left">
                        <c:if test="${not empty sessionScope.currentUser}">
                            <button id="favoriteBtn" class="btn-tool btn-fav ${isFavorited ? 'active' : ''}" onclick="toggleFavorite(${post.id})">
                                <svg viewBox="0 0 24 24"><path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg>
                                    ${isFavorited ? '已收藏' : '收藏'} <span style="margin-left:4px; opacity:0.7;">(${favoriteCount})</span>
                            </button>
                        </c:if>
                    </div>

                    <div class="toolbar-right">
                        <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.id == post.userId}">
                            <a href="${pageContext.request.contextPath}/post/${post.id}/edit" class="btn-tool btn-primary-sm">
                                <svg viewBox="0 0 24 24"><path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"/></svg>
                                编辑
                            </a>
                            <form action="${pageContext.request.contextPath}/post/${post.id}/delete" method="post" class="d-inline">
                                <input type="submit" value="删除" class="btn-tool btn-danger-sm" onclick="return confirm('确定删除？');"/>
                            </form>
                        </c:if>

                        <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.role == 'ADMIN'}">
                            <c:if test="${post.pinLevel > 0}">
                                <form action="${pageContext.request.contextPath}/post/${post.id}/unpin" method="post" class="d-inline">
                                    <input type="submit" value="取消置顶" class="btn-tool btn-admin-sm"/>
                                </form>
                            </c:if>
                            <c:if test="${post.pinLevel == 0}">
                                <form action="${pageContext.request.contextPath}/post/${post.id}/pin" method="post" class="d-inline">
                                    <input type="hidden" name="level" value="1"/>
                                    <input type="submit" value="置顶" class="btn-tool btn-admin-sm"/>
                                </form>
                            </c:if>
                            <c:if test="${post.isLocked}">
                                <form action="${pageContext.request.contextPath}/post/${post.id}/unlock" method="post" class="d-inline">
                                    <input type="submit" value="解锁" class="btn-tool btn-admin-sm"/>
                                </form>
                            </c:if>
                            <c:if test="${!post.isLocked}">
                                <form action="${pageContext.request.contextPath}/post/${post.id}/lock" method="post" class="d-inline">
                                    <input type="submit" value="锁定" class="btn-tool btn-admin-sm"/>
                                </form>
                            </c:if>
                        </c:if>

                        <a href="${pageContext.request.contextPath}/forum/section/${post.sectionId}/posts" class="btn-tool">
                            <svg viewBox="0 0 24 24"><path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"/></svg>
                            返回列表
                        </a>
                    </div>
                </div>

                <c:if test="${post.isLocked}">
                    <div style="background:#fff8e6; color:#b57f00; padding:12px; border-radius:4px; margin-bottom:20px; font-size:14px; border:1px solid #ffe58f;">
                        ⚠️ 此帖子已被管理员锁定，禁止普通用户回复。
                    </div>
                </c:if>

                <!-- 帖子内容 -->
                <div class="post-content">
                    <div id="postContentRaw" style="display:none;">${post.content}</div>
                    <div id="postContentRendered"></div>
                </div>
            </div>
        </div>

        <!-- 回复区域 -->
        <div class="section-header">
            回复 <span class="reply-count">(<c:out value="${totalReplies}"/>)</span>
        </div>

        <div class="card">
            <div class="card-body" style="padding: 0 20px;">
                <c:choose>
                    <c:when test="${not empty replies}">
                        <ul id="repliesList">
                            <c:forEach items="${replies}" var="reply">
                                <li class="reply-item" id="reply-${reply.id}">
                                    <div class="reply-header">
                                        <div class="reply-author-line">
                                            <span class="author-name">${fn:escapeXml(reply.authorUsername)}</span>
                                            <c:choose>
                                                <c:when test="${reply.authorRole == 'CERTIFIED'}">
                                                    <span class="role-tag role-cert">认证用户</span>
                                                </c:when>
                                                <c:when test="${reply.authorRole == 'ADMIN'}">
                                                    <span class="role-tag role-admin">管理员</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="role-tag">普通用户</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <span class="reply-time"><fmt:formatDate value="${reply.createTime}" pattern="MM-dd HH:mm"/></span>
                                    </div>
                                    <div class="reply-body">
                                        <div class="reply-content-raw" style="display:none;">${reply.content}</div>
                                        <div class="reply-content-rendered"></div>
                                    </div>
                                    <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.id == reply.userId}">
                                        <div class="reply-actions">
                                            <button class="action-link delete" onclick="deleteReply(${reply.id})">删除</button>
                                        </div>
                                    </c:if>
                                </li>
                            </c:forEach>
                        </ul>

                        <c:if test="${totalPages > 1}">
                            <div class="pagination">
                                <c:if test="${pageNum > 1}">
                                    <a href="${pageContext.request.contextPath}/post/${post.id}?pageNum=${pageNum - 1}&pageSize=6" class="page-item">上一页</a>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <c:choose>
                                        <c:when test="${i eq pageNum}">
                                            <span class="page-item active">${i}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/post/${post.id}?pageNum=${i}&pageSize=6" class="page-item">${i}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <c:if test="${pageNum < totalPages}">
                                    <a href="${pageContext.request.contextPath}/post/${post.id}?pageNum=${pageNum + 1}&pageSize=6" class="page-item">下一页</a>
                                </c:if>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align:center; padding:40px; color:#8a8a8a;">暂无回复，快来抢沙发吧</div>
                    </c:otherwise>
                </c:choose>

                <!-- 回复表单 -->
                <c:choose>
                    <c:when test="${post.isLocked and sessionScope.currentUser.role != 'ADMIN'}">
                        <div style="margin-top:20px; text-align:center; color:#8a8a8a; padding:20px; background:#f9f9f9; border-radius:4px;">
                            帖子已锁定，无法回复
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${not empty sessionScope.currentUser}">
                            <div class="reply-editor">
                                <form:form action="${pageContext.request.contextPath}/post/${post.id}/reply" method="post" modelAttribute="reply">
                                    <form:hidden path="postId" value="${post.id}"/>
                                    <form:hidden path="userId" value="${sessionScope.currentUser.id}"/>

                                    <div class="editor-toolbar">
                                        <button type="button" id="replyUploadBtn" class="btn-upload">📷 上传图片</button>
                                        <input type="file" id="replyImageFileInput" accept="image/*" style="display:none;">
                                        <c:if test="${sessionScope.currentUser.role == 'CERTIFIED' || sessionScope.currentUser.role == 'ADMIN'}">
                                            <button type="button" id="replyInsertReferenceBtn" class="btn-upload">📊 引用硬件</button>
                                        </c:if>
                                    </div>

                                    <form:textarea path="content" id="replyContent" cssClass="editor-input" placeholder="写下你的回复..."/>
                                    <form:errors path="content" cssClass="error-msg"/>

                                    <div class="submit-row">
                                        <input type="submit" value="发布回复" class="btn-submit"/>
                                    </div>
                                </form:form>
                            </div>
                        </c:if>
                        <c:if test="${empty sessionScope.currentUser}">
                            <div style="margin-top:20px; text-align:center; padding:30px; background:#f9f9f9; border-radius:4px;">
                                <p style="margin-bottom:15px; color:#666;">登录后参与讨论</p>
                                <a href="${pageContext.request.contextPath}/user/login" class="btn-submit">去登录</a>
                            </div>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>
</div>

<!-- 硬件详情模态框 -->
<div id="hardwareModal" class="modal-overlay">
    <div class="modal-panel">
        <div class="modal-header">
            <h3 class="modal-title">📊 硬件详情</h3>
            <button class="modal-close">&times;</button>
        </div>
        <div class="modal-body">
            <div id="hardwareDetailContent" class="hw-detail-grid"></div>
        </div>
    </div>
</div>

<!-- 硬件搜索模态框 -->
<div id="replyHardwareModal" class="modal-overlay">
    <div class="modal-panel">
        <div class="modal-header">
            <h3 class="modal-title">📊 选择硬件</h3>
            <button class="modal-close">&times;</button>
        </div>
        <div class="modal-body">
            <div class="search-box">
                <label style="font-size:13px; color:#8a8a8a; display:block; margin-bottom:5px;">硬件类型</label>
                <select id="replyHardwareTypeSelect" class="search-select">
                    <option value="">-- 请选择 --</option>
                    <option value="cpu_info">CPU</option>
                    <option value="gpu_info">显卡</option>
                    <option value="motherboard_info">主板</option>
                </select>

                <label style="font-size:13px; color:#8a8a8a; display:block; margin-bottom:5px;">型号关键词</label>
                <input type="text" id="replyHardwareSearchInput" class="search-input" placeholder="例如：RTX 4090, i9-13900K">

                <button id="replyHardwareSearchBtn" class="btn-submit" style="width:100%;">🔍 搜索</button>
            </div>
            <div id="replyHardwareList" class="search-list"></div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // 1. 渲染帖子内容
        var rawPost = $('#postContentRaw').text();
        // 解码 HTML 实体 (防止 double escape)
        rawPost = rawPost.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&amp;/g, '&').replace(/&quot;/g, '"');
        $('#postContentRendered').html(renderContentWithReferences(rawPost));

        // 2. 渲染回复内容
        $('.reply-item').each(function() {
            var $item = $(this);
            var raw = $item.find('.reply-content-raw').text();
            raw = raw.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&amp;/g, '&').replace(/&quot;/g, '"');
            $item.find('.reply-content-rendered').html(renderContentWithReferences(raw));
        });

        // 3. 模态框关闭逻辑
        $('.modal-close').click(function() { $(this).closest('.modal-overlay').hide(); });
        $(window).click(function(e) { if($(e.target).hasClass('modal-overlay')) $(e.target).hide(); });

        // 4. 删除回复
        $('.action-link.delete').click(function() {
            var rid = $(this).attr('onclick').match(/\d+/)[0];
            if(confirm('确定删除此回复？')) {
                $.post('${pageContext.request.contextPath}/reply/' + rid + '/delete', function(res) {
                    if(res.success) $('#reply-' + rid).fadeOut();
                    else alert('失败:' + res.message);
                });
            }
        });

        // 5. 图片上传 (修复了 data 语法错误)
        $('#replyUploadBtn').click(function() { $('#replyImageFileInput').click(); });
        $('#replyImageFileInput').change(function(e) {
            if(e.target.files && e.target.files[0]) {
                var fd = new FormData();
                fd.append('file', e.target.files[0]);
                $.ajax({
                    url: '${pageContext.request.contextPath}/upload/image',
                    type: 'POST',
                    data: fd, // 修复：这里之前可能少了逗号或者语法不对
                    processData: false,
                    contentType: false,
                    success: function(res) {
                        if(res.success) insertTextAtCursor($('#replyContent'), '![](' + res.url + ')');
                        else alert('上传失败:' + res.message);
                    },
                    error: function(xhr, status, err) {
                        console.error(err);
                        alert('网络错误，请检查控制台或服务器日志');
                    }
                });
            }
        });

        // 6. 硬件引用搜索 (移除了不存在的内存/存储)
        $('#replyInsertReferenceBtn').click(function() {
            $('#replyHardwareModal').show();
            $('#replyHardwareList').empty();
        });

        $('#replyHardwareSearchBtn').click(function() {
            var type = $('#replyHardwareTypeSelect').val();
            var kw = $('#replyHardwareSearchInput').val().trim();
            if(!type) { alert('请选择类型'); return; }

            $.get('${pageContext.request.contextPath}/api/hardware/search/' + type + '?keyword=' + encodeURIComponent(kw), function(data) {
                var html = '';
                if(data.length === 0) html = '<div style="padding:15px; color:#8a8a8a; text-align:center;">未找到相关硬件</div>';
                else {
                    data.forEach(function(item) {
                        html += '<div class="search-item" onclick="insertRef(\'' + type + '\', ' + item.id + ')">' +
                            '<strong>' + item.model + '</strong>' +
                            (item.brand ? '<span>(' + item.brand + ')</span>' : '') +
                            '</div>';
                    });
                }
                $('#replyHardwareList').html(html);
            });
        });
    });

    function insertRef(table, id) {
        insertTextAtCursor($('#replyContent'), '[' + table + ':' + id + ']');
        $('#replyHardwareModal').hide();
    }

    // 收藏功能
    function toggleFavorite(pid) {
        $.ajax({
            url: '${pageContext.request.contextPath}/post/' + pid + '/favorite',
            type: 'POST',
            contentType: 'application/json',
            success: function(res) {
                if(res.success) {
                    var btn = $('#favoriteBtn');
                    var countSpan = btn.find('span');
                    countSpan.text('(' + res.count + ')');
                    if(res.favorited) {
                        btn.addClass('active').html('<svg viewBox="0 0 24 24" style="width:16px;height:16px;fill:currentColor"><path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg> 已收藏 <span style="margin-left:4px; opacity:0.7;">(' + res.count + ')</span>');
                    } else {
                        btn.removeClass('active').html('<svg viewBox="0 0 24 24" style="width:16px;height:16px;fill:currentColor"><path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg> 收藏 <span style="margin-left:4px; opacity:0.7;">(' + res.count + ')</span>');
                    }
                } else {
                    alert(res.message || '操作失败');
                }
            },
            error: function() { alert('网络错误'); }
        });
    }

    // 渲染带引用的内容
    function renderContentWithReferences(text) {
        var html = text.split(/\n\s*\n/).map(p => p.trim() ? '<p>' + p.replace(/\n/g, '<br>') + '</p>' : '').join('');

        // 图片
        html = html.replace(/!\[([^\]]*)\]\(([^)]+)\)/g, function(m, alt, url) {
            return '<img src="' + url + '" alt="' + alt + '">';
        });

        // 硬件引用
        html = html.replace(/\[([a-zA-Z_]+):(\d+)\]/g, function(m, t, id) {
            var name = getHwName(t);
            return '<a href="#" class="hardware-ref" data-t="' + t + '" data-id="' + id + '">📊 ' + name + '</a>';
        });
        return html;
    }

    function getHwName(t) {
        var map = { 'cpu_info':'CPU', 'gpu_info':'显卡', 'motherboard_info':'主板' };
        return map[t] || '硬件';
    }

    function insertTextAtCursor($el, text) {
        var el = $el[0];
        var start = el.selectionStart;
        var end = el.selectionEnd;
        var val = $el.val();
        $el.val(val.substring(0, start) + text + val.substring(end));
        el.selectionStart = el.selectionEnd = start + text.length;
        el.focus();
    }

    // 硬件详情点击 (恢复完整字段显示)
    $(document).on('click', '.hardware-ref', function(e) {
        e.preventDefault();
        var t = $(this).data('t');
        var id = $(this).data('id');
        $('#hardwareModal').show();

        $.get('${pageContext.request.contextPath}/api/hardware/detail/' + t + '/' + id, function(data) {
            var html = '';

            // 通用字段
            if(data.model) html += '<div class="hw-row"><span class="hw-label">型号</span><span class="hw-value">' + data.model + '</span></div>';
            if(data.brand) html += '<div class="hw-row"><span class="hw-label">品牌</span><span class="hw-value">' + data.brand + '</span></div>';

            // CPU 特有
            if(t === 'cpu_info') {
                if(data.interfaceType) html += '<div class="hw-row"><span class="hw-label">接口</span><span class="hw-value">' + data.interfaceType + '</span></div>';
                if(data.cores) html += '<div class="hw-row"><span class="hw-label">核心数</span><span class="hw-value">' + data.cores + '</span></div>';
                if(data.threads) html += '<div class="hw-row"><span class="hw-label">线程数</span><span class="hw-value">' + data.threads + '</span></div>';
                if(data.baseFrequency) html += '<div class="hw-row"><span class="hw-label">基频</span><span class="hw-value">' + data.baseFrequency + ' GHz</span></div>';
                if(data.maxFrequency) html += '<div class="hw-row"><span class="hw-label">睿频</span><span class="hw-value">' + data.maxFrequency + ' GHz</span></div>';
                if(data.tdp) html += '<div class="hw-row"><span class="hw-label">TDP</span><span class="hw-value">' + data.tdp + ' W</span></div>';
            }
            // 显卡特有
            else if(t === 'gpu_info') {
                if(data.memorySize) html += '<div class="hw-row"><span class="hw-label">显存</span><span class="hw-value">' + data.memorySize + ' GB</span></div>';
                if(data.memoryType) html += '<div class="hw-row"><span class="hw-label">显存类型</span><span class="hw-value">' + data.memoryType + '</span></div>';
                if(data.baseClock) html += '<div class="hw-row"><span class="hw-label">基频</span><span class="hw-value">' + data.baseClock + ' MHz</span></div>';
                if(data.boostClock) html += '<div class="hw-row"><span class="hw-label">加速</span><span class="hw-value">' + data.boostClock + ' MHz</span></div>';
                if(data.tdp) html += '<div class="hw-row"><span class="hw-label">TDP</span><span class="hw-value">' + data.tdp + ' W</span></div>';
            }
            // 主板特有
            else if(t === 'motherboard_info') {
                if(data.chipset) html += '<div class="hw-row"><span class="hw-label">芯片组</span><span class="hw-value">' + data.chipset + '</span></div>';
                if(data.cpuInterface) html += '<div class="hw-row"><span class="hw-label">CPU 接口</span><span class="hw-value">' + data.cpuInterface + '</span></div>';
                if(data.memorySlots) html += '<div class="hw-row"><span class="hw-label">内存插槽</span><span class="hw-value">' + data.memorySlots + '</span></div>';
                if(data.maxMemory) html += '<div class="hw-row"><span class="hw-label">最大内存</span><span class="hw-value">' + data.maxMemory + ' GB</span></div>';
                if(data.memoryType) html += '<div class="hw-row"><span class="hw-label">内存类型</span><span class="hw-value">' + data.memoryType + '</span></div>';
            }

            if(html === '') html = '<div style="color:#8a8a8a; text-align:center;">暂无详细数据</div>';
            $('#hardwareDetailContent').html(html);
        });
    });
</script>
</body>
</html>
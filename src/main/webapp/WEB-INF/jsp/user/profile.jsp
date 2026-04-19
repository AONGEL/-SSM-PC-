<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${user.username} - 个人中心</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei', sans-serif; background: #f6f6f6; color: #121212; line-height: 1.6; min-height: 100vh; }
        .header { background: #fff; box-shadow: 0 1px 3px rgba(0,0,0,0.1); position: sticky; top: 0; z-index: 1000; padding: 0 20px; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; height: 56px; }
        .logo { font-size: 22px; font-weight: 700; color: #0066ff; text-decoration: none; }
        .logo:hover { color: #0055dd; }
        .nav-links { display: flex; align-items: center; gap: 20px; }
        .nav-links a { color: #121212; text-decoration: none; font-size: 15px; padding: 8px 16px; border-radius: 20px; transition: all 0.3s ease; }
        .nav-links a:hover { background: #f0f0f0; color: #0066ff; }
        .nav-links .highlight { background: #0066ff; color: #fff; }
        .nav-links .highlight:hover { background: #0055dd; }
        .main-container { max-width: 1200px; margin: 20px auto; padding: 0 20px; }
        .card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); overflow: hidden; margin-bottom: 20px; }
        .card-header { padding: 16px 20px; border-bottom: 1px solid #f0f0f0; display: flex; justify-content: space-between; align-items: center; }
        .card-title { font-size: 18px; font-weight: 600; color: #121212; }
        .card-body { padding: 20px; }
        .tab-nav { display: flex; border-bottom: 1px solid #f0f0f0; background: #fff; border-radius: 8px 8px 0 0; overflow: hidden; }
        .tab-item { padding: 14px 24px; cursor: pointer; font-size: 15px; font-weight: 500; color: #8a8a8a; border-bottom: 2px solid transparent; transition: all 0.3s ease; background: none; border: none; }
        .tab-item:hover { color: #0066ff; background: #fafafa; }
        .tab-item.active { color: #0066ff; border-bottom-color: #0066ff; background: #fff; }
        .tab-content { display: none; padding: 20px; }
        .tab-content.active { display: block; }
        .profile-header { display: flex; align-items: center; gap: 24px; padding: 24px; background: #fafafa; border-radius: 8px; }
        .profile-avatar { width: 80px; height: 80px; border-radius: 50%; object-fit: cover; border: 3px solid #f0f0f0; }
        .profile-avatar-placeholder { width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #0066ff 0%, #00ccff 100%); display: flex; align-items: center; justify-content: center; font-size: 36px; color: #fff; font-weight: 700; }
        .profile-info { flex: 1; }
        .profile-name { font-size: 22px; font-weight: 600; color: #121212; margin-bottom: 8px; }
        .profile-role { display: inline-block; padding: 2px 12px; background: #e6f0ff; color: #0066ff; border-radius: 12px; font-size: 12px; font-weight: 500; }
        .profile-stats { display: flex; gap: 24px; margin-top: 16px; }
        .stat-item { text-align: center; }
        .stat-value { font-size: 18px; font-weight: 600; color: #0066ff; }
        .stat-label { font-size: 12px; color: #8a8a8a; margin-top: 4px; }
        .btn { display: inline-block; padding: 10px 20px; border-radius: 8px; text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.3s ease; cursor: pointer; border: none; }
        .btn-primary { background: #0066ff; color: #fff; }
        .btn-primary:hover { background: #0055dd; }
        .btn-secondary { background: #fafafa; color: #121212; border: 1px solid #e0e0e0; }
        .btn-secondary:hover { background: #f0f0f0; }
        .link-list { list-style: none; }
        .link-item { display: block; padding: 12px 16px; margin: 8px 0; border-radius: 8px; text-decoration: none; color: #121212; font-size: 15px; transition: all 0.3s ease; }
        .link-item:hover { background: #fafafa; color: #0066ff; }
        .cert-status { padding: 16px; border-radius: 8px; margin: 12px 0; font-size: 14px; }
        .cert-status-approved { background: #e8f5e9; color: #2e7d32; border-left: 4px solid #4caf50; }
        .cert-status-pending { background: #e3f2fd; color: #1976d2; border-left: 4px solid #2196f3; }
        .cert-status-rejected { background: #ffebee; color: #c62828; border-left: 4px solid #f44336; }
        .cert-status-discussion { background: #fff8e1; color: #e65100; border-left: 4px solid #ffc107; }
        .post-list { list-style: none; }
        .post-item { padding: 16px; margin-bottom: 12px; border-radius: 8px; background: #fafafa; border: 1px solid #f0f0f0; transition: all 0.3s ease; }
        .post-item:hover { background: #f0f0f0; transform: translateX(4px); }
        .post-title-link { display: block; font-size: 16px; font-weight: 500; color: #121212; text-decoration: none; margin-bottom: 8px; }
        .post-title-link:hover { color: #0066ff; text-decoration: underline; }
        .post-meta { display: flex; flex-wrap: wrap; gap: 12px; font-size: 13px; color: #8a8a8a; }
        .post-meta-item { display: flex; align-items: center; gap: 4px; }
        .post-actions { display: flex; gap: 8px; margin-top: 12px; justify-content: flex-end; }
        .post-actions button, .post-actions input[type="submit"] { padding: 8px 16px; font-size: 13px; border-radius: 6px; border: none; cursor: pointer; transition: all 0.3s ease; }
        .post-actions .btn-edit { background: #0066ff; color: #fff; }
        .post-actions .btn-edit:hover { background: #0055dd; }
        .post-actions .btn-delete { background: #dc3545; color: #fff; }
        .post-actions .btn-delete:hover { background: #c82333; }
        .post-actions form { display: inline; }
        .reply-item { padding: 16px; margin-bottom: 12px; border-radius: 8px; background: #fafafa; border: 1px solid #f0f0f0; transition: all 0.3s ease; }
        .reply-item:hover { background: #f0f0f0; transform: translateX(4px); }
        .reply-content { display: block; font-size: 15px; color: #121212; text-decoration: none; margin-bottom: 8px; word-break: break-word; }
        .reply-content:hover { color: #0066ff; }
        .reply-meta { font-size: 13px; color: #8a8a8a; }
        .empty-state { text-align: center; padding: 40px 20px; color: #8a8a8a; }
        .empty-icon { font-size: 48px; margin-bottom: 12px; opacity: 0.5; }
        .empty-text { font-size: 15px; margin: 12px 0; }
        .pagination { display: flex; justify-content: center; gap: 8px; margin: 20px 0; flex-wrap: wrap; }
        .pagination a, .pagination span { padding: 8px 14px; border-radius: 6px; text-decoration: none; font-size: 14px; transition: all 0.3s ease; }
        .pagination a { background: #fafafa; color: #121212; border: 1px solid #e0e0e0; }
        .pagination a:hover { background: #0066ff; color: #fff; border-color: #0066ff; }
        .pagination .current-page { background: #0066ff; color: #fff; border: 1px solid #0066ff; }
        .pagination-info { text-align: center; color: #8a8a8a; font-size: 13px; margin-top: 12px; }
        .count-badge { display: inline-block; padding: 2px 10px; background: #e6f0ff; color: #0066ff; border-radius: 12px; font-size: 12px; font-weight: 500; }
        .grid-2 { display: grid; grid-template-columns: repeat(2, 1fr); gap: 16px; }
        @media (max-width: 768px) { .profile-header { flex-direction: column; text-align: center; } .profile-stats { justify-content: center; } .grid-2 { grid-template-columns: 1fr; } .tab-item { padding: 12px 16px; font-size: 14px; } }
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
    <div class="card">
        <div class="card-body">
            <div class="profile-header">
                <c:choose>
                    <c:when test="${not empty user.avatar && user.avatar != ''}">
                        <img src="${user.avatar}?t=${System.currentTimeMillis()}" alt="头像" class="profile-avatar" onerror="this.src='${pageContext.request.contextPath}/static/avatar/1.png'">
                    </c:when>
                    <c:otherwise>
                        <div class="profile-avatar-placeholder">${fn:substring(user.username, 0, 1)}</div>
                    </c:otherwise>
                </c:choose>
                <div class="profile-info">
                    <div class="profile-name">${user.username}</div>
                    <c:choose>
                        <c:when test="${user.role == 'ADMIN'}"><span class="profile-role">👑 管理员</span></c:when>
                        <c:when test="${user.role == 'CERTIFIED'}"><span class="profile-role">✅ 认证用户</span></c:when>
                        <c:otherwise><span class="profile-role">👤 普通用户</span></c:otherwise>
                    </c:choose>
                    <div class="profile-stats">
                        <div class="stat-item"><span class="stat-value">${totalPosts}</span><div class="stat-label">发帖数</div></div>
                        <div class="stat-item"><span class="stat-value">${totalReplies}</span><div class="stat-label">回复数</div></div>
                        <div class="stat-item"><span class="stat-value"><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd"/></span><div class="stat-label">注册时间</div></div>
                    </div>
                </div>
                <div><a href="${pageContext.request.contextPath}/user/edit-avatar" class="btn btn-secondary">修改头像</a></div>
                <div><a href="${pageContext.request.contextPath}/user/edit-username" class="btn btn-secondary" style="margin-right: 8px;">修改用户名</a></div>
                <div><a href="${pageContext.request.contextPath}/user/edit-password" class="btn btn-secondary">修改密码</a></div>

            </div>
        </div>
    </div>
    <div class="tab-nav">
        <button class="tab-item active" onclick="switchTab('overview')">概览</button>
        <button class="tab-item" onclick="switchTab('posts')">我的帖子</button>
        <button class="tab-item" onclick="switchTab('replies')">我的回复</button>
    </div>
    <div id="tab-overview" class="tab-content active">
        <div class="grid-2">
            <div class="card">
                <div class="card-header"><h2 class="card-title">账户操作</h2></div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${user.role == 'ADMIN'}">
                            <div class="cert-status cert-status-approved">您是管理员，感谢您对社区的贡献！</div>
                            <ul class="link-list">
                                <li><a href="${pageContext.request.contextPath}/certification/admin/review" class="link-item">审核认证申请</a></li>
                                <li><a href="${pageContext.request.contextPath}/user/admin/user-list" class="link-item">管理用户</a></li>
                            </ul>
                        </c:when>
                        <c:when test="${user.role == 'CERTIFIED'}">
                            <div class="cert-status cert-status-approved">恭喜！您现在是一名认证用户！
                                <c:if test="${latestCertificationApplication != null && latestCertificationApplication.applicationStatus == 'approved'}">
                                    <div style="margin-top: 8px; font-size: 13px;">(最近一次认证申请已通过审核)</div>
                                </c:if>
                            </div>
                        </c:when>
                        <c:when test="${user.role == 'USER'}">
                            <c:choose>
                                <c:when test="${latestCertificationApplication != null}">
                                    <c:choose>
                                        <c:when test="${latestCertificationApplication.applicationStatus == 'pending'}">
                                            <div class="cert-status cert-status-pending">您已提交认证申请，当前状态为 <strong>待审核</strong>。<div style="margin-top: 8px; font-size: 13px;">审核通常需要 1-3 个工作日。</div></div>
                                        </c:when>
                                        <c:when test="${latestCertificationApplication.applicationStatus == 'approved'}">
                                            <div class="cert-status cert-status-rejected">您的认证资格已被撤销。<a href="${pageContext.request.contextPath}/certification/info" class="btn btn-primary" style="margin-top: 12px;">重新申请</a></div>
                                        </c:when>
                                        <c:when test="${latestCertificationApplication.applicationStatus == 'rejected'}">
                                            <div class="cert-status cert-status-rejected">您的认证申请未通过审核。<c:if test="${not empty latestCertificationApplication.adminRemarks}"><div style="margin-top: 8px; font-size: 13px;">备注：<em>${latestCertificationApplication.adminRemarks}</em></div></c:if><a href="${pageContext.request.contextPath}/certification/info" class="btn btn-primary" style="margin-top: 12px;">重新申请</a></div>
                                        </c:when>
                                        <c:when test="${latestCertificationApplication.applicationStatus == 'pending_discussion'}">
                                            <div class="cert-status cert-status-discussion">您的认证申请状态为 <strong>待商议</strong>。<c:if test="${not empty latestCertificationApplication.adminRemarks}"><div style="margin-top: 8px; font-size: 13px;">备注：<em>${latestCertificationApplication.adminRemarks}</em></div></c:if><a href="${pageContext.request.contextPath}/certification/info" class="btn btn-primary" style="margin-top: 12px;">重新申请</a></div>
                                        </c:when>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <div class="cert-status cert-status-pending">您可以申请成为认证用户。<a href="${pageContext.request.contextPath}/certification/info" class="btn btn-primary" style="margin-top: 12px;">申请认证</a></div>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                    </c:choose>
                </div>
            </div>
            <div class="card">
                <div class="card-header"><h2 class="card-title">功能导航</h2></div>
                <div class="card-body">
                    <ul class="link-list">
                        <li><a href="${pageContext.request.contextPath}/user/favorites" class="link-item">⭐ 我的收藏</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/notifications" class="link-item">🔔 通知中心</a></li>
                        <li><a href="${pageContext.request.contextPath}/forum/section" class="link-item">📁 论坛分区</a></li>
                        <li><a href="${pageContext.request.contextPath}/hardware-library" class="link-item">🔧 硬件参数库</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div id="tab-posts" class="tab-content">
        <div class="card">
            <div class="card-header"><h2 class="card-title">我的帖子</h2><span class="count-badge">${totalPosts}</span></div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty userPosts && fn:length(userPosts) > 0}">
                        <ul class="post-list">
                            <c:forEach items="${userPosts}" var="post">
                                <li class="post-item">
                                    <a href="${pageContext.request.contextPath}/post/${post.id}" class="post-title-link">${post.title}</a>
                                    <div class="post-meta">
                                        <c:if test="${not empty post.sectionName}"><span class="post-meta-item">${post.sectionName}</span></c:if>
                                        <span class="post-meta-item"><fmt:formatDate value="${post.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                                        <span class="post-meta-item">${post.viewCount} 次浏览</span>
                                    </div>
                                    <div class="post-actions">
                                        <c:if test="${sessionScope.currentUser != null && sessionScope.currentUser.id == post.userId}">
                                            <button type="button" class="btn-edit" onclick="window.location.href='${pageContext.request.contextPath}/post/${post.id}/edit'">编辑</button>
                                        </c:if>
                                        <c:if test="${sessionScope.currentUser != null && (sessionScope.currentUser.id == post.userId || sessionScope.currentUser.role == 'ADMIN')}">
                                            <form action="${pageContext.request.contextPath}/post/${post.id}/delete" method="post" style="display:inline;">
                                                <input type="submit" value="删除" class="btn-delete" onclick="return confirm('确定要删除此帖子吗？');">
                                            </form>
                                        </c:if>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                        <div class="pagination">
                            <c:forEach begin="1" end="${totalPagesPosts}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPagePosts}"><span class="current-page">${i}</span></c:when>
                                    <c:otherwise><a href="${pageContext.request.contextPath}/user/profile?pagePosts=${i}&pageReplies=${pageReplies}&tab=posts">${i}</a></c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                        <div class="pagination-info">显示 ${startPostIndex} 到 ${endPostIndex} 条，共 ${totalPosts} 条</div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state"><div class="empty-text">您还没有发布任何帖子。</div><a href="${pageContext.request.contextPath}/post/create?sectionId=1" class="btn btn-primary">创建新帖子(默认发布到硬件故障区)</a></div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <div id="tab-replies" class="tab-content">
        <div class="card">
            <div class="card-header"><h2 class="card-title">我的回复</h2><span class="count-badge">${totalReplies}</span></div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty userReplies && fn:length(userReplies) > 0}">
                        <ul class="post-list">
                            <c:forEach items="${userReplies}" var="reply">
                                <li class="reply-item">
                                    <a href="${pageContext.request.contextPath}/post/${reply.postId}#reply-${reply.id}" class="reply-content">${fn:substring(reply.content, 0, 80)}<c:if test="${fn:length(reply.content) > 80}">...</c:if></a>
                                    <div class="reply-meta"><span><fmt:formatDate value="${reply.createTime}" pattern="yyyy-MM-dd HH:mm"/></span></div>
                                </li>
                            </c:forEach>
                        </ul>
                        <div class="pagination">
                            <c:forEach begin="1" end="${totalPagesReplies}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPageReplies}"><span class="current-page">${i}</span></c:when>
                                    <c:otherwise><a href="${pageContext.request.contextPath}/user/profile?pagePosts=${pagePosts}&pageReplies=${i}&tab=replies">${i}</a></c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                        <div class="pagination-info">显示 ${startReplyIndex} 到 ${endReplyIndex} 条，共 ${totalReplies} 条</div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state"><div class="empty-text">您还没有发表任何回复。</div><a href="${pageContext.request.contextPath}/" class="btn btn-primary">去首页浏览</a></div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<script>
    // 从 URL 参数中获取 tab 名称，如果没有则默认为 'overview'
    function getActiveTabFromUrl() {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get('tab') || 'overview';
    }

    // 页面加载时根据 URL 参数激活对应的标签页
    document.addEventListener('DOMContentLoaded', function() {
        const activeTab = getActiveTabFromUrl();
        if (activeTab === 'posts' || activeTab === 'replies' || activeTab === 'overview') {
            switchTab(activeTab, true);
        }
    });

    function switchTab(tabName, fromLoad) {
        document.querySelectorAll('.tab-content').forEach(function(content) { content.classList.remove('active'); });
        document.querySelectorAll('.tab-item').forEach(function(item) { item.classList.remove('active'); });
        document.getElementById('tab-' + tabName).classList.add('active');

        // 如果是从页面加载触发的，需要根据 tabName 找到对应的按钮
        if (fromLoad) {
            const buttons = document.querySelectorAll('.tab-item');
            for (let i = 0; i < buttons.length; i++) {
                if (buttons[i].textContent.includes(
                    tabName === 'overview' ? '概览' :
                        tabName === 'posts' ? '我的帖子' : '我的回复'
                )) {
                    buttons[i].classList.add('active');
                    break;
                }
            }
        } else {
            event.target.classList.add('active');
        }
    }
</script>
</body>
</html>
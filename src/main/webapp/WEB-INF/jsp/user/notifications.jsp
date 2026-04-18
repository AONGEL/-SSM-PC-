<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>通知中心 - PC 硬件交流论坛</title>
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

        /* 消息提示 */
        .success-message, .error-message { padding: 14px 18px; margin-bottom: 20px; border-radius: 8px; font-weight: 500; font-size: 14px; }
        .success-message { background: #d4edda; color: #155724; border-left: 4px solid #28a745; }
        .error-message { background: #f8d7da; color: #721c24; border-left: 4px solid #dc3545; }

        /* 通知卡片 */
        .notification-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); overflow: hidden; }

        /* 通知操作栏 */
        .notification-actions { padding: 16px 20px; border-bottom: 1px solid #f0f0f0; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 12px; background: #fafafa; }

        /* 按钮样式 */
        .btn { display: inline-block; padding: 8px 20px; border-radius: 20px; text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.3s ease; cursor: pointer; border: none; }
        .btn-delete-all { background: #dc3545; color: #fff; }
        .btn-delete-all:hover { background: #c82333; }
        .btn-primary { background: #0066ff; color: #fff; }
        .btn-primary:hover { background: #0055dd; }
        .btn-secondary { background: #fafafa; color: #121212; border: 1px solid #e0e0e0; }
        .btn-secondary:hover { background: #f0f0f0; }
        .btn-delete { background: #dc3545; color: #fff; padding: 6px 16px; font-size: 13px; }
        .btn-delete:hover { background: #c82333; }

        /* 通知列表 */
        .notification-list { list-style: none; }
        .notification-item { padding: 20px 24px; border-bottom: 1px solid #f0f0f0; transition: all 0.3s ease; }
        .notification-item:last-child { border-bottom: none; }
        .notification-item:hover { background: #fafafa; }
        .notification-item.unread { background: #e6f0ff; border-left: 4px solid #0066ff; }

        .notification-title { font-size: 15px; font-weight: 600; color: #121212; margin-bottom: 10px; display: flex; align-items: center; gap: 8px; flex-wrap: wrap; }
        .notification-title a { color: #0066ff; text-decoration: none; font-weight: 600; }
        .notification-title a:hover { color: #0055dd; text-decoration: underline; }

        .notification-content { font-size: 14px; color: #666; margin-bottom: 10px; line-height: 1.6; }
        .notification-time { font-size: 13px; color: #8a8a8a; }

        .notification-actions-item { display: flex; gap: 10px; margin-top: 16px; justify-content: flex-end; }

        /* 底部操作栏 */
        .notification-footer { margin-top: 20px; text-align: center; padding: 16px 20px; border-top: 1px solid #f0f0f0; background: #fafafa; }

        /* 空状态 */
        .empty-notifications { text-align: center; padding: 80px 30px; background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin: 20px 0; }
        .empty-icon { font-size: 72px; margin-bottom: 20px; opacity: 0.4; }
        .empty-notifications h3 { font-size: 20px; color: #121212; margin-bottom: 12px; font-weight: 600; }
        .empty-notifications p { color: #8a8a8a; font-size: 15px; margin: 8px 0; }

        /* 响应式 */
        @media (max-width: 768px) {
            .header-content { flex-wrap: wrap; height: auto; padding: 10px 0; gap: 10px; }
            .nav-links { width: 100%; justify-content: center; }
            .main-container { padding: 0 15px; }
            .page-header-card { padding: 16px 18px; }
            .page-title { font-size: 20px; }
            .notification-actions { flex-direction: column; }
            .btn { width: 100%; text-align: center; }
            .notification-item { padding: 16px 18px; }
            .notification-title { font-size: 14px; }
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
        <h1 class="page-title">🔔 通知中心</h1>
    </div>

    <!-- 成功/错误消息显示 -->
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="success-message">
                ${sessionScope.successMessage}
        </div>
        <% session.removeAttribute("successMessage"); %>
    </c:if>

    <c:if test="${not empty sessionScope.errorMessage}">
        <div class="error-message">
                ${sessionScope.errorMessage}
        </div>
        <% session.removeAttribute("errorMessage"); %>
    </c:if>

    <div class="notification-card">
        <div class="notification-actions">
            <a href="${pageContext.request.contextPath}/user/notifications/delete-all"
               class="btn btn-delete-all"
               onclick="return confirm('确定要删除所有通知吗？这个操作无法撤销！')">
                🗑️ 清空所有通知
            </a>
            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">
                👤 返回个人中心
            </a>
        </div>

        <c:choose>
            <c:when test="${not empty notifications && fn:length(notifications) > 0}">
                <ul class="notification-list">
                    <c:forEach items="${notifications}" var="notification">
                        <li class="notification-item ${notification.readStatus ? '' : 'unread'}">
                            <div class="notification-title">
                                <c:choose>
                                    <c:when test="${notification.type == 'REPLY' || notification.type == 'REPLY_TO_POST'}">
                                        <c:if test="${notification.relatedId != null && notification.relatedId > 0}">
                                            <c:set var="postTitle" value="${notification.postTitle}"/>
                                            <c:if test="${empty postTitle}">
                                                <c:set var="postTitle" value="帖子 #${notification.relatedId}"/>
                                            </c:if>
                                            <a href="${pageContext.request.contextPath}/post/${notification.relatedId}">
                                                    ${postTitle}
                                            </a>
                                        </c:if>
                                    </c:when>
                                    <c:when test="${notification.type == 'SYSTEM'}">
                                        <span>⚙️ 系统通知</span>
                                    </c:when>
                                    <c:when test="${notification.type == 'CERTIFICATION'}">
                                        <span>🎓 认证申请通知</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>📌 未知通知类型</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="notification-content">
                                <c:choose>
                                    <c:when test="${notification.type == 'REPLY' || notification.type == 'REPLY_TO_POST'}">
                                        您的帖子收到了新回复
                                    </c:when>
                                    <c:when test="${notification.type == 'SYSTEM'}">
                                        系统消息
                                    </c:when>
                                    <c:when test="${notification.type == 'CERTIFICATION'}">
                                        您的认证申请状态已更新
                                    </c:when>
                                    <c:otherwise>
                                        未知类型通知
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="notification-time">
                                <fmt:formatDate value="${notification.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </div>

                            <div class="notification-actions-item">
                                <a href="${pageContext.request.contextPath}/user/notifications/${notification.id}/delete"
                                   class="btn btn-delete"
                                   onclick="return confirm('确定要删除这条通知吗？')">
                                    ❌ 删除
                                </a>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <div class="empty-notifications">
                    <div class="empty-icon">📭</div>
                    <h3>没有通知</h3>
                    <p>当有人回复您的帖子时，通知将显示在这里</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="notification-footer">
            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-primary">
                👤 返回个人中心
            </a>
        </div>
    </div>
</div>
</body>
</html>
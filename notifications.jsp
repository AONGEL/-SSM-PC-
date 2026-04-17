<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>通知中心</title>
    <style>
        /* 整体布局 - 紫色渐变背景（管理员审核页面风格） */
        body {
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            min-height: 100vh;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 标题美化 */
        h1 {
            text-align: center;
            color: #fff;
            font-size: 36px;
            margin-bottom: 30px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
            letter-spacing: 1px;
            font-weight: 700;
            position: relative;
        }

        h1::after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 120px;
            height: 4px;
            background: rgba(255, 255, 255, 0.5);
            border-radius: 2px;
        }

        /* 消息提示美化 */
        .success-message,
        .error-message {
            padding: 15px 20px;
            margin-bottom: 25px;
            border-radius: 15px;
            font-weight: 500;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            animation: slideDown 0.3s ease;
        }

        .success-message {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724 !important;
            border-left: 5px solid #28a745;
        }

        .success-message::before {
            content: '✅';
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 24px;
        }

        .success-message span {
            margin-left: 35px;
            display: inline-block;
        }

        .error-message {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24 !important;
            border-left: 5px solid #dc3545;
        }

        .error-message::before {
            content: '⚠️';
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 24px;
        }

        .error-message span {
            margin-left: 35px;
            display: inline-block;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* 通知容器美化 */
        .notification-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 25px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.25);
            border: 1px solid rgba(255, 255, 255, 0.3);
            margin-bottom: 30px;
        }

        /* 通知操作按钮组美化 */
        .notification-actions {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
            justify-content: space-between;
            flex-wrap: wrap;
            align-items: center;
        }

        /* 统一按钮样式 */
        .btn {
            padding: 12px 28px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            position: relative;
            overflow: hidden;
            gap: 8px;
            color: white !important;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
        }

        .btn:active {
            transform: translateY(1px);
        }

        /* 清空所有按钮 - 红色渐变 */
        .btn-delete-all {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        }

        .btn-delete-all:hover {
            background: linear-gradient(135deg, #c82333 0%, #bd2130 100%);
        }

        /* 返回按钮 - 蓝色渐变 */
        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #0069d9 0%, #004494 100%);
        }

        /* 通知项美化 */
        .notification-item {
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .notification-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
        }

        .notification-item.unread::before {
            background: linear-gradient(135deg, #2196F3 0%, #1976d2 100%);
            width: 6px;
        }

        .notification-item:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .notification-item.unread {
            background: rgba(33, 150, 243, 0.1);
            border-left: 4px solid #2196F3;
        }

        /* 通知标题美化 */
        .notification-title {
            font-weight: 700;
            color: #2c3e50;
            font-size: 18px;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .notification-title a {
            color: #667eea;
            text-decoration: none;
            font-weight: 700;
            transition: all 0.3s ease;
        }

        .notification-title a:hover {
            color: #5568d3;
            text-decoration: underline;
        }

        /* 通知内容美化 */
        .notification-content {
            color: #495057;
            font-size: 16px;
            margin-bottom: 10px;
            line-height: 1.6;
        }

        /* 通知时间美化 */
        .notification-time {
            font-size: 14px;
            color: #6c757d;
            margin-top: 8px;
            display: block;
        }

        /* 通知操作按钮美化 */
        .notification-actions-item {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            justify-content: flex-end;
        }

        /* 删除按钮 - 红色渐变 */
        .btn-delete {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            padding: 8px 18px;
            font-size: 15px;
        }

        .btn-delete:hover {
            background: linear-gradient(135deg, #c82333 0%, #bd2130 100%);
        }

        /* 空状态美化 */
        .empty-notifications {
            text-align: center;
            padding: 60px 30px;
            color: rgba(255, 255, 255, 0.85);
            background: rgba(255, 255, 255, 0.1);
            border: 1px dashed rgba(255, 255, 255, 0.3);
            border-radius: 20px;
            margin: 30px 0;
            backdrop-filter: blur(5px);
        }

        .empty-notifications h3 {
            color: #000000;
            font-size: 28px;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .empty-notifications p {
            color: rgba(0,0, 0, 0.7);
            font-size: 18px;
            margin: 10px 0;
            font-weight: 500;
        }

        .empty-icon {
            font-size: 80px;
            margin-bottom: 25px;
            color: rgba(255, 255, 255, 0.6);
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            h1 {
                font-size: 28px;
                margin-bottom: 20px;
            }

            h1::after {
                width: 100px;
                height: 3px;
            }

            .notification-container {
                padding: 25px 20px;
                border-radius: 20px;
            }

            .notification-actions {
                flex-direction: column;
                align-items: stretch;
            }

            .btn {
                width: 100%;
                max-width: 300px;
                margin-bottom: 10px;
            }

            .notification-item {
                padding: 15px;
            }

            .notification-title {
                font-size: 16px;
            }

            .empty-notifications {
                padding: 40px 20px;
            }

            .empty-notifications h3 {
                font-size: 24px;
            }

            .empty-icon {
                font-size: 60px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>🔔 通知中心</h1>

    <!-- 成功/错误消息显示 -->
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="success-message">
            <span>${sessionScope.successMessage}</span>
        </div>
        <% session.removeAttribute("successMessage"); %>
    </c:if>

    <c:if test="${not empty sessionScope.errorMessage}">
        <div class="error-message">
            <span>${sessionScope.errorMessage}</span>
        </div>
        <% session.removeAttribute("errorMessage"); %>
    </c:if>

    <div class="notification-container">
        <div class="notification-actions">
            <!-- 清空所有通知按钮 -->
            <a href="${pageContext.request.contextPath}/user/notifications/delete-all"
               class="btn btn-delete-all"
               onclick="return confirm('确定要删除所有通知吗？这个操作无法撤销！')">
                🗑️ 清空所有通知
            </a>

            <!-- 返回个人中心按钮 -->
            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-primary">
                👤 返回个人中心
            </a>
        </div>

        <c:choose>
            <c:when test="${not empty notifications && fn:length(notifications) > 0}">
                <c:forEach items="${notifications}" var="notification">
                    <div class="notification-item ${notification.readStatus ? '' : 'unread'}">
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

                        <span class="notification-time">
                                <fmt:formatDate value="${notification.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </span>

                        <div class="notification-actions-item">
                            <a href="${pageContext.request.contextPath}/user/notifications/${notification.id}/delete"
                               class="btn btn-delete"
                               onclick="return confirm('确定要删除这条通知吗？')">
                                ❌ 删除
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-notifications">
                    <div class="empty-icon">📭</div>
                    <h3>没有通知</h3>
                    <p>当有人回复您的帖子时，通知将显示在这里</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div style="margin-top: 25px; text-align: center;">
            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-primary">
                👤 返回个人中心
            </a>
        </div>
    </div>
</div>
</body>
</html>
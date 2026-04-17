<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>认证申请状态</title>
    <style>
        /* 整体布局 - 白色渐变背景 */
        body {
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 状态容器 - 毛玻璃效果 */
        .status-container {
            text-align: center;
            padding: 60px 40px;
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 25px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
            max-width: 600px;
            width: 100%;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .status-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(102, 126, 234, 0.05) 0%, transparent 70%);
            z-index: 0;
        }

        .status-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.12);
        }

        /* 标题美化 */
        h1 {
            color: #2c3e50;
            font-size: 32px;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.05);
            letter-spacing: 1px;
            font-weight: 700;
            position: relative;
            z-index: 1;
        }

        /* 用户信息美化 */
        .user-info {
            color: #6c757d;
            font-size: 18px;
            margin-bottom: 30px;
            padding: 12px 20px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            display: inline-block;
            position: relative;
            z-index: 1;
        }

        /* 状态图标美化 */
        .status-icon {
            font-size: 96px;
            margin-bottom: 25px;
            position: relative;
            z-index: 1;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        /* 状态消息美化 */
        .status-message {
            font-size: 20px;
            color: #495057;
            margin-bottom: 25px;
            font-weight: 500;
            line-height: 1.8;
            position: relative;
            z-index: 1;
        }

        .status-message strong {
            color: #2c3e50;
            font-weight: 700;
        }

        /* 管理员留言美化 */
        .admin-remarks {
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            color: #1976d2;
            padding: 20px;
            border-radius: 15px;
            margin: 25px 0;
            box-shadow: 0 4px 15px rgba(25, 118, 210, 0.2);
            border-left: 5px solid #2196f3;
            font-style: italic;
            font-size: 16px;
            position: relative;
            z-index: 1;
        }

        .admin-remarks::before {
            content: '💬';
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 24px;
        }

        .admin-remarks p {
            margin: 0;
            padding-left: 35px;
        }

        /* 提交时间美化 */
        .submit-time {
            color: #6c757d;
            font-size: 15px;
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px dashed #e9ecef;
            position: relative;
            z-index: 1;
        }

        /* 按钮组美化 */
        .button-group {
            display: flex;
            gap: 20px;
            margin-top: 35px;
            justify-content: center;
            flex-wrap: wrap;
            position: relative;
            z-index: 1;
        }

        /* 统一按钮样式 */
        .btn {
            padding: 14px 32px;
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
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            gap: 8px;
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
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .btn:active {
            transform: translateY(1px);
        }

        /* 主要按钮 - 蓝色渐变 */
        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #0069d9 0%, #004494 100%);
        }

        /* 次要按钮 - 灰色渐变 */
        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            color: white;
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #5a6268 0%, #4e555b 100%);
        }

        /* 待审核状态 - 蓝色 */
        .status-pending {
            border-left: 5px solid #2196F3;
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
        }

        .status-pending .status-icon {
            color: #2196F3;
        }

        /* 已通过状态 - 绿色 */
        .status-approved {
            border-left: 5px solid #4CAF50;
            background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
        }

        .status-approved .status-icon {
            color: #4CAF50;
        }

        /* 被拒绝状态 - 红色 */
        .status-rejected {
            border-left: 5px solid #f44336;
            background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
        }

        .status-rejected .status-icon {
            color: #f44336;
        }

        /* 待商议状态 - 橙色 */
        .status-discussion {
            border-left: 5px solid #ff9800;
            background: linear-gradient(135deg, #fff8e1 0%, #ffecb3 100%);
        }

        .status-discussion .status-icon {
            color: #ff9800;
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .status-container {
                padding: 40px 20px;
                border-radius: 20px;
            }

            h1 {
                font-size: 26px;
                margin-bottom: 15px;
            }

            .status-icon {
                font-size: 72px;
                margin-bottom: 20px;
            }

            .status-message {
                font-size: 18px;
                margin-bottom: 20px;
            }

            .button-group {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                max-width: 300px;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="status-container
            <c:choose>
                <c:when test="${existingApplication.applicationStatus == 'pending'}">status-pending</c:when>
                <c:when test="${existingApplication.applicationStatus == 'approved'}">status-approved</c:when>
                <c:when test="${existingApplication.applicationStatus == 'rejected'}">status-rejected</c:when>
                <c:when test="${existingApplication.applicationStatus == 'pending_discussion'}">status-discussion</c:when>
            </c:choose>">

        <div class="status-icon">
            <c:choose>
                <c:when test="${existingApplication.applicationStatus == 'pending'}">⏳</c:when>
                <c:when test="${existingApplication.applicationStatus == 'approved'}">✅</c:when>
                <c:when test="${existingApplication.applicationStatus == 'rejected'}">❌</c:when>
                <c:when test="${existingApplication.applicationStatus == 'pending_discussion'}">💬</c:when>
            </c:choose>
        </div>

        <h1>认证申请状态</h1>

        <div class="user-info">
            <strong>当前用户:</strong> ${sessionScope.currentUser.username}
        </div>

        <c:choose>
            <c:when test="${existingApplication.applicationStatus == 'pending'}">
                <p class="status-message">
                    您已经提交了认证申请，当前状态为 <strong>待审核</strong>。请耐心等待管理员审核。
                </p>
            </c:when>

            <c:when test="${existingApplication.applicationStatus == 'approved'}">
                <p class="status-message">
                    恭喜！您的认证申请已 <strong>通过审核</strong>。您现在是一名认证用户！
                </p>
            </c:when>

            <c:when test="${existingApplication.applicationStatus == 'rejected'}">
                <p class="status-message">
                    很遗憾，您的认证申请 <strong>未通过审核</strong>。
                </p>
                <p class="status-message">
                    您可以点击下方按钮重新提交申请。
                </p>
                <div class="button-group">
                    <a href="${pageContext.request.contextPath}/certification/info" class="btn btn-primary">
                        📝 重新申请认证用户
                    </a>
                    <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">
                        👤 返回个人中心
                    </a>
                </div>
            </c:when>

            <c:when test="${existingApplication.applicationStatus == 'pending_discussion'}">
                <p class="status-message">
                    您的认证申请状态为 <strong>待商议</strong>。
                </p>
                <c:if test="${not empty existingApplication.adminRemarks}">
                    <div class="admin-remarks">
                        <p>${existingApplication.adminRemarks}</p>
                    </div>
                </c:if>
                <p class="status-message">
                    请根据备注要求操作，或点击下方按钮重新提交申请。
                </p>
                <div class="button-group">
                    <a href="${pageContext.request.contextPath}/certification/info" class="btn btn-primary">
                        📝 重新申请认证用户
                    </a>
                    <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">
                        👤 返回个人中心
                    </a>
                </div>
            </c:when>

            <c:otherwise>
                <p class="status-message">
                    未知的申请状态。
                </p>
                <div class="button-group">
                    <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">
                        👤 返回个人中心
                    </a>
                </div>
            </c:otherwise>
        </c:choose>

        <c:if test="${existingApplication.applicationStatus == 'pending' || existingApplication.applicationStatus == 'approved'}">
            <div class="button-group">
                <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">
                    👤 返回个人中心
                </a>
            </div>
        </c:if>

        <c:if test="${existingApplication.applicationStatus == 'pending' || existingApplication.applicationStatus == 'rejected' || existingApplication.applicationStatus == 'pending_discussion'}">
            <p class="submit-time">
                <strong>📅 申请提交时间:</strong> ${existingApplication.submittedAt}
            </p>
        </c:if>
    </div>
</div>
</body>
</html>
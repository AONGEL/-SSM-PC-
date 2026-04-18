<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>认证用户申请说明 - PC 硬件交流论坛</title>
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
        .main-container { max-width: 1000px; margin: 20px auto; padding: 0 20px; }

        /* 页面标题卡片 */
        .page-header-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 20px 24px; margin-bottom: 20px; }
        .page-title { font-size: 24px; font-weight: 700; color: #121212; display: flex; align-items: center; gap: 10px; }

        /* 用户信息卡片 */
        .user-info-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 16px 20px; margin-bottom: 20px; text-align: center; }
        .user-info-text { font-size: 15px; color: #666; }
        .user-info-text strong { color: #0066ff; font-weight: 600; }

        /* 状态卡片 */
        .status-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 24px; margin-bottom: 20px; transition: all 0.3s ease; border-left: 4px solid #e0e0e0; }
        .status-card:hover { box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .status-pending { border-left-color: #2196F3; background: linear-gradient(135deg, #e3f2fd 0%, #fff 100%); }
        .status-rejected { border-left-color: #f44336; background: linear-gradient(135deg, #ffebee 0%, #fff 100%); }
        .status-discussion { border-left-color: #ff9800; background: linear-gradient(135deg, #fff8e1 0%, #fff 100%); }

        .status-title { font-size: 20px; font-weight: 600; color: #121212; margin-bottom: 15px; }
        .status-description { font-size: 15px; color: #666; margin-bottom: 15px; line-height: 1.7; }
        .status-description strong { color: #121212; font-weight: 600; }

        .admin-remarks { background: #f6f6f6; border-left: 3px solid #0066ff; padding: 12px 16px; border-radius: 6px; margin: 15px 0; font-style: italic; color: #666; font-size: 14px; }
        .submit-time { font-size: 13px; color: #8a8a8a; margin-top: 15px; padding-top: 15px; border-top: 1px dashed #e0e0e0; }

        /* 信息卡片 */
        .info-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 24px; margin-bottom: 20px; }
        .info-card h2 { font-size: 18px; font-weight: 600; color: #121212; margin-bottom: 16px; padding-bottom: 12px; border-bottom: 2px solid #f0f0f0; }
        .info-card p { font-size: 15px; color: #666; line-height: 1.8; margin-bottom: 12px; }
        .info-card ul { padding-left: 24px; margin-bottom: 16px; }
        .info-card ul li { font-size: 15px; color: #666; line-height: 1.8; margin-bottom: 10px; position: relative; }
        .info-card ul li::before { content: '•'; color: #0066ff; font-weight: bold; position: absolute; left: -16px; font-size: 18px; }
        .info-card ul li strong { color: #121212; font-weight: 600; }
        .info-card ol { padding-left: 24px; margin-bottom: 16px; }
        .info-card ol li { font-size: 15px; color: #666; line-height: 1.8; margin-bottom: 10px; }

        /* 重要提示 */
        .important-notice { background: #fff8e1; border-left: 4px solid #ffc107; padding: 16px 20px; border-radius: 8px; margin: 20px 0; }
        .important-notice p { margin: 0; color: #5d4037; font-weight: 500; font-size: 14px; }

        /* 按钮组 */
        .button-group { display: flex; gap: 15px; margin-top: 25px; justify-content: center; flex-wrap: wrap; }
        .btn { padding: 12px 28px; border: none; border-radius: 20px; cursor: pointer; font-size: 15px; font-weight: 500; transition: all 0.3s ease; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .btn-primary { background: #0066ff; color: #fff; }
        .btn-primary:hover { background: #0055dd; }
        .btn-secondary { background: #fafafa; color: #121212; border: 1px solid #e0e0e0; }
        .btn-secondary:hover { background: #f0f0f0; }

        /* 响应式 */
        @media (max-width: 768px) {
            .header-content { flex-wrap: wrap; height: auto; padding: 10px 0; gap: 10px; }
            .nav-links { width: 100%; justify-content: center; }
            .main-container { padding: 0 15px; }
            .page-header-card { padding: 16px 18px; }
            .page-title { font-size: 20px; }
            .status-card { padding: 18px; }
            .info-card { padding: 18px; }
            .button-group { flex-direction: column; align-items: stretch; }
            .btn { width: 100%; justify-content: center; }
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
        <h1 class="page-title">📝 申请成为认证用户</h1>
    </div>

    <div class="user-info-card">
        <p class="user-info-text">当前用户：<strong>${sessionScope.currentUser.username}</strong> (${sessionScope.currentUser.role})</p>
    </div>

    <!-- ========== 优先判断：认证资格被撤销（角色为 USER 但最近申请状态为 approved） ========== -->
    <c:if test="${sessionScope.currentUser.role == 'USER' && not empty latestCertificationApplication && latestCertificationApplication.applicationStatus == 'approved'}">
        <div class="status-card status-rejected">
            <h2 class="status-title">❌ 认证资格已被撤销</h2>
            <p class="status-description">
                您的认证资格已被管理员撤销，当前身份为 <strong>普通用户</strong>。
            </p>
            <c:if test="${not empty latestCertificationApplication.adminRemarks}">
                <div class="admin-remarks">
                    📌 撤销原因：<em>${latestCertificationApplication.adminRemarks}</em>
                </div>
            </c:if>
            <p class="status-description" style="margin-top: 15px;">
                您可以点击下方按钮重新提交认证申请。
            </p>
            <div class="button-group">
                <a href="${pageContext.request.contextPath}/certification/apply" class="btn btn-primary">
                    📝 重新开始认证答题
                </a>
                <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">
                    🏠 返回个人中心
                </a>
            </div>
        </div>
    </c:if>

    <!-- ========== 如果用户有待审核的申请，则显示状态并阻止重新申请 ========== -->
    <c:if test="${not empty existingPendingApplication && (sessionScope.currentUser.role != 'USER' || latestCertificationApplication.applicationStatus != 'approved')}">
        <div class="status-card status-pending">
            <h2 class="status-title">⏳ 当前申请状态</h2>
            <p class="status-description">
                您有一个 <strong>待审核</strong> 的认证申请，请耐心等待管理员审核。在此期间，您无法提交新的申请。
            </p>
            <p class="submit-time">
                <strong>📅 提交时间:</strong> ${existingPendingApplication.submittedAt}
            </p>
            <div class="button-group">
                <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">
                    🏠 返回个人中心
                </a>
            </div>
        </div>
    </c:if>

    <!-- ========== 如果用户有被拒绝或待商议的申请，显示状态，但允许重新申请 ========== -->
    <c:if test="${empty existingPendingApplication && not empty latestRejectedOrDiscussionApplication && (sessionScope.currentUser.role != 'USER' || latestCertificationApplication.applicationStatus != 'approved')}">
        <div class="status-card
                <c:choose>
                    <c:when test="${latestRejectedOrDiscussionApplication.applicationStatus eq 'rejected'}">status-rejected</c:when>
                    <c:when test="${latestRejectedOrDiscussionApplication.applicationStatus eq 'pending_discussion'}">status-discussion</c:when>
                </c:choose>">
            <h2 class="status-title">
                <c:choose>
                    <c:when test="${latestRejectedOrDiscussionApplication.applicationStatus eq 'rejected'}">
                        ❌ 上一次申请状态
                    </c:when>
                    <c:when test="${latestRejectedOrDiscussionApplication.applicationStatus eq 'pending_discussion'}">
                        💬 上一次申请状态
                    </c:when>
                </c:choose>
            </h2>
            <c:choose>
                <c:when test="${latestRejectedOrDiscussionApplication.applicationStatus eq 'rejected'}">
                    <p class="status-description">
                        您上一次的认证申请 <strong>未通过审核</strong>。
                    </p>
                </c:when>
                <c:when test="${latestRejectedOrDiscussionApplication.applicationStatus eq 'pending_discussion'}">
                    <p class="status-description">
                        您上一次的认证申请状态为 <strong>待商议</strong>。
                    </p>
                    <c:if test="${not empty latestRejectedOrDiscussionApplication.adminRemarks}">
                        <div class="admin-remarks">
                                ${latestRejectedOrDiscussionApplication.adminRemarks}
                        </div>
                    </c:if>
                </c:when>
            </c:choose>
            <p class="status-description">
                您可以点击下方按钮重新提交申请。
            </p>
            <p class="submit-time">
                <strong>📅 提交时间:</strong> ${latestRejectedOrDiscussionApplication.submittedAt}
            </p>
            <div class="button-group">
                <a href="${pageContext.request.contextPath}/certification/apply" class="btn btn-primary">
                    📝 重新开始认证答题
                </a>
                <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">
                    🏠 返回个人中心
                </a>
            </div>
        </div>
    </c:if>

    <!-- ========== 如果用户既没有待审核的申请，也没有被拒绝或待商议的申请，且不是被撤销状态，则显示说明和申请按钮 ========== -->
    <c:if test="${empty existingPendingApplication &&
                      empty latestRejectedOrDiscussionApplication &&
                      (empty latestCertificationApplication ||
                       latestCertificationApplication.applicationStatus != 'approved' ||
                       sessionScope.currentUser.role != 'USER')}">
        <div class="info-card">
            <h2>🌟 认证用户的意义</h2>
            <p>
                认证用户是论坛内的一个特殊身份标识，代表着用户在硬件领域具备了相当的专业知识和经验。拥有此身份的用户，不仅享有更高的社区地位，更重要的是，他们肩负着为其他用户提供高质量、准确、负责任的技术解答和支持的责任。
            </p>
        </div>

        <div class="info-card">
            <h2>🎯 认证用户的责任</h2>
            <ul>
                <li><strong>专业性</strong>：在回答问题、参与讨论时，应基于充分的知识和实践经验，确保信息的准确性。</li>
                <li><strong>责任感</strong>：意识到自己的言论可能对他人产生重大影响（如装机决策），应谨慎发言，避免误导。</li>
                <li><strong>互助精神</strong>：乐于分享知识，耐心帮助初学者，共同营造积极、友善、专业的社区氛围。</li>
                <li><strong>遵守规则</strong>：严格遵守论坛的各项规定，维护社区秩序。</li>
            </ul>
        </div>

        <div class="info-card">
            <h2>📋 认证申请流程</h2>
            <ol>
                <li>仔细阅读本说明，确认您理解并愿意承担认证用户的责任。</li>
                <li>点击下方按钮进入认证答题环节。</li>
                <li>完成系统设定的题目，题目旨在评估您的硬件基础知识和应用能力。</li>
                <li>提交您的答案。管理员将对您的申请进行审核。</li>
                <li>审核结果将通过系统消息或站内信通知您。</li>
            </ol>
        </div>

        <div class="important-notice">
            <p>认证用户资格并非终身制，若发现滥用身份、发布错误信息或违反社区规定的行为，其资格可能会被撤销。</p>
        </div>

        <div class="button-group">
            <a href="${pageContext.request.contextPath}/certification/apply" class="btn btn-primary">
                📝 开始认证答题
            </a>
            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">
                🏠 返回个人中心
            </a>
        </div>
    </c:if>
</div>
</body>
</html>
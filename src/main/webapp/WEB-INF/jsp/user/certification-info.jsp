<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>认证用户申请说明</title>
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
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 标题美化 */
        h1 {
            text-align: center;
            color: #2c3e50;
            font-size: 36px;
            margin-bottom: 30px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.05);
            letter-spacing: 1px;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 2px;
        }

        /* 用户信息美化 */
        .user-info {
            text-align: center;
            color: #6c757d;
            font-size: 18px;
            margin-bottom: 25px;
            padding: 15px 30px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        .user-info strong {
            color: #2c3e50;
            font-weight: 600;
        }

        /* 申请状态卡片美化 */
        .status-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .status-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(102, 126, 234, 0.05) 0%, transparent 70%);
            z-index: 0;
        }

        .status-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
        }

        /* 待审核状态 - 蓝色 */
        .status-pending {
            border-left: 5px solid #2196F3;
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
        }

        .status-pending::before {
            background: radial-gradient(circle, rgba(33, 150, 243, 0.05) 0%, transparent 70%);
        }

        /* 被拒绝状态 - 红色 */
        .status-rejected {
            border-left: 5px solid #f44336;
            background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
        }

        .status-rejected::before {
            background: radial-gradient(circle, rgba(244, 67, 54, 0.05) 0%, transparent 70%);
        }

        /* 待商议状态 - 橙色 */
        .status-discussion {
            border-left: 5px solid #ff9800;
            background: linear-gradient(135deg, #fff8e1 0%, #ffecb3 100%);
        }

        .status-discussion::before {
            background: radial-gradient(circle, rgba(255, 152, 0, 0.05) 0%, transparent 70%);
        }

        /* 状态标题美化 */
        .status-title {
            font-size: 24px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 15px;
            position: relative;
            z-index: 1;
        }

        /* 状态描述美化 */
        .status-description {
            font-size: 17px;
            color: #495057;
            margin-bottom: 20px;
            line-height: 1.8;
            position: relative;
            z-index: 1;
        }

        .status-description strong {
            color: #2c3e50;
            font-weight: 700;
        }

        /* 管理员留言美化 */
        .admin-remarks {
            background: rgba(255, 255, 255, 0.7);
            border-left: 4px solid #667eea;
            padding: 15px 20px;
            border-radius: 10px;
            margin: 15px 0;
            font-style: italic;
            color: #2c3e50;
            position: relative;
            z-index: 1;
        }

        .admin-remarks::before {
            content: '💬';
            margin-right: 10px;
            font-size: 18px;
        }

        /* 提交时间美化 */
        .submit-time {
            color: #6c757d;
            font-size: 15px;
            margin-top: 10px;
            padding-top: 15px;
            border-top: 1px dashed #e9ecef;
            position: relative;
            z-index: 1;
        }

        /* 说明内容卡片美化 */
        .info-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
            position: relative;
            overflow: hidden;
        }

        .info-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(102, 126, 234, 0.03) 0%, transparent 70%);
            z-index: 0;
        }

        /* 卡片标题美化 */
        .info-card h2 {
            color: #2c3e50;
            font-size: 26px;
            margin-bottom: 20px;
            font-weight: 700;
            position: relative;
            z-index: 1;
            padding-bottom: 10px;
            border-bottom: 2px solid #e9ecef;
        }

        /* 段落美化 */
        .info-card p {
            color: #495057;
            font-size: 16px;
            line-height: 1.8;
            margin-bottom: 15px;
            position: relative;
            z-index: 1;
        }

        /* 列表美化 */
        .info-card ul {
            padding-left: 30px;
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
        }

        .info-card ul li {
            color: #495057;
            font-size: 16px;
            line-height: 1.8;
            margin-bottom: 10px;
            position: relative;
        }

        .info-card ul li::before {
            content: '•';
            color: #667eea;
            font-weight: bold;
            position: absolute;
            left: -20px;
            font-size: 20px;
        }

        .info-card ul li strong {
            color: #2c3e50;
            font-weight: 700;
        }

        /* 有序列表美化 */
        .info-card ol {
            padding-left: 30px;
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
        }

        .info-card ol li {
            color: #495057;
            font-size: 16px;
            line-height: 1.8;
            margin-bottom: 10px;
            position: relative;
        }

        .info-card ol li::before {
            color: #667eea;
            font-weight: bold;
        }

        /* 重要提示美化 */
        .important-notice {
            background: linear-gradient(135deg, #fff8e1 0%, #ffecb3 100%);
            border-left: 5px solid #ffc107;
            padding: 20px 25px;
            border-radius: 15px;
            margin: 25px 0;
            box-shadow: 0 4px 15px rgba(255, 193, 7, 0.2);
            position: relative;
            overflow: hidden;
        }

        .important-notice::before {
            content: '⚠️';
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 32px;
            opacity: 0.3;
        }

        .important-notice p {
            margin: 0;
            color: #5d4037;
            font-weight: 600;
            padding-left: 45px;
            position: relative;
            z-index: 1;
        }

        /* 按钮组美化 */
        .button-group {
            display: flex;
            gap: 20px;
            margin-top: 30px;
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

        /* 响应式调整 */
        @media (max-width: 768px) {
            h1 {
                font-size: 28px;
                margin-bottom: 20px;
            }

            h1::after {
                width: 100px;
                height: 3px;
            }

            .user-info {
                font-size: 16px;
                padding: 12px 20px;
            }

            .status-card,
            .info-card {
                padding: 25px 20px;
            }

            .status-title {
                font-size: 22px;
            }

            .info-card h2 {
                font-size: 24px;
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
    <h1>📝 申请成为认证用户</h1>

    <div class="user-info">
        <strong>当前用户:</strong> ${sessionScope.currentUser.username} (${sessionScope.currentUser.role})
    </div>

    <!-- ========== 优先判断：认证资格被撤销（角色为USER但最近申请状态为approved） ========== -->
    <c:if test="${sessionScope.currentUser.role == 'USER' && not empty latestCertificationApplication && latestCertificationApplication.applicationStatus == 'approved'}">
        <div class="status-card status-rejected">
            <h2 class="status-title">❌ 认证资格已被撤销</h2>
            <p class="status-description">
                您的认证资格已被管理员撤销，当前身份为 <strong>普通用户</strong>。
            </p>
            <c:if test="${not empty latestCertificationApplication.adminRemarks}">
                <div class="admin-remarks">
                    📌 撤销原因: <em>${latestCertificationApplication.adminRemarks}</em>
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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>管理员 - 审核认证申请</title>
    <style>
        /* 整体布局 */
        body {
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            min-height: 100vh;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 标题居中 */
        h1 {
            text-align: center;
            color: #fff;
            font-size: 32px;
            margin-bottom: 30px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            letter-spacing: 1px;
        }

        h2 {
            text-align: center;
            color: #fff;
            font-size: 24px;
            margin: 40px 0 20px;
            background: rgba(255, 255, 255, 0.1);
            padding: 12px 30px;
            border-radius: 30px;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            display: inline-block;
        }

        /* 用户信息 - 白色文字 */
        .user-info {
            background: rgba(255, 255, 255, 0.15);
            padding: 12px 20px;
            border-radius: 20px;
            margin-bottom: 30px;
            font-size: 15px;
            color: #fff !important;
            text-align: center;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .user-info p {
            color: #fff !important;
            margin: 5px 0;
        }

        /* 每个申请的浮窗卡片 - 毛玻璃效果 */
        .application-item {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
            margin-bottom: 30px;
            padding: 30px;
            border: 1px solid rgba(255, 255, 255, 0.18);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .application-item:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.25);
            border-color: rgba(255, 255, 255, 0.3);
        }

        /* 卡片内容 */
        .application-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 20px;
            margin-bottom: 25px;
        }

        .applicant-info h3 {
            color: #2c3e50;
            font-size: 22px;
            margin: 0;
            font-weight: 600;
        }

        .applicant-info span {
            color: #6c757d;
            font-size: 14px;
            margin-top: 5px;
            display: block;
        }

        /* 申请内容区域 */
        .application-content {
            margin-bottom: 25px;
        }

        .application-content h4 {
            color: #2c3e50;
            font-size: 18px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        /* 答题内容样式 */
        .answers-container {
            background: rgba(248, 249, 250, 0.8);
            border-radius: 12px;
            padding: 20px;
            border: 1px solid #e9ecef;
        }

        .answer-item {
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px dashed #dee2e6;
        }

        .answer-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .answer-question {
            font-weight: 700;
            color: #2c3e50;
            font-size: 16px;
            margin-bottom: 8px;
            line-height: 1.6;
        }

        .answer-content {
            margin-left: 15px;
            color: #495057;
            font-size: 15px;
            line-height: 1.8;
            padding: 12px 15px;
            background: #fff;
            border-radius: 8px;
            border-left: 3px solid #4CAF50;
        }

        /* 答题时长 */
        .exam-duration {
            display: inline-block;
            background: #e3f2fd;
            color: #1976d2;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            margin-top: 10px;
        }

        /* 操作按钮区域 */
        .application-actions {
            display: flex;
            gap: 15px;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 2px solid #f0f0f0;
        }

        /* 按钮样式 */
        .btn-action {
            flex: 1;
            padding: 14px 20px;
            border: none;
            border-radius: 12px;
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
        }

        .btn-action::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .btn-action:hover::before {
            left: 100%;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .btn-approve {
            background: linear-gradient(135deg, #4CAF50 0%, #2E7D32 100%);
            color: white;
        }

        .btn-approve:hover {
            background: linear-gradient(135deg, #45a049 0%, #1B5E20 100%);
            transform: translateY(-3px);
        }

        .btn-reject {
            background: linear-gradient(135deg, #f44336 0%, #c62828 100%);
            color: white;
        }

        .btn-reject:hover {
            background: linear-gradient(135deg, #e53935 0%, #b71c1c 100%);
            transform: translateY(-3px);
        }

        .btn-pending-discussion {
            background: linear-gradient(135deg, #ff9800 0%, #e65100 100%);
            color: white;
        }

        .btn-pending-discussion:hover {
            background: linear-gradient(135deg, #fb8c00 0%, #bf360c 100%);
            transform: translateY(-3px);
        }

        .btn-reset-to-pending {
            background: linear-gradient(135deg, #ffc107 0%, #ff8f00 100%);
            color: #212529;
        }

        .btn-reset-to-pending:hover {
            background: linear-gradient(135deg, #ffb300 0%, #ef6c00 100%);
            transform: translateY(-3px);
        }

        .btn-disabled {
            background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
            color: white;
            cursor: not-allowed;
            opacity: 0.7;
        }

        .btn-disabled:hover {
            transform: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        /* 备注表单 */
        .remarks-form {
            margin-top: 20px;
            padding: 25px;
            background: rgba(248, 249, 250, 0.9);
            border-radius: 15px;
            border: 2px solid #e9ecef;
            display: none;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .remarks-textarea {
            width: 100%;
            padding: 15px;
            margin-bottom: 15px;
            border: 2px solid #dee2e6;
            border-radius: 10px;
            font-size: 15px;
            resize: vertical;
            min-height: 100px;
            transition: border-color 0.3s ease;
        }

        .remarks-textarea:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
        }

        /* 备注表单按钮 */
        .action-btn {
            padding: 12px 25px;
            margin-right: 10px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
        }

        /* 底部导航 */
        .page-footer {
            margin-top: 40px;
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .back-link {
            display: inline-block;
            padding: 12px 30px;
            background: rgba(255, 255, 255, 0.15);
            color: #fff !important;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .back-link:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.2);
            background: rgba(255, 255, 255, 0.25);
        }

        /* 空状态提示 */
        .empty-state {
            text-align: center;
            padding: 60px 30px;
            color: #fff !important;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            margin: 30px 0;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.15);
        }

        .empty-state p {
            color: #fff !important;
            font-size: 18px;
            margin: 10px 0;
        }

        .empty-icon {
            font-size: 64px;
            margin-bottom: 20px;
            color: rgba(255, 255, 255, 0.7);
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            h1 {
                font-size: 26px;
            }

            h2 {
                font-size: 20px;
                padding: 10px 20px;
            }

            .application-item {
                padding: 20px;
            }

            .application-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .application-actions {
                flex-wrap: wrap;
            }

            .btn-action {
                width: 100%;
                margin-bottom: 10px;
            }

            .action-btn {
                width: 100%;
                margin-bottom: 10px;
            }

            .back-link {
                width: 100%;
                text-align: center;
            }
        }

        /* 用户信息 - 白色文字，半透明背景 */
        .user-info {
            background: rgba(255, 255, 255, 0.15);
            padding: 12px 20px;
            border-radius: 20px;
            margin-bottom: 30px;
            font-size: 15px;
            color: #fff !important; /* 强制白色文字 */
            text-align: center;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .user-info p {
            color: #fff !important; /* 强制白色文字 */
            margin: 5px 0;
            font-weight: 500;
        }

        /* 空状态提示 - 白色文字，毛玻璃效果 */
        .empty-state {
            text-align: center;
            padding: 60px 30px;
            color: #fff !important; /* 强制白色文字 */
            background: rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            margin: 30px 0;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.15);
        }

        .empty-state p {
            color: #fff !important; /* 强制白色文字 */
            font-size: 18px;
            margin: 10px 0;
            font-weight: 500;
        }

        .empty-icon {
            font-size: 64px;
            margin-bottom: 20px;
            color: rgba(255, 255, 255, 0.7);
        }

        /* 底部导航 - 白色文字，半透明按钮 */
        .page-footer {
            margin-top: 40px;
            display: flex;
            justify-content: center;
            gap: 20px;
            padding: 20px;
        }

        .back-link, .manage-link {
            display: inline-block;
            padding: 12px 30px;
            background: rgba(255, 255, 255, 0.15);
            color: #fff !important; /* 强制白色文字 */
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .back-link:hover, .manage-link:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.2);
            background: rgba(255, 255, 255, 0.25);
        }
        /* ========== 统一按钮基础样式 ========== */
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 15px;
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
            min-width: 110px;
            height: 48px;
            line-height: 1;
            box-sizing: border-box;
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

        /* ========== 通过按钮 - 绿色渐变 ========== */
        .btn-approve {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
        }

        .btn-approve:hover {
            background: linear-gradient(135deg, #218838 0%, #1e7e34 100%);
        }

        /* ========== 不通过按钮 - 红色渐变 ========== */
        .btn-reject {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
        }

        .btn-reject:hover {
            background: linear-gradient(135deg, #c82333 0%, #bd2130 100%);
        }

        /* ========== 待商议按钮 - 橙色渐变 ========== */
        .btn-pending-discussion {
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
            color: #212529;
        }

        .btn-pending-discussion:hover {
            background: linear-gradient(135deg, #e0a800 0%, #d39e00 100%);
        }

        /* ========== 备注表单按钮 ========== */
        .action-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            gap: 6px;
            min-width: 90px;
            height: 42px;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
        }

        /* ========== 按钮组布局 ========== */
        .application-actions {
            display: flex;
            gap: 12px;
            margin-top: 25px;
            justify-content: center;
            flex-wrap: wrap;
            padding-top: 25px;
            border-top: 2px solid #f0f0f0;
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            .btn {
                width: 100%;
                max-width: 300px;
                margin-bottom: 10px;
            }

            .application-actions {
                flex-direction: column;
                align-items: stretch;
            }
        }
    </style>
</head>
<body>
<h1>管理员面板 - 审核认证申请</h1>

<!-- 用户信息 -->
<div class="user-info">
<p>当前用户: ${sessionScope.currentUser.username} (${sessionScope.currentUser.role})</p>
</div>

<h2>待审核申请列表</h2>
<c:choose>
    <c:when test="${not empty appsWithUserInfo}">
        <div id="applicationsContainer">
            <c:forEach items="${appsWithUserInfo}" var="item">
                <c:set var="application" value="${item.application}" />
                <c:set var="applicantUsername" value="${item.applicantUsername}" />
                <div class="application-item" id="app-${application.id}">
                    <div class="application-header">
                        <h3>申请人: ${applicantUsername} (ID: ${application.id})</h3>
                        <span>提交时间: ${application.submittedAt}</span>
                    </div>
                    <div class="application-content">
                        <h4>答题内容:</h4>
                        <!-- 使用一个div来存放原始JSON字符串，JavaScript将对其进行处理 -->
                        <div class="raw-answers" style="display:none;">${application.answers}</div>
                        <!-- 显示结构化答案的容器 -->
                        <div class="structured-answers-display"></div>
                        <p>答题时长: ${application.examDuration}s</p>
                    </div>
                    <div class="application-actions">
                        <button class="btn btn-approve" onclick="performAction(${application.id}, 'approved', '${applicantUsername}')" data-app-id="${application.id}">通过</button>
                        <button class="btn btn-reject" onclick="performAction(${application.id}, 'rejected', '${applicantUsername}')" data-app-id="${application.id}">不通过</button>
                        <button class="btn btn-pending-discussion" onclick="toggleRemarksForm(${application.id})" data-app-id="${application.id}">待商议</button>
                    </div>
                    <!-- 备注表单位于 actions 下方 -->
                    <div id="remarks-form-${application.id}" class="remarks-form" data-app-id="${application.id}">
                        <textarea id="remarks-input-${application.id}" class="remarks-textarea" data-app-id="${application.id}" placeholder="请输入备注/留言 (可选)"></textarea>
                        <button class="btn btn-approve action-btn" onclick="submitActionWithRemarks(${application.id}, 'pending_discussion', '${applicantUsername}')" data-app-id="${application.id}">提交</button>
                        <button class="btn btn-default action-btn" onclick="cancelRemarks(${application.id})" data-app-id="${application.id}">取消</button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <!-- 空状态提示 -->
        <div class="empty-state">
            <div class="empty-icon">📋</div>
                <p>暂无待审核的认证申请。</p>
        </div>
    </c:otherwise>
</c:choose>

<!-- 底部导航 -->
<div class="page-footer">
    <a href="${pageContext.request.contextPath}/user/admin/user-list" class="manage-link">管理用户</a>
    <a href="${pageContext.request.contextPath}/" class="back-link">返回首页</a>
</div>

<script>
    // 定义全局变量存储上下文路径，确保 JSP EL 正确解析
    const CONTEXT_PATH = "${pageContext.request.contextPath}" || "/"; // 如果 JSP EL 未解析，CONTEXT_PATH 将是空字符串，此时使用 "/" 作为默认值

    // 将 JSP 的问题列表转换为 JavaScript 对象
    const fillBlankQuestions = [
        <c:forEach items="${fillBlankQuestions}" var="q" varStatus="vs">
        { id: ${q.id}, content: "${q.formattedQuestionContent}", type: "${q.questionType}" }<c:if test="${!vs.last}">,</c:if>
        </c:forEach>
    ];

    const openEndedQuestions = [
        <c:forEach items="${openEndedQuestions}" var="q" varStatus="vs">
        { id: ${q.id}, content: "${q.questionContent}", type: "${q.questionType}" }<c:if test="${!vs.last}">,</c:if>
        </c:forEach>
    ];

    // 页面加载完成后，处理每个申请的答案
    document.addEventListener('DOMContentLoaded', function() {
        // --- 按总顺序构建 indexedQuestionMap ---
        const allQuestions = [...fillBlankQuestions, ...openEndedQuestions]; // 合并所有问题
        const indexedQuestionMap = {};
        allQuestions.forEach((q, index) => {
            // 使用总索引 + 1 作为键，例如 fill_blank_1, fill_blank_2, open_ended_3, open_ended_4
            // 需要区分类型，构造正确的键名
            const keyPrefix = q.type === 'fill_blank' ? 'fill_blank_' : 'open_ended_';
            const key = keyPrefix + (index + 1);
            indexedQuestionMap[key] = q;
        });
        console.log("Indexed Question Map (after DOM loaded):", indexedQuestionMap); // 调试日志

        // --- 将 renderStructuredAnswers 也移到这里 ---
        function renderStructuredAnswers(answersObj, container) {
            container.innerHTML = ''; // 清空容器

            // 按照提交的顺序处理答案
            for (const [key, value] of Object.entries(answersObj)) {
                console.log("Looking up question for key:", key); // 调试日志
                const questionInfo = indexedQuestionMap[key];
                if (questionInfo) {
                    console.log("Found question:", questionInfo); // 调试日志
                    const answerItemDiv = document.createElement('div');
                    answerItemDiv.className = 'answer-item';

                    const questionDiv = document.createElement('div');
                    questionDiv.className = 'answer-question';
                    questionDiv.textContent = questionInfo.content;

                    const contentDiv = document.createElement('div');
                    contentDiv.className = 'answer-content';
                    contentDiv.textContent = value || '(未作答)';

                    answerItemDiv.appendChild(questionDiv);
                    answerItemDiv.appendChild(contentDiv);
                    container.appendChild(answerItemDiv);
                } else {
                    // 如果找不到对应的问题，直接显示键值对
                    console.warn("Question not found for key:", key);
                    const fallbackDiv = document.createElement('div');
                    fallbackDiv.textContent = `${key}: ${value}`;
                    container.appendChild(fallbackDiv);
                }
            }
        }
        // --- /renderStructuredAnswers ---

        const applicationItems = document.querySelectorAll('.application-item');
        applicationItems.forEach(item => {
            const rawAnswersDiv = item.querySelector('.raw-answers');
            const structuredDisplayDiv = item.querySelector('.structured-answers-display');
            const rawAnswersJson = rawAnswersDiv.textContent.trim();

            if (rawAnswersJson) {
                try {
                    const answersObj = JSON.parse(rawAnswersJson);
                    console.log("Parsing answers for item:", item.id, "Answers:", answersObj); // 调试日志
                    renderStructuredAnswers(answersObj, structuredDisplayDiv);
                } catch (e) {
                    console.error("Failed to parse answers JSON for application item:", item.id, e);
                    structuredDisplayDiv.innerHTML = '<p style="color: red;">解析答题内容失败: ' + e.message + '</p>';
                }
            } else {
                structuredDisplayDiv.innerHTML = '<p>用户未提交任何答案。</p>';
            }
        });
    });

    // --- toggleRemarksForm 函数 ---
    function toggleRemarksForm(appId) {
        console.log("toggleRemarksForm called with appId:", appId, typeof appId); // 调试日志

        // 尝试直接查找 ID
        const formElement = document.getElementById(`remarks-form-${appId}`);
        console.log("Form element found by ID:", formElement); // 调试日志

        // 如果直接查找失败，尝试通过类名查找并匹配 data-app-id
        if (!formElement) {
            console.log("Direct ID lookup failed. Trying to find by data-app-id attribute.");
            const allForms = document.querySelectorAll('.remarks-form');
            console.log("All forms found:", allForms); // 调试日志
            let targetForm = null;
            for (let i = 0; i < allForms.length; i++) {
                if (allForms[i].getAttribute('data-app-id') == appId) { // 使用 == 比较，因为可能一个是字符串一个是数字
                    targetForm = allForms[i];
                    console.log("Found target form by data-app-id:", targetForm); // 调试日志
                    break;
                }
            }
            if (targetForm) {
                // 关闭其他表单
                allForms.forEach(form => {
                    if (form !== targetForm) {
                        form.style.display = 'none';
                    }
                });
                // 切换当前表单显示状态
                targetForm.style.display = targetForm.style.display === 'block' ? 'none' : 'block';
                console.log("Target form display toggled to:", targetForm.style.display); // 调试日志
                return; // 找到并处理了，退出函数
            } else {
                console.error("Form element not found for appId:", appId, "even by data-app-id.");
                return;
            }
        }

        // 如果直接查找成功
        const otherForms = document.querySelectorAll('.remarks-form');
        // 关闭所有其他表单
        otherForms.forEach(form => {
            if (form.id !== `remarks-form-${appId}`) {
                form.style.display = 'none';
            }
        });
        // 切换当前表单显示状态
        formElement.style.display = formElement.style.display === 'block' ? 'none' : 'block';
        console.log("Form display toggled to:", formElement.style.display); // 调试日志
    }


    function cancelRemarks(appId) {
        const formElement = document.getElementById(`remarks-form-${appId}`);
        if (formElement) {
            formElement.style.display = 'none';
        }
        // 清空输入框
        const textareaElement = document.getElementById(`remarks-input-${appId}`);
        if (textareaElement) {
            textareaElement.value = '';
        }
    }

    function performAction(appId, status, applicantUsername) {
        console.log("performAction called with appId:", appId, "status:", status, "applicantUsername:", applicantUsername); // 调试日志
        if (status === undefined || status === null) {
            console.error("Status is undefined or null!");
            return; // 避免后续错误
        }
        let statusText = '';
        switch(status) {
            case 'approved': statusText = '通过'; break;
            case 'rejected': statusText = '不通过'; break;
            case 'pending_discussion': statusText = '待商议'; break;
            default: statusText = status;
        }
        console.log("statusText calculated as:", statusText); // 调试日志
        if (confirm(`确定要将 ${applicantUsername} (ID: ${appId}) 的申请状态设置为 "${statusText}" 吗？`)) {
            sendActionRequest(appId, status, '');
        }
    }

    function submitActionWithRemarks(appId, status, applicantUsername) {
        console.log("submitActionWithRemarks called with appId:", appId, "status:", status, "applicantUsername:", applicantUsername); // 调试日志
        // 使用容错方式查找 textarea
        let remarksValue = '';
        const textareaElement = document.getElementById(`remarks-input-${appId}`);

        if (textareaElement) {
            remarksValue = textareaElement.value;
        } else {
            console.error("Textarea element not found by ID for appId:", appId);
            // 尝试通过 data-app-id 查找
            const allTextareas = document.querySelectorAll('.remarks-textarea');
            for (let i = 0; i < allTextareas.length; i++) {
                if (allTextareas[i].getAttribute('data-app-id') == appId) {
                    remarksValue = allTextareas[i].value;
                    console.log("Found textarea by data-app-id for appId:", appId, "value:", remarksValue); // 调试日志
                    break;
                }
            }
            if (!remarksValue) {
                console.error("Textarea value could not be retrieved for appId:", appId);
                return; // 无法获取值，终止操作
            }
        }

        let statusText = '';
        switch(status) {
            case 'approved': statusText = '通过'; break;
            case 'rejected': statusText = '不通过'; break;
            case 'pending_discussion': statusText = '待商议'; break;
            default: statusText = status;
        }
        console.log("statusText calculated as:", statusText); // 调试日志
        if (confirm(`确定要将 ${applicantUsername} (ID: ${appId}) 的申请状态设置为 "${statusText}" 并添加备注吗？\n\n备注: ${remarksValue || '(无)'}`)) {
            sendActionRequest(appId, status, remarksValue);
        }
    }

    function sendActionRequest(appId, status, remarks) {
        console.log("sendActionRequest called with appId:", appId, "status:", status, "remarks:", remarks); // 调试日志
        console.log("Using CONTEXT_PATH:", CONTEXT_PATH); // 调试日志

        // --- 使用 URL 构造函数构建 URL ---
        const baseUrl = new URL(CONTEXT_PATH, window.location.origin);
        baseUrl.pathname += '/certification/admin/review/' + appId; // 拼接路径
        const fullUrl = baseUrl.toString();
        console.log("Full fetch URL will be:", fullUrl); // 调试日志
        // --- /修正 ---

        const params = new URLSearchParams();
        params.append('status', status);
        params.append('remarks', remarks);

        fetch(fullUrl, { // 使用构建好的完整 URL
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: params.toString()
        })
            .then(response => {
                if (response.ok) {
                    window.location.reload();
                } else {
                    console.error('Failed to update application:', response.statusText);
                    alert('操作失败，请稍后重试。');
                }
            })
            .catch(error => {
                console.error('Error updating application:', error);
                alert('操作失败，请检查网络或稍后重试。');
            });
    }
</script>
</body>
</html>
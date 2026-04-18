<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>管理员 - 审核认证申请</title>
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

        /* 用户信息卡片 */
        .user-info-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 16px 20px; margin-bottom: 20px; }
        .user-info-text { font-size: 15px; color: #666; margin: 0; }
        .user-info-text strong { color: #0066ff; }

        /* 申请列表卡片 */
        .applications-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); overflow: hidden; }

        /* 单个申请项 */
        .application-item { padding: 24px; border-bottom: 1px solid #f0f0f0; transition: all 0.3s ease; }
        .application-item:last-child { border-bottom: none; }
        .application-item:hover { background: #fafafa; }

        .application-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 12px; }
        .applicant-info h3 { color: #121212; font-size: 18px; margin: 0; font-weight: 600; }
        .applicant-info span { color: #8a8a8a; font-size: 13px; margin-top: 6px; display: block; }

        .application-content { margin-bottom: 20px; }
        .application-content h4 { color: #121212; font-size: 16px; margin-bottom: 15px; font-weight: 600; }

        .answers-container { background: #fafafa; border-radius: 8px; padding: 16px; border: 1px solid #e0e0e0; }
        .answer-item { margin-bottom: 16px; padding-bottom: 16px; border-bottom: 1px dashed #e0e0e0; }
        .answer-item:last-child { border-bottom: none; margin-bottom: 0; padding-bottom: 0; }
        .answer-question { font-weight: 600; color: #121212; font-size: 15px; margin-bottom: 8px; line-height: 1.5; }
        .answer-content { margin-left: 0; color: #666; font-size: 14px; line-height: 1.7; padding: 12px; background: #fff; border-radius: 6px; border-left: 3px solid #0066ff; }

        .exam-duration { display: inline-block; background: #e6f0ff; color: #0066ff; padding: 4px 12px; border-radius: 12px; font-size: 13px; font-weight: 500; margin-top: 12px; }

        .application-actions { display: flex; gap: 12px; margin-top: 20px; padding-top: 20px; border-top: 1px solid #f0f0f0; flex-wrap: wrap; }

        /* 按钮样式 */
        .btn { padding: 10px 20px; border: none; border-radius: 20px; cursor: pointer; font-size: 14px; font-weight: 500; transition: all 0.3s ease; display: inline-flex; align-items: center; justify-content: center; text-decoration: none; gap: 6px; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .btn-approve { background: #28a745; color: white; }
        .btn-approve:hover { background: #218838; }
        .btn-reject { background: #dc3545; color: white; }
        .btn-reject:hover { background: #c82333; }
        .btn-pending-discussion { background: #ffc107; color: #212529; }
        .btn-pending-discussion:hover { background: #e0a800; }
        .btn-default { background: #fafafa; color: #121212; border: 1px solid #e0e0e0; }
        .btn-default:hover { background: #f0f0f0; }

        /* 备注表单 */
        .remarks-form { margin-top: 20px; padding: 20px; background: #fafafa; border-radius: 8px; border: 1px solid #e0e0e0; display: none; animation: fadeIn 0.3s ease; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        .remarks-textarea { width: 100%; padding: 12px; border: 1px solid #e0e0e0; border-radius: 6px; font-size: 14px; resize: vertical; min-height: 80px; transition: border-color 0.3s ease; }
        .remarks-textarea:focus { outline: none; border-color: #0066ff; box-shadow: 0 0 0 3px rgba(0,102,255,0.1); }
        .remarks-form-buttons { display: flex; gap: 10px; margin-top: 15px; }

        /* 底部导航 */
        .page-footer { margin-top: 20px; display: flex; justify-content: center; gap: 15px; flex-wrap: wrap; }
        .back-link { display: inline-block; padding: 10px 24px; background: #fafafa; color: #121212; text-decoration: none; border-radius: 20px; font-weight: 500; font-size: 14px; transition: all 0.3s ease; border: 1px solid #e0e0e0; }
        .back-link:hover { background: #f0f0f0; }

        /* 空状态 */
        .empty-state { text-align: center; padding: 60px 30px; background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin: 20px 0; }
        .empty-icon { font-size: 64px; margin-bottom: 20px; opacity: 0.4; }
        .empty-state p { color: #8a8a8a; font-size: 15px; margin: 10px 0; }

        /* 响应式 */
        @media (max-width: 768px) {
            .header-content { flex-wrap: wrap; height: auto; padding: 10px 0; gap: 10px; }
            .nav-links { width: 100%; justify-content: center; }
            .main-container { padding: 0 15px; }
            .page-header-card { padding: 16px 18px; }
            .page-title { font-size: 20px; }
            .application-item { padding: 16px; }
            .application-header { flex-direction: column; align-items: flex-start; }
            .application-actions { flex-direction: column; }
            .btn { width: 100%; }
            .page-footer { flex-direction: column; }
            .back-link { width: 100%; text-align: center; }
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
        <h1 class="page-title">⚙️ 管理员面板 - 审核认证申请</h1>
    </div>

    <!-- 用户信息 -->
    <div class="user-info-card">
        <p class="user-info-text">👑 当前管理员：<strong>${sessionScope.currentUser.username}</strong> (${sessionScope.currentUser.role})</p>
    </div>

    <div class="applications-card">
        <h2 style="padding: 20px 24px 0; font-size: 18px; font-weight: 600; color: #121212;">📋 待审核申请列表</h2>
        <c:choose>
            <c:when test="${not empty appsWithUserInfo}">
                <div id="applicationsContainer">
                    <c:forEach items="${appsWithUserInfo}" var="item">
                        <c:set var="application" value="${item.application}" />
                        <c:set var="applicantUsername" value="${item.applicantUsername}" />
                        <div class="application-item" id="app-${application.id}">
                            <div class="application-header">
                                <div class="applicant-info">
                                    <h3>申请人：${applicantUsername} (ID: ${application.id})</h3>
                                    <span>提交时间：${application.submittedAt}</span>
                                </div>
                            </div>
                            <div class="application-content">
                                <h4>答题内容:</h4>
                                <div class="raw-answers" style="display:none;">${application.answers}</div>
                                <div class="structured-answers-display"></div>
                                <span class="exam-duration">⏱️ 答题时长：${application.examDuration}秒</span>
                            </div>
                            <div class="application-actions">
                                <button class="btn btn-approve" onclick="performAction(${application.id}, 'approved', '${applicantUsername}')" data-app-id="${application.id}">✅ 通过</button>
                                <button class="btn btn-reject" onclick="performAction(${application.id}, 'rejected', '${applicantUsername}')" data-app-id="${application.id}">❌ 不通过</button>
                                <button class="btn btn-pending-discussion" onclick="toggleRemarksForm(${application.id})" data-app-id="${application.id}">⏳ 待商议</button>
                            </div>
                            <div id="remarks-form-${application.id}" class="remarks-form" data-app-id="${application.id}">
                                <textarea id="remarks-input-${application.id}" class="remarks-textarea" data-app-id="${application.id}" placeholder="请输入备注/留言 (可选)"></textarea>
                                <div class="remarks-form-buttons">
                                    <button class="btn btn-approve" onclick="submitActionWithRemarks(${application.id}, 'pending_discussion', '${applicantUsername}')" data-app-id="${application.id}">提交</button>
                                    <button class="btn btn-default" onclick="cancelRemarks(${application.id})" data-app-id="${application.id}">取消</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">📋</div>
                    <p>暂无待审核的认证申请。</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="page-footer">
        <a href="${pageContext.request.contextPath}/user/admin/user-list" class="back-link">👥 管理用户</a>
        <a href="${pageContext.request.contextPath}/" class="back-link">🏠 返回首页</a>
    </div>
</div>

<script>
    const CONTEXT_PATH = "${pageContext.request.contextPath}" || "/";

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

    document.addEventListener('DOMContentLoaded', function() {
        const allQuestions = [...fillBlankQuestions, ...openEndedQuestions];
        const indexedQuestionMap = {};
        allQuestions.forEach((q, index) => {
            const keyPrefix = q.type === 'fill_blank' ? 'fill_blank_' : 'open_ended_';
            const key = keyPrefix + (index + 1);
            indexedQuestionMap[key] = q;
        });
        console.log("Indexed Question Map:", indexedQuestionMap);

        function renderStructuredAnswers(answersObj, container) {
            container.innerHTML = '';
            for (const [key, value] of Object.entries(answersObj)) {
                console.log("Looking up question for key:", key);
                const questionInfo = indexedQuestionMap[key];
                if (questionInfo) {
                    console.log("Found question:", questionInfo);
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
                    console.warn("Question not found for key:", key);
                    const fallbackDiv = document.createElement('div');
                    fallbackDiv.textContent = `${key}: ${value}`;
                    container.appendChild(fallbackDiv);
                }
            }
        }

        const applicationItems = document.querySelectorAll('.application-item');
        applicationItems.forEach(item => {
            const rawAnswersDiv = item.querySelector('.raw-answers');
            const structuredDisplayDiv = item.querySelector('.structured-answers-display');
            const rawAnswersJson = rawAnswersDiv.textContent.trim();

            if (rawAnswersJson) {
                try {
                    const answersObj = JSON.parse(rawAnswersJson);
                    console.log("Parsing answers for item:", item.id, "Answers:", answersObj);
                    renderStructuredAnswers(answersObj, structuredDisplayDiv);
                } catch (e) {
                    console.error("Failed to parse answers JSON for application item:", item.id, e);
                    structuredDisplayDiv.innerHTML = '<p style="color: red;">解析答题内容失败：' + e.message + '</p>';
                }
            } else {
                structuredDisplayDiv.innerHTML = '<p>用户未提交任何答案。</p>';
            }
        });
    });

    function toggleRemarksForm(appId) {
        console.log("toggleRemarksForm called with appId:", appId, typeof appId);
        const formElement = document.getElementById(`remarks-form-${appId}`);
        console.log("Form element found by ID:", formElement);

        if (!formElement) {
            console.log("Direct ID lookup failed. Trying to find by data-app-id attribute.");
            const allForms = document.querySelectorAll('.remarks-form');
            console.log("All forms found:", allForms);
            let targetForm = null;
            for (let i = 0; i < allForms.length; i++) {
                if (allForms[i].getAttribute('data-app-id') == appId) {
                    targetForm = allForms[i];
                    console.log("Found target form by data-app-id:", targetForm);
                    break;
                }
            }
            if (targetForm) {
                allForms.forEach(form => {
                    if (form !== targetForm) {
                        form.style.display = 'none';
                    }
                });
                targetForm.style.display = targetForm.style.display === 'block' ? 'none' : 'block';
                console.log("Target form display toggled to:", targetForm.style.display);
                return;
            } else {
                console.error("Form element not found for appId:", appId, "even by data-app-id.");
                return;
            }
        }

        const otherForms = document.querySelectorAll('.remarks-form');
        otherForms.forEach(form => {
            if (form.id !== `remarks-form-${appId}`) {
                form.style.display = 'none';
            }
        });
        formElement.style.display = formElement.style.display === 'block' ? 'none' : 'block';
        console.log("Form display toggled to:", formElement.style.display);
    }

    function cancelRemarks(appId) {
        const formElement = document.getElementById(`remarks-form-${appId}`);
        if (formElement) {
            formElement.style.display = 'none';
        }
        const textareaElement = document.getElementById(`remarks-input-${appId}`);
        if (textareaElement) {
            textareaElement.value = '';
        }
    }

    function performAction(appId, status, applicantUsername) {
        console.log("performAction called with appId:", appId, "status:", status, "applicantUsername:", applicantUsername);
        if (status === undefined || status === null) {
            console.error("Status is undefined or null!");
            return;
        }
        let statusText = '';
        switch(status) {
            case 'approved': statusText = '通过'; break;
            case 'rejected': statusText = '不通过'; break;
            case 'pending_discussion': statusText = '待商议'; break;
            default: statusText = status;
        }
        console.log("statusText calculated as:", statusText);
        if (confirm(`确定要将 ${applicantUsername} (ID: ${appId}) 的申请状态设置为 "${statusText}" 吗？`)) {
            sendActionRequest(appId, status, '');
        }
    }

    function submitActionWithRemarks(appId, status, applicantUsername) {
        console.log("submitActionWithRemarks called with appId:", appId, "status:", status, "applicantUsername:", applicantUsername);
        let remarksValue = '';
        const textareaElement = document.getElementById(`remarks-input-${appId}`);

        if (textareaElement) {
            remarksValue = textareaElement.value;
        } else {
            console.error("Textarea element not found by ID for appId:", appId);
            const allTextareas = document.querySelectorAll('.remarks-textarea');
            for (let i = 0; i < allTextareas.length; i++) {
                if (allTextareas[i].getAttribute('data-app-id') == appId) {
                    remarksValue = allTextareas[i].value;
                    console.log("Found textarea by data-app-id for appId:", appId, "value:", remarksValue);
                    break;
                }
            }
            if (!remarksValue) {
                console.error("Textarea value could not be retrieved for appId:", appId);
                return;
            }
        }

        let statusText = '';
        switch(status) {
            case 'approved': statusText = '通过'; break;
            case 'rejected': statusText = '不通过'; break;
            case 'pending_discussion': statusText = '待商议'; break;
            default: statusText = status;
        }
        console.log("statusText calculated as:", statusText);
        if (confirm(`确定要将 ${applicantUsername} (ID: ${appId}) 的申请状态设置为 "${statusText}" 并添加备注吗？\n\n备注：${remarksValue || '(无)'}`)) {
            sendActionRequest(appId, status, remarksValue);
        }
    }

    function sendActionRequest(appId, status, remarks) {
        console.log("sendActionRequest called with appId:", appId, "status:", status, "remarks:", remarks);
        console.log("Using CONTEXT_PATH:", CONTEXT_PATH);

        const baseUrl = new URL(CONTEXT_PATH, window.location.origin);
        baseUrl.pathname += '/certification/admin/review/' + appId;
        const fullUrl = baseUrl.toString();
        console.log("Full fetch URL will be:", fullUrl);

        const params = new URLSearchParams();
        params.append('status', status);
        params.append('remarks', remarks);

        fetch(fullUrl, {
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
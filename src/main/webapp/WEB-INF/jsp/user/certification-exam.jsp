<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>认证用户答题 - PC 硬件交流论坛</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei', sans-serif; background: #f6f6f6; color: #121212; line-height: 1.6; min-height: 100vh; padding-bottom: 40px; }

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
        .main-container { max-width: 900px; margin: 20px auto; padding: 0 20px; }

        /* 页面标题卡片 */
        .page-header-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 20px 24px; margin-bottom: 20px; }
        .page-title { font-size: 24px; font-weight: 700; color: #121212; display: flex; align-items: center; gap: 10px; }

        /* 用户信息卡片 */
        .user-info-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 12px 20px; margin-bottom: 20px; text-align: center; }
        .user-info-text { font-size: 14px; color: #666; }
        .user-info-text strong { color: #0066ff; font-weight: 600; }

        /* 计时器 */
        .timer { position: fixed; top: 70px; right: 20px; background: #fff; padding: 12px 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); border: 1px solid #e0e0e0; z-index: 999; text-align: center; }
        .timer-label { font-size: 12px; color: #8a8a8a; margin-bottom: 4px; }
        .timer span { font-size: 20px; font-weight: 700; color: #0066ff; letter-spacing: 1px; }

        /* 题目区块 */
        .question-block { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 20px 24px; margin-bottom: 20px; transition: all 0.3s ease; }
        .question-block:hover { box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .question-title { font-weight: 600; color: #121212; font-size: 16px; margin-bottom: 12px; padding-left: 10px; border-left: 3px solid #0066ff; }

        /* 输入框 */
        .question-input { width: 100%; padding: 12px 16px; border: 1px solid #e0e0e0; border-radius: 6px; font-size: 14px; transition: all 0.3s ease; background: #fff; color: #121212; box-sizing: border-box; font-family: inherit; margin-top: 8px; resize: vertical; cursor: text; }
        .question-input:focus { outline: none; border-color: #0066ff; box-shadow: 0 0 0 3px rgba(0,102,255,0.1); }
        .question-input::placeholder { color: #9e9e9e; }
        textarea.question-input { min-height: 120px; max-height: 400px; line-height: 1.6; }

        /* 按钮容器 */
        .btn-container { display: flex; gap: 15px; margin-top: 25px; justify-content: center; flex-wrap: wrap; }

        /* 按钮样式 */
        .btn { padding: 12px 28px; border: none; border-radius: 20px; cursor: pointer; font-size: 15px; font-weight: 500; transition: all 0.3s ease; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .btn-warning { background: #ffc107; color: #212529; }
        .btn-warning:hover { background: #e0a800; }
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
            .timer { position: static; margin-bottom: 20px; width: 100%; text-align: center; }
            .question-block { padding: 16px 18px; }
            .question-title { font-size: 15px; }
            .btn-container { flex-direction: column; align-items: stretch; }
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
        <h1 class="page-title">📝 认证用户答题</h1>
    </div>

    <div class="user-info-card">
        <p class="user-info-text">当前用户：<strong>${sessionScope.currentUser.username}</strong></p>
    </div>

    <div class="timer">
        <div class="timer-label">答题用时</div>
        <span id="timeDisplay">00:00:00</span>
    </div>

    <form id="examForm">
        <!-- 填空题部分 -->
        <c:forEach items="${fillBlankQuestions}" var="question" varStatus="status">
            <div class="question-block">
                <div class="question-title">
                    填空题 ${status.index + 1}. ${question.questionContent}
                </div>
                <input
                        type="text"
                        name="fill_blank_${question.id}"
                        id="fill_blank_${question.id}"
                        class="question-input"
                        placeholder="请在此处填写答案"
                >
            </div>
        </c:forEach>

        <!-- 简答题部分 -->
        <c:forEach items="${openEndedQuestions}" var="question" varStatus="status">
            <div class="question-block">
                <div class="question-title">
                    简答题 ${status.index + 1}. ${question.questionContent}
                </div>
                <textarea
                        name="open_ended_${question.id}"
                        id="open_ended_${question.id}"
                        class="question-input"
                        rows="6"
                        placeholder="请在此处填写您的回答"
                ></textarea>
            </div>
        </c:forEach>

        <!-- 按钮组 -->
        <div class="btn-container">
            <button type="button" id="saveDraftBtn" class="btn btn-warning">
                💾 保存草稿
            </button>
            <button type="button" id="submitBtn" class="btn btn-primary">
                ✅ 提交申请
            </button>
            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">
                🏠 返回个人中心
            </a>
        </div>
    </form>
</div>

<script>
    // 计时器逻辑 - 保持原样
    let startTime = ${startTime};
    let timerInterval;
    let elapsedSeconds = 0;

    function formatTime(seconds) {
        const h = Math.floor(seconds / 3600);
        const m = Math.floor((seconds % 3600) / 60);
        const s = seconds % 60;
        return [h, m, s].map(v => v.toString().padStart(2, '0')).join(':');
    }

    function updateTimer() {
        const now = new Date().getTime();
        elapsedSeconds = Math.floor((now - startTime) / 1000);
        document.getElementById('timeDisplay').textContent = formatTime(elapsedSeconds);
    }

    timerInterval = setInterval(updateTimer, 1000);
    updateTimer();

    // 本地草稿保存逻辑 - 保持原样
    const formId = '#examForm';
    const draftKey = 'certification_draft_' + ${sessionScope.currentUser.id};

    function saveDraftToLocalStorage() {
        const formData = $(formId).serializeArray();
        const draftData = {};
        formData.forEach(field => {
            if (field.value.trim() !== '') {
                draftData[field.name] = field.value;
            }
        });
        localStorage.setItem(draftKey, JSON.stringify(draftData));
        console.log("Draft saved to localStorage.");
    }

    function loadDraftFromLocalStorage() {
        const savedDraft = localStorage.getItem(draftKey);
        if (savedDraft) {
            const data = JSON.parse(savedDraft);
            Object.keys(data).forEach(key => {
                const element = document.getElementById(key);
                if (element) {
                    element.value = data[key];
                }
            });
            console.log("Draft loaded from localStorage.");
        }
    }

    $(document).ready(function() {
        loadDraftFromLocalStorage();

        $('#saveDraftBtn').click(function() {
            saveDraftToLocalStorage();
            alert('✓ 草稿已保存至浏览器本地！');
        });

        $('#submitBtn').click(function() {
            submitApplication();
        });
    });

    // 提交逻辑 - 保持原样
    function submitApplication() {
        const formData = $(formId).serializeArray();
        const answers = {};

        formData.forEach(field => {
            const parts = field.name.split('_');
            if (parts.length >= 3) {
                const type = parts.slice(0, 2).join('_');
                const id = parts[2];
                answers[type + '_' + id] = field.value;
            }
        });

        const submissionData = {
            answers: JSON.stringify(answers),
            examDuration: elapsedSeconds
        };

        $.ajax({
            url: '${pageContext.request.contextPath}/certification/apply',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(submissionData),
            success: function(response, textStatus, xhr) {
                console.log("Submission successful:", response);
                localStorage.removeItem(draftKey);
                window.location.href = '${pageContext.request.contextPath}/certification/success';
            },
            error: function(xhr, status, error) {
                console.error("Submission failed:", status, error);
                console.error("Response Text:", xhr.responseText);
                alert('提交失败，请检查网络或稍后再试。\n错误详情：' + error);
            }
        });
    }

    // 页面卸载前保存草稿 - 保持原样
    window.addEventListener('beforeunload', function(e) {
        saveDraftToLocalStorage();
    });
</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>认证用户答题</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
    <style>
        /* 整体布局 - 白色背景 */
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
            margin-bottom: 20px;
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
            margin-bottom: 15px;
            padding: 12px 20px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .user-info strong {
            color: #2c3e50;
            font-weight: 600;
        }

        /* 计时器美化 */
        .timer {
            position: fixed;
            top: 20px;
            right: 20px;
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            padding: 15px 25px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(25, 118, 210, 0.2);
            border: 2px solid #bbdefb;
            z-index: 1000;
            text-align: center;
        }

        .timer span {
            font-size: 24px;
            font-weight: 700;
            color: #1976d2;
            letter-spacing: 2px;
            display: inline-block;
            background: rgba(255, 255, 255, 0.8);
            padding: 5px 15px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        /* 题目区块美化 */
        .question-block {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
        }

        .question-block:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
        }

        /* 题目标题美化 */
        .question-title {
            font-weight: 700;
            color: #2c3e50;
            font-size: 18px;
            margin-bottom: 15px;
            padding-left: 10px;
            border-left: 4px solid #667eea;
        }

        /* 输入框美化 - 修复无法点击问题 */
        .question-input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #fff;
            color: #333;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
            margin-top: 8px;
            resize: vertical;
            cursor: text !important; /* 确保可以点击 */
            pointer-events: auto !important; /* 确保可以交互 */
        }

        .question-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .question-input::placeholder {
            color: #9e9e9e;
            font-style: italic;
        }

        /* 简答题文本域美化 */
        textarea.question-input {
            min-height: 120px;
            max-height: 400px;
            line-height: 1.6;
        }

        /* 按钮容器美化 */
        .btn-container {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            justify-content: center;
            flex-wrap: wrap;
        }

        /* 按钮美化 - 修复点击问题 */
        .btn {
            padding: 12px 28px;
            border: none;
            border-radius: 25px;
            cursor: pointer !important; /* 确保可以点击 */
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

        /* 保存草稿按钮 - 黄色渐变 */
        .btn-warning {
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
            color: #212529;
        }

        .btn-warning:hover {
            background: linear-gradient(135deg, #e0a800 0%, #d39e00 100%);
        }

        /* 提交申请按钮 - 蓝色渐变 */
        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #0069d9 0%, #004494 100%);
        }

        /* 返回按钮 - 灰色渐变 */
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
                margin-bottom: 15px;
            }

            .question-block {
                padding: 20px 15px;
            }

            .question-title {
                font-size: 16px;
            }

            .btn-container {
                flex-direction: column;
                align-items: stretch;
            }

            .btn {
                width: 100%;
                max-width: 300px;
                margin-bottom: 10px;
            }

            .timer {
                position: static;
                margin-bottom: 20px;
            }

            .timer span {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>📝 认证用户答题</h1>

    <div class="user-info">
        <strong>当前用户:</strong> ${sessionScope.currentUser.username}
    </div>

    <div class="timer">
        答题用时: <span id="timeDisplay">00:00:00</span>
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
                alert('提交失败，请检查网络或稍后再试。\n错误详情: ' + error);
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
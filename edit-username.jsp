<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>修改用户名</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
            max-width: 600px;
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

        /* 消息提示美化 */
        p[style*="color: red"],
        p[style*="color: green"] {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 15px;
            font-weight: 500;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            animation: slideDown 0.3s ease;
        }

        p[style*="color: red"] {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
            border-left: 5px solid #dc3545;
        }

        p[style*="color: red"]::before {
            content: '⚠️';
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 24px;
        }

        p[style*="color: red"] span {
            margin-left: 25px;
        }

        p[style*="color: green"] {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
            border-left: 5px solid #28a745;
        }

        p[style*="color: green"]::before {
            content: '✅';
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 24px;
        }

        p[style*="color: green"] span {
            margin-left: 25px;
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

        /* 表单容器美化 */
        .form-container {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 25px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
            margin-bottom: 30px;
        }

        /* 表单字段美化 */
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: 700;
            color: #2c3e50;
            font-size: 16px;
            padding-left: 5px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e0e0e0;
            border-radius: 15px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #fff;
            color: #333;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        input[type="text"]::placeholder,
        input[type="password"]::placeholder {
            color: #9e9e9e;
            font-style: italic;
        }

        /* 只读输入框美化 */
        input[readonly] {
            background: rgba(248, 249, 250, 0.6);
            color: #6c757d;
            cursor: not-allowed;
        }

        /* 错误提示美化 */
        .error {
            color: #dc3545;
            font-size: 14px;
            margin-top: 8px;
            display: block;
            font-weight: 500;
            padding-left: 5px;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-5px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* 按钮组美化 */
        .actions {
            margin-top: 30px;
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
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

        /* 保存按钮 - 蓝色渐变 */
        input[type="submit"].btn {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }

        input[type="submit"].btn:hover {
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
                margin-bottom: 20px;
            }

            h1::after {
                width: 100px;
                height: 3px;
            }

            .form-container {
                padding: 30px 20px;
            }

            .actions {
                flex-direction: column;
                align-items: stretch;
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
    <h1>✏️ 修改用户名</h1>

    <c:if test="${not empty errorMessage}">
        <p style="color: red;">
            <span>${errorMessage}</span>
        </p>
    </c:if>

    <c:if test="${not empty successMessage}">
        <p style="color: green;">
            <span>${successMessage}</span>
        </p>
    </c:if>

    <div class="form-container">
        <form:form action="${pageContext.request.contextPath}/user/update-username" method="post" modelAttribute="user">
            <div class="form-group">
                <label for="currentUsername">当前用户名</label>
                <input type="text" id="currentUsername" value="${currentUser.username}" readonly>
            </div>

            <div class="form-group">
                <label for="newUsername">新用户名</label>
                <form:input path="username" id="newUsername" type="text" required="required"/>
                <form:errors path="username" cssClass="error"/>
            </div>

            <div class="form-group">
                <label for="password">验证密码</label>
                <input type="password" id="password" name="password" required="required"/>
                <span class="error">${passwordError}</span>
            </div>

            <div class="actions">
                <input type="submit" value="💾 保存修改" class="btn">
                <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">
                    🏠 返回个人中心
                </a>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户登录 - PC 硬件交流论坛</title>
    <style>
        /* 知乎风格整体布局 */
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei', sans-serif;
            background-color: #f6f6f6;
            color: #121212;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            max-width: 400px;
            width: 100%;
            padding: 20px;
        }

        /* 标题样式 */
        h1 {
            text-align: center;
            color: #121212;
            font-size: 24px;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .subtitle {
            text-align: center;
            color: #646464;
            font-size: 14px;
            margin-bottom: 32px;
        }

        /* 登录卡片 - 知乎风格白色卡片 */
        .login-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 40px 32px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .login-card:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        /* 错误消息 - 知乎风格提示 */
        .error-message {
            background: #fff3e8;
            color: #ea4d3e;
            padding: 12px 16px;
            border-radius: 4px;
            margin-bottom: 24px;
            font-size: 14px;
            border-left: 3px solid #ea4d3e;
        }

        /* 表单字段 */
        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            display: block;
            font-weight: 500;
            color: #121212;
            font-size: 14px;
            margin-bottom: 8px;
        }

        /* 输入框 - 知乎风格 */
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.2s ease;
            background: #fff;
            color: #121212;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei', sans-serif;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #0066ff;
            box-shadow: 0 0 0 2px rgba(0, 102, 255, 0.1);
        }

        input[type="text"]::placeholder,
        input[type="password"]::placeholder {
            color: #b0b0b0;
        }

        /* 按钮 - 知乎风格主按钮 */
        .btn {
            width: 100%;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .btn:active {
            transform: scale(0.98);
        }

        /* 登录按钮 - 知乎蓝 */
        .btn-login {
            background: #0066ff;
            color: #ffffff;
        }

        .btn-login:hover {
            background: #0059e6;
        }

        /* 注册链接 */
        .register-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #0066ff;
            font-size: 14px;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .register-link:hover {
            color: #0059e6;
            text-decoration: underline;
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            .login-container {
                padding: 16px;
            }

            .login-card {
                padding: 32px 24px;
            }

            h1 {
                font-size: 20px;
            }

            .subtitle {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-card">
        <h1>登录</h1>
        <p class="subtitle">欢迎回到 PC 硬件交流论坛</p>

        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                    ${errorMessage}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/user/login" method="post">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" required placeholder="请输入用户名">
            </div>

            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" required placeholder="请输入密码">
            </div>

            <button type="submit" class="btn btn-login">
                登录
            </button>
        </form>

        <a href="${pageContext.request.contextPath}/user/register" class="register-link">
            没有账号？立即注册
        </a>
    </div>
</div>
</body>
</html>
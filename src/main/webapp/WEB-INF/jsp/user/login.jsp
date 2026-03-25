<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户登录 - PC硬件交流论坛</title>
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

        .login-container {
            max-width: 450px;
            width: 100%;
            margin: 0 auto;
        }

        /* 标题美化 */
        h1 {
            text-align: center;
            color: #2c3e50;
            font-size: 36px;
            margin-bottom: 10px;
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
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 2px;
        }

        .subtitle {
            text-align: center;
            color: #6c757d;
            font-size: 18px;
            margin-bottom: 40px;
            font-weight: 500;
        }

        /* 登录卡片美化 */
        .login-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 25px;
            padding: 45px 40px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .login-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(102, 126, 234, 0.05) 0%, transparent 70%);
            z-index: 0;
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.12);
        }

        /* 错误消息美化 */
        p[style*="color: red"] {
            background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
            color: #c62828 !important;
            padding: 15px 20px;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 4px 15px rgba(211, 47, 47, 0.2);
            border-left: 5px solid #f44336;
            font-weight: 500;
            position: relative;
            overflow: hidden;
            animation: slideDown 0.3s ease;
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
            margin-left: 30px;
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

        /* 表单字段美化 */
        .form-group {
            margin-bottom: 25px;
            position: relative;
            z-index: 1;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #2c3e50;
            font-size: 16px;
            margin-bottom: 10px;
            padding-left: 5px;
        }

        /* 输入框美化 */
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 16px 20px;
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
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        input[type="text"]::placeholder,
        input[type="password"]::placeholder {
            color: #9e9e9e;
            font-style: italic;
        }

        /* 按钮美化 */
        .btn {
            width: 100%;
            padding: 16px 25px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 17px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
            position: relative;
            overflow: hidden;
            gap: 10px;
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
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.18);
        }

        .btn:active {
            transform: translateY(1px);
        }

        /* 登录按钮 - 蓝色渐变 */
        .btn-login {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }

        .btn-login:hover {
            background: linear-gradient(135deg, #0069d9 0%, #004494 100%);
        }

        /* 注册链接美化 */
        .register-link {
            display: block;
            text-align: center;
            margin-top: 25px;
            color: #667eea;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
            z-index: 1;
        }

        .register-link::after {
            content: ' →';
            font-size: 18px;
            transition: all 0.3s ease;
        }

        .register-link:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .register-link:hover::after {
            transform: translateX(3px);
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .login-container {
                max-width: 100%;
            }

            h1 {
                font-size: 30px;
                margin-bottom: 5px;
            }

            h1::after {
                width: 70px;
                height: 2px;
            }

            .subtitle {
                font-size: 16px;
                margin-bottom: 30px;
            }

            .login-card {
                padding: 35px 25px;
                border-radius: 20px;
            }

            .btn {
                padding: 14px 20px;
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-card">
        <h1>🔐 用户登录</h1>
        <p class="subtitle">欢迎回到PC硬件交流论坛</p>

        <c:if test="${not empty errorMessage}">
            <p style="color: red;">
                <span>${errorMessage}</span>
            </p>
        </c:if>

        <form action="${pageContext.request.contextPath}/user/login" method="post">
            <div class="form-group">
                <label for="username">👤 用户名</label>
                <input type="text" id="username" name="username" required placeholder="请输入您的用户名">
            </div>

            <div class="form-group">
                <label for="password">🔒 密码</label>
                <input type="password" id="password" name="password" required placeholder="请输入您的密码">
            </div>

            <button type="submit" class="btn btn-login">
                💡 登录账号
            </button>
        </form>

        <a href="${pageContext.request.contextPath}/user/register" class="register-link">
            没有账号？立即注册
        </a>
    </div>
</div>
</body>
</html>
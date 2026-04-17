<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>帖子已删除 - PC硬件交流论坛</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .error-container {
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

        .error-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(102, 126, 234, 0.05) 0%, transparent 70%);
            z-index: 0;
        }

        .error-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.12);
        }

        /* 标题美化 */
        h1 {
            color: #2c3e50;
            font-size: 42px;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.05);
            letter-spacing: 1px;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            position: relative;
            z-index: 1;
        }

        h1::after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 2px;
        }

        /* 错误图标 */
        .error-icon {
            font-size: 120px;
            margin-bottom: 25px;
            color: #dc3545;
            animation: pulse 2s infinite;
            position: relative;
            z-index: 1;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
                opacity: 1;
            }
            50% {
                transform: scale(1.1);
                opacity: 0.8;
            }
        }

        /* 错误消息美化 */
        .error-message {
            font-size: 22px;
            color: #6c757d;
            margin-bottom: 35px;
            font-weight: 500;
            line-height: 1.8;
            position: relative;
            z-index: 1;
        }

        .error-message strong {
            color: #dc3545;
            font-weight: 700;
        }

        /* 返回按钮美化 */
        .back-link {
            display: inline-block;
            padding: 16px 45px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white !important;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 18px;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            position: relative;
            overflow: hidden;
            gap: 10px;
        }

        .back-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.6s;
        }

        .back-link:hover::before {
            left: 100%;
        }

        .back-link:hover {
            transform: translateY(-4px) scale(1.02);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
            text-decoration: none;
        }

        .back-link:active {
            transform: translateY(2px) scale(0.98);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.3);
        }

        /* 按钮图标 */
        .back-link::after {
            content: '🏠';
            margin-right: 10px;
            font-size: 20px;
            display: inline-block;
        }

        /* 底部提示信息 */
        .error-footer {
            margin-top: 30px;
            color: #6c757d;
            font-size: 15px;
            position: relative;
            z-index: 1;
        }

        .error-footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .error-footer a:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .error-container {
                padding: 40px 20px;
                border-radius: 20px;
            }

            h1 {
                font-size: 32px;
                margin-bottom: 15px;
            }

            h1::after {
                width: 80px;
                height: 3px;
            }

            .error-icon {
                font-size: 80px;
                margin-bottom: 20px;
            }

            .error-message {
                font-size: 18px;
                margin-bottom: 25px;
            }

            .back-link {
                padding: 14px 35px;
                font-size: 16px;
                width: 100%;
                max-width: 300px;
            }

            .back-link::after {
                font-size: 18px;
            }
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-icon">🗑️</div>
    <h1>帖子已删除</h1>
    <p class="error-message">
        很抱歉，您访问的帖子 <strong>已被删除或不存在</strong>。
    </p>
    <a href="${pageContext.request.contextPath}/" class="back-link">返回首页 </a>
    <div class="error-footer">
        <p>如有疑问，请联系管理员</p>
    </div>
</div>
</body>
</html>
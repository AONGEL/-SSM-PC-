<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>认证申请提交成功</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 成功容器 - 毛玻璃效果 */
        .success-container {
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

        .success-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(40, 167, 69, 0.05) 0%, transparent 70%);
            z-index: 0;
        }

        .success-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.12);
        }

        /* 标题美化 */
        h1 {
            color: #2c3e50;
            font-size: 36px;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.05);
            letter-spacing: 1px;
            font-weight: 700;
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
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
            width: 100px;
            height: 4px;
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            border-radius: 2px;
        }

        /* 成功图标 */
        .success-icon {
            font-size: 120px;
            margin-bottom: 25px;
            color: #28a745;
            animation: bounce 1s ease;
            position: relative;
            z-index: 1;
        }

        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-20px);
            }
        }

        /* 成功消息美化 */
        .success-message {
            font-size: 20px;
            color: #495057;
            margin-bottom: 15px;
            font-weight: 500;
            line-height: 1.8;
            position: relative;
            z-index: 1;
        }

        .success-message strong {
            color: #2c3e50;
            font-weight: 700;
        }

        /* 提示信息美化 */
        .info-message {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
            padding: 20px;
            border-radius: 15px;
            margin: 25px 0;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.2);
            border-left: 5px solid #28a745;
            font-size: 16px;
            font-weight: 500;
            position: relative;
            z-index: 1;
        }

        .info-message::before {
            content: 'ℹ️';
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 24px;
        }

        .info-message p {
            margin: 0;
            padding-left: 35px;
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

        /* 主要按钮 - 绿色渐变 */
        .btn-primary {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #218838 0%, #1e7e34 100%);
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .success-container {
                padding: 40px 20px;
                border-radius: 20px;
            }

            h1 {
                font-size: 28px;
                margin-bottom: 15px;
            }

            h1::after {
                width: 80px;
                height: 3px;
            }

            .success-icon {
                font-size: 80px;
                margin-bottom: 20px;
            }

            .success-message {
                font-size: 18px;
                margin-bottom: 12px;
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
    <div class="success-container">
        <div class="success-icon">✅</div>
        <h1>认证申请提交成功！</h1>
        <p class="success-message">
            您的认证申请已 <strong>成功提交</strong>，管理员将会尽快进行审核。
        </p>
        <div class="info-message">
            <p>请您耐心等待审核结果，结果将通过站内信等方式通知您。</p>
        </div>
        <div class="button-group">
            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-primary">
                👤 返回个人中心
            </a>
        </div>
    </div>
</div>
</body>
</html>
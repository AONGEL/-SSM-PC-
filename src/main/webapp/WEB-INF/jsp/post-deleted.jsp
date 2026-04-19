<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>帖子已删除 - PC硬件交流论坛</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei', sans-serif; background: #f6f6f6; color: #121212; line-height: 1.6; min-height: 100vh; }
        a { text-decoration: none; color: inherit; }

        /* ================= 顶部 Header (知乎风格) ================= */
        .header { background: #fff; box-shadow: 0 1px 3px rgba(0,0,0,0.1); position: sticky; top: 0; z-index: 1000; padding: 0 20px; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; height: 56px; }
        .logo { font-size: 22px; font-weight: 700; color: #0066ff; text-decoration: none; display: flex; align-items: center; gap: 8px; }
        .logo:hover { color: #0055dd; }
        .nav-links { display: flex; align-items: center; gap: 20px; }
        .nav-links a { color: #121212; text-decoration: none; font-size: 15px; padding: 8px 16px; border-radius: 20px; transition: all 0.3s ease; }
        .nav-links a:hover { background: #f0f0f0; color: #0066ff; }
        .nav-links .highlight { background: #0066ff; color: #fff; }
        .nav-links .highlight:hover { background: #0055dd; }

        /* 响应式 */
        @media (max-width: 768px) {
            .header-content { flex-wrap: wrap; height: auto; padding: 10px 0; gap: 10px; }
            .nav-links { width: 100%; justify-content: center; }
        }

        /* 错误页面主体内容 */
        .error-page-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 56px);
            padding: 40px 20px;
        }

        .error-container {
            text-align: center;
            padding: 60px 40px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            max-width: 500px;
            width: 100%;
        }

        .error-icon {
            font-size: 80px;
            margin-bottom: 20px;
        }

        h1 {
            color: #121212;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 16px;
        }

        .error-message {
            font-size: 16px;
            color: #8a8a8a;
            margin-bottom: 24px;
            line-height: 1.6;
        }

        .back-link {
            display: inline-block;
            padding: 10px 24px;
            background: #0066ff;
            color: #fff !important;
            border-radius: 4px;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background: #0055dd;
            transform: translateY(-1px);
        }

        .error-footer {
            margin-top: 20px;
            color: #8a8a8a;
            font-size: 14px;
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            .error-page-wrapper {
                min-height: calc(100vh - 80px);
                padding: 20px 10px;
            }

            .error-container {
                padding: 40px 20px;
            }

            h1 {
                font-size: 20px;
            }

            .error-icon {
                font-size: 60px;
            }

            .error-message {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
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

<div class="error-page-wrapper">
    <div class="error-container">
        <div class="error-icon">🗑️</div>
        <h1>帖子已删除</h1>
        <p class="error-message">
            很抱歉，您访问的帖子已被删除或不存在。
        </p>
        <a href="${pageContext.request.contextPath}/" class="back-link">返回首页</a>
        <div class="error-footer">
            <p>如有疑问，请联系管理员</p>
        </div>
    </div>
</div>
</body>
</html>
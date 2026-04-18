<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>认证申请提交成功 - PC 硬件交流论坛</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei', sans-serif; background: #f6f6f6; color: #121212; line-height: 1.6; min-height: 100vh; display: flex; flex-direction: column; }

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
        .main-container { flex: 1; display: flex; justify-content: center; align-items: center; padding: 40px 20px; }

        /* 成功卡片 */
        .success-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 60px 40px; text-align: center; max-width: 500px; width: 100%; transition: all 0.3s ease; }
        .success-card:hover { box-shadow: 0 4px 12px rgba(0,0,0,0.1); }

        .success-icon { font-size: 80px; margin-bottom: 20px; }

        .success-title { font-size: 24px; font-weight: 700; color: #121212; margin-bottom: 16px; }

        .success-message { font-size: 16px; color: #666; margin-bottom: 20px; line-height: 1.6; }
        .success-message strong { color: #121212; font-weight: 600; }

        .info-box { background: #e6f7ed; border-left: 4px solid #28a745; padding: 16px 20px; border-radius: 6px; margin: 25px 0; text-align: left; }
        .info-box p { margin: 0; color: #155724; font-size: 14px; line-height: 1.6; }

        .button-group { display: flex; gap: 15px; margin-top: 30px; justify-content: center; flex-wrap: wrap; }
        .btn { padding: 12px 28px; border: none; border-radius: 20px; cursor: pointer; font-size: 15px; font-weight: 500; transition: all 0.3s ease; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .btn-primary { background: #0066ff; color: #fff; }
        .btn-primary:hover { background: #0055dd; }

        /* 响应式 */
        @media (max-width: 768px) {
            .header-content { flex-wrap: wrap; height: auto; padding: 10px 0; gap: 10px; }
            .nav-links { width: 100%; justify-content: center; }
            .main-container { padding: 20px 15px; }
            .success-card { padding: 40px 20px; }
            .success-icon { font-size: 60px; }
            .success-title { font-size: 20px; }
            .success-message { font-size: 15px; }
            .button-group { flex-direction: column; align-items: stretch; }
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
    <div class="success-card">
        <div class="success-icon">✅</div>
        <h1 class="success-title">认证申请提交成功！</h1>
        <p class="success-message">
            您的认证申请已 <strong>成功提交</strong>，管理员将会尽快进行审核。
        </p>
        <div class="info-box">
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
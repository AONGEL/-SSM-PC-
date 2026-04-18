<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>修改用户名</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei', sans-serif; background: #f6f6f6; color: #121212; line-height: 1.6; min-height: 100vh; }

        .header { background: #fff; box-shadow: 0 1px 3px rgba(0,0,0,0.1); position: sticky; top: 0; z-index: 1000; padding: 0 20px; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; height: 56px; }
        .logo { font-size: 22px; font-weight: 700; color: #0066ff; text-decoration: none; display: flex; align-items: center; gap: 8px; }
        .logo:hover { color: #0055dd; }
        .nav-links { display: flex; align-items: center; gap: 20px; }
        .nav-links a { color: #121212; text-decoration: none; font-size: 15px; padding: 8px 16px; border-radius: 20px; transition: all 0.3s ease; }
        .nav-links a:hover { background: #f0f0f0; color: #0066ff; }

        .nav-tabs { background: #fff; border-bottom: 1px solid #e6e6e6; }
        .tabs-container { max-width: 1200px; margin: 0 auto; display: flex; padding: 0 20px; }
        .tab-item { padding: 15px 20px; cursor: pointer; border-bottom: 2px solid transparent; color: #646464; transition: all 0.3s; font-size: 15px; }
        .tab-item:hover { color: #0066ff; }
        .tab-item.active { border-bottom: 2px solid #0066ff; color: #0066ff; }

        .main-container { max-width: 600px; margin: 20px auto; padding: 0 20px; }
        .card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); overflow: hidden; margin-bottom: 20px; }
        .card-header { padding: 20px; border-bottom: 1px solid #f0f0f0; }
        .card-title { font-size: 18px; font-weight: 600; color: #121212; }
        .card-body { padding: 20px; }

        .message { padding: 15px 20px; border-radius: 8px; margin-bottom: 20px; font-weight: 500; }
        .message-error { background: #f8d7da; color: #721c24; border-left: 4px solid #dc3545; }
        .message-success { background: #d4edda; color: #155724; border-left: 4px solid #28a745; }

        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; color: #121212; font-size: 15px; }
        input[type="text"], input[type="password"] { width: 100%; padding: 12px 16px; border: 1px solid #e0e0e0; border-radius: 8px; font-size: 15px; transition: all 0.3s ease; background: #fff; color: #121212; font-family: inherit; }
        input[type="text"]:focus, input[type="password"]:focus { outline: none; border-color: #0066ff; box-shadow: 0 0 0 3px rgba(0,102,255,0.1); }
        input[readonly] { background: #fafafa; color: #646464; cursor: not-allowed; }
        .error { color: #dc3545; font-size: 13px; margin-top: 6px; display: block; font-weight: 500; }

        .actions { display: flex; gap: 12px; justify-content: center; margin-top: 24px; }
        .btn { padding: 12px 28px; border: none; border-radius: 8px; cursor: pointer; font-size: 15px; font-weight: 500; transition: all 0.3s ease; text-decoration: none; display: inline-flex; align-items: center; justify-content: center; gap: 8px; }
        .btn-primary { background: #0066ff; color: #fff; }
        .btn-primary:hover { background: #0055dd; }
        .btn-secondary { background: #fafafa; color: #121212; border: 1px solid #e0e0e0; }
        .btn-secondary:hover { background: #f0f0f0; }
        input[type="submit"].btn { width: auto; }

        @media (max-width: 600px) {
            .header-content { flex-wrap: wrap; height: auto; padding: 10px 0; gap: 10px; }
            .nav-links { width: 100%; justify-content: center; }
            .actions { flex-direction: column; }
            .btn { width: 100%; }
        }
    </style>
</head>
<body>
<header class="header">
    <div class="header-content">
        <a href="${pageContext.request.contextPath}/" class="logo">💻 PC 硬件交流论坛</a>
        <nav class="nav-links">
            <c:choose>
                <c:when test="${sessionScope.currentUser != null}">
                    <span style="color: #646464; font-size: 14px;">欢迎, ${sessionScope.currentUser.username}</span>
                    <a href="${pageContext.request.contextPath}/user/profile">👤 个人中心</a>
                    <a href="${pageContext.request.contextPath}/user/logout">🚪 退出</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/login">🔑 登录</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </div>
</header>

<div class="main-container">
    <div class="card">
        <div class="card-header">
            <h1 class="card-title">✏️ 修改用户名</h1>
        </div>
        <div class="card-body">
            <c:if test="${not empty errorMessage}">
                <div class="message message-error">${errorMessage}</div>
            </c:if>

            <c:if test="${not empty successMessage}">
                <div class="message message-success">${successMessage}</div>
            </c:if>

            <form:form action="${pageContext.request.contextPath}/user/update-username" method="post" modelAttribute="user">
                <div class="form-group">
                    <label for="currentUsername">当前用户名</label>
                    <input type="text" id="currentUsername" value="${currentUser.username}" readonly>
                </div>

                <div class="form-group">
                    <label for="newUsername">新用户名</label>
                    <form:input path="username" id="newUsername" type="text" required="required" placeholder="请输入新用户名"/>
                    <form:errors path="username" cssClass="error"/>
                </div>

                <div class="form-group">
                    <label for="password">验证密码</label>
                    <input type="password" id="password" name="password" required="required" placeholder="请输入您的密码"/>
                    <span class="error">${passwordError}</span>
                </div>

                <div class="actions">
                    <input type="submit" value="💾 保存修改" class="btn btn-primary">
                    <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">🏠 返回个人中心</a>
                </div>
            </form:form>
        </div>
    </div>
</div>
</body>
</html>
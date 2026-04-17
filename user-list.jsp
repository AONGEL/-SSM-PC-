<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%// 服务器端获取 contextPath
    String contextPath = request.getContextPath();
%>
<html>
<head>
    <title>管理员 - 认证用户管理</title>
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

        /* 当前用户信息美化 */
        .current-user-info {
            text-align: center;
            padding: 15px 30px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 15px;
            margin-bottom: 30px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        .current-user-info p {
            color: #6c757d;
            font-size: 18px;
            margin: 0;
        }

        .current-user-info strong {
            color: #2c3e50;
            font-weight: 600;
        }

        /* 用户列表卡片美化 */
        .user-list-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .user-list-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(102, 126, 234, 0.05) 0%, transparent 70%);
            z-index: 0;
        }

        .user-list-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
        }

        /* 用户项美化 */
        .user-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            margin-bottom: 10px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 12px;
            border: 1px solid #e9ecef;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .user-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .user-item:hover {
            background: rgba(40, 167, 69, 0.05);
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .user-item:hover::before {
            opacity: 1;
        }

        /* 用户信息美化 */
        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-id {
            font-weight: 700;
            color: #2c3e50;
            font-size: 16px;
        }

        .user-username {
            font-weight: 600;
            color: #2c3e50;
            font-size: 18px;
        }

        /* 认证用户标识 */
        .certified-badge {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 14px;
            font-weight: 700;
            margin-left: 15px;
            box-shadow: 0 2px 8px rgba(40, 167, 69, 0.3);
        }

        /* 按钮美化 */
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            gap: 6px;
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
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
        }

        .btn:active {
            transform: translateY(1px);
        }

        /* 撤销认证按钮 - 红色渐变 */
        .btn-revoke {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
        }

        .btn-revoke:hover {
            background: linear-gradient(135deg, #c82333 0%, #bd2130 100%);
        }

        /* 返回按钮 - 灰色渐变 */
        .btn-back {
            display: inline-block;
            padding: 12px 28px;
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
            margin-top: 15px;
            display: block;
            width: fit-content;
            margin: 25px auto 0;
        }

        .btn-back:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(108, 117, 125, 0.4);
            background: linear-gradient(135deg, #5a6268 0%, #4e555b 100%);
        }

        /* 空状态美化 */
        .empty-state {
            text-align: center;
            padding: 60px 30px;
            color: #6c757d;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            margin: 30px 0;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .empty-state h3 {
            color: #2c3e50;
            font-size: 28px;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .empty-state p {
            color: #6c757d;
            font-size: 18px;
            margin: 10px 0;
            font-weight: 500;
        }

        .empty-icon {
            font-size: 80px;
            margin-bottom: 25px;
            color: rgba(40, 167, 69, 0.5);
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            h1 {
                font-size: 28px;
                margin-bottom: 15px;
            }

            h1::after {
                width: 100px;
                height: 3px;
            }

            .current-user-info {
                font-size: 16px;
                padding: 12px 20px;
            }

            .user-list-card {
                padding: 25px 20px;
            }

            .user-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
                padding: 15px;
            }

            .user-info {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }

            .btn {
                width: 100%;
                max-width: 200px;
                margin-top: 10px;
            }

            .btn-back {
                width: 100%;
                max-width: 300px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>🎓 认证用户管理</h1>

    <div class="current-user-info">
        <p>👑 <strong>当前管理员:</strong> ${sessionScope.currentUser.username} (${sessionScope.currentUser.role})</p>
    </div>

    <div class="user-list-card">
        <h2 style="color: #2c3e50; font-size: 24px; margin-bottom: 20px; font-weight: 700;">📋 认证用户列表</h2>

        <c:choose>
            <c:when test="${not empty users}">
                <div id="usersContainer">
                    <c:forEach items="${users}" var="user">
                        <!-- 只显示认证用户 -->
                        <c:if test="${user.role == 'CERTIFIED'}">
                            <div class="user-item">
                                <div class="user-info">
                                    <span class="user-id">ID: ${user.id}</span>
                                    <span class="user-username">👤 ${user.username}</span>
                                    <span class="certified-badge">🎓 认证用户</span>
                                </div>

                                <button class="btn btn-revoke"
                                        onclick="revokeCertification(parseInt(${user.id}), '${user.username}')">
                                    🚫 撤销认证
                                </button>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">📭</div>
                    <h3>暂无认证用户</h3>
                    <p>当前系统中还没有认证用户</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <a href="${pageContext.request.contextPath}/" class="btn-back">
        🏠 返回首页
    </a>
</div>

<!-- 保留原有的JavaScript逻辑，完全不变 -->
<script>
    function revokeCertification(userId, username) {
        console.log("revokeCertification called with userId:", userId, "type:", typeof userId, "and username:", username);
        if (userId == null || userId === '' || isNaN(userId)) {
            console.error("Invalid userId provided:", userId, "Type:", typeof userId);
            alert("无效的用户ID，无法撤销认证。");
            return;
        }
        const reason = prompt(`确定要撤销用户 "${username}" 的认证吗？\n请输入原因（可选）:`);
        if (reason !== null) {
            const jspContextPath = "${pageContext.request.contextPath}";
            console.log("JSP Context Path inside function:", jspContextPath);
            const constructedUrl = jspContextPath + "/certification/admin/revoke/" + userId;
            console.log("Final constructed URL for fetch:", constructedUrl);
            fetch(constructedUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({ reason: reason })
            })
                .then(response => {
                    console.log("Fetch response received with status:", response.status);
                    return response.text();
                })
                .then(result => {
                    console.log("Raw response text:", result);
                    try {
                        const parsedResult = JSON.parse(result);
                        if (parsedResult.status === 'success') {
                            alert('✅ 认证撤销成功！');
                            location.reload();
                        } else {
                            alert('❌ 认证撤销失败！服务器返回: ' + parsedResult.message);
                        }
                    } catch (e) {
                        console.error("Failed to parse response as JSON:", e);
                        console.error("Response text was:", result);
                        alert('操作失败，服务器返回非JSON格式响应。请检查网络或稍后重试。');
                    }
                })
                .catch(error => {
                    console.error('Error revoking certification:', error);
                    alert('操作失败，请检查网络或稍后重试。');
                });
        }
    }
</script>
</body>
</html>
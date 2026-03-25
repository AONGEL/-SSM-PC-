<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>PC硬件交流论坛</title>
    <style>
        /* 整体布局 - 白色背景 */
        body {
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* ========== 顶部信息栏 ========== */
        .top-bar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            padding: 12px 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .top-bar .time-info {
            font-size: 14px;
            opacity: 0.9;
        }

        .top-bar .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .top-bar .user-info span {
            font-size: 15px;
            font-weight: 500;
        }

        .top-bar .user-info a {
            color: #fff;
            text-decoration: none;
            padding: 6px 15px;
            border-radius: 20px;
            transition: all 0.3s ease;
            font-weight: 500;
            font-size: 14px;
        }

        .top-bar .user-info a:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        /* ========== 主标题 ========== */
        .main-title {
            text-align: center;
            color: #2c3e50;
            font-size: 42px;
            margin: 40px 0 30px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.05);
            letter-spacing: 2px;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            position: relative;
        }

        .main-title::after {
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

        /* ========== Tab导航栏 ========== */
        .tab-nav-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 15px 0;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
            margin: 0 auto 30px;  /* 居中 + 底部间距 */
            max-width: 800px;     /* 横条最大宽度 */
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .tab-nav {
            display: flex;
            justify-content: center;
            gap: 30px;
            list-style: none;
            padding: 0;
            max-width: 1000px;
            margin: 0 auto;
        }

        .tab-nav li {
            position: relative;
        }

        .tab-nav a {
            display: inline-block;
            padding: 12px 30px;
            color: #6c757d;
            text-decoration: none;
            font-size: 17px;
            font-weight: 600;
            border-radius: 25px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .tab-nav a::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.2), transparent);
            transition: left 0.5s;
        }

        .tab-nav a:hover::before {
            left: 100%;
        }

        .tab-nav a:hover {
            color: #667eea;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
        }

        .tab-nav a.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 20px rgba(102, 126, 234, 0.4);
            transform: translateY(-2px);
        }

        /* ========== 内容卡片 ========== */
        .content-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.18);
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }

        .content-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 100%);
            z-index: 0;
        }

        .content-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
        }

        .content-card::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            z-index: 0;
        }

        /* 卡片标题 */
        .card-title {
            color: #2c3e50;
            font-size: 26px;
            margin-bottom: 25px;
            font-weight: 700;
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-title::before {
            content: '•';
            font-size: 36px;
            color: #667eea;
            font-weight: bold;
        }

        /* ========== 最新帖子列表 ========== */
        .latest-posts-list {
            list-style: none;
            padding: 0;
            margin: 0;
            position: relative;
            z-index: 1;
        }

        .latest-post-item {
            padding: 20px;
            border-bottom: 1px solid #e9ecef;
            transition: all 0.3s ease;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .latest-post-item:last-child {
            border-bottom: none;
        }

        .latest-post-item:hover {
            background: rgba(102, 126, 234, 0.03);
            padding-left: 25px;
            border-left: 4px solid #667eea;
        }

        /* 帖子标题 */
        .latest-post-title {
            font-weight: 700;
            color: #2c3e50;
            text-decoration: none;
            font-size: 18px;
            transition: all 0.3s ease;
            display: inline-block;
            max-width: 200px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .latest-post-title:hover {
            color: #667eea;
            text-decoration: underline;
        }

        /* 帖子元信息 */
        .latest-post-meta {
            display: flex;
            align-items: center;
            gap: 20px;
            font-size: 14px;
            color: #6c757d;
        }

        .latest-post-author,
        .latest-post-section,
        .latest-post-date {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .latest-post-author::before {
            content: '👤';
        }

        .latest-post-section::before {
            content: '📁';
        }

        .latest-post-date::before {
            content: '📅';
        }

        /* ========== 未登录状态 ========== */
        .not-logged-in {
            text-align: center;
            padding: 40px 20px;
            position: relative;
            z-index: 1;
        }

        .not-logged-in h3 {
            color: #6c757d;
            font-size: 20px;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .not-logged-in .login-links {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .not-logged-in .login-links a {
            display: inline-block;
            padding: 10px 30px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            font-size: 15px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .not-logged-in .login-links a.login-btn {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }

        .not-logged-in .login-links a.register-btn {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
        }

        .not-logged-in .login-links a:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        /* ========== 空状态提示 ========== */
        .empty-state {
            text-align: center;
            padding: 60px 30px;
            color: #6c757d;
            position: relative;
            z-index: 1;
        }

        .empty-state .empty-icon {
            font-size: 64px;
            margin-bottom: 20px;
            color: #adb5bd;
        }

        .empty-state p {
            font-size: 18px;
            margin: 10px 0;
            font-weight: 500;
        }

        /* ========== 底部版权信息 ========== */
        .footer {
            text-align: center;
            color: #6c757d;
            font-size: 14px;
            margin-top: 50px;
            padding: 20px;
            border-top: 1px solid #e9ecef;
            position: relative;
            z-index: 1;
        }

        /* ========== 响应式调整 ========== */
        @media (max-width: 768px) {
            .top-bar {
                flex-direction: column;
                gap: 10px;
                padding: 15px;
            }

            .top-bar .time-info,
            .top-bar .user-info {
                width: 100%;
                justify-content: center;
            }

            .main-title {
                font-size: 32px;
                margin: 30px 0 20px;
            }

            .main-title::after {
                width: 80px;
                height: 3px;
            }

            .tab-nav {
                flex-wrap: wrap;
                gap: 10px;
            }

            .tab-nav a {
                padding: 10px 20px;
                font-size: 15px;
            }

            .content-card {
                padding: 20px;
            }

            .card-title {
                font-size: 22px;
            }

            .latest-post-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .latest-post-meta {
                flex-wrap: wrap;
                width: 100%;
            }

            .not-logged-in .login-links {
                flex-direction: column;
                gap: 10px;
            }

            .not-logged-in .login-links a {
                width: 100%;
            }
        }

        /* ========== 动画效果 ========== */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .content-card {
            animation: fadeInUp 0.6s ease-out;
        }

        .content-card:nth-child(1) { animation-delay: 0.1s; }
        .content-card:nth-child(2) { animation-delay: 0.2s; }
        .content-card:nth-child(3) { animation-delay: 0.3s; }

        /* ========== 链接样式 ========== */
        a {
            color: #667eea;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        a:hover {
            color: #764ba2;
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <!-- 顶部信息栏 -->
    <div class="top-bar">
    <div class="time-info">
        <span>⏰ 当前日期时间: </span>
        <span id="currentTime">-- ::</span>
        <script>
            // 立即执行时间更新
            (function() {
                function updateCurrentTime() {
                    var now = new Date();
                    var year = now.getFullYear();
                    var month = String(now.getMonth() + 1).padStart(2, '0');
                    var day = String(now.getDate()).padStart(2, '0');
                    var hours = String(now.getHours()).padStart(2, '0');
                    var minutes = String(now.getMinutes()).padStart(2, '0');
                    var seconds = String(now.getSeconds()).padStart(2, '0');

                    var formattedTime = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
                    document.getElementById('currentTime').textContent = formattedTime;
                }

                // 立即更新一次
                updateCurrentTime();
                // 每秒更新一次
                setInterval(updateCurrentTime, 1000);
            })();
        </script>
    </div>
    <div class="user-info">
        <c:choose>
            <c:when test="${sessionScope.currentUser != null}">
                <span>👤 欢迎, ${sessionScope.currentUser.username}</span>
                <a href="${pageContext.request.contextPath}/user/profile">👤 个人中心</a>
                <a href="${pageContext.request.contextPath}/user/logout">🚪 登出</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/user/login">🔑 登录</a>
                <a href="${pageContext.request.contextPath}/user/register">📝 注册</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

    <!-- 主标题 -->
    <h1 class="main-title">欢迎来到PC硬件交流论坛！</h1>

    <!-- Tab导航栏 -->
    <div class="tab-nav-container">
        <ul class="tab-nav">
        <li><a href="${pageContext.request.contextPath}/forum/section" class="active">📁 论坛分区</a></li>
        <li><a href="${pageContext.request.contextPath}/hardware-library" class="active">📊 硬件参数库</a></li>
    </ul>
    </div>

    <div class="container">
        <!-- 最新帖子卡片 -->
        <div class="content-card">
        <h2 class="card-title">最新帖子</h2>
        <ul class="latest-posts-list">
            <c:choose>
                <c:when test="${not empty latestPosts}">
                    <c:forEach items="${latestPosts}" var="post">
                        <li class="latest-post-item">
                            <a href="${pageContext.request.contextPath}/post/${post.id}" class="latest-post-title">
                                <c:choose>
                                    <c:when test="${fn:length(post.title) > 7}">
                                        ${fn:substring(post.title, 0, 7)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${post.title}
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            <div class="latest-post-meta">
                                <span class="latest-post-author">${post.authorUsername}</span>
                                <span class="latest-post-section">${post.sectionName}</span>
                                <span class="latest-post-date">
                                        <fmt:formatDate value="${post.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                    </span>
                            </div>
                        </li>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">📭</div>
                        <p>暂无最新帖子</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
    </div>

    <!-- 底部版权信息 -->
    <div class="footer">
    <p>© 2026 PC硬件交流论坛 </p>
</div>

</body>
</html>
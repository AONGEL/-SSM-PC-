<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${section.name} - 帖子列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
        }

        .container {
            max-width: 1200px;
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

        /* 板块描述美化 */
        .section-description {
            text-align: center;
            color: #6c757d;
            font-size: 18px;
            margin-bottom: 30px;
            padding: 15px 30px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        /* 帖子卡片美化 */
        .post-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            cursor: default;
        }

        .post-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(102, 126, 234, 0.05) 0%, transparent 70%);
            z-index: 0;
        }

        .post-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
        }

        /* 帖子标题美化 */
        .post-title {
            display: flex;
            align-items: center;
            margin: 0 0 15px 0;
            gap: 10px;
            position: relative;
            z-index: 1;
        }

        .post-title h3 {
            margin: 0;
            font-size: 22px;
            font-weight: 700;
            position: relative;
            z-index: 1;
        }

        /* 修复链接点击问题 */
        .post-title a {
            color: #2c3e50;
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
            z-index: 2;
            display: inline-block;
            cursor: pointer !important;
        }

        .post-title a:hover {
            color: #667eea;
            text-decoration: underline;
        }

        /* 置顶标签美化 */
        .pinned-tag {
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            color: #1976d2;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 13px;
            font-weight: 600;
            display: inline-block;
            box-shadow: 0 2px 8px rgba(25, 118, 210, 0.2);
            position: relative;
            z-index: 2;
        }

        /* 锁定标签美化 */
        .locked-tag {
            background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
            color: #d32f2f;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 13px;
            font-weight: 600;
            display: inline-block;
            box-shadow: 0 2px 8px rgba(211, 47, 47, 0.2);
            position: relative;
            z-index: 2;
        }

        /* 帖子信息美化 */
        .post-info {
            color: #6c757d;
            font-size: 15px;
            margin-bottom: 15px;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            position: relative;
            z-index: 1;
        }

        .post-info-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .post-info-item strong {
            color: #2c3e50;
            font-weight: 600;
        }

        /* 用户角色标识美化 */
        .user-role {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 700;
            margin-left: 8px;
            vertical-align: middle;
        }

        .role-regular {
            background-color: #e9ecef;
            color: #495057;
        }

        .role-certified {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
        }

        .role-admin {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
        }

        /* ========== 帖子操作按钮区域 ========== */
        .post-actions {
            display: flex;
            gap: 12px;
            margin-top: 25px;
            flex-wrap: wrap;
            justify-content: flex-start;
            padding: 15px 20px;
            background: rgba(255, 255, 255, 0.5);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            align-items: center;
            line-height: 1;
        }

        /* 表单容器对齐问题 */
        .post-actions form {
            display: inline-block !important;
            margin: 0 !important;
            padding: 0 !important;
            vertical-align: middle !important;
            line-height: normal !important;
            height: auto !important;
        }

        /* ========== 统一所有按钮样式 ========== */
        .post-actions a,
        .post-actions input[type="submit"] {
            padding: 0 24px !important; /* 让padding只控制左右 */
            border: none !important;
            border-radius: 25px !important;
            cursor: pointer !important;
            font-size: 15px !important;
            font-weight: 600 !important;
            transition: all 0.3s ease !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            text-decoration: none !important;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1) !important;
            position: relative !important;
            overflow: hidden !important;
            gap: 8px !important;
            min-width: 110px !important;
            height: 48px !important;
            line-height: 48px !important; /* 行高等于高度 */
            box-sizing: border-box !important;
            text-align: center !important;
            vertical-align: middle !important; /* 强制垂直居中 */
            margin: 0 !important;
        }

        /* input按钮的内部对齐 */
        .post-actions input[type="submit"] {
            appearance: none !important;
            -webkit-appearance: none !important;
            -moz-appearance: none !important;
            text-align: center !important;
            line-height: 48px !important;
        }

        /* 悬停效果 */
        .post-actions a:hover,
        .post-actions input[type="submit"]:hover {
            transform: translateY(-3px) !important;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15) !important;
        }

        /* 点击效果 */
        .post-actions a:active,
        .post-actions input[type="submit"]:active {
            transform: translateY(1px) !important;
        }

        /* 光流动画 */
        .post-actions a::before,
        .post-actions input[type="submit"]::before {
            content: '' !important;
            position: absolute !important;
            top: 0 !important;
            left: -100% !important;
            width: 100% !important;
            height: 100% !important;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent) !important;
            transition: left 0.5s !important;
        }

        .post-actions a:hover::before,
        .post-actions input[type="submit"]:hover::before {
            left: 100% !important;
        }

        /* ========== 编辑按钮 - 蓝色渐变 ========== */
        .post-actions a[href*="/edit"] {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%) !important;
            color: white !important;
        }

        .post-actions a[href*="/edit"]:hover {
            background: linear-gradient(135deg, #0069d9 0%, #004494 100%) !important;
        }

        /* ========== 删除按钮 - 红色渐变 ========== */
        .post-actions input[type="submit"][value*="删除"] {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%) !important;
            color: white !important;
        }

        .post-actions input[type="submit"][value*="删除"]:hover {
            background: linear-gradient(135deg, #c82333 0%, #bd2130 100%) !important;
        }

        /* ========== 置顶按钮 - 紫色渐变 ========== */
        .post-actions input[type="submit"][value*="置顶"] {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
            color: white !important;
        }

        .post-actions input[type="submit"][value*="置顶"]:hover {
            background: linear-gradient(135deg, #5568d3 0%, #653a8f 100%) !important;
        }

        /* ========== 取消置顶按钮 - 灰色渐变 ========== */
        .post-actions input[type="submit"][value*="取消置顶"] {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%) !important;
            color: white !important;
        }

        .post-actions input[type="submit"][value*="取消置顶"]:hover {
            background: linear-gradient(135deg, #5a6268 0%, #4e555b 100%) !important;
        }

        /* ========== 锁定按钮 - 橙色渐变 ========== */
        .post-actions input[type="submit"][value*="锁定"] {
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%) !important;
            color: #212529 !important;
        }

        .post-actions input[type="submit"][value*="锁定"]:hover {
            background: linear-gradient(135deg, #e0a800 0%, #d39e00 100%) !important;
        }

        /* ========== 解锁按钮 - 绿色渐变 ========== */
        .post-actions input[type="submit"][value*="解锁"] {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%) !important;
            color: white !important;
        }

        .post-actions input[type="submit"][value*="解锁"]:hover {
            background: linear-gradient(135deg, #218838 0%, #1e7e34 100%) !important;
        }

        /* 空状态提示美化 */
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

        .empty-state p {
            color: #6c757d;
            font-size: 18px;
            margin: 10px 0;
            font-weight: 500;
        }

        .empty-icon {
            font-size: 64px;
            margin-bottom: 20px;
            color: rgba(102, 126, 234, 0.5);
        }

        /* 底部导航美化 */
        .page-footer {
            margin-top: 40px;
            display: flex;
            justify-content: center;
            gap: 20px;
            padding: 20px;
        }

        .footer-link {
            display: inline-block;
            padding: 12px 25px;
            background: rgba(255, 255, 255, 0.2);
            color: #667eea !important;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255, 255, 255, 0.3);
        }

        .footer-link:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
            background: rgba(255, 255, 255, 0.3);
            color: #764ba2 !important;
            border-color: rgba(255, 255, 255, 0.5);
        }

        /* 创建帖子按钮美化 */
        .create-post-btn {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
            padding: 12px 25px;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
            display: inline-block;
        }

        .create-post-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
            background: linear-gradient(135deg, #218838 0%, #1e7e34 100%);
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

            .section-description {
                font-size: 16px;
                padding: 12px 20px;
            }

            .post-card {
                padding: 20px 15px;
            }

            .post-title h3 {
                font-size: 20px;
            }

            .post-info {
                flex-direction: column;
                gap: 8px;
            }

            .post-actions {
                flex-direction: column;
                align-items: stretch;
            }

            .admin-btn,
            .btn-edit,
            .btn-delete,
            .btn-pin,
            .btn-unpin,
            .btn-lock,
            .btn-unlock,
            input[type="submit"] {
                width: 100%;
                justify-content: center;
            }

            .page-footer {
                flex-direction: column;
                gap: 15px;
            }

            .footer-link,
            .create-post-btn {
                width: 100%;
                max-width: 300px;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>${section.name}</h1>
    <p class="section-description">${section.description}</p>

    <c:choose>
        <c:when test="${not empty posts}">
            <c:forEach items="${posts}" var="post">
                <div class="post-card">
                    <div class="post-title">
                        <!-- 添加置顶标记 -->
                        <c:if test="${post.pinLevel > 0}">
                            <span class="pinned-tag">📌 置顶</span>
                        </c:if>

                        <!-- 修复：确保链接可以点击 -->
                        <h3>
                            <a href="${pageContext.request.contextPath}/post/${post.id}">
                                    ${post.title}
                            </a>
                        </h3>

                        <!-- 添加锁定标记 -->
                        <c:if test="${post.isLocked}">
                            <span class="locked-tag">🔒 已锁定</span>
                        </c:if>
                    </div>

                    <div class="post-info">
                            <span class="post-info-item">
                                <strong>👤</strong> 作者: ${post.authorUsername}
                                <c:if test="${post.authorRole == 'CERTIFIED'}">
                                    <span class="user-role role-certified">[认证用户]</span>
                                </c:if>
                                <c:if test="${post.authorRole == 'ADMIN'}">
                                    <span class="user-role role-admin">[管理员]</span>
                                </c:if>
                                <c:if test="${post.authorRole == 'USER' || post.authorRole == null}">
                                    <span class="user-role role-regular">[普通用户]</span>
                                </c:if>
                            </span>

                        <span class="post-info-item">
                                <strong>📅</strong> <fmt:formatDate value="${post.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                            </span>

                        <span class="post-info-item">
                                <strong>👁️</strong> 浏览: ${post.viewCount}
                            </span>
                    </div>

                    <!-- 管理员操作按钮 -->
                    <c:if test="${sessionScope.currentUser != null && sessionScope.currentUser.role == 'ADMIN'}">
                        <!-- ========== 帖子操作按钮区域 ========== -->
                        <div class="post-actions">
                            <!-- ========== 编辑按钮 - 仅原作者可见 ========== -->
                            <c:if test="${sessionScope.currentUser != null && sessionScope.currentUser.id == post.userId}">
                                <a href="${pageContext.request.contextPath}/post/${post.id}/edit" class="btn-edit">
                                    ✏️ 编辑
                                </a>
                            </c:if>

                            <!-- ========== 删除按钮 - 原作者或管理员可见 ========== -->
                            <c:if test="${sessionScope.currentUser != null && (sessionScope.currentUser.id == post.userId || sessionScope.currentUser.role == 'ADMIN')}">
                                <form action="${pageContext.request.contextPath}/post/${post.id}/delete" method="post" style="display:inline;">
                                    <input type="submit" value="🗑️ 删除" onclick="return confirm('确定要删除此帖子吗？');">
                                </form>
                            </c:if>

                            <!-- ========== 管理员专属操作按钮 ========== -->
                            <c:if test="${sessionScope.currentUser != null && sessionScope.currentUser.role == 'ADMIN'}">
                                <!-- 置顶/取消置顶 -->
                                <c:if test="${post.pinLevel > 0}">
                                    <form action="${pageContext.request.contextPath}/post/${post.id}/unpin" method="post" style="display:inline;">
                                        <input type="submit" value="📌 取消置顶">
                                    </form>
                                </c:if>
                                <c:if test="${post.pinLevel == 0}">
                                    <form action="${pageContext.request.contextPath}/post/${post.id}/pin" method="post" style="display:inline;">
                                        <input type="hidden" name="level" value="1">
                                        <input type="submit" value="📌 置顶">
                                    </form>
                                </c:if>

                                <!-- 锁定/解锁 -->
                                <c:if test="${post.isLocked}">
                                    <form action="${pageContext.request.contextPath}/post/${post.id}/unlock" method="post" style="display:inline;">
                                        <input type="submit" value="🔓 解锁">
                                    </form>
                                </c:if>
                                <c:if test="${!post.isLocked}">
                                    <form action="${pageContext.request.contextPath}/post/${post.id}/lock" method="post" style="display:inline;">
                                        <input type="submit" value="🔒 锁定">
                                    </form>
                                </c:if>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <div class="empty-icon">📭</div>
                <p>该分区下暂无帖子</p>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="page-footer">
        <a href="${pageContext.request.contextPath}/post/create?sectionId=${section.id}" class="create-post-btn">
            ✏️ 创建帖子
        </a>
        <a href="${pageContext.request.contextPath}/forum/section" class="footer-link">
            📁 返回分区列表
        </a>
        <a href="${pageContext.request.contextPath}/" class="footer-link">
            🏠 返回首页
        </a>
    </div>
</div>
</body>
</html>
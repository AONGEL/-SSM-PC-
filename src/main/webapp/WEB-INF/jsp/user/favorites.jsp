<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>我的收藏</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
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

        /* 页眉美化 */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 15px 25px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        .favorite-count {
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
            color: #212529;
            padding: 6px 15px;
            border-radius: 20px;
            font-weight: 700;
            font-size: 16px;
            box-shadow: 0 2px 8px rgba(255, 193, 7, 0.3);
        }

        /* 调试信息美化 */
        .debug-info {
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            border-left: 5px solid #2196f3;
            padding: 15px 20px;
            border-radius: 10px;
            margin: 20px 0;
            font-size: 14px;
            box-shadow: 0 2px 8px rgba(33, 150, 243, 0.2);
        }

        .debug-info p {
            margin: 5px 0;
            color: #1976d2;
        }

        /* 收藏项卡片美化 */
        .favorite-item {
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
        }

        .favorite-item::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(102, 126, 234, 0.05) 0%, transparent 70%);
            z-index: 0;
        }

        .favorite-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
        }

        /* 收藏内容美化 */
        .favorite-content {
            margin-bottom: 15px;
        }

        .favorite-title {
            font-size: 20px;
            font-weight: 700;
            color: #2c3e50;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-block;
            position: relative;
            z-index: 1;
        }

        .favorite-title:hover {
            color: #667eea;
            text-decoration: underline;
        }

        .favorite-title.deleted {
            color: #dc3545 !important;
            text-decoration: line-through !important;
            opacity: 0.7;
        }

        /* 元信息美化 */
        .favorite-meta {
            color: #6c757d;
            font-size: 15px;
            margin-top: 10px;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            position: relative;
            z-index: 1;
        }

        .favorite-meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .favorite-meta-item strong {
            color: #2c3e50;
            font-weight: 600;
        }

        /* 已删除提示美化 */
        .deleted-notice {
            background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
            color: #c62828;
            padding: 8px 15px;
            border-radius: 10px;
            margin-top: 10px;
            font-weight: 600;
            display: inline-block;
            position: relative;
            z-index: 1;
        }

        /* 按钮组美化 */
        .favorite-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 15px;
            position: relative;
            z-index: 1;
        }

        /* 统一按钮样式 */
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 15px;
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

        /* 取消收藏按钮 - 黄色渐变 */
        .btn-warning {
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
            color: #212529;
        }

        .btn-warning:hover {
            background: linear-gradient(135deg, #e0a800 0%, #d39e00 100%);
        }

        /* 返回按钮 - 蓝色渐变 */
        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #0069d9 0%, #004494 100%);
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
            color: rgba(102, 126, 234, 0.5);
        }

        /* 底部导航美化 */
        .page-footer {
            margin-top: 40px;
            display: flex;
            justify-content: center;
            padding: 25px;
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

            .header {
                flex-direction: column;
                gap: 15px;
                padding: 15px 20px;
            }

            .favorite-item {
                padding: 20px 15px;
            }

            .favorite-title {
                font-size: 18px;
            }

            .favorite-actions {
                flex-direction: column;
                align-items: stretch;
            }

            .btn {
                width: 100%;
                max-width: 300px;
                margin-bottom: 10px;
            }

            .empty-state {
                padding: 40px 20px;
            }

            .empty-state h3 {
                font-size: 24px;
            }

            .empty-icon {
                font-size: 60px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>⭐ 我的收藏</h1>

    <div class="header">
        <div>
            <c:if test="${not empty totalFavorites}">
                <span class="favorite-count">⭐ 共 ${totalFavorites} 个收藏</span>
            </c:if>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-primary">
                👤 返回个人中心
            </a>
        </div>
    </div>

    <%-- 调试信息，部署时可移除 --%>
    <c:if test="${debug}">
        <div class="debug-info">
            <p><strong>调试信息:</strong></p>
            <p>• 收藏列表大小: ${fn:length(favorites)}</p>
            <p>• 当前用户ID: ${user.id}</p>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${not empty favorites && fn:length(favorites) > 0}">
            <c:forEach items="${favorites}" var="favorite" varStatus="status">
                <div class="favorite-item" id="favorite-item-${favorite.id}">
                    <div class="favorite-content">
                        <a href="${pageContext.request.contextPath}/post/${favorite.postId}"
                           class="favorite-title ${favorite.postExists ? '' : 'deleted'}">
                                ${fn:escapeXml(favorite.postTitle)}
                        </a>
                        <div class="favorite-meta">
                                <span class="favorite-meta-item">
                                    <strong>📅</strong> 收藏时间: <fmt:formatDate value="${favorite.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                </span>
                            <c:if test="${!favorite.postExists}">
                                <span class="deleted-notice">⚠️ 此帖子已被删除</span>
                            </c:if>
                        </div>
                    </div>
                    <div class="favorite-actions">
                        <button class="btn btn-warning"
                                onclick="cancelFavorite(${favorite.id}, ${favorite.postId})">
                            ❌ 取消收藏
                        </button>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <div class="empty-icon">📭</div>
                <h3>暂无收藏内容</h3>
                <p>在帖子详情页点击"⭐ 收藏"按钮即可收藏感兴趣的内容</p>
                <div style="margin-top: 25px;">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                        🏠 去首页浏览帖子
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    $(document).ready(function() {
        console.log("Favorites page loaded");
    });

    function cancelFavorite(favoriteId, postId) {
        if(confirm("确定要取消收藏此帖子吗？")) {
            $.ajax({
                url: "${pageContext.request.contextPath}/post/" + postId + "/toggle-favorite",
                type: "POST",
                dataType: "json",
                success: function(response) {
                    if(response.success) {
                        // 移除对应的收藏项
                        $("#favorite-item-" + favoriteId).fadeOut(300, function() {
                            $(this).remove();

                            // 检查是否还有收藏项
                            if($(".favorite-item").length === 0) {
                                // 显示空状态
                                $(".empty-state").show();
                            }

                            // 更新收藏数量显示
                            var currentCount = parseInt($(".favorite-count").text().match(/\d+/)[0]);
                            if (!isNaN(currentCount) && currentCount > 0) {
                                $(".favorite-count").text("⭐ 共 " + (currentCount - 1) + " 个收藏");
                            }
                        });
                        alert('✓ 已取消收藏');
                    } else {
                        alert('❌ 取消收藏失败: ' + (response.message || '未知错误'));
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error:", error);
                    alert('❌ 请求失败，请重试。错误: ' + error);
                }
            });
        }
    }
</script>
</body>
</html>
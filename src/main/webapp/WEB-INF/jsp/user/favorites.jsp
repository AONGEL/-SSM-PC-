<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>我的收藏 - PC 硬件交流论坛</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei', sans-serif; background: #f6f6f6; color: #121212; line-height: 1.6; min-height: 100vh; }

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
        .main-container { max-width: 1200px; margin: 20px auto; padding: 0 20px; }

        /* 页面标题卡片 */
        .page-header-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 20px 24px; margin-bottom: 20px; }
        .page-title { font-size: 24px; font-weight: 700; color: #121212; display: flex; align-items: center; gap: 10px; }

        /* 收藏统计和操作栏 */
        .favorite-actions-bar { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 16px 20px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 12px; }
        .favorite-count { font-size: 15px; color: #0066ff; font-weight: 600; }
        .back-btn { display: inline-block; padding: 8px 20px; background: #fafafa; color: #121212; border-radius: 20px; text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.3s ease; border: 1px solid #e0e0e0; }
        .back-btn:hover { background: #f0f0f0; border-color: #d0d0d0; }

        /* 收藏列表卡片 */
        .favorite-list-card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); overflow: hidden; }
        .favorite-item { padding: 20px 24px; border-bottom: 1px solid #f0f0f0; transition: all 0.3s ease; }
        .favorite-item:last-child { border-bottom: none; }
        .favorite-item:hover { background: #fafafa; }

        .favorite-content { margin-bottom: 12px; }
        .favorite-title { font-size: 16px; font-weight: 500; color: #121212; text-decoration: none; transition: all 0.3s ease; display: block; margin-bottom: 8px; }
        .favorite-title:hover { color: #0066ff; text-decoration: underline; }
        .favorite-title.deleted { color: #dc3545; text-decoration: line-through; opacity: 0.7; }

        .favorite-meta { display: flex; flex-wrap: wrap; gap: 16px; font-size: 13px; color: #8a8a8a; }
        .favorite-meta-item { display: flex; align-items: center; gap: 6px; }
        .deleted-notice { display: inline-block; padding: 3px 10px; background: #ffebee; color: #c62828; border-radius: 4px; font-size: 12px; font-weight: 500; }

        .favorite-actions { display: flex; gap: 10px; justify-content: flex-end; margin-top: 16px; }
        .btn { display: inline-block; padding: 8px 20px; border: none; border-radius: 20px; cursor: pointer; font-size: 14px; font-weight: 500; transition: all 0.3s ease; text-decoration: none; }
        .btn-warning { background: #ffc107; color: #212529; }
        .btn-warning:hover { background: #e0a800; }

        /* 空状态 */
        .empty-state { text-align: center; padding: 80px 30px; background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin: 20px 0; }
        .empty-icon { font-size: 72px; margin-bottom: 20px; opacity: 0.4; }
        .empty-state h3 { font-size: 20px; color: #121212; margin-bottom: 12px; font-weight: 600; }
        .empty-state p { color: #8a8a8a; font-size: 15px; margin: 8px 0; }
        .empty-state .btn { margin-top: 24px; }

        /* 响应式 */
        @media (max-width: 768px) {
            .header-content { flex-wrap: wrap; height: auto; padding: 10px 0; gap: 10px; }
            .nav-links { width: 100%; justify-content: center; }
            .main-container { padding: 0 15px; }
            .page-header-card { padding: 16px 18px; }
            .page-title { font-size: 20px; }
            .favorite-actions-bar { flex-direction: column; text-align: center; }
            .favorite-item { padding: 16px 18px; }
            .favorite-title { font-size: 15px; }
            .favorite-actions { flex-direction: column; }
            .btn { width: 100%; text-align: center; }
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
    <div class="page-header-card">
        <h1 class="page-title">⭐ 我的收藏</h1>
    </div>

    <div class="favorite-actions-bar">
        <div>
            <c:if test="${not empty totalFavorites}">
                <span class="favorite-count">共 ${totalFavorites} 个收藏</span>
            </c:if>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/user/profile" class="back-btn">👤 返回个人中心</a>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty favorites && fn:length(favorites) > 0}">
            <div class="favorite-list-card">
                <c:forEach items="${favorites}" var="favorite" varStatus="status">
                    <div class="favorite-item" id="favorite-item-${favorite.id}">
                        <div class="favorite-content">
                            <a href="${pageContext.request.contextPath}/post/${favorite.postId}"
                               class="favorite-title ${favorite.postExists ? '' : 'deleted'}">
                                    ${fn:escapeXml(favorite.postTitle)}
                            </a>
                            <div class="favorite-meta">
                                <span class="favorite-meta-item">
                                    📅 <fmt:formatDate value="${favorite.createTime}" pattern="yyyy-MM-dd HH:mm"/>
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
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <div class="empty-icon">📭</div>
                <h3>暂无收藏内容</h3>
                <p>在帖子详情页点击"⭐ 收藏"按钮即可收藏感兴趣的内容</p>
                <a href="${pageContext.request.contextPath}/" class="btn btn-warning">🏠 去首页浏览帖子</a>
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
                                $(".favorite-count").text("共 " + (currentCount - 1) + " 个收藏");
                            }
                        });
                        alert('✓ 已取消收藏');
                    } else {
                        alert('❌ 取消收藏失败：' + (response.message || '未知错误'));
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error:", error);
                    alert('❌ 请求失败，请重试。错误：' + error);
                }
            });
        }
    }
</script>
</body>
</html>
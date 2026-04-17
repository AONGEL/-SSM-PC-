<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>${post.title} - 帖子详情</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>

</head>
<body>
<div class="container">
    <h1>${post.title}</h1>

    <!-- 帖子信息卡片 -->
    <div class="post-info-card">
        <div class="post-info">
            <div class="post-meta">
            <span class="post-meta-item">
                <strong>👤</strong> 作者: ${post.authorUsername}
            </span>
                <span class="post-meta-item">
                <strong>📅</strong> <fmt:formatDate value="${post.createTime}" pattern="yyyy-MM-dd HH:mm"/>
            </span>
                <span class="post-meta-item">
                <strong>👁️</strong> 浏览: ${post.viewCount}
            </span>
                <span class="post-meta-item">
                <strong>📁</strong> 板块: <a href="${pageContext.request.contextPath}/forum/section/${post.sectionId}/posts">${post.sectionName}</a>
            </span>
                <!-- 锁定状态显示 -->
                <c:if test="${post.isLocked}">
                <span class="post-meta-item post-status locked">
                    🔒 已锁定
                </span>
                </c:if>
            </div>
        </div>
    </div>

    <!-- 帖子操作按钮区域 -->
    <div class="post-actions">
        <!-- ========== 收藏按钮 - 所有登录用户可见 ========== -->
        <c:if test="${sessionScope.currentUser != null}">
            <button
                    id="favoriteBtn"
                    class="btn-favorite ${isFavorited ? 'favorited' : ''}"
                    data-post-id="${post.id}"
                    onclick="toggleFavorite(${post.id})"
            >
                    ${isFavorited ? '已收藏' : '收藏'}
                (<span id="favoriteCount">${favoriteCount}</span>)
            </button>
        </c:if>

        <!-- ========== 编辑按钮 - 仅原作者可见 ========== -->
        <c:if test="${sessionScope.currentUser != null && sessionScope.currentUser.id == post.userId}">
            <a href="${pageContext.request.contextPath}/post/${post.id}/edit" class="btn-edit">✏️ 编辑</a>
        </c:if>

        <!-- ========== 删除按钮 - 原作者或管理员可见 ========== -->
        <c:if test="${sessionScope.currentUser != null && (sessionScope.currentUser.id == post.userId || sessionScope.currentUser.role == 'ADMIN')}">
            <form action="${pageContext.request.contextPath}/post/${post.id}/delete" method="post" style="display:inline;">
                <input
                        type="submit"
                        value="🗑️ 删除"
                        class="action-btn btn-delete"
                        onclick="return confirm('确定要删除此帖子吗？删除后无法恢复！');"
                >
            </form>
        </c:if>

        <!-- ========== 管理员专属操作按钮 ========== -->
        <c:if test="${sessionScope.currentUser != null && sessionScope.currentUser.role == 'ADMIN'}">
            <!-- 置顶/取消置顶 -->
            <c:if test="${post.pinLevel > 0}">
                <form action="${pageContext.request.contextPath}/post/${post.id}/unpin" method="post" style="display:inline;">
                    <input
                            type="submit"
                            value="📌 取消置顶"
                            class="action-btn btn-unpin"
                    >
                </form>
            </c:if>
            <c:if test="${post.pinLevel == 0}">
                <form action="${pageContext.request.contextPath}/post/${post.id}/pin" method="post" style="display:inline;">
                    <input type="hidden" name="level" value="1">
                    <input
                            type="submit"
                            value="📌 置顶"
                            class="action-btn btn-pin"
                    >
                </form>
            </c:if>

            <!-- 锁定/解锁 -->
            <c:if test="${post.isLocked}">
                <form action="${pageContext.request.contextPath}/post/${post.id}/unlock" method="post" style="display:inline;">
                    <input
                            type="submit"
                            value="🔓 解锁"
                            class="action-btn btn-unlock"
                    >
                </form>
            </c:if>
            <c:if test="${!post.isLocked}">
                <form action="${pageContext.request.contextPath}/post/${post.id}/lock" method="post" style="display:inline;">
                    <input
                            type="submit"
                            value="🔒 锁定"
                            class="action-btn btn-lock"
                    >
                </form>
            </c:if>
        </c:if>
    </div><br>

    <!-- 锁定提示 -->
    <c:if test="${post.isLocked}">
        <div class="locked-post-message">
            <p><strong>🔒 此帖子已被锁定</strong>，只有管理员可以进行回复操作。</p>
        </div>
    </c:if>

    <div class="post-content">
    <!-- 使用一个 div 来存放原始内容，然后用 JS 渲染 -->
    <div id="postContentRaw" style="display: none;">${post.content}</div>
    <div id="postContentRendered"></div>
</div>

    <!-- 回复列表部分 -->
    <div class="reply-list">
    <h2>💬 回复 (<c:out value="${totalReplies}"/>)</h2>
    <c:choose>
    <c:when test="${not empty replies}">
        <ul id="repliesList">
            <c:forEach items="${replies}" var="reply" varStatus="status">
                <li class="reply-item" id="reply-${reply.id}">
                    <div class="reply-header">
                        <p>👤 用户: ${reply.authorUsername}
                            <c:if test="${reply.authorRole == 'CERTIFIED'}">
                                <span class="user-role role-certified">[认证用户]</span>
                            </c:if>
                            <c:if test="${reply.authorRole == 'ADMIN'}">
                                <span class="user-role role-admin">[管理员]</span>
                            </c:if>
                            <c:if test="${reply.authorRole == 'USER' || reply.authorRole == null}">
                                <span class="user-role role-regular">[普通用户]</span>
                            </c:if>
                            📅 时间: <fmt:formatDate value="${reply.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                    </div>
                    <div class="reply-content">
                        <div class="reply-content-raw" style="display: none;">${reply.content}</div>
                        <div class="reply-content-rendered"></div>
                    </div>
                    <c:if test="${sessionScope.currentUser != null && sessionScope.currentUser.id == reply.userId}">
                        <div class="reply-actions">
                            <!-- 增加了 delete-reply-btn 类名，方便 JS 定位 -->
                            <button class="btn btn-primary delete-reply-btn" data-reply-id="${reply.id}">🗑️ 删除</button>
                        </div>
                    </c:if>
                </li>
            </c:forEach>
        </ul>

        <!-- 分页控件 -->
        <!-- ========== 美化后的分页控件 ========== -->
        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <!-- 上一页 -->
                <c:if test="${pageNum > 1}">
                    <a href="${pageContext.request.contextPath}/post/${post.id}?pageNum=${pageNum - 1}&pageSize=6">
                        &laquo; <span class="page-text">上一页</span>
                    </a>
                </c:if>

                <!-- 页码列表 -->
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:choose>
                        <c:when test="${i eq pageNum}">
                            <span class="current-page">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/post/${post.id}?pageNum=${i}&pageSize=6">
                                    ${i}
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <!-- 下一页 -->
                <c:if test="${pageNum < totalPages}">
                    <a href="${pageContext.request.contextPath}/post/${post.id}?pageNum=${pageNum + 1}&pageSize=6">
                        <span class="page-text">下一页</span> &raquo;
                    </a>
                </c:if>

                <!-- 页码信息 -->
                <div class="page-info">
                    <strong>第 ${pageNum} 页</strong> / 共 <strong>${totalPages} 页</strong>
                    (共 <strong>${totalReplies} 条</strong> 回复)
                </div>
            </div>
        </c:if>
    </c:when>
    <c:otherwise>
        <p>暂无回复。</p>
    </c:otherwise>
</c:choose>
    </div>

    <!-- 回复表单 - 根据帖子是否锁定和用户权限决定是否显示 -->
    <c:choose>
    <c:when test="${post.isLocked && (!sessionScope.currentUser.role.equals('ADMIN'))}">
        <div class="locked-post-message">
            <p>此帖子已被锁定，只有管理员可以回复。</p>
        </div>
    </c:when>
    <c:otherwise>
        <c:if test="${sessionScope.currentUser != null}">
        <div class="reply-form-card">
            <h3>💬 发表回复</h3>
            <form:form action="${pageContext.request.contextPath}/post/${post.id}/reply" method="post" modelAttribute="reply">
                <form:hidden path="postId" value="${post.id}"/>
                <form:hidden path="userId" value="${sessionScope.currentUser.id}"/>

                <div class="form-group">
                    <div class="form-button-group">
                    <button type="button" id="replyUploadBtn" class="btn btn-info">📝 上传图片</button>
                    <input type="file" id="replyImageFileInput" accept="image/*" style="display:none;">
                    <c:if test="${sessionScope.currentUser.role == 'CERTIFIED' || sessionScope.currentUser.role == 'ADMIN'}">
                        <button type="button" id="replyInsertReferenceBtn" class="btn btn-info">📊 插入硬件引用</button>
                    </c:if>
                    </div><br>
                <form:textarea path="content" id="replyContent" rows="5" cols="50" required="required"/><br>
                <form:errors path="content" cssClass="error" /><br>
                <input type="submit" value="✅ 回复" class="btn btn-primary">
                </div>
            </form:form>
        </div>
        </c:if>
    </c:otherwise>
</c:choose>

    <!-- 底部导航 -->
    <div class="page-footer">
        <a href="${pageContext.request.contextPath}/forum/section/${post.sectionId}/posts" class="back-link">📁 返回帖子列表</a>
        <a href="${pageContext.request.contextPath}/" class="back-link">🏠 返回首页</a>
    </div>

    <!-- 硬件详情模态框 -->
    <div id="hardwareModal" class="hardware-modal">
    <div class="hardware-modal-content">
        <span class="hardware-modal-close">&times;</span>
        <h3>📊 硬件详情</h3>
        <div id="hardwareDetailContent" class="hardware-detail">
            <!-- 硬件详情将在这里动态加载 -->
        </div>
    </div>
</div>

    <!-- 统一的硬件引用搜索模态框 -->
    <div id="replyHardwareModal" class="hardware-modal">
    <div class="hardware-modal-content">
        <span class="hardware-modal-close">&times;</span>
        <h3>📊 选择硬件</h3>
        <!-- 硬件类型选择框 (上) -->
        <select id="replyHardwareTypeSelect" style="width: 100%; padding: 5px; margin-bottom: 10px;">
            <option value="cpu_info">CPU</option>
            <option value="gpu_info">GPU</option>
            <option value="motherboard_info">主板</option>
        </select>
        <!-- 搜索框 (下) -->
        <input type="text" id="replyHardwareSearch" placeholder="搜索硬件型号..." style="width: 100%; padding: 5px; margin-bottom: 10px;">
        <div id="replyHardwareList"></div>
    </div>
</div>
</div>
<script>
    $(document).ready(function() {
        console.log("Detail Document ready fired"); // 调试日志

        // 渲染帖子内容
        var postContentRaw = $('#postContentRaw').text();
        var postContentRendered = renderContentWithReferences(postContentRaw);
        $('#postContentRendered').html(postContentRendered);

        // 渲染回复内容
        $('.reply-content-raw').each(function() {
            var rawContent = $(this).text();
            var renderedContent = renderContentWithReferences(rawContent);
            // 将渲染后的内容放入相邻的 .reply-content-rendered div
            $(this).next('.reply-content-rendered').html(renderedContent);
        });

        // --- 处理回复删除按钮点击事件 ---
        $(document).on('click', '.btn-delete-reply', function() {
            var replyId = $(this).data('reply-id');
            console.log("Delete reply button clicked for reply ID:", replyId); // 调试日志

            if (confirm('确定要删除这条回复吗？')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/reply/' + replyId,
                    type: 'DELETE', // 使用 DELETE 方法
                    success: function(response) {
                        console.log("Delete reply request succeeded for reply ID:", replyId, "Response:", response); // 调试日志
                        if (response === 'success') {
                            // 删除成功，从页面上移除该回复元素
                            $('#reply-' + replyId).fadeOut('fast', function() {
                                $(this).remove();
                                // 可选：更新回复计数或显示提示
                            });
                        } else {
                            alert('删除回复失败：' + response); // 显示服务器返回的错误信息
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Delete reply request failed for reply ID:", replyId, "Status:", status, "Error:", error); // 调试日志
                        console.error("XHR Status:", xhr.status); // 添加状态码日志
                        console.error("Response Text:", xhr.responseText); // 添加响应内容日志
                        alert('删除请求失败，请检查网络或稍后重试。');
                    }
                });
            }
        });

        // --- 收藏/取消收藏功能 ---
        $("#favoriteBtn").click(function() {
            var postId = $(this).data("post-id");
            var button = $(this);
            var isCurrentlyFavorited = button.hasClass("favorited");

            $.post("${pageContext.request.contextPath}/post/" + postId + "/toggle-favorite",
                function(response) {
                    if(response.success) {
                        // 更新按钮状态
                        if(!isCurrentlyFavorited) {
                            button.addClass("favorited");
                            button.html('<span class="favorite-icon"></span>已收藏 (<span id="favoriteCount">' + response.favoriteCount + '</span>)');
                        } else {
                            button.removeClass("favorited");
                            button.html('<span class="favorite-icon"></span>收藏 (<span id="favoriteCount">' + response.favoriteCount + '</span>)');
                        }

                        // 显示成功消息
                        var message = isCurrentlyFavorited ? '已取消收藏' : '收藏成功';
                        alert(message);
                    } else {
                        alert('操作失败: ' + response.message);
                    }
                });
        });
        // --- /收藏功能 ---

        // ========== 修复硬件引用功能 - 回复框部分 ==========
// 将变量定义移到 $(document).ready 内部
        var replyHardwareModal = $('#replyHardwareModal');
        var replyHardwareModalClose = replyHardwareModal.find('.hardware-modal-close'); // 修复：只选择当前模态框的关闭按钮
        var replyHardwareSearchInput = $('#replyHardwareSearch');
        var replyHardwareTypeSelect = $('#replyHardwareTypeSelect');
        var replyHardwareSearchList = $('#replyHardwareList');

// 点击插入硬件引用按钮 (回复)
        $(document).on('click', '#replyInsertReferenceBtn', function() {
            console.log("Reply Insert Reference button clicked"); // 调试日志
            replyHardwareModal.show(); // 显示模态框
            replyHardwareSearchInput.val(''); // 清空搜索框
            replyHardwareTypeSelect.val('cpu_info'); // 重置下拉框
            replyHardwareSearchList.empty(); // 清空列表
            replyHardwareSearchInput.focus(); // 自动聚焦搜索框
        });

// 点击关闭按钮 (回复) - 修复：使用模态框内部的选择器
        replyHardwareModalClose.click(function() {
            replyHardwareModal.hide(); // 隐藏模态框
        });

// 点击模态框外部区域 (回复)
        $(window).click(function(event) {
            if (event.target === replyHardwareModal[0]) {
                replyHardwareModal.hide();
            }
        });

// 搜索功能 (回复)
        replyHardwareSearchInput.on('input', function() {
            var keyword = $(this).val().trim();
            var table = replyHardwareTypeSelect.val(); // 获取下拉框选择的表名
            if (keyword.length >= 1 && table) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/hardware/search',
                    type: 'GET',
                    data: { term: keyword, table: table }, // 修正：添加 'data:' 标识符
                    success: function(data) {
                        console.log("Hardware search API returned:", data);
                        replyHardwareSearchList.empty();
                        if (data && data.length > 0) {
                            data.forEach(function(item) {
                                var itemDiv = $('<div class="search-result-item" data-id="' + item.id + '">' + item.brand + ' ' + item.model + '</div>');
                                itemDiv.click(function() {
                                    var id = $(this).data('id');
                                    var table = replyHardwareTypeSelect.val();
                                    var referenceText = '[' + table + ':' + id + ']';
                                    insertTextAtCursor($('#replyContent'), referenceText);
                                    replyHardwareModal.hide(); // 选择后隐藏模态框
                                });
                                replyHardwareSearchList.append(itemDiv);
                            });
                        } else {
                            replyHardwareSearchList.append('<div class="search-result-item">未找到匹配项</div>');
                        }
                        replyHardwareSearchList.show();
                    },
                    error: function(xhr, status, error) {
                        console.error("Hardware search API failed:", status, error);
                        replyHardwareSearchList.html('<div class="search-result-item">搜索失败: ' + error + '</div>');
                    }
                });
            } else {
                replyHardwareSearchList.empty().hide();
            }
        });

        // 处理模态框关闭 (详情)
        $('.hardware-modal-close').click(function() {
            $('#hardwareModal').hide();
        });

        $(window).click(function(event) {
            if (event.target === document.getElementById('hardwareModal')) {
                $('#hardwareModal').hide();
            }
        });
        // --- /新增 ---

        // 回复编辑器的上传逻辑
        $('#replyUploadBtn').click(function() {
            console.log("Reply Upload button clicked"); // 调试日志
            $('#replyImageFileInput').click();
        });

        $('#replyImageFileInput').change(function() {
            console.log("Reply File selected"); // 调试日志
            var file = this.files[0];
            if (file) {
                if (!file.type.startsWith('image/')) {
                    alert('请选择图片文件！');
                    return;
                }
                var maxSize = 5 * 1024 * 1024;
                if (file.size > maxSize) {
                    alert('文件大小不能超过 5MB！');
                    return;
                }

                var formData = new FormData();
                formData.append('file', file);

                $.ajax({
                    url: '${pageContext.request.contextPath}/upload/image',
                    type: 'POST',
                    data: formData, // 修正：添加 'data:' 标识符
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        console.log("Reply Upload success:", response); // 调试日志
                        if (response.success) {
                            var imageUrl = response.url;
                            insertTextAtCursor($('#replyContent'), '![](' + imageUrl + ')');
                            $('#replyImageFileInput').val(''); // 清空文件输入框
                        } else {
                            alert('上传失败: ' + response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Reply Upload error:", status, error); // 调试日志
                        console.error("XHR Status:", xhr.status); // 添加状态码日志
                        console.error("Response Text:", xhr.responseText); // 添加响应内容日志
                        alert('上传请求失败，请检查网络或服务器状态。');
                    }
                });
            }
        });

        // 收藏/取消收藏功能
        function toggleFavorite(postId) {
            const btn = document.getElementById('favoriteBtn');
            const countSpan = document.getElementById('favoriteCount');
            const isFavorited = btn.classList.contains('favorited');

            // 发送AJAX请求
            fetch('${pageContext.request.contextPath}/post/' + postId + '/favorite', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // 更新按钮状态
                        if (isFavorited) {
                            btn.classList.remove('favorited');
                            btn.innerHTML = '<i class="far fa-heart"></i><span>收藏</span><span>(' + data.count + ')</span>';
                        } else {
                            btn.classList.add('favorited');
                            btn.innerHTML = '<i class="fas fa-heart"></i><span>已收藏</span><span>(' + data.count + ')</span>';
                        }

                        // 更新收藏数量
                        countSpan.textContent = data.count;
                    } else {
                        alert(data.message || '操作失败，请稍后重试');
                    }
                })
                .catch(error => {
                    console.error('收藏操作失败:', error);
                    alert('网络错误，请检查网络连接');
                });
        }

        // --- 渲染内容并处理引用 ---
        function renderContentWithReferences(text) {
            // 收到通知：将相关通知标记为已读
            if($("#postNotificationAlert").length > 0) {
                closePostNotification(${post.id});
            }

            // 正则表达式匹配 ![](url) 和 [table:id] 格式
            var referenceRegex = /!\[([^\]]*)\]\(([^)]+)\)|\[([a-zA-Z_]+):(\d+)\]/g;
            var match;
            var lastIndex = 0;
            var result = '';

            while ((match = referenceRegex.exec(text)) !== null) {
                result += text.substring(lastIndex, match.index);

                // 检查是哪种匹配
                if (match[1] !== undefined && match[2] !== undefined) {
                    // 匹配 ![](url) 格式
                    var alt = match[1];
                    var url = match[2];
                    // 验证 URL 是否安全 (基本检查)
                    if (url.startsWith('${pageContext.request.contextPath}/uploads/') || url.startsWith('http')) {
                        result += '<img src="' + url + '" alt="' + (alt || 'Image') + '" style="max-width: 100%; height: auto;">';
                    } else {
                        console.warn("Invalid image URL detected during render: " + url); // 即使在生产环境，保留这条警告日志也有助于排查问题
                        result += match[0]; // 如果 URL 不符合预期，返回原始文本
                    }
                } else if (match[3] !== undefined && match[4] !== undefined) {
                    // 匹配 [table:id] 格式
                    var table = match[3];
                    var id = match[4];
                    if (isValidTableName(table)) {
                        result += '<a href="#" class="hardware-ref" data-table="' + table + '" data-id="' + id + '">' + match[0] + '</a>';
                    } else {
                        console.warn("Invalid table name in reference during render: " + table); // 同上，保留警告日志
                        result += match[0]; // 如果表名不合法，返回原始文本
                    }
                } else {
                    // 理论上不应该到达这里
                    console.error("Unexpected match structure:", match); // 同上，保留错误日志
                    result += match[0];
                }

                lastIndex = match.index + match[0].length;
            }

            result += text.substring(lastIndex);
            return result;
        }

        function isValidTableName(tableName) {
            var validTables = ["cpu_info", "gpu_info", "motherboard_info", "memory_info", "storage_info"];
            return validTables.includes(tableName);
        }

        // 使用事件委托，因为链接是动态生成的
        $(document).on('click', '.hardware-ref', function(e) {
            e.preventDefault(); // 阻止默认的链接跳转行为
            var table = $(this).data('table');
            var id = $(this).data('id');
            console.log("Hardware reference clicked: " + table + ":" + id);

            // 显示模态框
            $('#hardwareModal').show();

            // 调用 API 获取硬件详情
            $.ajax({
                url: '${pageContext.request.contextPath}/api/hardware/detail/' + table + '/' + id,
                type: 'GET',
                success: function(data) {
                    console.log("Hardware detail fetched:", data);
                    // 构建硬件详情的 HTML
                    var detailHtml = '<p><strong>型号:</strong> ' + data.model + '</p>';
                    // 根据不同表名添加不同的字段
                    if (table === 'cpu_info') {
                        detailHtml += '<p><strong>品牌:</strong> ' + data.brand + '</p>';
                        detailHtml += '<p><strong>接口:</strong> ' + data.interfaceType + '</p>';
                        detailHtml += '<p><strong>核心数:</strong> ' + data.cores + '</p>';
                        detailHtml += '<p><strong>线程数:</strong> ' + data.threads + '</p>';
                        detailHtml += '<p><strong>基础频率:</strong> ' + data.baseFrequency + ' GHz</p>';
                        detailHtml += '<p><strong>最大频率:</strong> ' + data.maxFrequency + ' GHz</p>';
                        detailHtml += '<p><strong>TDP:</strong> ' + data.tdp + ' W</p>';
                    } else if (table === 'gpu_info') {
                        detailHtml += '<p><strong>品牌:</strong> ' + data.brand + '</p>';
                        detailHtml += '<p><strong>显存容量:</strong> ' + data.memorySize + ' GB</p>';
                        detailHtml += '<p><strong>显存类型:</strong> ' + data.memoryType + '</p>';
                        detailHtml += '<p><strong>基础频率:</strong> ' + data.baseClock + ' MHz</p>';
                        detailHtml += '<p><strong>加速频率:</strong> ' + data.boostClock + ' MHz</p>';
                        detailHtml += '<p><strong>TDP:</strong> ' + data.tdp + ' W</p>';
                    } else if (table === 'motherboard_info') {
                        detailHtml += '<p><strong>品牌:</strong> ' + data.brand + '</p>';
                        detailHtml += '<p><strong>芯片组:</strong> ' + data.chipset + '</p>';
                        detailHtml += '<p><strong>CPU接口:</strong> ' + data.cpuInterface + '</p>';
                        detailHtml += '<p><strong>内存插槽:</strong> ' + data.memorySlots + '</p>';
                        detailHtml += '<p><strong>最大内存:</strong> ' + data.maxMemory + ' GB</p>';
                        detailHtml += '<p><strong>内存类型:</strong> ' + data.memoryType + '</p>';
                    } else if (table === 'memory_info') {
                        detailHtml += '<p><strong>品牌:</strong> ' + data.brand + '</p>';
                        detailHtml += '<p><strong>容量:</strong> ' + data.capacity + ' GB</p>';
                        detailHtml += '<p><strong>类型:</strong> ' + data.type + '</p>';
                        detailHtml += '<p><strong>频率:</strong> ' + data.frequency + ' MHz</p>';
                        detailHtml += '<p><strong>时序:</strong> ' + data.timing + '</p>';
                    } else if (table === 'storage_info') {
                        detailHtml += '<p><strong>品牌:</strong> ' + data.brand + '</p>';
                        detailHtml += '<p><strong>类型:</strong> ' + data.type + '</p>';
                        detailHtml += '<p><strong>容量:</strong> ' + data.capacity + ' GB</p>';
                        detailHtml += '<p><strong>接口类型:</strong> ' + data.interfaceType + '</p>';
                        detailHtml += '<p><strong>读取速度:</strong> ' + data.readSpeed + ' MB/s</p>';
                        detailHtml += '<p><strong>写入速度:</strong> ' + data.writeSpeed + ' MB/s</p>';
                    }
                    // 将详情插入到模态框内容区域
                    $('#hardwareDetailContent').html(detailHtml);
                },
                error: function(xhr, status, error) {
                    console.error("Failed to fetch hardware detail:", status, error);
                    $('#hardwareDetailContent').html('<p>获取硬件详情失败: ' + error + '</p>');
                }
            });
        });

        // 插入文本到文本域光标位置的函数
        function insertTextAtCursor(textarea, text) {
            var start = textarea[0].selectionStart;
            var end = textarea[0].selectionEnd;
            var content = textarea.val();
            var newContent = content.substring(0, start) + text + content.substring(end);
            textarea.val(newContent);
            textarea[0].selectionStart = textarea[0].selectionEnd = start + text.length;
            textarea.focus();
        }
    });
</script>
</body>
</html>

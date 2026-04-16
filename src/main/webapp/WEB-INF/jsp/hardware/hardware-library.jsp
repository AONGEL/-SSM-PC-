<!-- src/main/webapp/WEB-INF/jsp/hardware/hardware-library.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>硬件参数库 - PC 硬件交流论坛</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei', sans-serif; background: #f6f6f6; color: #121212; line-height: 1.6; min-height: 100vh; }
        
        /* 顶部导航栏 - 与首页统一 */
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

        /* 页面标题 */
        .page-title { font-size: 24px; font-weight: 600; color: #121212; margin-bottom: 20px; display: flex; align-items: center; gap: 8px; }

        /* 卡片样式 */
        .card { background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); overflow: hidden; margin-bottom: 20px; }
        .card-header { padding: 16px 20px; border-bottom: 1px solid #f0f0f0; display: flex; justify-content: space-between; align-items: center; }
        .card-title { font-size: 18px; font-weight: 600; color: #121212; display: flex; align-items: center; gap: 8px; }
        .card-body { padding: 20px; }

        /* 消息提示 */
        .message { padding: 12px 16px; margin-bottom: 20px; border-radius: 4px; font-size: 14px; }
        .message-success { background: #e6f7ed; color: #00a854; border-left: 3px solid #00a854; }
        .message-error { background: #ffe8e8; color: #ff4d4f; border-left: 3px solid #ff4d4f; }

        /* 外部链接按钮 */
        .external-link-btn { display: inline-flex; align-items: center; gap: 6px; padding: 10px 24px; background: #fff3e8; color: #ff6b00; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.2s; }
        .external-link-btn:hover { background: #ffe8d0; }

        /* 搜索框 */
        .search-box { margin-bottom: 20px; display: flex; gap: 12px; }
        .search-box input[type="text"] { flex: 1; padding: 10px 16px; border: 1px solid #e0e0e0; border-radius: 4px; font-size: 14px; transition: all 0.2s; }
        .search-box input[type="text"]:focus { outline: none; border-color: #0066ff; box-shadow: 0 0 0 2px rgba(0,102,255,0.1); }
        .search-box input[type="text"]::placeholder { color: #969696; }
        .search-box button { padding: 10px 24px; background: #0066ff; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 14px; font-weight: 500; transition: all 0.2s; }
        .search-box button:hover { background: #0052cc; }

        /* 标签页导航 */
        .tab-nav { display: flex; list-style: none; padding: 0; margin: 0 0 20px 0; border-bottom: 1px solid #f0f0f0; }
        .tab-nav li { margin-right: 8px; }
        .tab-nav a { display: block; padding: 12px 20px; background: transparent; color: #646464; text-decoration: none; border-radius: 4px 4px 0 0; border: 1px solid transparent; border-bottom: none; cursor: pointer; font-size: 15px; font-weight: 500; transition: all 0.2s; }
        .tab-nav a:hover:not(.active) { background: #fafafa; color: #0066ff; }
        .tab-nav a.active { background: #fff; color: #0066ff; border-color: #e0e0e0; border-bottom: 2px solid #fff; margin-bottom: -1px; font-weight: 600; }

        /* 硬件类别 */
        .hardware-category { display: none; }
        .hardware-category.active { display: block; }

        /* 类别标题 */
        .category-title { font-size: 18px; font-weight: 600; color: #121212; margin-bottom: 16px; padding-bottom: 12px; border-bottom: 1px solid #f0f0f0; display: flex; align-items: center; gap: 8px; }

        /* 表格样式 */
        .hardware-table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        .hardware-table th { background: #fafafa; color: #646464; font-weight: 600; text-align: left; padding: 12px 16px; border-bottom: 2px solid #e0e0e0; font-size: 14px; }
        .hardware-table td { border-bottom: 1px solid #f0f0f0; padding: 12px 16px; text-align: left; word-break: break-word; color: #121212; font-size: 14px; }
        .hardware-table tr:hover td { background: #fafafa; }
        .hardware-table .brand-model { font-weight: 600; color: #0066ff; }
        .hardware-table .hidden { display: none; }

        /* 底部操作栏 */
        .page-footer { margin-top: 20px; display: flex; justify-content: center; gap: 12px; flex-wrap: wrap; }
        .btn { display: inline-flex; align-items: center; gap: 6px; padding: 10px 24px; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.2s; }
        .btn-primary { background: #0066ff; color: #fff; }
        .btn-primary:hover { background: #0052cc; }
        .btn-secondary { background: #f5f5f5; color: #121212; }
        .btn-secondary:hover { background: #e8e8e8; }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .header-content { flex-wrap: wrap; height: auto; padding: 10px 0; gap: 10px; }
            .nav-links { width: 100%; justify-content: center; }
            .search-box { flex-direction: column; }
            .search-box input[type="text"] { width: 100%; }
            .tab-nav { flex-wrap: wrap; }
            .tab-nav a { font-size: 14px; padding: 10px 16px; }
            .hardware-table { font-size: 13px; }
            .hardware-table th, .hardware-table td { padding: 10px 12px; }
        }
    </style>
</head>
<body>
    <!-- 顶部导航栏 -->
    <header class="header">
        <div class="header-content">
            <a href="${pageContext.request.contextPath}/" class="logo">💻 PC 硬件交流论坛</a>
            <nav class="nav-links">
                <a href="${pageContext.request.contextPath}/">🏠 首页</a>
                <a href="${pageContext.request.contextPath}/forum/section">📁 论坛分区</a>
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
        <h1 class="page-title">🔧 硬件参数库</h1>

        <!-- 消息提示 -->
        <c:if test="${not empty successMessage}">
            <div class="message message-success">${successMessage}</div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="message message-error">${errorMessage}</div>
        </c:if>

        <!-- 外部链接按钮 -->
        <div style="margin-bottom: 20px;">
            <a href="https://cpuranklist.com/index.php" target="_blank" rel="noopener noreferrer" class="external-link-btn">
                📈 查看更多硬件排名
            </a>
        </div>

        <!-- 搜索框 -->
        <div class="search-box">
            <input type="text" id="globalSearchInput" placeholder="🔍 搜索硬件型号或品牌...">
            <button onclick="performGlobalSearch()">搜索</button>
        </div>

        <!-- 卡片容器 -->
        <div class="card">
            <div class="card-body">
                <!-- 标签页导航 -->
                <ul class="tab-nav">
                    <li><a href="#" class="tab-link active" data-tab="cpu">💻 CPU 信息</a></li>
                    <li><a href="#" class="tab-link" data-tab="gpu">🎮 GPU 信息</a></li>
                    <li><a href="#" class="tab-link" data-tab="motherboard">🔌 主板信息</a></li>
                </ul>

                <!-- CPU Section -->
                <div id="cpu" class="hardware-category active">
                    <h2 class="category-title">💻 CPU 信息</h2>
                    <table class="hardware-table" id="cpuTable">
                        <thead>
                        <tr>
                            <th>品牌/型号</th>
                            <th>接口</th>
                            <th>核心数</th>
                            <th>线程数</th>
                            <th>基础频率</th>
                            <th>最大频率</th>
                            <th>TDP</th>
                            <th>核显</th>
                            <th>发布日期</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${cpus}" var="cpu">
                            <tr>
                                <td class="brand-model" data-brand="${cpu.brand}" data-model="${cpu.model}">
                                        ${cpu.brand} ${cpu.model}
                                </td>
                                <td>${cpu.interfaceType}</td>
                                <td>${cpu.cores}</td>
                                <td>${cpu.threads}</td>
                                <td>${cpu.baseFrequency} GHz</td>
                                <td>${cpu.maxFrequency} GHz</td>
                                <td>${cpu.tdp} W</td>
                                <td>${cpu.integratedGraphics}</td>
                                <td>${cpu.releaseDate}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- GPU Section -->
                <div id="gpu" class="hardware-category">
                    <h2 class="category-title">🎮 GPU 信息</h2>
                    <table class="hardware-table" id="gpuTable">
                        <thead>
                        <tr>
                            <th>品牌/型号</th>
                            <th>显存容量</th>
                            <th>显存类型</th>
                            <th>显存位宽</th>
                            <th>基础频率</th>
                            <th>加速频率</th>
                            <th>TDP</th>
                            <th>接口类型</th>
                            <th>发布日期</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${gpus}" var="gpu">
                            <tr>
                                <td class="brand-model" data-brand="${gpu.brand}" data-model="${gpu.model}">
                                        ${gpu.brand} ${gpu.model}
                                </td>
                                <td>${gpu.memorySize} GB</td>
                                <td>${gpu.memoryType}</td>
                                <td>${gpu.memoryBusWidth} bit</td>
                                <td>${gpu.baseClock} MHz</td>
                                <td>${gpu.boostClock} MHz</td>
                                <td>${gpu.tdp} W</td>
                                <td>${gpu.interfaceType}</td>
                                <td>${gpu.releaseDate}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- 主板 Section -->
                <div id="motherboard" class="hardware-category">
                    <h2 class="category-title">🔌 主板信息</h2>
                    <table class="hardware-table" id="motherboardTable">
                        <thead>
                        <tr>
                            <th>品牌/型号</th>
                            <th>芯片组</th>
                            <th>CPU 接口</th>
                            <th>内存插槽</th>
                            <th>最大内存</th>
                            <th>内存类型</th>
                            <th>供电相数</th>
                            <th>SATA 接口</th>
                            <th>M.2 插槽</th>
                            <th>发布日期</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${motherboards}" var="mb">
                            <tr>
                                <td class="brand-model" data-brand="${mb.brand}" data-model="${mb.model}">
                                        ${mb.brand} ${mb.model}
                                </td>
                                <td>${mb.chipset}</td>
                                <td>${mb.cpuInterface}</td>
                                <td>${mb.memorySlots}</td>
                                <td>${mb.maxMemory} GB</td>
                                <td>${mb.memoryType}</td>
                                <td>${mb.powerPhase}</td>
                                <td>${mb.sataPorts}</td>
                                <td>${mb.m2Slots}</td>
                                <td>${mb.releaseDate}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 底部链接 -->
        <div class="page-footer">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">🏠 返回首页</a>
            <a href="${pageContext.request.contextPath}/forum/section" class="btn btn-secondary">📁 论坛分区</a>
        </div>
    </div>

<script>
    // 标签页切换逻辑
    document.querySelectorAll('.tab-link').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();

            const tabId = this.getAttribute('data-tab');

            // 移除所有标签和内容区的激活状态
            document.querySelectorAll('.tab-link').forEach(l => l.classList.remove('active'));
            document.querySelectorAll('.hardware-category').forEach(cat => cat.classList.remove('active'));

            // 为当前点击的标签和对应的内容区添加激活状态
            this.classList.add('active');
            document.getElementById(tabId).classList.add('active');
        });
    });

    // 全局搜索功能
    function performGlobalSearch() {
        const searchTerm = document.getElementById('globalSearchInput').value.toLowerCase();

        // 获取当前显示的硬件类别内容区
        const activeCategory = document.querySelector('.hardware-category.active');
        if (!activeCategory) return;

        // 获取当前类别下的所有数据行
        const allRows = activeCategory.querySelectorAll('tbody tr');

        allRows.forEach(row => {
            const brandModelCell = row.querySelector('.brand-model');
            const brand = brandModelCell.getAttribute('data-brand').toLowerCase();
            const model = brandModelCell.getAttribute('data-model').toLowerCase();

            if (brand.includes(searchTerm) || model.includes(searchTerm)) {
                row.classList.remove('hidden');
            } else {
                row.classList.add('hidden');
            }
        });
    }

    // 回车键搜索
    document.getElementById('globalSearchInput').addEventListener('keypress', function(event) {
        if (event.key === 'Enter') {
            performGlobalSearch();
        }
    });
</script>
</body>
</html>

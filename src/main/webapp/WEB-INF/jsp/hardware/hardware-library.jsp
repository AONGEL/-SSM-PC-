<!-- src/main/webapp/WEB-INF/jsp/hardware/hardware-library.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>硬件参数库</title>
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
            margin-bottom: 30px;
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

        /* 消息提示美化 */
        .message {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 15px;
            font-size: 16px;
            font-weight: 500;
            position: relative;
            overflow: hidden;
        }

        .success {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
            border-left: 5px solid #28a745;
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.2);
        }

        .success::before {
            content: '✅';
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 24px;
        }

        .success p {
            margin: 0;
            padding-left: 35px;
        }

        .error {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
            border-left: 5px solid #dc3545;
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.2);
        }

        .error::before {
            content: '⚠️';
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 24px;
        }

        .error p {
            margin: 0;
            padding-left: 35px;
        }

        /* 外部链接按钮美化 */
        .external-link-button {
            display: inline-block;
            padding: 12px 30px;
            background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            font-size: 16px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
            margin-bottom: 20px;
            position: relative;
            overflow: hidden;
        }

        .external-link-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .external-link-button:hover::before {
            left: 100%;
        }

        .external-link-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(231, 76, 60, 0.4);
            text-decoration: none;
        }

        .external-link-button::after {
            content: ' ↗';
            font-size: 18px;
        }

        /* 搜索框美化 */
        .search-box {
            margin-bottom: 25px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 20px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }

        .search-box input[type="text"] {
            width: calc(100% - 110px);
            padding: 12px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 15px;
            font-size: 16px;
            margin-right: 10px;
            transition: all 0.3s ease;
            background: #fff;
            color: #333;
            box-sizing: border-box;
        }

        .search-box input[type="text"]:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-box input[type="text"]::placeholder {
            color: #9e9e9e;
            font-style: italic;
        }

        .search-box button {
            padding: 12px 25px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .search-box button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            background: linear-gradient(135deg, #5568d3 0%, #653a8f 100%);
        }

        /* 标签页导航美化 */
        .tab-container {
            margin-bottom: 25px;
        }

        .tab-nav {
            display: flex;
            list-style: none;
            padding: 0;
            margin: 0;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 25px;
            padding: 10px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }

        .tab-nav li {
            margin: 0;
        }

        .tab-nav a {
            display: block;
            padding: 12px 25px;
            background: rgba(255, 255, 255, 0.3);
            color: #667eea;
            text-decoration: none;
            border-radius: 20px;
            border: 2px solid transparent;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-align: center;
        }

        .tab-nav a:hover:not(.active) {
            background: rgba(255, 255, 255, 0.5);
            color: #764ba2;
            transform: translateY(-2px);
        }

        .tab-nav a.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: rgba(255, 255, 255, 0.5);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            transform: translateY(-2px);
        }

        /* 硬件类别卡片美化 */
        .hardware-category {
            display: none;
            margin-top: 20px;
        }

        .hardware-category.active {
            display: block;
        }

        .category-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 25px;
            margin: 0 -25px 20px -25px;
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
            border-left: 5px solid #5568d3;
            box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
        }

        .category-header h2 {
            margin: 0;
            font-size: 24px;
            font-weight: 700;
        }

        /* 表格美化 */
        .hardware-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .hardware-table th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: 700;
            text-align: center;
            padding: 15px 12px;
            border-bottom: 2px solid rgba(255, 255, 255, 0.3);
        }

        .hardware-table td {
            border: 1px solid #e0e0e0;
            padding: 12px 10px;
            text-align: left;
            word-break: break-word;
            color: #333;
            font-size: 15px;
        }

        .hardware-table tr:nth-child(even) {
            background: rgba(248, 249, 250, 0.5);
        }

        .hardware-table tr:hover {
            background: rgba(102, 126, 234, 0.05);
            transform: translateX(5px);
        }

        /* 品牌型号单元格美化 */
        .hardware-table .brand-model {
            font-weight: 700;
            color: #2c3e50;
            background: rgba(102, 126, 234, 0.05);
        }

        /* 搜索结果隐藏 */
        .hardware-table .hidden {
            display: none;
        }

        /* 底部链接美化 */
        .page-footer {
            margin-top: 40px;
            display: flex;
            justify-content: center;
            gap: 20px;
            padding: 20px;
        }

        .back-link {
            display: inline-block;
            padding: 12px 30px;
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

        .back-link:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
            background: rgba(255, 255, 255, 0.3);
            color: #764ba2 !important;
            border-color: rgba(255, 255, 255, 0.5);
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            h1 {
                font-size: 28px;
                margin-bottom: 20px;
            }

            h1::after {
                width: 100px;
                height: 3px;
            }

            .search-box {
                padding: 15px;
            }

            .search-box input[type="text"] {
                width: 100%;
                margin-bottom: 10px;
            }

            .tab-nav {
                flex-direction: column;
                padding: 5px;
            }

            .tab-nav a {
                padding: 10px 20px;
                margin-bottom: 5px;
            }

            .hardware-table {
                font-size: 14px;
            }

            .hardware-table th,
            .hardware-table td {
                padding: 8px 5px;
            }

            .page-footer {
                flex-direction: column;
                gap: 15px;
            }

            .back-link {
                width: 100%;
                max-width: 300px;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>📊 硬件参数库</h1>

    <!-- 消息提示 -->
    <c:if test="${not empty successMessage}">
        <div class="message success">
            <p>${successMessage}</p>
        </div>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="message error">
            <p>${errorMessage}</p>
        </div>
    </c:if>

    <!-- 外部链接按钮 -->
    <div style="text-align: center; margin-bottom: 20px;">
        <a href="https://cpuranklist.com/index.php" target="_blank" rel="noopener noreferrer" class="external-link-button">
            📈 查看更多硬件排名
        </a>
    </div>

    <!-- 搜索框 -->
    <div class="search-box">
        <input type="text" id="globalSearchInput" placeholder="🔍 搜索硬件型号或品牌...">
        <button onclick="performGlobalSearch()">搜索</button>
    </div>

    <!-- 标签页导航 -->
    <div class="tab-container">
        <ul class="tab-nav">
            <li><a href="#" class="tab-link active" data-tab="cpu">💻 CPU 信息</a></li>
            <li><a href="#" class="tab-link" data-tab="gpu">🎮 GPU 信息</a></li>
            <li><a href="#" class="tab-link" data-tab="motherboard">🔌 主板 信息</a></li>
        </ul>
    </div>

    <!-- CPU Section -->
    <div id="cpu" class="hardware-category active">
        <div class="category-header">
            <h2>CPU 信息</h2>
        </div>
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
        <div class="category-header">
            <h2>GPU 信息</h2>
        </div>
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
        <div class="category-header">
            <h2>主板 信息</h2>
        </div>
        <table class="hardware-table" id="motherboardTable">
            <thead>
            <tr>
                <th>品牌/型号</th>
                <th>芯片组</th>
                <th>CPU接口</th>
                <th>内存插槽</th>
                <th>最大内存</th>
                <th>内存类型</th>
                <th>供电相数</th>
                <th>SATA接口</th>
                <th>M.2插槽</th>
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

    <!-- 底部链接 -->
    <div class="page-footer">
        <a href="${pageContext.request.contextPath}/" class="back-link">🏠 返回首页</a>
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
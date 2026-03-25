<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>论坛分区</title>
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
            margin-bottom: 40px;
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

        /* 分区列表美化 */
        .section-list {
            list-style: none;
            padding: 0;
            margin: 0;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }

        /* 分区卡片美化 */
        .section-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }

        .section-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(102, 126, 234, 0.05) 0%, transparent 70%);
            z-index: 0;
        }

        .section-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }

        /* 分区标题美化 */
        .section-card h3 {
            margin: 0 0 15px 0;
            font-size: 24px;
            font-weight: 700;
            color: #2c3e50;
            position: relative;
            z-index: 1;
        }

        .section-card h3 a {
            color: #2c3e50;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .section-card h3 a:hover {
            color: #667eea;
            text-decoration: underline;
        }

        /* 分区描述美化 */
        .section-card p {
            margin: 0;
            color: #6c757d;
            font-size: 16px;
            line-height: 1.8;
            position: relative;
            z-index: 1;
        }

        /* 底部链接美化 */
        .page-footer {
            margin-top: 50px;
            display: flex;
            justify-content: center;
            gap: 25px;
            padding: 25px;
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
                margin-bottom: 30px;
            }

            h1::after {
                width: 100px;
                height: 3px;
            }

            .section-list {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .section-card {
                padding: 25px 20px;
            }

            .section-card h3 {
                font-size: 22px;
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
    <h1>📚 论坛分区</h1>

    <c:choose>
        <c:when test="${not empty sections}">
            <ul class="section-list">
                <c:forEach items="${sections}" var="section">
                    <li class="section-card">
                        <h3>
                            <a href="${pageContext.request.contextPath}/forum/section/${section.id}/posts">
                                    ${section.name}
                            </a>
                        </h3>
                        <p>${section.description}</p>
                    </li>
                </c:forEach>
            </ul>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <div class="empty-icon">📭</div>
                <p>暂无分区信息</p>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="page-footer">
        <a href="${pageContext.request.contextPath}/" class="back-link">🏠 返回首页</a>
    </div>
</div>
</body>
</html>
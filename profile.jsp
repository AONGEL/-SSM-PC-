<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${user.username} - 个人中心</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* ========== 修复按钮大小不一致问题 - 强制统一 ========== */
        .post-actions {
            display: flex;
            gap: 12px;
            margin-top: 25px;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
            background: rgba(255, 255, 255, 0.5);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            align-items: center;
        }

        /* 关键修复：统一所有按钮的基础样式 */
        .action-btn,
        .post-actions button,
        .post-actions input[type="submit"] {
            /* 强制盒模型 */
            box-sizing: border-box !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;

            /* 固定尺寸 */
            width: auto !important;
            min-width: 110px !important;
            height: 48px !important;
            padding: 0 24px !important; /* 移除垂直padding，用height控制高度 */
            line-height: 48px !important; /* 行高等于高度 */

            /* 样式统一 */
            font-size: 15px !important;
            font-weight: 600 !important;
            border-radius: 25px !important;
            border: none !important;
            cursor: pointer !important;
            text-decoration: none !important;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1) !important;
            position: relative !important;
            overflow: hidden !important;
            gap: 8px !important;
            text-align: center !important;
            margin: 0 !important;
            vertical-align: middle !important;
        }

        /* 悬停效果 */
        .action-btn:hover,
        .post-actions button:hover,
        .post-actions input[type="submit"]:hover {
            transform: translateY(-3px) !important;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15) !important;
        }

        /* 点击效果 */
        .action-btn:active,
        .post-actions button:active,
        .post-actions input[type="submit"]:active {
            transform: translateY(1px) !important;
        }

        /* 光流动画 */
        .action-btn::before,
        .post-actions button::before,
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

        .action-btn:hover::before,
        .post-actions button:hover::before,
        .post-actions input[type="submit"]:hover::before {
            left: 100% !important;
        }

        /* 按钮颜色样式（保持不变） */
        .action-btn.btn-edit,
        .post-actions button.btn-edit {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%) !important;
            color: white !important;
        }

        .action-btn.btn-edit:hover,
        .post-actions button.btn-edit:hover {
            background: linear-gradient(135deg, #0069d9 0%, #004494 100%) !important;
        }

        .action-btn.btn-delete,
        .post-actions input[type="submit"].btn-delete {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%) !important;
            color: white !important;
        }

        .action-btn.btn-delete:hover,
        .post-actions input[type="submit"].btn-delete:hover {
            background: linear-gradient(135deg, #c82333 0%, #bd2130 100%) !important;
        }

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

        /* 用户信息卡片美化 - 角色名片 */
        .user-profile-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 25px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .user-profile-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(102, 126, 234, 0.05) 0%, transparent 70%);
            z-index: 0;
        }

        .user-profile-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.12);
        }

        /* 头像区域美化 */
        .avatar-section {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 25px;
            gap: 30px;
        }

        .avatar-container {
            position: relative;
        }

        .avatar-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 5px solid #667eea;
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.3);
            object-fit: cover;
            transition: all 0.3s ease;
        }

        .avatar-img:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .role-badge {
            position: absolute;
            bottom: -10px;
            right: -10px;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 700;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .role-admin {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
        }

        .role-certified {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
        }

        .role-regular {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            color: white;
        }

        /* 用户信息美化 */
        .user-info-section {
            text-align: center;
        }

        .username-display {
            font-size: 28px;
            font-weight: 700;
            color: #2c3e50;
            margin: 15px 0;
            position: relative;
            display: inline-block;
        }

        .username-display::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 2px;
        }

        .user-details {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        .detail-item {
            text-align: center;
        }

        .detail-label {
            font-size: 14px;
            color: #6c757d;
            margin-bottom: 5px;
        }

        .detail-value {
            font-size: 18px;
            font-weight: 600;
            color: #2c3e50;
        }

        /* 按钮组美化 */
        .profile-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 25px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 28px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
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

        /* 主要按钮 - 蓝色渐变 */
        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #0069d9 0%, #004494 100%);
        }

        /* 危险按钮 - 红色渐变 */
        .btn-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #c82333 0%, #bd2130 100%);
        }

        /* 卡片容器美化 */
        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        /* 通用卡片美化 */
        .info-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .info-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(102, 126, 234, 0.03) 0%, transparent 70%);
            z-index: 0;
        }

        .info-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
        }

        .info-card h2 {
            color: #2c3e50;
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: 700;
            position: relative;
            z-index: 1;
            padding-bottom: 10px;
            border-bottom: 2px solid #e9ecef;
        }

        /* 认证状态美化 */
        .certification-status {
            padding: 20px;
            border-radius: 15px;
            margin: 15px 0;
            font-weight: 500;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .status-pending {
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            color: #1976d2;
            border-left: 5px solid #2196f3;
        }

        .status-approved {
            background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
            color: #2e7d32;
            border-left: 5px solid #4caf50;
        }

        .status-rejected {
            background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
            color: #c62828;
            border-left: 5px solid #f44336;
        }

        .status-discussion {
            background: linear-gradient(135deg, #fff8e1 0%, #ffecb3 100%);
            color: #e65100;
            border-left: 5px solid #ffc107;
        }

        /* 链接项美化 */
        .link-item {
            display: block;
            padding: 12px 15px;
            margin: 8px 0;
            border-radius: 12px;
            transition: all 0.3s ease;
            text-decoration: none;
            color: #2c3e50;
            font-weight: 500;
            position: relative;
            overflow: hidden;
        }

        .link-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            transform: scaleY(0);
            transform-origin: bottom;
            transition: transform 0.3s ease;
        }

        .link-item:hover {
            background: rgba(102, 126, 234, 0.08);
            transform: translateX(5px);
            color: #667eea;
        }

        .link-item:hover::before {
            transform: scaleY(1);
        }

        /* 帖子/回复列表美化 */
        .posts-section, .replies-section {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .section-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e9ecef;
        }

        .section-title h2 {
            color: #2c3e50;
            font-size: 24px;
            font-weight: 700;
            margin: 0;
        }

        .count-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 14px;
            font-weight: 600;
        }

        /* 帖子项美化 */
        .post-item, .reply-item {
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.6);
            border: 1px solid #e9ecef;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .post-item::before,
        .reply-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .post-item:hover,
        .reply-item:hover {
            background: rgba(102, 126, 234, 0.05);
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .post-item:hover::before,
        .reply-item:hover::before {
            opacity: 1;
        }

        .post-title, .reply-content {
            font-size: 18px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 10px;
            display: block;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .post-title:hover,
        .reply-content:hover {
            color: #667eea;
            text-decoration: underline;
        }

        .post-meta, .reply-meta {
            font-size: 14px;
            color: #6c757d;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 10px;
        }

        .post-meta span,
        .reply-meta span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .post-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            justify-content: flex-end;
        }

        /* 空状态美化 */
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #6c757d;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 15px;
            margin: 20px 0;
        }

        .empty-state p {
            font-size: 18px;
            margin: 15px 0;
            font-weight: 500;
        }

        .empty-icon {
            font-size: 64px;
            margin-bottom: 20px;
            color: rgba(102, 126, 234, 0.5);
        }

        /* 分页美化 */
        .pagination {
            display: flex;
            justify-content: center;
            gap: 8px;
            margin: 25px 0;
            flex-wrap: wrap;
        }

        .pagination a,
        .pagination span {
            padding: 10px 18px;
            border-radius: 12px;
            text-decoration: none;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .pagination a {
            background: rgba(255, 255, 255, 0.6);
            color: #667eea;
            border: 2px solid rgba(102, 126, 234, 0.3);
        }

        .pagination a:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: rgba(102, 126, 234, 0.8);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .pagination span.current-page {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: 2px solid rgba(102, 126, 234, 0.8);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .pagination-info {
            text-align: center;
            color: #6c757d;
            font-size: 15px;
            margin-top: 15px;
            font-weight: 500;
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

            .user-profile-card {
                padding: 30px 20px;
            }

            .avatar-section {
                flex-direction: column;
                gap: 20px;
            }

            .avatar-img {
                width: 100px;
                height: 100px;
            }

            .username-display {
                font-size: 24px;
            }

            .user-details {
                gap: 15px;
                flex-direction: column;
            }

            .card-container {
                grid-template-columns: 1fr;
            }

            .profile-actions {
                flex-direction: column;
                align-items: stretch;
            }

            .btn {
                width: 100%;
                max-width: 300px;
                margin-bottom: 10px;
            }

            .posts-section,
            .replies-section {
                padding: 25px 20px;
            }
        }

        /* ========== 修复"我的帖子"卡片中按钮垂直对齐问题 ========== */
        /* 确保帖子操作区域垂直居中对齐 */
        .posts-section .post-actions,
        .replies-section .post-actions {
            display: flex !important;
            gap: 12px !important;
            margin-top: 15px !important;
            justify-content: flex-end !important; /* 右对齐，符合操作按钮习惯 */
            align-items: center !important; /* 垂直居中对齐 */
            flex-wrap: wrap !important;
            padding: 0 !important; /* 移除内边距，避免影响对齐 */
            background: transparent !important; /* 移除背景，保持简洁 */
            border: none !important;
            box-shadow: none !important;
        }

        /* 修复表单容器对齐问题 - 关键修复 */
        .posts-section .post-actions form,
        .replies-section .post-actions form {
            display: inline-flex !important; /* 使表单容器与按钮对齐 */
            align-items: center !important;
            justify-content: center !important;
            margin: 0 !important;
            padding: 0 !important;
            height: 48px !important; /* 与按钮高度一致 */
            box-sizing: border-box !important;
            vertical-align: middle !important;
        }

        /* 统一按钮样式 - 确保完全一致 */
        .posts-section .post-actions button,
        .posts-section .post-actions input[type="submit"],
        .replies-section .post-actions button,
        .replies-section .post-actions input[type="submit"] {
            /* 强制盒模型 */
            box-sizing: border-box !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;

            /* 固定尺寸 */
            min-width: 100px !important; /* 稍微缩小宽度，更适合操作按钮 */
            height: 48px !important;
            padding: 0 20px !important; /* 调整内边距 */
            line-height: 48px !important;

            /* 样式统一 */
            font-size: 15px !important;
            font-weight: 600 !important;
            border-radius: 20px !important; /* 稍微减小圆角，更紧凑 */
            border: none !important;
            cursor: pointer !important;
            text-decoration: none !important;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1) !important;
            position: relative !important;
            overflow: hidden !important;
            gap: 6px !important;
            text-align: center !important;
            margin: 0 !important;
            vertical-align: middle !important;
        }

        /* 悬停效果 */
        .posts-section .post-actions button:hover,
        .posts-section .post-actions input[type="submit"]:hover,
        .replies-section .post-actions button:hover,
        .replies-section .post-actions input[type="submit"]:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15) !important;
        }

        /* 点击效果 */
        .posts-section .post-actions button:active,
        .posts-section .post-actions input[type="submit"]:active,
        .replies-section .post-actions button:active,
        .replies-section .post-actions input[type="submit"]:active {
            transform: translateY(1px) !important;
        }

        /* 光流动画 */
        .posts-section .post-actions button::before,
        .posts-section .post-actions input[type="submit"]::before,
        .replies-section .post-actions button::before,
        .replies-section .post-actions input[type="submit"]::before {
            content: '' !important;
            position: absolute !important;
            top: 0 !important;
            left: -100% !important;
            width: 100% !important;
            height: 100% !important;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent) !important;
            transition: left 0.5s !important;
        }

        .posts-section .post-actions button:hover::before,
        .posts-section .post-actions input[type="submit"]:hover::before,
        .replies-section .post-actions button:hover::before,
        .replies-section .post-actions input[type="submit"]:hover::before {
            left: 100% !important;
        }

        /* 编辑按钮 - 蓝色渐变 */
        .posts-section .post-actions button.btn-edit,
        .replies-section .post-actions button.btn-edit {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%) !important;
            color: white !important;
        }

        .posts-section .post-actions button.btn-edit:hover,
        .replies-section .post-actions button.btn-edit:hover {
            background: linear-gradient(135deg, #0069d9 0%, #004494 100%) !important;
        }

        /* 删除按钮 - 红色渐变 */
        .posts-section .post-actions input[type="submit"].btn-delete,
        .replies-section .post-actions input[type="submit"].btn-delete {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%) !important;
            color: white !important;
        }

        .posts-section .post-actions input[type="submit"].btn-delete:hover,
        .replies-section .post-actions input[type="submit"].btn-delete:hover {
            background: linear-gradient(135deg, #c82333 0%, #bd2130 100%) !important;
        }

        .btn-back {
            width: 100%;
            max-width: 300px;
        }

        .btn-back:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(108, 117, 125, 0.4);
            background: linear-gradient(135deg, #5a6268 0%, #4e555b 100%);
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
        }
    </style>
</head>
<body>
<div class="container">
    <h1>👤 个人中心</h1>

    <!-- 用户信息卡片 - 角色名片 -->
    <div class="user-profile-card">
        <div class="avatar-section">
            <div class="avatar-container">
                <img src="${user.avatar}?t=${System.currentTimeMillis()}"
                     alt="头像"
                     class="avatar-img"
                     onerror="this.src='${pageContext.request.contextPath}/static/avatar/1.png'">
                <c:choose>
                    <c:when test="${user.role == 'ADMIN'}">
                        <span class="role-badge role-admin">👑 管理员</span>
                    </c:when>
                    <c:when test="${user.role == 'CERTIFIED'}">
                        <span class="role-badge role-certified">🎓 认证用户</span>
                    </c:when>
                    <c:otherwise>
                        <span class="role-badge role-regular">👤 普通用户</span>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="user-info-section">
                <div class="username-display">${user.username}</div>
                <div class="user-details">
                    <div class="detail-item">
                        <div class="detail-label">注册时间</div>
                        <div class="detail-value">
                            <fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd"/>
                        </div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">用户角色</div>
                        <div class="detail-value">
                            <c:choose>
                                <c:when test="${user.role == 'ADMIN'}">👑 管理员</c:when>
                                <c:when test="${user.role == 'CERTIFIED'}">🎓 认证用户</c:when>
                                <c:otherwise>👤 普通用户</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- 按钮组 -->
                <div class="profile-actions">
                    <a href="${pageContext.request.contextPath}/user/edit-username" class="btn btn-primary">
                        ✏️ 修改用户名
                    </a>
                    <a href="${pageContext.request.contextPath}/user/edit-password" class="btn btn-primary">
                        🔒 修改密码
                    </a>
                    <a href="${pageContext.request.contextPath}/user/edit-avatar" class="btn btn-primary">
                        🖼️ 修改头像
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- 卡片容器 - 两列布局 -->
    <div class="card-container">
        <!-- 账户操作卡片 -->
        <div class="info-card">
            <h2>⚙️ 账户操作</h2>
            <c:choose>
                <c:when test="${user.role == 'ADMIN'}">
                    <div class="certification-status status-approved">
                        <p>👑 您是管理员，感谢您对社区的贡献！</p>
                    </div>
                    <div style="margin-top: 20px;">
                        <a href="${pageContext.request.contextPath}/certification/admin/review" class="link-item">
                            📋 审核认证申请
                        </a>
                        <a href="${pageContext.request.contextPath}/user/admin/user-list" class="link-item">
                            👥 管理用户
                        </a>
                    </div>
                </c:when>
                <c:when test="${user.role == 'CERTIFIED'}">
                    <div class="certification-status status-approved">
                        <p>🎓 恭喜！您现在是一名认证用户！</p>
                        <c:if test="${latestCertificationApplication != null && latestCertificationApplication.applicationStatus == 'approved'}">
                            <p style="margin-top: 10px; font-size: 14px;">
                                (最近一次认证申请已通过审核)
                            </p>
                        </c:if>
                    </div>
                </c:when>
                <c:when test="${user.role == 'USER'}">
                    <c:choose>
                        <c:when test="${latestCertificationApplication != null}">
                            <c:choose>
                                <c:when test="${latestCertificationApplication.applicationStatus == 'pending'}">
                                    <div class="certification-status status-pending">
                                        <p>⏳ 您已提交认证申请，当前状态为 <strong>待审核</strong>。</p>
                                        <p style="margin-top: 10px; font-size: 14px;">
                                            审核通常需要1-3个工作日，审核结果将通过通知告知您。
                                        </p>
                                    </div>
                                </c:when>
                                <c:when test="${latestCertificationApplication.applicationStatus == 'approved'}">
                                    <div class="certification-status status-rejected">
                                        <p>⚠️ 您的认证资格已被撤销。</p>
                                        <p style="margin-top: 10px; font-size: 14px;">
                                            如有疑问，请联系管理员。
                                        </p>
                                        <a href="${pageContext.request.contextPath}/certification/info" class="btn btn-primary" style="margin-top: 15px; display: inline-block;">
                                            📝 重新申请认证用户
                                        </a>
                                    </div>
                                </c:when>
                                <c:when test="${latestCertificationApplication.applicationStatus == 'rejected'}">
                                    <div class="certification-status status-rejected">
                                        <p>❌ 很遗憾，您之前的认证申请 <strong>未通过审核</strong>。</p>
                                        <c:if test="${not empty latestCertificationApplication.adminRemarks}">
                                            <p style="margin-top: 10px; font-size: 14px;">
                                                审核备注: <em>${latestCertificationApplication.adminRemarks}</em>
                                            </p>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/certification/info" class="btn btn-primary" style="margin-top: 15px; display: inline-block;">
                                            📝 重新申请认证用户
                                        </a>
                                    </div>
                                </c:when>
                                <c:when test="${latestCertificationApplication.applicationStatus == 'pending_discussion'}">
                                    <div class="certification-status status-discussion">
                                        <p>💬 您之前的认证申请状态为 <strong>待商议</strong>。</p>
                                        <c:if test="${not empty latestCertificationApplication.adminRemarks}">
                                            <p style="margin-top: 10px; font-size: 14px;">
                                                管理员备注: <em>${latestCertificationApplication.adminRemarks}</em>
                                            </p>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/certification/info" class="btn btn-primary" style="margin-top: 15px; display: inline-block;">
                                            📝 重新申请认证用户
                                        </a>
                                    </div>
                                </c:when>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <div class="certification-status status-pending">
                                <p>📝 您可以申请成为认证用户，获得在帖子中引用硬件参数的权限。</p>
                                <a href="${pageContext.request.contextPath}/certification/info" class="btn btn-primary" style="margin-top: 15px; display: inline-block;">
                                    📝 申请认证用户
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:when>
            </c:choose>
        </div>

        <!-- 功能导航卡片 -->
        <div class="info-card">
            <h2>🚀 功能导航</h2>
            <a href="${pageContext.request.contextPath}/user/favorites" class="link-item">
                ⭐ 我的收藏
            </a>
            <a href="${pageContext.request.contextPath}/user/notifications" class="link-item">
                🔔 通知中心
            </a>
            <a href="${pageContext.request.contextPath}/forum/section" class="link-item">
                📁 论坛分区
            </a>
            <a href="${pageContext.request.contextPath}/hardware-library" class="link-item">
                📊 硬件参数库
            </a>
        </div>
    </div>

    <!-- 我的帖子 -->
    <div class="posts-section">
        <div class="section-title">
            <h2>📝 我的帖子</h2>
            <span class="count-badge">${totalPosts}</span>
        </div>

        <c:choose>
            <c:when test="${not empty userPosts && fn:length(userPosts) > 0}">
                <c:forEach items="${userPosts}" var="post">
                    <div class="post-item">
                        <a href="${pageContext.request.contextPath}/post/${post.id}" class="post-title">
                                ${post.title}
                        </a>
                        <div class="post-meta">
                            <c:if test="${not empty post.sectionName}">
                                <span>📁 ${post.sectionName}</span>
                            </c:if>
                            <span>📅 <fmt:formatDate value="${post.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                            <span>👁️ ${post.viewCount} 次浏览</span>
                        </div>
                        <div class="post-actions">
                            <c:if test="${sessionScope.currentUser != null && sessionScope.currentUser.id == post.userId}">
                                <!-- 修复：将 <a> 改为 <button>，使用 onclick 跳转 -->
                                <button type="button" class="action-btn btn-edit"
                                        onclick="window.location.href='${pageContext.request.contextPath}/post/${post.id}/edit'">
                                    ✏️ 编辑
                                </button>
                            </c:if>
                            <c:if test="${sessionScope.currentUser != null && (sessionScope.currentUser.id == post.userId || sessionScope.currentUser.role == 'ADMIN')}">
                                <form action="${pageContext.request.contextPath}/post/${post.id}/delete" method="post" style="display:inline;">
                                    <input type="submit" value="🗑️ 删除" class="action-btn btn-delete"
                                           onclick="return confirm('确定要删除此帖子吗？删除后无法恢复！');">
                                </form>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>

                <!-- 帖子分页 -->
                <div class="pagination">
                    <c:forEach begin="1" end="${totalPagesPosts}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPagePosts}">
                                <span class="current-page">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/user/profile?pagePosts=${i}&pageReplies=${pageReplies}">
                                        ${i}
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
                <div class="pagination-info">
                    显示 ${startPostIndex} 到 ${endPostIndex} 条，共 ${totalPosts} 条
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">📭</div>
                    <p>您还没有发布任何帖子。</p>
                    <a href="${pageContext.request.contextPath}/post/create" class="btn btn-primary">
                        ✏️ 创建新帖子
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 我的回复 -->
    <div class="replies-section">
        <div class="section-title">
            <h2>💬 我的回复</h2>
            <span class="count-badge">${totalReplies}</span>
        </div>

        <c:choose>
            <c:when test="${not empty userReplies && fn:length(userReplies) > 0}">
                <c:forEach items="${userReplies}" var="reply">
                    <div class="reply-item">
                        <a href="${pageContext.request.contextPath}/post/${reply.postId}#reply-${reply.id}" class="reply-content">
                                ${fn:substring(reply.content, 0, 50)}
                            <c:if test="${fn:length(reply.content) > 50}">...</c:if>
                        </a>
                        <div class="reply-meta">
                            <span>📅 <fmt:formatDate value="${reply.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                        </div>
                    </div>
                </c:forEach>

                <!-- 回复分页 -->
                <div class="pagination">
                    <c:forEach begin="1" end="${totalPagesReplies}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPageReplies}">
                                <span class="current-page">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/user/profile?pagePosts=${pagePosts}&pageReplies=${i}">
                                        ${i}
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
                <div class="pagination-info">
                    显示 ${startReplyIndex} 到 ${endReplyIndex} 条，共 ${totalReplies} 条
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">📭</div>
                    <p>您还没有发表任何回复。</p>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                        🏠 去首页浏览帖子
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 返回控件 -->
    <div style="text-align: center;">
        <a href="${pageContext.request.contextPath}/" class="btn-back">
            🏠 返回首页
        </a>
    </div>

</div>
</body>
</html>
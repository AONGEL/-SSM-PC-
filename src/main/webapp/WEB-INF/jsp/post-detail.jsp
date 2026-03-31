<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>${post.title} - 帖子详情</title>
    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
    <style>
    /* 帖子标题美化 - 居中显示 */
    h1 {
        text-align: center !important;
        color: #2c3e50;
        font-size: 36px;
        margin: 20px auto 30px !important;
        padding: 15px 0 !important;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.05);
        letter-spacing: 1px;
        font-weight: 700;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        position: relative;
        display: block;
        width: fit-content;
        margin-left: auto !important;
        margin-right: auto !important;
    }

    /* 标题底部横线 - 确保居中 */
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
        margin-left: 0 !important;
        margin-right: 0 !important;
    }

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
    max-width: 1000px;
    margin: 0 auto;
    padding: 20px;
    }

    /* 帖子信息卡片 */
    .post-info-card {
        background: rgba(255, 255, 255, 0.98);
        backdrop-filter: blur(10px);
        padding: 20px;
        border-radius: 20px;
        margin-bottom: 25px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
        border: 1px solid rgba(255, 255, 255, 0.18);
        text-align: center; /* 整个卡片内容居中 */
    }

    /* 帖子信息区域 - 居中布局 */
    .post-info {
        display: flex;
        flex-direction: column; /* 改为垂直排列 */
        align-items: center; /* 水平居中 */
        justify-content: center; /* 垂直居中 */
        gap: 15px;
    }

    .post-info p {
        margin: 0;
        color: #495057;
        font-size: 15px;
    }

    /* 元信息区域 - 居中布局 */
    .post-meta {
        display: flex;
        flex-wrap: wrap;
        justify-content: center; /* 居中对齐 */
        align-items: center;
        gap: 20px;
        margin-top: 10px;
    }

    .post-meta-item {
        display: flex;
        align-items: center;
        gap: 5px;
        color: #6c757d;
        padding: 5px 10px;
        border-radius: 10px;
        background: rgba(102, 126, 234, 0.05);
        transition: all 0.3s ease;
    }

    .post-meta-item:hover {
        background: rgba(102, 126, 234, 0.1);
        transform: translateY(-2px);
    }

    .post-meta-item strong {
        color: #2c3e50;
        font-weight: 600;
    }

    /* 板块信息 - 居中 */
    .post-section {
        margin-top: 10px;
    }

    .post-section p {
        margin: 5px 0;
        color: #6c757d;
        font-size: 14px;
    }

    .post-section a {
        color: #667eea;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .post-section a:hover {
        color: #764ba2;
        text-decoration: underline;
    }

    /* 帖子内容美化 */
    .post-content {
    background: rgba(255, 255, 255, 0.98);
    backdrop-filter: blur(10px);
    padding: 30px;
    border-radius: 20px;
    margin-bottom: 25px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
    border: 1px solid rgba(255, 255, 255, 0.18);
    line-height: 1.8;
    font-size: 16px;
    color: #333;
    }

    .post-content img,
    .reply-content-rendered img {
    max-width: 100%;
    height: auto;
    margin: 10px 0;
    border: 1px solid #e9ecef;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }

    /* 按钮美化 */
    .btn {
    padding: 10px 20px;
    border: none;
    border-radius: 20px;
    cursor: pointer;
    font-size: 15px;
    font-weight: 600;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    position: relative;
    overflow: hidden;
    gap: 5px;
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
    box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
    }

    .btn:active {
    transform: translateY(1px);
    }

    /* 主要按钮 - 紫色渐变 */
    .btn-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    }

    .btn-primary:hover {
    background: linear-gradient(135deg, #5568d3 0%, #653a8f 100%);
    }

    /* 危险按钮 - 红色渐变 */
    .btn-danger {
    background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
    color: white;
    }

    .btn-danger:hover {
    background: linear-gradient(135deg, #c82333 0%, #bd2130 100%);
    }

    /* 信息按钮 - 蓝色渐变 */
    .btn-info {
    background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
    color: white;
    }

    .btn-info:hover {
    background: linear-gradient(135deg, #138496 0%, #117a8b 100%);
    }

    /* 锁定帖子提示样式 */
    .locked-post-message {
        background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
        border-left: 5px solid #f44336;
        padding: 20px 25px;
        border-radius: 15px;
        margin-bottom: 25px;
        box-shadow: 0 4px 15px rgba(244, 67, 54, 0.15);
        animation: slideDown 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .locked-post-message::before {
        content: '🔒';
        position: absolute;
        left: 15px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 32px;
        opacity: 0.3;
    }

    .locked-post-message p {
        margin: 0;
        color: #c62828;
        font-size: 17px;
        font-weight: 600;
        padding-left: 45px;
        line-height: 1.6;
    }

    .locked-post-message p strong {
        color: #d32f2f;
        font-weight: 700;
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
    padding: 10px 25px;
    background: rgba(255, 255, 255, 0.15);
    color: #667eea !important;
    text-decoration: none;
    border-radius: 25px;
    font-weight: 600;
    font-size: 15px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .back-link:hover {
    transform: translateY(-3px);
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
    background: rgba(255, 255, 255, 0.25);
    color: #764ba2 !important;
    }

    /* 硬件引用链接样式 */
    .hardware-ref {
    color: #667eea;
    text-decoration: none;
    border-bottom: 2px solid #667eea;
    padding: 2px 6px;
    border-radius: 4px;
    font-weight: 600;
    transition: all 0.3s ease;
    display: inline-block;
    background: rgba(102, 126, 234, 0.05);
    }

    .hardware-ref:hover {
    color: #764ba2;
    border-bottom-color: #764ba2;
    background: rgba(102, 126, 234, 0.1);
    transform: translateY(-2px);
    }

    /* 硬件模态框美化 */
    .hardware-modal {
    display: none;
    position: fixed;
    z-index: 2000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.6);
    backdrop-filter: blur(8px);
    }

    .hardware-modal-content {
    background: rgba(255, 255, 255, 0.99);
    backdrop-filter: blur(15px);
    margin: 8% auto;
    padding: 40px;
    border-radius: 25px;
    width: 90%;
    max-width: 650px;
    box-shadow: 0 15px 60px rgba(0, 0, 0, 0.35);
    border: 2px solid rgba(255, 255, 255, 0.5);
    animation: modalFadeIn 0.4s ease;
    position: relative;
    }

    @keyframes modalFadeIn {
    from {
    opacity: 0;
    transform: translateY(-30px) scale(0.95);
    }
    to {
    opacity: 1;
    transform: translateY(0) scale(1);
    }
    }

    .hardware-modal-close {
    color: #6c757d;
    float: right;
    font-size: 36px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease;
    position: relative;
    z-index: 10;
    background: none;
    border: none;
    padding: 0;
    line-height: 1;
    }

    .hardware-modal-close:hover,
    .hardware-modal-close:focus {
    color: #dc3545;
    transform: rotate(90deg) scale(1.2);
    text-shadow: 0 0 10px rgba(220, 53, 69, 0.3);
    }

    .hardware-modal h3 {
    color: #2c3e50;
    font-size: 26px;
    margin-bottom: 25px;
    font-weight: 700;
    text-align: center;
    position: relative;
    }

    .hardware-modal h3::after {
    content: '';
    position: absolute;
    bottom: -12px;
    left: 50%;
    transform: translateX(-50%);
    width: 80px;
    height: 4px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 2px;
    }

    .hardware-detail {
    margin-top: 15px;
    }

    .hardware-detail p {
    margin: 10px 0;
    color: #495057;
    font-size: 16px;
    }

    .hardware-detail p strong {
    color: #2c3e50;
    font-weight: 600;
    margin-right: 8px;
    }

    /* ========== 帖子操作按钮区域 ========== */
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
    }

    /* ========== 统一按钮基础样式 ========== */
    .action-btn,
    .btn-edit,
    .btn-delete,
    .btn-pin,
    .btn-unpin,
    .btn-lock,
    .btn-unlock,
    .btn-favorite {
        display: inline-flex !important;  /* 确保是 flex 布局 */
        align-items: center !important;   /* 垂直居中 */
        justify-content: center !important; /* 水平居中 */
        padding: 12px 24px !important;    /* 统一内边距 */
        height: 48px !important;          /* 统一高度 */
        line-height: 1 !important;        /* 统一行高 */
        border: none !important;
        border-radius: 25px !important;
        cursor: pointer !important;
        font-size: 15px !important;
        font-weight: 600 !important;
        text-decoration: none !important; /* 去掉超链接下划线 */
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1) !important;
        position: relative !important;
        overflow: hidden !important;
        gap: 8px !important;
        min-width: 110px !important;
        box-sizing: border-box !important; /* 确保盒模型一致 */
    }

    .action-btn::before,
    .btn-edit::before,
    .btn-delete::before,
    .btn-pin::before,
    .btn-unpin::before,
    .btn-lock::before,
    .btn-unlock::before,
    .btn-favorite::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: left 0.5s;
    }

    .action-btn:hover::before,
    .btn-edit:hover::before,
    .btn-delete:hover::before,
    .btn-pin:hover::before,
    .btn-unpin:hover::before,
    .btn-lock:hover::before,
    .btn-unlock:hover::before,
    .btn-favorite:hover::before {
        left: 100%;
    }

    .action-btn:hover::before,
    .btn-edit:hover,
    .btn-delete:hover,
    .btn-pin:hover,
    .btn-unpin:hover,
    .btn-lock:hover,
    .btn-unlock:hover,
    .btn-favorite:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
    }

    .action-btn:active,
    .btn-edit:active,
    .btn-delete:active,
    .btn-pin:active,
    .btn-unpin:active,
    .btn-lock:active,
    .btn-unlock:active,
    .btn-favorite:active {
        transform: translateY(1px);
    }

    /* ========== 编辑按钮 - 蓝色渐变 ========== */
    .btn-edit {
        background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
        color: white;
    }

    .btn-edit:hover {
        background: linear-gradient(135deg, #0069d9 0%, #004494 100%);
    }

    /* ========== 删除按钮 - 红色渐变 ========== */
    .btn-delete {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        color: white;
    }

    .btn-delete:hover {
        background: linear-gradient(135deg, #c82333 0%, #bd2130 100%);
    }

    /* ========== 置顶按钮 - 紫色渐变 ========== */
    .btn-pin {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
    }

    .btn-pin:hover {
        background: linear-gradient(135deg, #5568d3 0%, #653a8f 100%);
    }

    /* ========== 取消置顶按钮 - 灰色渐变 ========== */
    .btn-unpin {
        background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
        color: white;
    }

    .btn-unpin:hover {
        background: linear-gradient(135deg, #5a6268 0%, #4e555b 100%);
    }

    /* ========== 锁定按钮 - 橙色渐变 ========== */
    .btn-lock {
        background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
        color: #212529;
    }

    .btn-lock:hover {
        background: linear-gradient(135deg, #e0a800 0%, #d39e00 100%);
    }

    /* ========== 解锁按钮 - 绿色渐变 ========== */
    .btn-unlock {
        background: linear-gradient(135deg, #28a745 0%, #218838 100%);
        color: white;
    }

    .btn-unlock:hover {
        background: linear-gradient(135deg, #218838 0%, #1e7e34 100%);
    }

    /* ========== 收藏按钮 - 粉色渐变 ========== */
    .btn-favorite {
        background: linear-gradient(135deg, #e83e8c 0%, #d91a6a 100%);
        color: white;
    }

    .btn-favorite:hover {
        background: linear-gradient(135deg, #d91a6a 0%, #c4155d 100%);
    }

    .btn-favorite.favorited {
        background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
        color: #212529;
    }

    .btn-favorite.favorited:hover {
        background: linear-gradient(135deg, #e0a800 0%, #d39e00 100%);
    }

    /* 回复列表美化 */
    .reply-list {
    margin-top: 30px;
    }

    .reply-item {
    background: rgba(255, 255, 255, 0.98);
    backdrop-filter: blur(10px);
    padding: 25px;
    border-radius: 20px;
    margin-bottom: 20px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
    border: 1px solid rgba(255, 255, 255, 0.18);
    transition: all 0.3s ease;
    }

    .reply-item:hover {
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
    transform: translateY(-3px);
    }

    .reply-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
    padding-bottom: 15px;
    border-bottom: 2px solid #e9ecef;
    }

    .reply-author {
    font-weight: 700;
    color: #2c3e50;
    font-size: 18px;
    }

    .reply-meta {
    color: #6c757d;
    font-size: 14px;
    display: flex;
    gap: 15px;
    }

    .reply-content-rendered {
    line-height: 1.8;
    color: #333;
    font-size: 16px;
    margin-bottom: 15px;
    }

    .reply-actions {
    display: flex;
    gap: 10px;
    margin-top: 15px;
    flex-wrap: wrap;
    }

    /* 回复表单美化 */
    .reply-form-card {
    background: rgba(255, 255, 255, 0.98);
    backdrop-filter: blur(10px);
    padding: 30px;
    border-radius: 20px;
    margin-top: 30px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
    border: 1px solid rgba(255, 255, 255, 0.18);
    }

    .reply-form-card h3 {
    color: #2c3e50;
    font-size: 22px;
    margin-bottom: 20px;
    font-weight: 600;
    }

    .form-group {
    margin-bottom: 20px;
    }

    .form-group label {
    display: block;
    font-weight: 600;
    color: #2c3e50;
    font-size: 16px;
    margin-bottom: 10px;
    padding-left: 5px;
    }

    textarea#replyContent {
    width: 100%;
    padding: 16px 20px;
    border: 2px solid #e0e0e0;
    border-radius: 15px;
    font-size: 16px;
    font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
    resize: vertical;
    min-height: 150px;
    max-height: 400px;
    transition: all 0.3s ease;
    background: #fff;
    color: #333;
    box-sizing: border-box;
    line-height: 1.6;
    }

    textarea#replyContent:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
    }

    textarea#replyContent::placeholder {
    color: #9e9e9e;
    font-style: italic;
    }

    /* 表单按钮组 */
    .form-button-group {
    display: flex;
    gap: 15px;
    margin-top: 20px;
    flex-wrap: wrap;
    }

    /* 错误提示美化 */
    .error {
    color: #dc3545;
    font-size: 14px;
    margin-top: 8px;
    display: block;
    font-weight: 500;
    padding-left: 5px;
    }

    /* 响应式调整 */
    @media (max-width: 768px) {
    body {
    padding: 10px;
    }

    .container {
    padding: 10px;
    }

    .btn {
    width: 100%;
    max-width: 300px;
    margin-bottom: 10px;
    }

    .form-button-group,
    .reply-actions {
    flex-direction: column;
    align-items: stretch;
    }

    .hardware-modal-content {
    margin: 15% auto;
    padding: 30px 20px;
    width: 95%;
    }

    .page-footer {
    flex-direction: column;
    gap: 10px;
    }

    .back-link {
        width: 100%;
        max-width: 300px;
        text-align: center;
    }
    }

    /* 修复硬件引用模态框滚动问题 */

    /* 1. 为模态框内容区域添加最大高度和滚动 */
    .hardware-modal-content {
        max-height: 85vh !important;  /* 限制最大高度 */
        overflow-y: auto !important;   /* 启用垂直滚动 */
        overflow-x: hidden !important; /* 隐藏水平滚动 */
    }

    /* 2. 修复搜索结果列表的滚动（回复框专用） */
    #replyHardwareList {
        max-height: 350px !important;  /* 增加高度 */
        overflow-y: auto !important;
        overflow-x: hidden !important;
        padding: 10px 0 !important;
        margin-top: 10px !important;
    }

    /* 3. 添加漂亮的滚动条样式（Chrome/Safari） */
    #replyHardwareList::-webkit-scrollbar {
        width: 10px !important;
    }

    #replyHardwareList::-webkit-scrollbar-track {
        background: #f1f1f1 !important;
        border-radius: 10px !important;
    }

    #replyHardwareList::-webkit-scrollbar-thumb {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
        border-radius: 10px !important;
        border: 2px solid #f1f1f1 !important;
    }

    #replyHardwareList::-webkit-scrollbar-thumb:hover {
        background: linear-gradient(135deg, #5568d3 0%, #653a8f 100%) !important;
    }

    /* 4. Firefox 滚动条支持 */
    #replyHardwareList {
        scrollbar-width: thin !important;
        scrollbar-color: #667eea #f1f1f1 !important;
    }

    /* 5. 确保模态框容器允许滚动 */
    .hardware-modal {
        overflow: hidden !important; /* 外层容器隐藏滚动 */
    }

    /* 6. 防止内容被截断 */
    .hardware-modal-content > * {
        position: relative !important;
        z-index: 1 !important;
    }

    /* ========== 美化分页控件 ========== */
    .pagination {
        margin: 40px 0;
        text-align: center;
        padding: 25px;
        background: rgba(255, 255, 255, 0.95);
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
        border: 1px solid rgba(255, 255, 255, 0.3);
        backdrop-filter: blur(10px);
        position: relative;
        overflow: hidden;
    }

    .pagination::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(102, 126, 234, 0.05) 0%, transparent 70%);
        z-index: 0;
    }

    /* 分页链接样式 */
    .pagination a,
    .pagination span.current-page {
        display: inline-block;
        padding: 10px 20px;
        margin: 0 5px;
        border-radius: 15px;
        text-decoration: none;
        font-size: 16px;
        font-weight: 600;
        transition: all 0.3s ease;
        position: relative;
        z-index: 1;
    }

    /* 普通分页链接 */
    .pagination a {
        background: rgba(255, 255, 255, 0.6);
        color: #667eea;
        border: 2px solid rgba(102, 126, 234, 0.3);
    }

    .pagination a:hover {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-color: rgba(102, 126, 234, 0.8);
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.3);
    }

    /* 当前页码样式 */
    .pagination span.current-page {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: 2px solid rgba(102, 126, 234, 0.8);
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        cursor: default;
    }

    /* 上一页/下一页按钮样式 */
    .pagination a:first-child {
        padding: 10px 18px;
    }

    .pagination a:last-child {
        padding: 10px 18px;
    }

    /* 页码信息样式 */
    .page-info {
        margin-top: 15px;
        color: #6c757d;
        font-size: 15px;
        font-weight: 500;
        padding-top: 15px;
        border-top: 1px solid rgba(102, 126, 234, 0.2);
    }

    /* 响应式调整 */
    @media (max-width: 768px) {
        .pagination {
            padding: 20px 15px;
        }

        .pagination a,
        .pagination span.current-page {
            padding: 8px 15px;
            margin: 0 3px;
            font-size: 14px;
        }

        .page-info {
            font-size: 14px;
        }
    }
    </style>
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

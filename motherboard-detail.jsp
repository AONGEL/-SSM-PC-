<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${motherboard.brand} ${motherboard.model} 详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<h1>${motherboard.brand} ${motherboard.model} 详情</h1>
<ul>
    <li><strong>ID:</strong> ${motherboard.id}</li>
    <li><strong>品牌:</strong> ${motherboard.brand}</li>
    <li><strong>型号:</strong> ${motherboard.model}</li>
    <li><strong>芯片组:</strong> ${motherboard.chipset}</li>
    <li><strong>CPU接口:</strong> ${motherboard.cpuInterface}</li>
    <li><strong>内存插槽:</strong> ${motherboard.memorySlots}</li>
    <li><strong>最大内存:</strong> ${motherboard.maxMemory} GB</li>
    <li><strong>内存类型:</strong> ${motherboard.memoryType}</li>
    <li><strong>供电相数:</strong> ${motherboard.powerPhase}</li>
    <li><strong>SATA接口:</strong> ${motherboard.sataPorts}</li>
    <li><strong>M.2插槽:</strong> ${motherboard.m2Slots}</li>
    <li><strong>发布日期:</strong> ${motherboard.releaseDate}</li>
</ul>
<a href="${pageContext.request.contextPath}/hardware/motherboard">返回主板列表</a>
</body>
</html>

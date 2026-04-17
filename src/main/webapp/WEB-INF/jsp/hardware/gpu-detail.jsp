<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${gpu.brand} ${gpu.model} 详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<h1>${gpu.brand} ${gpu.model} 详情</h1>
<ul>
    <li><strong>ID:</strong> ${gpu.id}</li>
    <li><strong>品牌:</strong> ${gpu.brand}</li>
    <li><strong>型号:</strong> ${gpu.model}</li>
    <li><strong>显存容量:</strong> ${gpu.memorySize} GB</li>
    <li><strong>显存类型:</strong> ${gpu.memoryType}</li>
    <li><strong>显存位宽:</strong> ${gpu.memoryBusWidth} bit</li>
    <li><strong>基础频率:</strong> ${gpu.baseClock} MHz</li>
    <li><strong>加速频率:</strong> ${gpu.boostClock} MHz</li>
    <li><strong>整卡功耗:</strong> ${gpu.tdp} W</li>
    <li><strong>接口类型:</strong> ${gpu.interfaceType}</li>
    <li><strong>发布日期:</strong> ${gpu.releaseDate}</li>
</ul>
<a href="${pageContext.request.contextPath}/hardware/gpu">返回GPU列表</a>
</body>
</html>

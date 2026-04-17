<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>GPU 列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<h1>GPU 列表</h1>
<table border="1">
    <thead>
    <tr>
        <th>ID</th>
        <th>品牌</th>
        <th>型号</th>
        <th>显存容量 (GB)</th>
        <th>显存类型</th>
        <th>显存位宽 (bit)</th>
        <th>基础频率 (MHz)</th>
        <th>加速频率 (MHz)</th>
        <th>TDP (W)</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${gpus}" var="gpu">
        <tr>
            <td>${gpu.id}</td>
            <td>${gpu.brand}</td>
            <td>${gpu.model}</td>
            <td>${gpu.memorySize}</td>
            <td>${gpu.memoryType}</td>
            <td>${gpu.memoryBusWidth}</td>
            <td>${gpu.baseClock}</td>
            <td>${gpu.boostClock}</td>
            <td>${gpu.tdp}</td>
            <td><a href="${pageContext.request.contextPath}/hardware/gpu/${gpu.id}">详情</a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<a href="${pageContext.request.contextPath}/">返回首页</a>
</body>
</html>

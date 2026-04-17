<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>主板 列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<h1>主板 列表</h1>
<table border="1">
    <thead>
    <tr>
        <th>ID</th>
        <th>品牌</th>
        <th>型号</th>
        <th>芯片组</th>
        <th>CPU接口</th>
        <th>内存插槽</th>
        <th>最大内存 (GB)</th>
        <th>内存类型</th>
        <th>供电相数</th>
        <th>SATA接口</th>
        <th>M.2插槽</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${motherboards}" var="motherboard">
        <tr>
            <td>${motherboard.id}</td>
            <td>${motherboard.brand}</td>
            <td>${motherboard.model}</td>
            <td>${motherboard.chipset}</td>
            <td>${motherboard.cpuInterface}</td>
            <td>${motherboard.memorySlots}</td>
            <td>${motherboard.maxMemory}</td>
            <td>${motherboard.memoryType}</td>
            <td>${motherboard.powerPhase}</td>
            <td>${motherboard.sataPorts}</td>
            <td>${motherboard.m2Slots}</td>
            <td><a href="${pageContext.request.contextPath}/hardware/motherboard/${motherboard.id}">详情</a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<a href="${pageContext.request.contextPath}/">返回首页</a>
</body>
</html>

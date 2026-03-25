<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>CPU 列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<h1>CPU 列表</h1>
<table border="1">
    <thead>
    <tr>
        <th>ID</th>
        <th>品牌</th>
        <th>型号</th>
        <th>接口类型</th>
        <th>核心数</th>
        <th>线程数</th>
        <th>基础频率 (GHz)</th>
        <th>最大频率 (GHz)</th>
        <th>TDP (W)</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${cpus}" var="cpu">
        <tr>
            <td>${cpu.id}</td>
            <td>${cpu.brand}</td>
            <td>${cpu.model}</td>
            <td>${cpu.interfaceType}</td>
            <td>${cpu.cores}</td>
            <td>${cpu.threads}</td>
            <td>${cpu.baseFrequency}</td>
            <td>${cpu.maxFrequency}</td>
            <td>${cpu.tdp}</td>
            <td><a href="${pageContext.request.contextPath}/hardware/cpu/${cpu.id}">详情</a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<a href="${pageContext.request.contextPath}/">返回首页</a>
</body>
</html>

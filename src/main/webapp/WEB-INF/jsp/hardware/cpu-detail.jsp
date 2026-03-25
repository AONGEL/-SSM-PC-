<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${cpu.brand} ${cpu.model} 详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<h1>${cpu.brand} ${cpu.model} 详情</h1>
<ul>
    <li><strong>ID:</strong> ${cpu.id}</li>
    <li><strong>品牌:</strong> ${cpu.brand}</li>
    <li><strong>型号:</strong> ${cpu.model}</li>
    <li><strong>接口类型:</strong> ${cpu.interfaceType}</li>
    <li><strong>核心数:</strong> ${cpu.cores}</li>
    <li><strong>线程数:</strong> ${cpu.threads}</li>
    <li><strong>基础频率:</strong> ${cpu.baseFrequency} GHz</li>
    <li><strong>最大睿频:</strong> ${cpu.maxFrequency} GHz</li>
    <li><strong>基础功耗:</strong> ${cpu.tdp} W</li>
    <li><strong>核显型号:</strong> ${cpu.integratedGraphics}</li>
    <li><strong>发布日期:</strong> ${cpu.releaseDate}</li>
</ul>
<a href="${pageContext.request.contextPath}/hardware/cpu">返回CPU列表</a>
</body>
</html>

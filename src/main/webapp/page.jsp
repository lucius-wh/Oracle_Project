<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>古建筑分页查询</title>
    <%@ include file="/includes/head.jsp" %>
</head>
<body class="page-bg font-sans text-ink antialiased">
<div id="page-loader"><div class="spinner"></div></div>

<header class="glass-nav sticky top-0 z-40">
    <div class="mx-auto flex max-w-7xl items-center justify-between px-4 py-3.5 sm:px-6 lg:px-8">
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn-ghost -ml-2">
            <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/></svg>
            返回首页
        </a>
        <span class="text-sm font-semibold text-ink">建筑目录</span>
        <div class="w-20"></div>
    </div>
</header>

<main class="mx-auto max-w-7xl px-4 py-8 sm:px-6 sm:py-10 lg:px-8">
    <section class="mb-8 text-center sm:text-left" data-animate>
        <h1 class="text-2xl font-bold tracking-tight text-ink sm:text-3xl">古建筑信息列表</h1>
        <p class="mt-2 text-sm text-ink-muted">正常数据 · 分页浏览与管理</p>
    </section>

    <div class="table-shell mb-8 overflow-x-auto" data-animate>
        <table class="data-table min-w-[800px]">
            <thead>
            <tr>
                <th>所属地区</th>
                <th>建筑名称</th>
                <th>建造年代</th>
                <th>保护等级</th>
                <th class="min-w-[200px]">建筑介绍</th>
                <th class="text-center">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${empty pageBean.list}">
                <tr>
                    <td colspan="6" class="py-12 text-center text-ink-muted">暂无正常数据</td>
                </tr>
            </c:if>
            <c:forEach items="${pageBean.list}" var="building">
                <tr>
                    <td class="font-medium">${building.areaName}</td>
                    <td>${building.buildingName}</td>
                    <td class="text-ink-muted">${building.buildYear == null ? "未知" : building.buildYear}</td>
                    <td>
                        <span class="inline-flex rounded-full bg-accent-soft px-2.5 py-0.5 text-xs font-medium text-accent">
                            ${building.protectionLevel == null ? "无等级" : building.protectionLevel}
                        </span>
                    </td>
                    <td class="max-w-xs text-left text-sm leading-relaxed text-ink-muted line-clamp-2">
                        ${building.introduction == null ? "暂无介绍" : building.introduction}
                    </td>
                    <td class="text-center">
                        <a href="javascript:;" onclick="confirmDelete(${building.id})"
                           class="btn-danger !px-3 !py-1.5 !text-xs">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <nav class="mb-10 flex flex-wrap items-center justify-center gap-2 sm:gap-3" data-animate aria-label="分页">
        <c:choose>
            <c:when test="${pageBean.pageNum == 1}">
                <span class="inline-flex cursor-not-allowed items-center rounded-2xl bg-black/5 px-4 py-2 text-sm text-ink-faint">首页</span>
                <span class="inline-flex cursor-not-allowed items-center rounded-2xl bg-black/5 px-4 py-2 text-sm text-ink-faint">上一页</span>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/building/page?pageNum=1" class="btn-secondary !py-2 !text-sm">首页</a>
                <a href="${pageContext.request.contextPath}/building/page?pageNum=${pageBean.pageNum - 1}" class="btn-secondary !py-2 !text-sm">上一页</a>
            </c:otherwise>
        </c:choose>

        <span class="mx-2 rounded-2xl bg-white px-4 py-2 text-sm text-ink-muted shadow-glow">
            第 <strong class="text-ink">${pageBean.pageNum}</strong> / ${pageBean.pages} 页 · 共 ${pageBean.total} 条
        </span>

        <c:choose>
            <c:when test="${pageBean.pageNum == pageBean.pages || pageBean.pages == 0}">
                <span class="inline-flex cursor-not-allowed items-center rounded-2xl bg-black/5 px-4 py-2 text-sm text-ink-faint">下一页</span>
                <span class="inline-flex cursor-not-allowed items-center rounded-2xl bg-black/5 px-4 py-2 text-sm text-ink-faint">尾页</span>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/building/page?pageNum=${pageBean.pageNum + 1}" class="btn-secondary !py-2 !text-sm">下一页</a>
                <a href="${pageContext.request.contextPath}/building/page?pageNum=${pageBean.pages}" class="btn-secondary !py-2 !text-sm">尾页</a>
            </c:otherwise>
        </c:choose>

        <div class="mt-2 flex w-full basis-full items-center justify-center gap-2 sm:mt-0 sm:w-auto sm:basis-auto">
            <input type="number" id="pageInput" min="1" max="${pageBean.pages}" placeholder="页码"
                   class="input-field !w-20 !py-2 text-center">
            <button type="button" onclick="jumpPage()" class="btn-primary !py-2">跳转</button>
        </div>
    </nav>

    <c:if test="${isLastPage}">
        <section class="mb-8" data-animate>
            <div class="mb-4 flex items-center gap-3">
                <div class="h-px flex-1 bg-black/10"></div>
                <h2 class="text-sm font-semibold uppercase tracking-wider text-ink-faint">已删除 · 可恢复</h2>
                <div class="h-px flex-1 bg-black/10"></div>
            </div>
            <div class="table-shell overflow-x-auto opacity-90">
                <table class="data-table min-w-[800px]">
                    <thead>
                    <tr>
                        <th>所属地区</th>
                        <th>建筑名称</th>
                        <th>建造年代</th>
                        <th>保护等级</th>
                        <th>建筑介绍</th>
                        <th class="text-center">操作</th>
                    </tr>
                    </thead>
                    <tbody class="text-ink-muted">
                    <c:if test="${empty deletedList}">
                        <tr>
                            <td colspan="6" class="py-10 text-center">暂无已删除数据</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${deletedList}" var="building">
                        <tr>
                            <td>${building.areaName}</td>
                            <td>${building.buildingName}</td>
                            <td>${building.buildYear == null ? "未知" : building.buildYear}</td>
                            <td>${building.protectionLevel == null ? "无等级" : building.protectionLevel}</td>
                            <td class="max-w-xs text-left text-sm line-clamp-2">${building.introduction == null ? "暂无介绍" : building.introduction}</td>
                            <td class="text-center">
                                <a href="javascript:;" onclick="confirmRestore(${building.id})"
                                   class="btn-success !px-3 !py-1.5 !text-xs">恢复</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>
    </c:if>
</main>

<script>
    function jumpPage() {
        let pageNum = document.getElementById("pageInput").value;
        let totalPages = ${pageBean.pages};
        if (!pageNum || pageNum < 1 || pageNum > totalPages) {
            alert("请输入1~" + totalPages + "之间的页码");
            return;
        }
        window.location.href = "${pageContext.request.contextPath}/building/page?pageNum=" + pageNum;
    }
    function confirmDelete(buildingId) {
        if (confirm("确定要删除该古建筑信息吗？")) {
            window.location.href = "${pageContext.request.contextPath}/building/delete?id=" + buildingId;
        }
    }
    function confirmRestore(buildingId) {
        if (confirm("确定要恢复该古建筑信息吗？")) {
            window.location.href = "${pageContext.request.contextPath}/building/restore?id=" + buildingId;
        }
    }
</script>
<%@ include file="/includes/footer-scripts.jsp" %>
</body>
</html>

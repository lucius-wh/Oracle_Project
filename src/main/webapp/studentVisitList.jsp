<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>学生参观古建筑记录</title>
    <%@ include file="/includes/head.jsp" %>
    <script>
        function deleteRel(relId) {
            let flag = confirm("确定删除该记录吗？");
            if (flag) {
                window.location.href =
                    "${pageContext.request.contextPath}/visit/deleteRel?relId=" + relId;
            }
        }
        function resetSearch() {
            window.location.href = "${pageContext.request.contextPath}/visit/list";
        }
        function goIndex() {
            window.location.href = "${pageContext.request.contextPath}/index.jsp";
        }
        function goAddRel() {
            window.location.href = "${pageContext.request.contextPath}/add_rel.jsp";
        }
    </script>
</head>
<body class="page-bg font-sans text-ink antialiased">
<div id="page-loader"><div class="spinner"></div></div>

<header class="glass-nav sticky top-0 z-40">
    <div class="mx-auto flex max-w-7xl flex-wrap items-center justify-between gap-3 px-4 py-3.5 sm:px-6 lg:px-8">
        <div class="flex items-center gap-2">
            <button type="button" onclick="goIndex()" class="btn-ghost !px-3">
                <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/></svg>
                首页
            </button>
        </div>
        <h1 class="text-sm font-semibold text-ink sm:text-base">参观评分记录</h1>
        <button type="button" onclick="goAddRel()" class="btn-primary !py-2 !text-sm">
            <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
            添加记录
        </button>
    </div>
</header>

<main class="mx-auto max-w-7xl px-4 py-8 sm:px-6 sm:py-10 lg:px-8">
    <section class="card mb-8 p-5 sm:p-6" data-animate>
        <p class="mb-4 text-xs font-semibold uppercase tracking-wider text-ink-faint">筛选条件</p>
        <form method="get" action="${pageContext.request.contextPath}/visit/list"
              class="flex flex-col gap-4" data-loading>
            <div class="grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
                <input type="text" name="keyword" class="input-field"
                       placeholder="学生姓名或建筑名称"
                       value="${param.keyword}">
                <select name="classname" class="select-field w-full">
                    <option value="">全部专业</option>
                    <option value="软工" ${param.classname=='软工'?'selected':''}>软工</option>
                    <option value="计科" ${param.classname=='计科'?'selected':''}>计科</option>
                    <option value="电建" ${param.classname=='电建'?'selected':''}>电建</option>
                    <option value="土木" ${param.classname=='土木'?'selected':''}>土木</option>
                    <option value="数学" ${param.classname=='数学'?'selected':''}>数学</option>
                    <option value="经管" ${param.classname=='经管'?'selected':''}>经管</option>
                    <option value="网安" ${param.classname=='网安'?'selected':''}>网安</option>
                </select>
                <select name="areaCode" class="select-field w-full">
                    <option value="">全部城市</option>
                    <option value="1401%" ${param.areaCode=='1401%'?'selected':''}>太原市</option>
                    <option value="1402%" ${param.areaCode=='1402%'?'selected':''}>大同市</option>
                    <option value="1403%" ${param.areaCode=='1403%'?'selected':''}>阳泉市</option>
                    <option value="1404%" ${param.areaCode=='1404%'?'selected':''}>长治市</option>
                    <option value="1405%" ${param.areaCode=='1405%'?'selected':''}>晋城市</option>
                    <option value="1406%" ${param.areaCode=='1406%'?'selected':''}>朔州市</option>
                    <option value="1407%" ${param.areaCode=='1407%'?'selected':''}>晋中市</option>
                    <option value="1408%" ${param.areaCode=='1408%'?'selected':''}>运城市</option>
                    <option value="1409%" ${param.areaCode=='1409%'?'selected':''}>忻州市</option>
                    <option value="1410%" ${param.areaCode=='1410%'?'selected':''}>临汾市</option>
                    <option value="1411%" ${param.areaCode=='1411%'?'selected':''}>吕梁市</option>
                </select>
                <input type="date" name="visitTime" value="${param.visitTime}" class="input-field">
            </div>
            <div class="flex flex-wrap gap-2">
                <button type="submit" class="btn-primary">查询</button>
                <button type="button" onclick="resetSearch()" class="btn-secondary">清空条件</button>
            </div>
        </form>
    </section>

    <div class="table-shell overflow-x-auto" data-animate>
        <table class="data-table min-w-[960px]">
            <thead>
            <tr>
                <th>记录ID</th>
                <th>学生ID</th>
                <th>学生姓名</th>
                <th>专业</th>
                <th>建筑ID</th>
                <th>建筑名称</th>
                <th>参观时间</th>
                <th>评分</th>
                <th class="text-center">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${visitList}" var="visit">
                <tr>
                    <td class="font-mono text-xs text-ink-muted">${visit.relId}</td>
                    <td class="font-mono text-xs">${visit.sid}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/student/detail?sid=${visit.sid}"
                           class="font-medium text-accent transition-colors hover:text-accent-hover hover:underline">
                            ${visit.sname}
                        </a>
                    </td>
                    <td>
                        <span class="rounded-full bg-black/[0.04] px-2 py-0.5 text-xs">${visit.className}</span>
                    </td>
                    <td class="font-mono text-xs">${visit.buildId}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/building/detail?id=${visit.buildId}"
                           class="font-medium text-accent transition-colors hover:text-accent-hover hover:underline">
                            ${visit.buildingName}
                        </a>
                    </td>
                    <td class="text-ink-muted whitespace-nowrap">
                        <fmt:formatDate value="${visit.visitTime}" pattern="yyyy年MM月dd日"/>
                    </td>
                    <td>
                        <span class="inline-flex min-w-[2.5rem] justify-center rounded-full bg-success/10 px-2.5 py-0.5 text-sm font-semibold text-success">
                            ${visit.score}
                        </span>
                    </td>
                    <td>
                        <div class="flex flex-wrap items-center justify-center gap-1.5">
                            <button type="button" onclick="deleteRel(${visit.relId})"
                                    class="rounded-xl px-3 py-1.5 text-xs font-medium text-danger transition-colors hover:bg-danger-soft">
                                删除
                            </button>
                            <button type="button"
                                    onclick="location.href='${pageContext.request.contextPath}/update.jsp?relId=${visit.relId}'"
                                    class="rounded-xl px-3 py-1.5 text-xs font-medium text-accent transition-colors hover:bg-accent-soft">
                                更新
                            </button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</main>

<%@ include file="/includes/footer-scripts.jsp" %>
</body>
</html>

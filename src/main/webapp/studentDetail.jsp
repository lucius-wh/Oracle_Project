<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>学生详情</title>
    <%@ include file="/includes/head.jsp" %>
    <script>
        function deleteStudent(sid) {
            let flag = confirm("确定删除该学生吗？");
            if (flag) {
                window.location.href =
                    "${pageContext.request.contextPath}/student/delete?sid=" + sid;
            }
        }
    </script>
</head>
<body class="page-bg font-sans text-ink antialiased">
<div id="page-loader"><div class="spinner"></div></div>

<header class="glass-nav sticky top-0 z-40">
    <div class="mx-auto flex max-w-lg items-center justify-between px-4 py-3.5 sm:px-6">
        <a href="${pageContext.request.contextPath}/visit/list" class="btn-ghost -ml-2">
            <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/></svg>
            返回列表
        </a>
        <span class="text-sm font-semibold">学生档案</span>
        <div class="w-16"></div>
    </div>
</header>

<main class="mx-auto max-w-lg px-4 py-8 sm:px-6 sm:py-12">
    <section class="mb-6 text-center" data-animate>
        <div class="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-full bg-gradient-to-br from-accent/20 to-blue-100 text-2xl font-bold text-accent">
            ${not empty student.sname ? student.sname.substring(0,1) : '学'}
        </div>
        <h1 class="text-2xl font-bold tracking-tight text-ink">${student.sname}</h1>
        <p class="mt-1 text-sm text-ink-muted">学号 ${student.sid}</p>
    </section>

    <div class="card overflow-hidden" data-animate>
        <dl class="divide-y divide-black/[0.04]">
            <div class="flex items-center justify-between px-6 py-4">
                <dt class="text-sm text-ink-muted">学生 ID</dt>
                <dd class="text-sm font-medium text-ink">${student.sid}</dd>
            </div>
            <div class="flex items-center justify-between px-6 py-4">
                <dt class="text-sm text-ink-muted">姓名</dt>
                <dd class="text-sm font-semibold text-ink">${student.sname}</dd>
            </div>
            <div class="flex items-center justify-between px-6 py-4">
                <dt class="text-sm text-ink-muted">性别</dt>
                <dd class="text-sm text-ink">
                    <c:if test="${student.gender.trim()=='1'}">
                        <span class="rounded-full bg-accent-soft px-3 py-1 text-xs font-medium text-accent">男</span>
                    </c:if>
                    <c:if test="${student.gender.trim()=='0'}">
                        <span class="rounded-full bg-pink-500/10 px-3 py-1 text-xs font-medium text-pink-600">女</span>
                    </c:if>
                </dd>
            </div>
            <div class="flex items-center justify-between px-6 py-4">
                <dt class="text-sm text-ink-muted">专业</dt>
                <dd class="text-sm font-medium text-ink">${student.classname}</dd>
            </div>
        </dl>
    </div>

    <div class="mt-8 flex flex-col gap-3 sm:flex-row sm:flex-wrap" data-animate>
        <a href="${pageContext.request.contextPath}/student/toUpdatePage?sid=${student.sid}" class="btn-primary flex-1 text-center sm:flex-none">
            修改学生信息
        </a>
        <button type="button" onclick="deleteStudent(${student.sid})" class="btn-danger flex-1 sm:flex-none">
            删除学生
        </button>
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/visit/list'"
                class="btn-secondary flex-1 sm:flex-none">
            返回列表
        </button>
    </div>
</main>

<%@ include file="/includes/footer-scripts.jsp" %>
</body>
</html>

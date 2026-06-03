<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>古建筑参观管理系统</title>
    <%@ include file="/includes/head.jsp" %>
</head>
<body class="page-bg font-sans text-ink antialiased">
<div id="page-loader" aria-hidden="true"><div class="spinner" role="status"></div></div>

<header class="glass-nav sticky top-0 z-40">
    <div class="mx-auto flex max-w-6xl items-center justify-between px-4 py-4 sm:px-6 lg:px-8">
        <div class="flex items-center gap-3">
            <div class="flex h-10 w-10 items-center justify-center rounded-2xl bg-gradient-to-br from-accent to-blue-600 text-lg text-white shadow-soft">🏛</div>
            <div>
                <p class="text-xs font-medium uppercase tracking-widest text-ink-faint">Heritage CMS</p>
                <p class="text-sm font-semibold text-ink">古建筑参观管理</p>
            </div>
        </div>
    </div>
</header>

<main class="mx-auto max-w-6xl px-4 py-12 sm:px-6 sm:py-16 lg:px-8 lg:py-20">
    <section class="mb-14 text-center sm:mb-16" data-animate>
        <p class="mb-3 inline-flex items-center rounded-full border border-black/5 bg-white/80 px-4 py-1.5 text-xs font-medium text-ink-muted shadow-glow backdrop-blur-sm">
            山西省古建筑数字化管理
        </p>
        <h1 class="text-3xl font-bold tracking-tight text-ink sm:text-4xl lg:text-5xl">
            欢迎回来
        </h1>
        <p class="mx-auto mt-4 max-w-xl text-base leading-relaxed text-ink-muted sm:text-lg">
            管理学生参观记录与古建筑档案，简洁高效的一站式工作台。
        </p>
    </section>

    <div class="grid gap-6 sm:grid-cols-2 lg:gap-8">
        <article class="card card-hover group p-8 sm:p-10" data-animate>
            <div class="mb-6 inline-flex h-14 w-14 items-center justify-center rounded-2xl bg-accent-soft text-2xl transition-transform duration-300 group-hover:scale-105">
                📋
            </div>
            <h2 class="text-xl font-semibold tracking-tight text-ink">学生参观记录</h2>
            <p class="mt-3 text-sm leading-relaxed text-ink-muted">
                查看、筛选与管理学生参观古建筑的评分记录，支持多条件查询与维护。
            </p>
            <div class="mt-8">
                <a href="${pageContext.request.contextPath}/visit/list" class="btn-primary w-full sm:w-auto">
                    进入管理
                    <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/></svg>
                </a>
            </div>
        </article>

        <article class="card card-hover group p-8 sm:p-10" data-animate>
            <div class="mb-6 inline-flex h-14 w-14 items-center justify-center rounded-2xl bg-black/[0.04] text-2xl transition-transform duration-300 group-hover:scale-105">
                🏯
            </div>
            <h2 class="text-xl font-semibold tracking-tight text-ink">建筑目录</h2>
            <p class="mt-3 text-sm leading-relaxed text-ink-muted">
                浏览山西省古建筑分页目录，查看详情、维护保护与介绍信息。
            </p>
            <div class="mt-8">
                <a href="${pageContext.request.contextPath}/building/page" class="btn-primary w-full sm:w-auto">
                    进入目录
                    <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/></svg>
                </a>
            </div>
        </article>
    </div>

    <footer class="mt-16 text-center text-xs text-ink-faint" data-animate>
        古建筑参观管理系统 · 专业教学演示平台
    </footer>
</main>

<%@ include file="/includes/footer-scripts.jsp" %>
</body>
</html>

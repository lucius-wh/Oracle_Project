<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>${building.buildingName} · 古建筑详情</title>
    <%@ include file="/includes/head.jsp" %>
</head>
<body class="page-bg font-sans text-ink antialiased">
<div id="page-loader"><div class="spinner"></div></div>

<header class="glass-nav sticky top-0 z-40">
    <div class="mx-auto flex max-w-4xl items-center justify-between px-4 py-3.5 sm:px-6">
        <a href="${pageContext.request.contextPath}/visit/list" class="btn-ghost -ml-2">
            <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/></svg>
            返回列表
        </a>
        <span class="text-xs font-medium text-ink-faint">建筑档案</span>
    </div>
</header>

<main class="mx-auto max-w-4xl px-4 py-8 sm:px-6 sm:py-12">
    <!-- 双图展示区：静态并排（桌面）/ 纵向堆叠（移动），固定 4:3 比例，不滚动 -->
    <section class="mb-8" data-animate aria-label="建筑图片">
        <div class="mb-4 flex items-end justify-between gap-4">
            <div>
                <p class="text-xs font-semibold uppercase tracking-widest text-ink-faint">影像资料</p>
                <h1 class="mt-1 text-2xl font-bold tracking-tight text-ink sm:text-3xl">${building.buildingName}</h1>
            </div>
            <span class="hidden shrink-0 rounded-full bg-surface-muted px-3 py-1 text-xs font-medium text-ink-muted sm:inline-block">
                静态双图展示
            </span>
        </div>

        <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 sm:gap-5">
            <figure class="building-gallery-slot is-empty group relative overflow-hidden rounded-3xl border border-black/[0.06] bg-surface-muted shadow-soft">
                <img
                    src="${pageContext.request.contextPath}/images/buildings/${building.id}_1.jpg"
                    alt="${building.buildingName} — 主图"
                    class="gallery-img h-full w-full object-cover transition-transform duration-500 group-hover:scale-[1.02]"
                    onerror="this.closest('.building-gallery-slot').classList.add('is-empty')"
                    onload="this.closest('.building-gallery-slot').classList.remove('is-empty')">
                <div class="gallery-placeholder absolute inset-0 flex flex-col items-center justify-center gap-2 bg-gradient-to-br from-surface-muted to-white p-6 text-center">
                    <span class="text-3xl opacity-40">🏛</span>
                    <p class="text-sm font-medium text-ink-muted">主图占位</p>
                    <p class="text-xs text-ink-faint">images/buildings/${building.id}_1.jpg</p>
                </div>
                <figcaption class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/50 to-transparent px-4 py-3 text-xs font-medium text-white opacity-0 transition-opacity duration-300 group-hover:opacity-100">
                    外观全景
                </figcaption>
            </figure>

            <figure class="building-gallery-slot is-empty group relative overflow-hidden rounded-3xl border border-black/[0.06] bg-surface-muted shadow-soft">
                <img
                    src="${pageContext.request.contextPath}/images/buildings/${building.id}_2.jpg"
                    alt="${building.buildingName} — 副图"
                    class="gallery-img h-full w-full object-cover transition-transform duration-500 group-hover:scale-[1.02]"
                    onerror="this.closest('.building-gallery-slot').classList.add('is-empty')"
                    onload="this.closest('.building-gallery-slot').classList.remove('is-empty')">
                <div class="gallery-placeholder absolute inset-0 flex flex-col items-center justify-center gap-2 bg-gradient-to-br from-surface-muted to-white p-6 text-center">
                    <span class="text-3xl opacity-40">📷</span>
                    <p class="text-sm font-medium text-ink-muted">副图占位</p>
                    <p class="text-xs text-ink-faint">images/buildings/${building.id}_2.jpg</p>
                </div>
                <figcaption class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/50 to-transparent px-4 py-3 text-xs font-medium text-white opacity-0 transition-opacity duration-300 group-hover:opacity-100">
                    细节 / 内景
                </figcaption>
            </figure>
        </div>
        <p class="mt-3 text-center text-xs text-ink-faint">
            两张图片固定比例静态展示；将图片放入 <code class="rounded bg-black/[0.04] px-1.5 py-0.5">images/buildings/</code> 目录即可自动加载
        </p>
    </section>

    <section class="card overflow-hidden" data-animate>
        <div class="border-b border-black/[0.06] bg-surface-muted/50 px-6 py-4">
            <h2 class="text-lg font-semibold text-ink">详细信息</h2>
            <p class="mt-0.5 text-sm text-ink-muted">古建筑档案完整字段</p>
        </div>
        <dl class="divide-y divide-black/[0.04]">
            <div class="grid grid-cols-1 gap-1 px-6 py-4 sm:grid-cols-3 sm:gap-4">
                <dt class="text-sm font-medium text-ink-muted">建筑 ID</dt>
                <dd class="text-sm text-ink sm:col-span-2">${building.id}</dd>
            </div>
            <div class="grid grid-cols-1 gap-1 px-6 py-4 sm:grid-cols-3 sm:gap-4">
                <dt class="text-sm font-medium text-ink-muted">地区编码</dt>
                <dd class="text-sm text-ink sm:col-span-2">${building.areaCode}</dd>
            </div>
            <div class="grid grid-cols-1 gap-1 px-6 py-4 sm:grid-cols-3 sm:gap-4">
                <dt class="text-sm font-medium text-ink-muted">地区名称</dt>
                <dd class="text-sm text-ink sm:col-span-2">${building.areaName}</dd>
            </div>
            <div class="grid grid-cols-1 gap-1 px-6 py-4 sm:grid-cols-3 sm:gap-4">
                <dt class="text-sm font-medium text-ink-muted">建筑名称</dt>
                <dd class="text-sm font-semibold text-ink sm:col-span-2">${building.buildingName}</dd>
            </div>
            <div class="grid grid-cols-1 gap-1 px-6 py-4 sm:grid-cols-3 sm:gap-4">
                <dt class="text-sm font-medium text-ink-muted">建筑地址</dt>
                <dd class="text-sm leading-relaxed text-ink sm:col-span-2">${building.address}</dd>
            </div>
            <div class="grid grid-cols-1 gap-1 px-6 py-4 sm:grid-cols-3 sm:gap-4">
                <dt class="text-sm font-medium text-ink-muted">建造年代</dt>
                <dd class="text-sm text-ink sm:col-span-2">${building.buildYear}</dd>
            </div>
            <div class="grid grid-cols-1 gap-1 px-6 py-4 sm:grid-cols-3 sm:gap-4">
                <dt class="text-sm font-medium text-ink-muted">保护等级</dt>
                <dd class="text-sm sm:col-span-2">
                    <span class="inline-flex rounded-full bg-accent-soft px-3 py-1 text-xs font-semibold text-accent">${building.protectionLevel}</span>
                </dd>
            </div>
            <div class="grid grid-cols-1 gap-1 px-6 py-4 sm:grid-cols-3 sm:gap-4">
                <dt class="text-sm font-medium text-ink-muted">建筑类型</dt>
                <dd class="text-sm text-ink sm:col-span-2">${building.buildType}</dd>
            </div>
            <div class="grid grid-cols-1 gap-1 px-6 py-4 sm:grid-cols-3 sm:gap-4">
                <dt class="text-sm font-medium text-ink-muted">建筑简介</dt>
                <dd class="text-sm leading-relaxed text-ink sm:col-span-2">${building.introduction}</dd>
            </div>
        </dl>
    </section>
</main>

<%@ include file="/includes/footer-scripts.jsp" %>
</body>
</html>

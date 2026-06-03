<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>新增参观记录</title>
    <%@ include file="/includes/head.jsp" %>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body class="page-bg font-sans text-ink antialiased">
<div id="page-loader"><div class="spinner"></div></div>

<main class="mx-auto flex min-h-screen max-w-md flex-col justify-center px-4 py-12 sm:px-6">
    <div class="card p-8 sm:p-10" data-animate>
        <div class="mb-8 text-center">
            <p class="text-xs font-semibold uppercase tracking-widest text-ink-faint">参观记录</p>
            <h1 class="mt-2 text-2xl font-bold tracking-tight text-ink">新增参观记录</h1>
            <p class="mt-2 text-sm text-ink-muted">关联学生与古建筑评分</p>
        </div>

        <div class="space-y-5">
            <div>
                <label class="form-label" for="sid">学生 ID</label>
                <input type="text" id="sid" class="input-field" placeholder="请输入学生 ID">
            </div>
            <div>
                <label class="form-label" for="buildId">建筑 ID</label>
                <input type="text" id="buildId" class="input-field" placeholder="请输入建筑 ID">
            </div>
            <div>
                <label class="form-label" for="score">评分</label>
                <input type="text" id="score" class="input-field" placeholder="如 96.0">
            </div>
            <div>
                <label class="form-label" for="visitTime">参观时间</label>
                <input type="datetime-local" id="visitTime" class="input-field">
            </div>
        </div>

        <button type="button" id="submitBtn" onclick="submitForm()" class="btn-primary mt-8 w-full">
            提交保存
        </button>
    </div>
</main>

<script>
    function setLoading(loading) {
        var btn = document.getElementById('submitBtn');
        if (!btn) return;
        if (loading) {
            btn.disabled = true;
            btn.dataset.original = btn.innerHTML;
            btn.innerHTML = '<span class="inline-block h-4 w-4 animate-spin rounded-full border-2 border-white/30 border-t-white"></span> 保存中…';
        } else {
            btn.disabled = false;
            btn.innerHTML = btn.dataset.original || '提交保存';
        }
    }

    function submitForm() {
        let rel = {
            sid: parseInt(document.getElementById("sid").value),
            buildId: parseInt(document.getElementById("buildId").value),
            score: parseFloat(document.getElementById("score").value),
            visitTime: document.getElementById("visitTime").value
        };
        console.log("发送的请求数据：", rel);
        setLoading(true);

        fetch("${pageContext.request.contextPath}/rel/add", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(rel)
        })
            .then(res => res.json())
            .then(data => {
                console.log("响应数据：", data);
                if (data.code === 200) {
                    alert(data.msg);
                    window.location.href = "${pageContext.request.contextPath}/visit/list";
                } else if (data.msg.includes("学生不存在")) {
                    alert(data.msg);
                    window.location.href = "${pageContext.request.contextPath}/add.jsp";
                } else {
                    alert(data.msg);
                    setLoading(false);
                }
            })
            .catch(err => {
                console.error("请求失败：", err);
                alert("请求失败，请查看控制台日志");
                setLoading(false);
            });
    }
</script>
<%@ include file="/includes/footer-scripts.jsp" %>
</body>
</html>

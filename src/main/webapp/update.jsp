<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>修改参观记录</title>
    <%@ include file="/includes/head.jsp" %>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body class="page-bg font-sans text-ink antialiased">
<div id="page-loader"><div class="spinner"></div></div>

<main class="mx-auto flex min-h-screen max-w-md flex-col justify-center px-4 py-12 sm:px-6">
    <div class="card p-8 sm:p-10" data-animate>
        <div class="mb-8 text-center">
            <p class="text-xs font-semibold uppercase tracking-widest text-ink-faint">参观记录</p>
            <h1 class="mt-2 text-2xl font-bold tracking-tight text-ink">修改参观记录</h1>
            <p class="mt-2 text-sm text-ink-muted">更新评分与关联信息</p>
        </div>

        <div class="space-y-5">
            <div>
                <label class="form-label" for="relId">记录 ID</label>
                <input type="text" id="relId" class="input-field" readonly>
            </div>
            <div>
                <label class="form-label" for="sid">学生 ID</label>
                <input type="text" id="sid" class="input-field" placeholder="请输入学生ID">
            </div>
            <div>
                <label class="form-label" for="buildId">建筑 ID</label>
                <input type="text" id="buildId" class="input-field" placeholder="请输入建筑ID">
            </div>
            <div>
                <label class="form-label" for="score">评分</label>
                <input type="text" id="score" class="input-field" placeholder="请输入评分（如96.0）">
            </div>
            <div>
                <label class="form-label" for="visitTime">参观时间</label>
                <input type="datetime-local" id="visitTime" class="input-field">
            </div>
        </div>

        <div class="mt-8 flex flex-col gap-3 sm:flex-row">
            <button type="button" id="submitBtn" onclick="submitForm()" class="btn-primary flex-1">提交修改</button>
            <button type="button" onclick="backToList()" class="btn-secondary flex-1">返回列表</button>
        </div>
    </div>
</main>

<script>
    const ctx = "${pageContext.request.contextPath}";

    function getUrlParam(name) {
        let reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        let r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }

    window.onload = function () {
        let relId = getUrlParam("relId");
        if (!relId) {
            alert("记录ID不能为空，请从列表页进入！");
            backToList();
            return;
        }
        document.getElementById("relId").value = relId;
    };

    function setLoading(loading) {
        var btn = document.getElementById('submitBtn');
        if (!btn) return;
        if (loading) {
            btn.disabled = true;
            btn.dataset.original = btn.innerHTML;
            btn.innerHTML = '<span class="inline-block h-4 w-4 animate-spin rounded-full border-2 border-white/30 border-t-white"></span> 提交中…';
        } else {
            btn.disabled = false;
            btn.innerHTML = btn.dataset.original || '提交修改';
        }
    }

    function submitForm() {
        let rel = {
            relId: parseInt(document.getElementById("relId").value),
            sid: parseInt(document.getElementById("sid").value),
            buildId: parseInt(document.getElementById("buildId").value),
            score: parseFloat(document.getElementById("score").value),
            visitTime: document.getElementById("visitTime").value
        };
        console.log("发送的请求数据：", rel);
        setLoading(true);

        fetch(ctx + "/rel/update", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(rel)
        })
            .then(res => res.json())
            .then(data => {
                console.log("响应数据：", data);
                alert(data.msg);
                if (data.code === 200) {
                    backToList();
                } else {
                    setLoading(false);
                }
            })
            .catch(err => {
                console.error("请求失败：", err);
                alert("请求失败，请查看控制台日志");
                setLoading(false);
            });
    }

    function backToList() {
        window.location.href = ctx + "/visit/list";
    }
</script>
<%@ include file="/includes/footer-scripts.jsp" %>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>新增学生信息</title>
    <%@ include file="/includes/head.jsp" %>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body class="page-bg font-sans text-ink antialiased">
<div id="page-loader"><div class="spinner"></div></div>

<main class="mx-auto flex min-h-screen max-w-md flex-col justify-center px-4 py-12 sm:px-6">
    <form id="addForm" class="card p-8 sm:p-10" data-animate>
        <div class="mb-8 text-center">
            <p class="text-xs font-semibold uppercase tracking-widest text-ink-faint">学生管理</p>
            <h1 class="mt-2 text-2xl font-bold tracking-tight text-ink">新增学生信息</h1>
            <p class="mt-2 text-sm text-ink-muted">填写完成后将保存至数据库</p>
        </div>

        <div class="space-y-5">
            <div>
                <label class="form-label" for="sid">学号</label>
                <input type="text" id="sid" class="input-field" placeholder="请输入学号" autocomplete="off">
            </div>
            <div>
                <label class="form-label" for="sname">姓名</label>
                <input type="text" id="sname" class="input-field" placeholder="请输入姓名">
            </div>
            <div>
                <label class="form-label" for="gender">性别</label>
                <select id="gender" class="select-field w-full">
                    <option value="0">女</option>
                    <option value="1">男</option>
                </select>
            </div>
            <div>
                <label class="form-label" for="className">班级</label>
                <input type="text" id="className" class="input-field" placeholder="请输入班级 / 专业">
            </div>
        </div>

        <button type="button" id="submitBtn" onclick="submitForm()" class="btn-primary mt-8 w-full">
            提交保存
        </button>
    </form>
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
        let student = {
            sid: document.getElementById("sid").value,
            sname: document.getElementById("sname").value,
            gender: document.getElementById("gender").value,
            classname: document.getElementById("className").value
        };
        console.log("发送的请求数据：", student);
        setLoading(true);

        fetch("${pageContext.request.contextPath}/student/add", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(student)
        })
            .then(res => {
                console.log("响应状态码：", res.status);
                return res.json();
            })
            .then(data => {
                console.log("响应数据：", data);
                alert(data.msg);
                if (data.code === 200 || data.msg.includes("成功")) {
                    window.location.href = "${pageContext.request.contextPath}/add_rel.jsp";
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
</script>
<%@ include file="/includes/footer-scripts.jsp" %>
</body>
</html>

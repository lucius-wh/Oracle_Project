<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>修改学生信息</title>
    <%@ include file="/includes/head.jsp" %>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body class="page-bg font-sans text-ink antialiased">
<div id="page-loader"><div class="spinner"></div></div>

<header class="glass-nav sticky top-0 z-40">
    <div class="mx-auto flex max-w-md items-center px-4 py-3.5 sm:px-6">
        <a href="${pageContext.request.contextPath}/student/detail?sid=${student.sid}" class="btn-ghost -ml-2">
            <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/></svg>
            返回详情
        </a>
    </div>
</header>

<main class="mx-auto max-w-md px-4 py-8 sm:px-6 sm:py-10">
    <div class="card p-8 sm:p-10" data-animate>
        <div class="mb-8 text-center">
            <p class="text-xs font-semibold uppercase tracking-widest text-ink-faint">学生管理</p>
            <h1 class="mt-2 text-2xl font-bold tracking-tight text-ink">修改学生信息</h1>
        </div>

        <div class="space-y-5">
            <div>
                <label class="form-label" for="sid">学号</label>
                <input type="text" id="sid" class="input-field" value="${student.sid}" readonly>
            </div>
            <div>
                <label class="form-label" for="sname">姓名</label>
                <input type="text" id="sname" class="input-field" value="${student.sname}" placeholder="请输入姓名">
            </div>
            <div>
                <label class="form-label" for="gender">性别</label>
                <input type="text" id="gender" class="input-field" value="${student.gender == '1' ? '男' : '女'}" placeholder="请输入 男 或 女">
            </div>
            <div>
                <label class="form-label" for="classname">班级</label>
                <input type="text" id="classname" class="input-field" value="${student.classname}" placeholder="请输入班级">
            </div>
        </div>

        <button type="button" id="submitBtn" onclick="submitForm()" class="btn-primary mt-8 w-full">
            提交修改
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
            btn.innerHTML = '<span class="inline-block h-4 w-4 animate-spin rounded-full border-2 border-white/30 border-t-white"></span> 提交中…';
        } else {
            btn.disabled = false;
            btn.innerHTML = btn.dataset.original || '提交修改';
        }
    }

    function submitForm() {
        let sid = document.getElementById("sid").value.trim();
        let sname = document.getElementById("sname").value.trim();
        let gender = document.getElementById("gender").value.trim();
        let classname = document.getElementById("classname").value.trim();

        if (!sid || !sname || !gender || !classname) {
            alert("所有项都不能为空！");
            return;
        }

        let genderCode = "";
        if (gender === "男") {
            genderCode = "1";
        } else if (gender === "女") {
            genderCode = "0";
        } else {
            alert("性别只能填：男 或 女");
            return;
        }

        let student = {
            sid: parseInt(sid),
            sname: sname,
            gender: genderCode,
            classname: classname
        };

        setLoading(true);

        fetch("${pageContext.request.contextPath}/rel/updateStudent", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(student)
        })
            .then(res => res.json())
            .then(data => {
                alert(data.msg);
                if (data.code === 200 || data.msg.indexOf("成功") !== -1) {
                    window.location.href = "${pageContext.request.contextPath}/visit/list";
                } else {
                    setLoading(false);
                }
            })
            .catch(err => {
                alert("请求失败");
                setLoading(false);
            });
    }
</script>
<%@ include file="/includes/footer-scripts.jsp" %>
</body>
</html>

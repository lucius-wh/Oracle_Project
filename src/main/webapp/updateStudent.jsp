<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>修改学生信息</title>
    <style>
        .form-box {
            width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
        .form-item {
            margin: 15px 0;
        }
        label {
            display: inline-block;
            width: 80px;
            text-align: right;
        }
        button {
            padding: 6px 15px;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 5px;
        }
        .btn-submit {
            background: #42b983;
            margin-left: 85px;
        }
        .btn-go {
            background: #409eff;
        }
        input[readonly] {
            background-color: #f5f5f5;
            cursor: not-allowed;
        }
    </style>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<div class="form-box">
    <h2 style="text-align: center;">修改学生信息</h2>

    <div class="form-item">
        <label>学号：</label>
        <input type="text" id="sid" value="${student.sid}" readonly>
    </div>
    <div class="form-item">
        <label>姓名：</label>
        <input type="text" id="sname" value="${student.sname}" placeholder="请输入姓名">
    </div>
    <div class="form-item">
        <label>性别：</label>
        <input type="text" id="gender" value="${student.gender == '1' ? '男' : '女'}" placeholder="请输入 男 或 女">
    </div>
    <div class="form-item">
        <label>班级：</label>
        <input type="text" id="classname" value="${student.classname}" placeholder="请输入班级">
    </div>

    <button class="btn-submit" onclick="submitForm()">提交修改</button>
</div>

<script>
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

        fetch("${pageContext.request.contextPath}/rel/updateStudent", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(student)
        })
            .then(res => res.json())
            .then(data => {
                // ========== 【新增跳转逻辑】 ==========
                alert(data.msg);
                // 判断后端返回成功，跳转到学生列表页
                if (data.code === 200 || data.msg.indexOf("成功") !== -1) {
                    // 此处填写你的【学生列表页路径】
                    window.location.href = "${pageContext.request.contextPath}/visit/list";
                }
            })
            .catch(err => {
                alert("请求失败");
            });
    }
</script>
</body>
</html>
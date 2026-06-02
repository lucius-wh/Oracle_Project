<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>新增参观记录</title>
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
            margin-left: 85px;
            padding: 6px 15px;
            background: #42b983;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<div class="form-box">
    <h2 style="text-align: center;">新增学生参观记录</h2>
    <div class="form-item">
        <label>学生ID：</label>
        <input type="text" id="sid">
    </div>
    <div class="form-item">
        <label>建筑ID：</label>
        <input type="text" id="buildId">
    </div>
    <div class="form-item">
        <label>评分：</label>
        <input type="text" id="score">
    </div>
    <div class="form-item">
        <label>参观时间：</label>
        <input type="datetime-local" id="visitTime">
    </div>
    <button type="button" onclick="submitForm()">提交保存</button>
</div>

<script>
    function submitForm() {
        let rel = {
            sid: parseInt(document.getElementById("sid").value),
            buildId: parseInt(document.getElementById("buildId").value),
            score: parseFloat(document.getElementById("score").value),
            visitTime: document.getElementById("visitTime").value
        };
        console.log("发送的请求数据：", rel);

        <!-- 修复接口路径：拼接项目根路径，解决404 -->
        fetch("${pageContext.request.contextPath}/rel/add", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(rel)
        })
            .then(res => res.json())
            .then(data => {
                console.log("响应数据：", data);
                if (data.code === 200) {
                    alert(data.msg);
                    <!-- 新增：添加成功后跳转到 参观记录列表页 -->
                    window.location.href = "${pageContext.request.contextPath}/visit/list";
                } else if (data.msg.includes("学生不存在")) {
                    alert(data.msg);
                    // 跳转到添加学生页面
                    window.location.href = "${pageContext.request.contextPath}/add.jsp";
                } else {
                    alert(data.msg);
                }
            })
            .catch(err => {
                console.error("请求失败：", err);
                alert("请求失败，请查看控制台日志");
            });
    }
</script>
</body>
</html>
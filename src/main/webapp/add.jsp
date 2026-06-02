<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>新增学生信息</title>
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
    <!-- 引入jQuery方便AJAX提交 -->
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<form id="addForm">
    <div class="form-box">
        <h2 style="text-align: center;">新增学生信息</h2>
        <div class="form-item">
            <label>学号：</label>
            <input type="text" id="sid">
        </div>
        <div class="form-item">
            <label>姓名：</label>
            <input type="text" id="sname">
        </div>
        <div class="form-item">
            <label>性别：</label>
            <select id="gender">
                <option value="0">女</option>
                <option value="1">男</option>
            </select>
        </div>
        <div class="form-item">
            <label>班级：</label>
            <input type="text" id="className">
        </div>
        <button type="button" onclick="submitForm()">提交保存</button>
    </div>
</form>

<script>
    function submitForm() {
        let student = {
            sid:document.getElementById("sid").value,
            sname: document.getElementById("sname").value,
            gender: document.getElementById("gender").value,
            classname: document.getElementById("className").value
        };
        console.log("发送的请求数据：", student);

        <!-- 修复接口路径：拼接项目根路径，防止404 -->
        fetch("${pageContext.request.contextPath}/student/add", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(student)
        })
            .then(res => {
                console.log("响应状态码：", res.status);
                return res.json();
            })
            .then(data => {
                console.log("响应数据：", data);
                alert(data.msg);
                <!-- 核心：新增成功后跳转到 add_rel.jsp -->
                // 根据后端返回结果判断是否跳转
                if (data.code === 200 || data.msg.includes("成功")) {
                    window.location.href = "${pageContext.request.contextPath}/add_rel.jsp";
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
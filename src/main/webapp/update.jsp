<%--
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改参观记录</title>
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
    <h2 style="text-align: center;">修改学生参观记录</h2>

    <div class="form-item">
        <label>记录ID：</label>
        <input type="text" id="relId">
    </div>
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

    <button type="button" onclick="submitForm()">提交修改</button>
</div>

<script>
    function submitForm() {
        let rel = {
            relId: parseInt(document.getElementById("relId").value),
            sid: parseInt(document.getElementById("sid").value),
            buildId: parseInt(document.getElementById("buildId").value),
            score: parseFloat(document.getElementById("score").value),
            visitTime: document.getElementById("visitTime").value
        };
        console.log("发送的请求数据：", rel);

        // 完全和你新增页面一样的写法！！！
        fetch("rel/update", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(rel)
        })
            .then(res => res.json())
            .then(data => {
                console.log("响应数据：", data);
                alert(data.msg);
            })
            .catch(err => {
                console.error("请求失败：", err);
                alert("请求失败，请查看控制台日志");
            });
    }
</script>
</body>
</html>--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改参观记录</title>
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
        input {
            padding: 5px;
        }
        button {
            margin-left: 85px;
            padding: 6px 15px;
            background: #42b983;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
        /* 只读输入框样式 */
        input[readonly]{
            background-color: #f5f5f5;
            cursor: not-allowed;
        }
    </style>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<div class="form-box">
    <h2 style="text-align: center;">修改学生参观记录</h2>

    <div class="form-item">
        <label>记录ID：</label>
        <input type="text" id="relId" readonly>
    </div>
    <div class="form-item">
        <label>学生ID：</label>
        <input type="text" id="sid" placeholder="请输入学生ID">
    </div>
    <div class="form-item">
        <label>建筑ID：</label>
        <input type="text" id="buildId" placeholder="请输入建筑ID">
    </div>
    <div class="form-item">
        <label>评分：</label>
        <input type="text" id="score" placeholder="请输入评分（如96.0）">
    </div>
    <div class="form-item">
        <label>参观时间：</label>
        <input type="datetime-local" id="visitTime">
    </div>

    <button type="button" onclick="submitForm()">提交修改</button>
    <button type="button" onclick="backToList()">返回列表</button>
</div>

<script>
    const ctx = "${pageContext.request.contextPath}";

    // 1. 从URL获取参数（只拿relId，不再请求后端）
    function getUrlParam(name) {
        let reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        let r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }

    // 2. 页面加载：只回填relId，不再请求后端接口
    window.onload = function () {
        let relId = getUrlParam("relId");
        if (!relId) {
            alert("记录ID不能为空，请从列表页进入！");
            backToList();
            return;
        }
        // 只填记录ID，其他字段不自动请求
        document.getElementById("relId").value = relId;
    };

    // 3. 提交修改（原有逻辑完全不变，后端/rel/update接口存在，可正常提交）
    function submitForm() {
        let rel = {
            relId: parseInt(document.getElementById("relId").value),
            sid: parseInt(document.getElementById("sid").value),
            buildId: parseInt(document.getElementById("buildId").value),
            score: parseFloat(document.getElementById("score").value),
            visitTime: document.getElementById("visitTime").value
        };
        console.log("发送的请求数据：", rel);

        fetch(ctx + "/rel/update", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(rel)
        })
            .then(res => res.json())
            .then(data => {
                console.log("响应数据：", data);
                alert(data.msg);
                if (data.code === 200) {
                    backToList();
                }
            })
            .catch(err => {
                console.error("请求失败：", err);
                alert("请求失败，请查看控制台日志");
            });
    }

    // 4. 返回列表页
    function backToList() {
        window.location.href = ctx + "/visit/list";
    }
</script>
</body>
</html>
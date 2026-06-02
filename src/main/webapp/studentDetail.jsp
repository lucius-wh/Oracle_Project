<%@ page contentType="text/html;charset=UTF-8"
         language="java" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<head>

    <title>学生详情</title>

    <style>

        body{
            font-family: Arial;
            margin: 30px;
        }

        table{
            border-collapse: collapse;
            width: 500px;
        }

        td{
            border:1px solid #ccc;
            padding:12px;
        }

        .btn{
            margin-top:20px;
        }

        button{
            padding:8px 16px;
            margin-right: 10px; /* 按钮间距 */
        }

        /* 只读输入框样式（复用） */
        input[readonly]{
            background-color: #f5f5f5;
            cursor: not-allowed;
        }
    </style>

    <script>

        function deleteStudent(sid){

            let flag =
                confirm("确定删除该学生吗？");

            if(flag){

                window.location.href =
                    "${pageContext.request.contextPath}"
                    + "/student/delete?sid="
                    + sid;
            }
        }

    </script>

</head>

<body>

<h2>学生详情</h2>

<table>

    <tr>
        <td>学生ID</td>
        <td>${student.sid}</td>
    </tr>

    <tr>
        <td>姓名</td>
        <td>${student.sname}</td>
    </tr>

    <tr>
        <td>性别</td>
        <td>

            <c:if test="${student.gender.trim()=='1'}">
                男
            </c:if>

            <c:if test="${student.gender.trim()=='0'}">
                女
            </c:if>

        </td>
    </tr>

    <tr>
        <td>专业</td>
        <td>${student.classname}</td>
    </tr>

</table>

<div class="btn">
    <!-- 【核心改动】修改学生按钮：携带 sid 跳转到修改页 -->
    <a href="${pageContext.request.contextPath}/student/toUpdatePage?sid=${student.sid}">
        <button>修改学生信息</button>
    </a>

    <button type="button"
            onclick="deleteStudent(${student.sid})">
        删除学生
    </button>

    <!-- 可选：返回列表页按钮，按需保留 -->
    <button type="button" onclick="location.href='${pageContext.request.contextPath}/visit/list'">
        返回列表
    </button>
</div>

</body>
</html>
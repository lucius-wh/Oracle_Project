<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%--//格式化显示日期--%>
<%@ taglib prefix="fmt"
           uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>学生参观古建筑记录</title>

    <style>
        body{
            font-family: Arial;
            margin: 30px;
        }

        table{
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        th,td{
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }

        th{
            background: #f5f5f5;
        }

        .search-area{
            margin-bottom: 20px;
        }

        /* 功能按钮组样式 */
        .btn-group{
            margin: 10px 0 20px 0;
        }

        input,select,button{
            padding: 6px;
            margin-right: 10px;
            cursor: pointer;
        }

        a{
            text-decoration: none;
            color: blue;
        }
    </style>

    <script>
        function deleteRel(relId){
            let flag = confirm("确定删除该记录吗？");
            if(flag){
                window.location.href =
                    "${pageContext.request.contextPath}"
                    + "/visit/deleteRel?relId=" + relId;
            }
        }

        function resetSearch(){
            window.location.href =
                "${pageContext.request.contextPath}"
                + "/visit/list";
        }

        // 返回首页
        function goIndex(){
            window.location.href = "${pageContext.request.contextPath}/index.jsp";
        }

        // 跳转添加记录页面
        function goAddRel(){
            window.location.href = "${pageContext.request.contextPath}/add_rel.jsp";
        }
    </script>

</head>

<body>

<h2>学生参观古建筑评分记录</h2>

<!-- 功能按钮：仅保留 返回首页、添加记录 -->
<div class="btn-group">
    <button onclick="goIndex()">返回首页</button>
    <button onclick="goAddRel()">添加记录</button>
</div>

<!-- 查询区域 -->
<div class="search-area">
    <form method="get"
          action="${pageContext.request.contextPath}/visit/list">

        <input type="text"
               name="keyword"
               placeholder="请输入学生姓名或建筑名称"
               value="${param.keyword}">

        <select name="classname">
            <option value="">全部专业</option>
            <option value="软工" ${param.classname=='软工'?'selected':''}>软工</option>
            <option value="计科" ${param.classname=='计科'?'selected':''}>计科</option>
            <option value="电建" ${param.classname=='电建'?'selected':''}>电建</option>
            <option value="土木" ${param.classname=='土木'?'selected':''}>土木</option>
            <option value="数学" ${param.classname=='数学'?'selected':''}>数学</option>
            <option value="经管" ${param.classname=='经管'?'selected':''}>经管</option>
            <option value="网安" ${param.classname=='网安'?'selected':''}>网安</option>
        </select>

        <select name="areaCode">
            <option value="">全部城市</option>
            <option value="1401%" ${param.areaCode=='1401%'?'selected':''}>太原市</option>
            <option value="1402%" ${param.areaCode=='1402%'?'selected':''}>大同市</option>
            <option value="1403%" ${param.areaCode=='1403%'?'selected':''}>阳泉市</option>
            <option value="1404%" ${param.areaCode=='1404%'?'selected':''}>长治市</option>
            <option value="1405%" ${param.areaCode=='1405%'?'selected':''}>晋城市</option>
            <option value="1406%" ${param.areaCode=='1406%'?'selected':''}>朔州市</option>
            <option value="1407%" ${param.areaCode=='1407%'?'selected':''}>晋中市</option>
            <option value="1408%" ${param.areaCode=='1408%'?'selected':''}>运城市</option>
            <option value="1409%" ${param.areaCode=='1409%'?'selected':''}>忻州市</option>
            <option value="1410%" ${param.areaCode=='1410%'?'selected':''}>临汾市</option>
            <option value="1411%" ${param.areaCode=='1411%'?'selected':''}>吕梁市</option>
        </select>

        <input type="date" name="visitTime" value="${param.visitTime}">

        <button type="submit">查询</button>
        <button type="button" onclick="resetSearch()">清空条件</button>
    </form>
</div>

<!-- 数据展示表格 -->
<table>
    <tr>
        <th>记录ID</th>
        <th>学生ID</th>
        <th>学生姓名</th>
        <th>专业</th>
        <th>建筑ID</th>
        <th>建筑名称</th>
        <th>参观时间</th>
        <th>评分</th>
        <th>操作</th>
    </tr>

    <c:forEach items="${visitList}" var="visit">
        <tr>
            <td>${visit.relId}</td>
            <td>${visit.sid}</td>
            <td>
                <a href="${pageContext.request.contextPath}/student/detail?sid=${visit.sid}">${visit.sname}</a>
            </td>
            <td>${visit.className}</td>
            <td>${visit.buildId}</td>
            <td>
                <a href="${pageContext.request.contextPath}/building/detail?id=${visit.buildId}">${visit.buildingName}</a>
            </td>
            <td>
                <fmt:formatDate value="${visit.visitTime}" pattern="yyyy年MM月dd日"/>
            </td>
            <td>${visit.score}</td>
            <td>
                <!-- 删除按钮 -->
                <button type="button" onclick="deleteRel(${visit.relId})">删除</button>
                <!-- 新增：更新按钮，携带relId跳转到修改页 -->
                <button type="button"
                        onclick="location.href='${pageContext.request.contextPath}/update.jsp?relId=${visit.relId}'">
                    更新
                </button>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>古建筑分页查询</title>
    <style>
        /* 原有样式完全不动 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "微软雅黑", sans-serif;
        }
        .container {
            width: 95%;
            margin: 30px auto;
        }
        /* ========== 新增：返回按钮容器样式 ========== */
        .back-box {
            text-align: left;
            margin-bottom: 15px;
        }
        /* 新增：返回首页按钮样式，和系统主色调统一 */
        .back-btn {
            display: inline-block;
            padding: 6px 16px;
            background-color: #409eff;
            color: #fff;
            text-decoration: none;
            border-radius: 3px;
            font-size: 14px;
        }
        .back-btn:hover {
            background-color: #66b1ff;
        }
        /* ======================================== */
        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }
        /* 正常数据表格 */
        .normal-table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
            margin-bottom: 30px;
        }
        .normal-table th, .normal-table td {
            border: 1px solid #ccc;
            padding: 12px 8px;
        }
        .normal-table th {
            background-color: #409eff;
            color: #fff;
        }
        .normal-table tr:nth-child(even) {
            background-color: #f5f7fa;
        }
        /* 已删除数据表格 */
        .deleted-table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
            margin-top: 40px;
            border: 1px solid #eee;
        }
        .deleted-table th, .deleted-table td {
            border: 1px solid #eee;
            padding: 12px 8px;
            color: #999;
        }
        .deleted-table th {
            background-color: #e4e7ed;
            color: #666;
        }
        /* 分页栏 */
        .page-box {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 40px;
        }
        .page-box a {
            display: inline-block;
            padding: 6px 14px;
            margin: 0 5px;
            border: none;
            background: #409eff;
            color: white;
            text-decoration: none;
            border-radius: 3px;
        }
        .page-box a.disabled {
            background: #999;
            cursor: not-allowed;
            pointer-events: none;
        }
        .page-info {
            margin: 0 15px;
            color: #666;
        }
        .intro-td {
            text-align: left;
            line-height: 1.5;
        }
        /* 按钮样式 */
        .delete-btn {
            background: #f56c6c;
            padding: 5px 10px;
            color: white;
            text-decoration: none;
            border-radius: 3px;
            font-size: 14px;
        }
        .restore-btn {
            background: #67c23a;
            padding: 5px 10px;
            color: white;
            text-decoration: none;
            border-radius: 3px;
            font-size: 14px;
        }
        /* 已删除数据标题 */
        .deleted-title {
            text-align: center;
            margin: 40px 0 20px;
            color: #999;
            font-size: 18px;
            border-top: 1px solid #eee;
            padding-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- ========== 新增：返回首页按钮（页面左上角） ========== -->
    <div class="back-box">
        <%-- 跳转到项目根目录 index.jsp 首页 --%>
        <a href="${pageContext.request.contextPath}/index.jsp" class="back-btn">← 返回首页</a>
    </div>
    <!-- ================================================ -->

    <!-- 正常数据表格：所有页都显示，保持不变 -->
    <h2>古建筑信息列表（正常数据）</h2>
    <table class="normal-table">
        <thead>
        <tr>
            <th>所属地区</th>
            <th>建筑名称</th>
            <th>建造年代</th>
            <th>保护等级</th>
            <th>建筑介绍</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty pageBean.list}">
            <tr>
                <td colspan="6">暂无正常数据</td>
            </tr>
        </c:if>
        <c:forEach items="${pageBean.list}" var="building">
            <tr>
                <td>${building.areaName}</td>
                <td>${building.buildingName}</td>
                <td>${building.buildYear == null ? "未知" : building.buildYear}</td>
                <td>${building.protectionLevel == null ? "无等级" : building.protectionLevel}</td>
                <td class="intro-td">${building.introduction == null ? "暂无介绍" : building.introduction}</td>
                <td>
                    <a href="javascript:;" class="delete-btn" onclick="confirmDelete(${building.id})">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- 分页栏：所有页都显示，保持不变 -->
    <div class="page-box">
        <c:choose>
            <c:when test="${pageBean.pageNum == 1}">
                <a href="javascript:;" class="disabled">首页</a>
                <a href="javascript:;" class="disabled">上一页</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/building/page?pageNum=1">首页</a>
                <a href="${pageContext.request.contextPath}/building/page?pageNum=${pageBean.pageNum - 1}">上一页</a>
            </c:otherwise>
        </c:choose>
        <span class="page-info">
            当前第${pageBean.pageNum}页 / 共${pageBean.pages}页 总数据：${pageBean.total}条
        </span>
        <c:choose>
            <c:when test="${pageBean.pageNum == pageBean.pages || pageBean.pages == 0}">
                <a href="javascript:;" class="disabled">下一页</a>
                <a href="javascript:;" class="disabled">尾页</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/building/page?pageNum=${pageBean.pageNum + 1}">下一页</a>
                <a href="${pageContext.request.contextPath}/building/page?pageNum=${pageBean.pages}">尾页</a>
            </c:otherwise>
        </c:choose>
        <span style="margin-left: 10px;">
            <input type="number" id="pageInput" min="1" max="${pageBean.pages}" placeholder="输入页码" style="padding: 5px; width: 60px; text-align: center;">
            <button onclick="jumpPage()" style="padding: 5px 10px; background: #409eff; color: white; border: none; border-radius: 3px; cursor: pointer;">跳转</button>
        </span>
    </div>

    <!-- 🔥 关键修改：已删除数据的标题和表格，仅在最后一页渲染 -->
    <c:if test="${isLastPage}">
        <h3 class="deleted-title">已删除数据（可恢复）</h3>
        <table class="deleted-table">
            <thead>
            <tr>
                <th>所属地区</th>
                <th>建筑名称</th>
                <th>建造年代</th>
                <th>保护等级</th>
                <th>建筑介绍</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${empty deletedList}">
                <tr>
                    <td colspan="6">暂无已删除数据</td>
                </tr>
            </c:if>
            <c:forEach items="${deletedList}" var="building">
                <tr>
                    <td>${building.areaName}</td>
                    <td>${building.buildingName}</td>
                    <td>${building.buildYear == null ? "未知" : building.buildYear}</td>
                    <td>${building.protectionLevel == null ? "无等级" : building.protectionLevel}</td>
                    <td class="intro-td">${building.introduction == null ? "暂无介绍" : building.introduction}</td>
                    <td>
                        <a href="javascript:;" class="restore-btn" onclick="confirmRestore(${building.id})">恢复</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

<script>
    // 原有跳转、删除、恢复函数，完全不动
    function jumpPage() {
        let pageNum = document.getElementById("pageInput").value;
        let totalPages = ${pageBean.pages};
        if (!pageNum || pageNum < 1 || pageNum > totalPages) {
            alert("请输入1~" + totalPages + "之间的页码");
            return;
        }
        window.location.href = "${pageContext.request.contextPath}/building/page?pageNum=" + pageNum;
    }
    function confirmDelete(buildingId) {
        if (confirm("确定要删除该古建筑信息吗？")) {
            window.location.href = "${pageContext.request.contextPath}/building/delete?id=" + buildingId;
        }
    }
    function confirmRestore(buildingId) {
        if (confirm("确定要恢复该古建筑信息吗？")) {
            window.location.href = "${pageContext.request.contextPath}/building/restore?id=" + buildingId;
        }
    }
</script>
</body>
</html>
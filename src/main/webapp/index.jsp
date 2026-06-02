<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>古建筑参观管理系统 - 首页</title>
    <style>
        /* 全局样式重置 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Microsoft YaHei", Arial, sans-serif;
        }

        /* 页面整体背景与居中布局 */
        body {
            background-color: #f0f2f5;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px 20px;
        }

        /* 顶部标题区域 */
        .header {
            text-align: center;
            margin-bottom: 60px;
        }

        .header h1 {
            color: #303133;
            font-size: 32px;
            margin-bottom: 10px;
        }

        .header p {
            color: #606266;
            font-size: 16px;
        }

        /* 功能卡片容器（弹性布局，自动换行） */
        .card-container {
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
            justify-content: center;
        }

        /* 单个功能卡片样式 */
        .function-card {
            background-color: #ffffff;
            width: 300px;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            text-align: center;
            transition: all 0.3s ease;
        }

        /* 卡片悬浮效果 */
        .function-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
        }

        /* 卡片图标 */
        .function-card .icon {
            font-size: 48px;
            margin-bottom: 20px;
            color: #409eff;
        }

        .function-card h3 {
            color: #303133;
            font-size: 20px;
            margin-bottom: 15px;
        }

        .function-card p {
            color: #606266;
            font-size: 14px;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        /* 跳转按钮样式 */
        .jump-btn {
            display: inline-block;
            padding: 12px 30px;
            background-color: #409eff;
            color: #ffffff;
            text-decoration: none;
            border-radius: 6px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .jump-btn:hover {
            background-color: #66b1ff;
        }
    </style>
</head>
<body>
<div class="header">
    <h1>🏛️ 古建筑参观管理系统</h1>
    <p>欢迎使用系统，请选择功能入口进入</p>
</div>

<div class="card-container">
    <!-- 1. 学生参观记录管理卡片（对应studentVisitList页面） -->
    <div class="function-card">
        <div class="icon">📋</div>
        <h3>学生参观记录管理</h3>
        <p>查看、管理学生参观古建筑的评分记录，支持多条件筛选与删除操作</p>
        <!-- 跳转路径对应你项目的/visit/list控制器 -->
        <a href="${pageContext.request.contextPath}/visit/list" class="jump-btn">进入管理</a>
    </div>

    <!-- 2. 分页功能页面卡片（对应page页面） -->
    <div class="function-card">
        <div class="icon">📄</div>
        <h3>建筑目录</h3>
        <a href="${pageContext.request.contextPath}/building/page" class="jump-btn">进入页面</a>
    </div>
</div>
</body>
</html>
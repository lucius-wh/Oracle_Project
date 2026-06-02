<%@ page contentType="text/html;charset=UTF-8"
         language="java" %>

<html>
<head>
    <title>古建筑详情</title>
    <style>
        /* 全局样式重置与基础美化 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Microsoft YaHei", SimSun, sans-serif;
            background-color: #f5f7fa;
            padding: 40px 20px;
            line-height: 1.6;
        }

        .container {
            width: 750px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            font-size: 26px;
            margin-bottom: 25px;
            letter-spacing: 2px;
        }

        .btn-box {
            text-align: right;
            margin-bottom: 20px;
        }

        .back-btn {
            display: inline-block;
            padding: 8px 20px;
            background-color: #3498db;
            color: #ffffff;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .back-btn:hover {
            background-color: #2980b9;
            box-shadow: 0 2px 8px rgba(52, 152, 219, 0.4);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid #e5e7eb;
        }

        td {
            border: 1px solid #e5e7eb;
            padding: 14px 16px;
            font-size: 15px;
            color: #333;
            vertical-align: top;
        }

        .title {
            width: 180px;
            background-color: #f0f4f8;
            color: #2c3e50;
            font-weight: bold;
            text-align: center;
        }

        table tr:last-child td:nth-child(2) {
            line-height: 1.8;
            text-align: justify;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 关键修改：用上下文路径构建绝对URL，避免404 -->
    <div class="btn-box">
        <a href="${pageContext.request.contextPath}/visit/list" class="back-btn">返回列表</a>
    </div>

    <h2>古建筑详情</h2>

    <table>
        <tr>
            <td class="title">建筑ID</td>
            <td>${building.id}</td>
        </tr>
        <tr>
            <td class="title">地区编码</td>
            <td>${building.areaCode}</td>
        </tr>
        <tr>
            <td class="title">地区名称</td>
            <td>${building.areaName}</td>
        </tr>
        <tr>
            <td class="title">建筑名称</td>
            <td>${building.buildingName}</td>
        </tr>
        <tr>
            <td class="title">建筑地址</td>
            <td>${building.address}</td>
        </tr>
        <tr>
            <td class="title">建造年代</td>
            <td>${building.buildYear}</td>
        </tr>
        <tr>
            <td class="title">保护等级</td>
            <td>${building.protectionLevel}</td>
        </tr>
        <tr>
            <td class="title">建筑类型</td>
            <td>${building.buildType}</td>
        </tr>
        <tr>
            <td class="title">建筑简介</td>
            <td>${building.introduction}</td>
        </tr>
    </table>
</div>
</body>
</html>
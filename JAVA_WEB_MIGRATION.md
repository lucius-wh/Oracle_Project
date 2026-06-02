# Spring MVC → 传统 JavaWeb（Servlet）改造说明

## 改造后架构

```
Browser
   ↓
Servlet（Controller 层）
   ↓
Service（Spring 管理，含 @Transactional）
   ↓
MyBatis Mapper
   ↓
Oracle
```

| 层次 | 技术 | 说明 |
|------|------|------|
| View | JSP + JSTL | 不变 |
| Controller | HttpServlet | 替代 @Controller |
| Service | Spring `@Service` | 不变 |
| Model | Entity / VO / Mapper | 不变 |

---

## 1. 新项目目录结构

```
OracleProject/
├── pom.xml
├── JAVA_WEB_MIGRATION.md
├── PROJECT_OVERVIEW.md
└── src/main/
    ├── java/com/oracleproject/
    │   ├── servlet/                    # 【新增】Controller 层
    │   │   ├── StudentVisitServlet.java
    │   │   ├── StudentServlet.java
    │   │   ├── StudentPageServlet.java
    │   │   ├── StudentAddServlet.java
    │   │   ├── BuildingPageServlet.java
    │   │   ├── BuildingDetailServlet.java
    │   │   └── RelServlet.java
    │   ├── util/                       # 【新增】
    │   │   └── ServletUtils.java
    │   ├── service/                    # 保留
    │   ├── mapper/                     # 保留
    │   ├── model/                      # 保留
    │   ├── vo/                         # 保留（移除 Spring 注解）
    │   └── utils/                      # 保留
    ├── resources/
    │   ├── spring.xml                  # 保留 + 事务配置
    │   ├── jdbc.properties
    │   └── com/oracleproject/mapper/*.xml
    └── webapp/
        ├── WEB-INF/web.xml             # 重构：Servlet 映射
        ├── index.jsp
        ├── studentVisitList.jsp        # 路径微调
        ├── studentDetail.jsp           # 路径微调
        └── ...（其余 JSP 基本不变）
```

**已删除目录/文件：**

- `src/main/java/com/oracleproject/controller/`（整个包）
- `src/main/resources/springmvc.xml`

---

## 2. 需要删除的文件清单

| 文件 | 原因 |
|------|------|
| `springmvc.xml` | SpringMVC 配置 |
| `PageController.java` | 已由 `BuildingPageServlet` 替代 |
| `BuildingController.java` | 已由 `BuildingDetailServlet` 替代 |
| `StudentVisitController.java` | 已由 `StudentVisitServlet` 替代 |
| `StudentController.java` | 已由 `StudentServlet` 替代 |
| `StudentPageController.java` | 已由 `StudentPageServlet` 替代 |
| `AddController.java` | 已由 `StudentAddServlet` 替代 |
| `RelController.java` | 已由 `RelServlet` 替代 |

---

## 3. 新增 Servlet 清单

| Servlet | URL 映射 | 方法 | 说明 |
|---------|----------|------|------|
| `StudentVisitServlet` | `/visit/list` | GET | 参观记录列表 + 多条件查询 |
| `StudentVisitServlet` | `/visit/deleteRel` | GET | 参观记录逻辑删除 |
| `StudentServlet` | `/student/detail` | GET | 学生详情 |
| `StudentServlet` | `/student/delete` | GET | 学生逻辑删除（级联） |
| `StudentPageServlet` | `/student/toUpdatePage` | GET | 跳转修改学生页 |
| `StudentAddServlet` | `/student/add` | POST | 新增学生 JSON |
| `BuildingPageServlet` | `/building/page` | GET | 建筑分页列表 |
| `BuildingPageServlet` | `/building/delete` | GET | 建筑逻辑删除 |
| `BuildingPageServlet` | `/building/restore` | GET | 建筑恢复 |
| `BuildingDetailServlet` | `/building/detail` | GET | 建筑详情 |
| `RelServlet` | `/rel/add` | POST | 新增参观记录 JSON |
| `RelServlet` | `/rel/update` | POST | 修改参观记录 JSON |
| `RelServlet` | `/rel/updateStudent` | POST | 修改学生 JSON |

---

## 4. Controller → Servlet 对照与核心代码

### 4.1 StudentVisitController → StudentVisitServlet

| 原 SpringMVC | 改造后 |
|--------------|--------|
| `GET /visit/list` + `VisitQueryVO` 自动绑定 | `GET /visit/list`，Servlet 手动组装 `VisitQueryVO` |
| `return "studentVisitList"` | `forward → /studentVisitList.jsp` |
| `GET /visit/deleteRel/{relId}` | `GET /visit/deleteRel?relId=` |
| `return "redirect:/visit/list"` | `sendRedirect(contextPath + "/visit/list")` |

### 4.2 StudentController → StudentServlet

| 原 SpringMVC | 改造后 |
|--------------|--------|
| `GET /student/detail/{sid}` | `GET /student/detail?sid=` |
| `GET /student/delete/{sid}` | `GET /student/delete?sid=` |

### 4.3 StudentPageController → StudentPageServlet

| 原 SpringMVC | 改造后 |
|--------------|--------|
| `GET /student/toUpdatePage?sid=` | 不变 |
| `return "updateStudent"` | `forward → /updateStudent.jsp` |
| 非法 sid 重定向 `studentList.jsp` | 修正为 `/visit/list` |

### 4.4 PageController + BuildingController → BuildingPageServlet + BuildingDetailServlet

| 原 SpringMVC | 改造后 |
|--------------|--------|
| `GET /building/page` | 不变 |
| `GET /building/delete?id=` | 不变 |
| `GET /building/restore?id=` | 不变 |
| `GET /building/detail/{id}` | `GET /building/detail?id=` |

### 4.5 AddController → StudentAddServlet

| 原 SpringMVC | 改造后 |
|--------------|--------|
| `@RestController` + `@RequestBody` | `readRequestBody` + `JSON.parseObject` |
| `return Result` | `ServletUtils.writeJson(response, result)` |

### 4.6 RelController → RelServlet

按 `request.getServletPath()` 分发 `/rel/add`、`/rel/update`、`/rel/updateStudent`。

### 4.7 Spring 获取 Service 示例

```java
@Override
public void init() throws ServletException {
    studentService = ServletUtils.getBean(getServletContext(), StudentService.class);
}
```

### 4.8 JSON 输出示例

```java
ServletUtils.writeJson(response, Result.success("操作成功"));
// 内部：JSON.toJSONString(result)，Content-Type: application/json;charset=UTF-8
```

---

## 5. web.xml 完整配置

见项目文件：`src/main/webapp/WEB-INF/web.xml`

要点：

- 保留 `CharacterEncodingFilter`
- 保留 `ContextLoaderListener` + `classpath:spring.xml`
- **已删除** `DispatcherServlet`
- **已新增** 全部 Servlet 及 `<servlet-mapping>`

---

## 6. JSP 需要修改的地方

| 文件 | 修改内容 |
|------|----------|
| `studentVisitList.jsp` | `/visit/deleteRel/{id}` → `/visit/deleteRel?relId=` |
| `studentVisitList.jsp` | `/student/detail/${sid}` → `/student/detail?sid=` |
| `studentVisitList.jsp` | `/building/detail/${id}` → `/building/detail?id=` |
| `studentDetail.jsp` | `/student/delete/{sid}` → `/student/delete?sid=` |
| `index.jsp` | 无需修改（路径未变） |
| `page.jsp` | 无需修改 |
| `add.jsp` / `add_rel.jsp` / `update.jsp` / `updateStudent.jsp` | 无需修改（REST 路径未变） |
| `buildingDetail.jsp` | 无需修改 |

---

## 7. Maven 依赖变更

### 删除

```xml
<!-- spring-webmvc 已移除 -->
<artifactId>spring-webmvc</artifactId>
```

### 保留

- `spring-context`、`spring-jdbc`
- `mybatis`、`mybatis-spring`
- `ojdbc6`、`druid`
- `fastjson`
- `jstl`、`standard`
- `javax.servlet-api`（provided）

### 新增

| 依赖 | 用途 |
|------|------|
| `spring-web` | `ContextLoaderListener`、`WebApplicationContextUtils` |
| `spring-tx` | 事务管理 |
| `spring-aop` | AOP / `@Transactional` |
| `aspectjweaver` | 具体类 CGLIB 事务代理 |

---

## 8. spring.xml 变更

**新增：**

```xml
<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
    <property name="dataSource" ref="dataSource"/>
</bean>
<tx:annotation-driven transaction-manager="transactionManager"/>
```

保证 `StudentService.deleteStudent()` 上 `@Transactional` 继续生效（学生删除 + 级联参观记录删除）。

---

## 9. 改造后 MVC 职责说明

| MVC | 包/文件 | 职责 |
|-----|---------|------|
| **M** | `model/`、`vo/`、`mapper/` | 数据实体、查询对象、持久化 |
| **V** | `webapp/*.jsp` | 页面展示 |
| **C** | `servlet/` | 接收请求、调用 Service、转发/重定向/输出 JSON |
| **Service** | `service/` | 业务逻辑（Spring 容器管理） |

**请求处理流程示例（参观列表）：**

1. 浏览器 `GET /visit/list?keyword=xxx`
2. `StudentVisitServlet.doGet()` 组装 `VisitQueryVO`
3. `studentVisitService.findVisitList(queryVO)`
4. `request.setAttribute("visitList", ...)`
5. `forward` → `studentVisitList.jsp`

---

## 10. 验证

```bash
mvn clean package -DskipTests
```

将 `target/OracleProject.war` 部署至 Tomcat，访问：

- `http://host:port/OracleProject/`
- `http://host:port/OracleProject/visit/list`

---

## 11. 未改动部分（按要求）

- 数据库表结构
- 全部 `Service` 实现
- 全部 `Mapper` 接口与 XML
- 业务逻辑与 SQL
- JSP 页面结构与样式（仅 URL 参数形式调整）

---

*改造完成日期：2026-06-01*

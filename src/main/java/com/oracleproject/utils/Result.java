package com.oracleproject.utils;

public class Result {
    private int  code;     // 响应的状态码
    private String msg;    // 响应的消息 → 改成 msg！前端要取 data.msg
    private Object data;   // 响应的结果数据

    // 必须有无参构造！否则 JSON 会报错
    public Result() {}

    public Result(int code, String msg, Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    // 成功响应（不带数据）
    public static Result success() {
        return new Result(200, "操作成功", null);
    }

    // 成功响应（带消息）→ 你现在要用这个！
    public static Result success(String msg) {
        return new Result(200, msg, null);
    }

    // 成功响应（带数据）
    public static Result success(Object data) {
        return new Result(200, "操作成功", data);
    }

    // 失败响应（无信息）
    public static Result error() {
        return new Result(500, "操作失败", null);
    }

    // 失败响应（带自定义信息）→ 你现在要用这个！
    public static Result error(String msg) {
        return new Result(500, msg, null);
    }

    // GETTER + SETTER
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
package com.example.testfive.controller;

public class ApiResponse<T> {
    private boolean success;
    private T data;
    private String message;

    public ApiResponse() {}


    public ApiResponse(T data) {
        this.success = true;
        this.data = data;
        this.message = null;
    }


    public ApiResponse(String message) {
        this.success = false;
        this.data = null;
        this.message = message;
    }


    public boolean isSuccess() { return success; }
    public void setSuccess(boolean success) { this.success = success; }
    public T getData() { return data; }
    public void setData(T data) { this.data = data; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
}

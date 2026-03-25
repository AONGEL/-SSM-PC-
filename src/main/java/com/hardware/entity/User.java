package com.hardware.entity;

import java.util.Date;

/**
 * 用户实体类
 * 对应数据库表: user
 * 包含用户基本信息、角色、头像路径等。
 */
public class User {
    private Integer id; // 用户ID
    private String username; // 用户名
    private String password; // 密码 (MD5加密后)
    private Date createTime; // 注册时间
    private String role = "USER"; // 用户角色: USER, CERTIFIED, ADMIN
    private String avatar = "/static/avatar/1.png"; // 用户头像路径
    private String certificationReason; // 认证原因或备注 (仅认证用户)

    // Constructors
    public User() {}

    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
        // 在设置ID时，可以添加一些业务逻辑，例如验证ID的有效性
        if (id != null && id <= 0) {
            throw new IllegalArgumentException("User ID must be a positive integer.");
        }
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
        // 可以添加验证用户名格式的逻辑
        if (username != null && username.length() > 30) {
            throw new IllegalArgumentException("Username exceeds maximum length of 30 characters.");
        }
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
        // 可以添加验证密码强度的逻辑
        if (password != null && password.length() > 32) {
            throw new IllegalArgumentException("Password hash exceeds maximum length of 32 characters.");
        }
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getCertificationReason() {
        return certificationReason;
    }

    public void setCertificationReason(String certificationReason) {
        this.certificationReason = certificationReason;
    }

    // toString, equals, hashCode methods can be added for debugging and collections usage
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", createTime=" + createTime +
                ", role='" + role + '\'' +
                ", avatar='" + avatar + '\'' +
                ", certificationReason='" + certificationReason + '\'' +
                '}';
    }
}

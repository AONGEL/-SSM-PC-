package com.hardware.entity;

import java.util.Date;

public class PostFavorite {
    private Integer id;
    private Integer userId;
    private Integer postId;
    private Date createTime;

    // 用于显示帖子信息
    private String postTitle;
    private Date postCreateTime;
    private Boolean postExists; // 帖子是否已被删除

    // getters and setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    public Date getPostCreateTime() {
        return postCreateTime;
    }

    public void setPostCreateTime(Date postCreateTime) {
        this.postCreateTime = postCreateTime;
    }

    public Boolean getPostExists() {
        return postExists;
    }

    public void setPostExists(Boolean postExists) {
        this.postExists = postExists;
    }
}
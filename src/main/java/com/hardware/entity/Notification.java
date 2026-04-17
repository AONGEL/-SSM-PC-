package com.hardware.entity;

import java.util.Date;

/**
 * 通知实体类
 * 对应数据库表: notifications
 */
public class Notification {
    private Integer id; // 通知ID
    private Integer recipientId; // 接收者ID
    private String type; // 通知类型 (如 "REPLY_TO_POST")
    private Integer relatedId; // 相关ID (帖子ID)
    private Date createTime; // 创建时间
    private Boolean readStatus = false; // 是否已读, 默认为false (未读)

    // 构造函数
    public Notification() {}
    public Notification(Integer recipientId, String type, Integer relatedId) {
        this.recipientId = recipientId;
        this.type = type;
        this.relatedId = relatedId;
    }

    // getters and setters
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public Integer getRecipientId() {
        return recipientId;
    }
    public void setRecipientId(Integer recipientId) {
        this.recipientId = recipientId;
    }
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public Integer getRelatedId() {
        return relatedId;
    }
    public void setRelatedId(Integer relatedId) {
        this.relatedId = relatedId;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    public Boolean getReadStatus() {
        return readStatus;
    }
    public void setReadStatus(Boolean readStatus) {
        this.readStatus = readStatus;
    }

    @Override
    public String toString() {
        return "Notification{" +
                "id=" + id +
                ", recipientId=" + recipientId +
                ", type='" + type + '\'' +
                ", relatedId=" + relatedId +
                ", createTime=" + createTime +
                ", readStatus=" + readStatus +
                '}';
    }

    private String postTitle;

    // getters 和 setters
    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

}
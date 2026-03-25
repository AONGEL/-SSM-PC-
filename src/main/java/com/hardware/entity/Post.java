package com.hardware.entity;

import javax.validation.constraints.NotBlank;
import java.util.Date;

/**
 * 帖子实体类
 * 对应数据库表: post
 * 包含帖子标题、内容、作者、所属分区、时间等信息。
 */
public class Post {
    private Integer id; // 帖子ID
    @NotBlank(message = "标题不能为空")
    private String title; // 帖子标题
    @NotBlank(message = "内容不能为空")
    private String content; // 帖子内容
    private String sectionName;// 版块名称
    private Integer userId; // 发帖用户ID
    private Integer sectionId; // 所属分区ID
    private Date createTime; // 发帖时间
    private Date updateTime; // 最后更新时间
    private Boolean isLocked = false; // 是否锁定
    private Integer viewCount = 0; // 浏览次数

    // --- 软删除标记字段 ---
    private Boolean isDeleted = false; // 是否已删除，用于软删除功能

    // --- 作者角色 ---
    private String authorRole;
    // --- 关联的用户名 ---
    private String authorUsername;

    private Integer pinLevel = 0; // 置顶级别，0表示不置顶，数值越大置顶级别越高

    // Constructors
    public Post() {}

    public Post(String title, String content, Integer userId, Integer sectionId) {
        this.title = title;
        this.content = content;
        this.userId = userId;
        this.sectionId = sectionId;
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getSectionId() {
        return sectionId;
    }

    public void setSectionId(Integer sectionId) {
        this.sectionId = sectionId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Boolean getIsLocked() {
        return isLocked;
    }

    public void setIsLocked(Boolean locked) {
        isLocked = locked;
    }

    public Integer getViewCount() {
        return viewCount;
    }

    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
    }

    // --- 软删除相关方法 ---
    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean deleted) {
        isDeleted = deleted;
    }

    // --- Getter 和 Setter for authorUsername ---
    public String getAuthorUsername() {
        return authorUsername;
    }

    public void setAuthorUsername(String authorUsername) {
        this.authorUsername = authorUsername;
    }

    // --- Getter 和 Setter for sectionName ---
    public String getSectionName() {
        return sectionName;
    }

    public void setSectionName(String sectionName) {
        this.sectionName = sectionName;
    }

    // --- 作者角色的 getter/setter ---
    public String getAuthorRole() {
        return authorRole;
    }

    public void setAuthorRole(String authorRole) {
        this.authorRole = authorRole;
    }

    public Integer getPinLevel() {
        return pinLevel;
    }

    public void setPinLevel(Integer pinLevel) {
        this.pinLevel = pinLevel;
    }

    @Override
    public String toString() {
        return "Post{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", userId=" + userId +
                ", sectionId=" + sectionId +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                ", isLocked=" + isLocked +
                ", viewCount=" + viewCount +
                ", isDeleted=" + isDeleted + // 添加到toString
                ", sectionName='" + sectionName + '\'' +
                ", authorUsername='" + authorUsername + '\'' +
                ", authorRole='" + authorRole + '\'' +
                ", pinLevel=" + pinLevel +
                '}';
    }
}
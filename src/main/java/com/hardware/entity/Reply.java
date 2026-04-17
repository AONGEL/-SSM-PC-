package com.hardware.entity;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 回复实体类
 * 对应数据库表: reply
 * 包含回复内容、作者、所属帖子、时间、父回复等信息。
 */
public class Reply {
    private Integer id; // 回复ID
    @NotNull(message = "帖子ID不能为空")
    private Integer postId; // 所属帖子ID
    @NotNull(message = "用户ID不能为空")
    private Integer userId; // 回复用户ID
    @NotBlank(message = "内容不能为空")
    private String content; // 回复内容
    private Date createTime; // 回复时间
    private Integer parentReplyId; // 父回复ID (用于楼中楼)
    // --- 作者角色 ---
    private String authorRole;
    // --- 关联的用户名 ---
    private String authorUsername;

    // Constructors
    public Reply() {}

    public Reply(Integer postId, Integer userId, String content) {
        this.postId = postId;
        this.userId = userId;
        this.content = content;
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getParentReplyId() {
        return parentReplyId;
    }

    public void setParentReplyId(Integer parentReplyId) {
        this.parentReplyId = parentReplyId;
    }

    // --- Getter 和 Setter for authorUsername ---
    public String getAuthorUsername() {
        return authorUsername;
    }

    public void setAuthorUsername(String authorUsername) {
        this.authorUsername = authorUsername;
    }
    // --- /Getter 和 Setter ---

    @Override
    public String toString() {
        return "Reply{" +
                "id=" + id +
                ", postId=" + postId +
                ", userId=" + userId +
                ", content='" + content + '\'' +
                ", createTime=" + createTime +
                ", parentReplyId=" + parentReplyId +
                ", authorUsername='" + authorUsername + '\'' +
                ", authorRole='" + authorRole + '\'' +
                '}';
    }
    // --- 作者角色的 getter/setter ---
    public String getAuthorRole() {
        return authorRole;
    }

    public void setAuthorRole(String authorRole) {
        this.authorRole = authorRole;
    }

}

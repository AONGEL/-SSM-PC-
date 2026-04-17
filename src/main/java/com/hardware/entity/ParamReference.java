package com.hardware.entity;

import java.util.Date;

/**
 * 参数引用实体类
 * 对应数据库表: param_reference
 * 记录帖子或回复中引用的硬件参数。
 */
public class ParamReference {
    private Integer id; // 引用记录ID
    private Integer postId; // 引用所在的帖子ID (可空)
    private Integer replyId; // 引用所在的回复ID (可空) - 确保postId和replyId不能同时为空或同时不为空
    private String paramTable; // 引用的参数表名 (cpu_info, gpu_info等)
    private Integer paramId; // 引用的参数记录ID
    private String referenceText; // 引用时的文本描述 (如: B650M主板) - 可选
    private Date createTime; // 引用时间

    // Constructors
    public ParamReference() {}

    public ParamReference(Integer postId, Integer replyId, String paramTable, Integer paramId) {
        this.postId = postId;
        this.replyId = replyId;
        this.paramTable = paramTable;
        this.paramId = paramId;
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

    public Integer getReplyId() {
        return replyId;
    }

    public void setReplyId(Integer replyId) {
        this.replyId = replyId;
    }

    public String getParamTable() {
        return paramTable;
    }

    public void setParamTable(String paramTable) {
        this.paramTable = paramTable;
    }

    public Integer getParamId() {
        return paramId;
    }

    public void setParamId(Integer paramId) {
        this.paramId = paramId;
    }

    public String getReferenceText() {
        return referenceText;
    }

    public void setReferenceText(String referenceText) {
        this.referenceText = referenceText;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "ParamReference{" +
                "id=" + id +
                ", postId=" + postId +
                ", replyId=" + replyId +
                ", paramTable='" + paramTable + '\'' +
                ", paramId=" + paramId +
                ", referenceText='" + referenceText + '\'' +
                ", createTime=" + createTime +
                '}';
    }
}

package com.hardware.entity;

import java.util.Date;

/**
 * 论坛分区实体类
 * 对应数据库表: forum_section
 */
public class ForumSection {
    private Integer id; // 分区ID
    private String name; // 分区名称
    private String description; // 分区描述
    private Date createTime; // 分区创建时间

    // Constructors
    public ForumSection() {}

    public ForumSection(String name, String description) {
        this.name = name;
        this.description = description;
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "ForumSection{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", createTime=" + createTime +
                '}';
    }
}

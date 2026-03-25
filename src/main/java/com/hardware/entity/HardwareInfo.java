// src/main/java/com/hardware/entity/HardwareInfo.java
package com.hardware.entity;

import javax.validation.constraints.NotBlank;
import java.util.Date;

/**
 * 通用硬件信息实体类 (基类)
 * 对应数据库表: cpu_info, gpu_info, motherboard_info
 * 用于存储具体硬件的详细参数信息。
 */
public class HardwareInfo {
    // 硬件ID (主键)
    protected Integer id;

    // 硬件品牌
    @NotBlank(message = "品牌不能为空")
    protected String brand;

    // 硬件型号
    @NotBlank(message = "型号不能为空")
    protected String model;

    // 创建时间
    protected Date createTime;

    // 更新时间
    protected Date updateTime;

    // --- 构造函数 ---
    public HardwareInfo() {}

    public HardwareInfo(String brand, String model) {
        this.brand = brand;
        this.model = model;
    }

    // --- Getter 和 Setter ---
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
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

    @Override
    public String toString() {
        return "HardwareInfo{" +
                "id=" + id +
                ", brand='" + brand + '\'' +
                ", model='" + model + '\'' +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}
// src/main/java/com/hardware/entity/GpuInfo.java
package com.hardware.entity;

import javax.validation.constraints.NotBlank;
import java.util.Date;

/**
 * GPU信息实体类
 * 对应数据库表: gpu_info
 * 继承自 HardwareInfo，包含GPU特有的参数。
 */
public class GpuInfo extends HardwareInfo {
    // 显存容量 (GB) - 数据库字段名: memory_size
    private Integer memorySize;

    // 显存类型 (如 GDDR6, GDDR6X) - 数据库字段名: memory_type
    private String memoryType;

    // 显存位宽 (bit) - 数据库字段名: memory_bus_width
    private Integer memoryBusWidth;

    // 基础频率 (MHz) - 数据库字段名: base_clock
    private Integer baseClock;

    // 加速频率 (MHz) - 数据库字段名: boost_clock
    private Integer boostClock;

    // TDP (W) - 数据库字段名: tdp
    private Integer tdp;

    // 接口类型 (如 PCIe 4.0 x16) - 数据库字段名: interface_type
    private String interfaceType;

    // 发布日期 - 数据库字段名: release_date
    private Date releaseDate;

    // --- 构造函数 ---
    public GpuInfo() {
        super(); // 调用父类构造函数
    }

    public GpuInfo(String brand, String model) {
        super(brand, model); // 调用父类构造函数
    }

    // --- Getter 和 Setter ---
    public Integer getMemorySize() {
        return memorySize;
    }

    public void setMemorySize(Integer memorySize) {
        this.memorySize = memorySize;
    }

    public String getMemoryType() {
        return memoryType;
    }

    public void setMemoryType(String memoryType) {
        this.memoryType = memoryType;
    }

    public Integer getMemoryBusWidth() {
        return memoryBusWidth;
    }

    public void setMemoryBusWidth(Integer memoryBusWidth) {
        this.memoryBusWidth = memoryBusWidth;
    }

    public Integer getBaseClock() {
        return baseClock;
    }

    public void setBaseClock(Integer baseClock) {
        this.baseClock = baseClock;
    }

    public Integer getBoostClock() {
        return boostClock;
    }

    public void setBoostClock(Integer boostClock) {
        this.boostClock = boostClock;
    }

    public Integer getTdp() {
        return tdp;
    }

    public void setTdp(Integer tdp) {
        this.tdp = tdp;
    }

    public String getInterfaceType() {
        return interfaceType;
    }

    public void setInterfaceType(String interfaceType) {
        this.interfaceType = interfaceType;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    @Override
    public String toString() {
        return "GpuInfo{" +
                "id=" + getId() + // 调用父类 getter
                ", brand='" + getBrand() + // 调用父类 getter
                "', model='" + getModel() + // 调用父类 getter
                "', memorySize=" + memorySize +
                ", memoryType='" + memoryType + '\'' +
                ", memoryBusWidth=" + memoryBusWidth +
                ", baseClock=" + baseClock +
                ", boostClock=" + boostClock +
                ", tdp=" + tdp +
                ", interfaceType='" + interfaceType + '\'' +
                ", releaseDate=" + releaseDate +
                ", createTime=" + getCreateTime() + // 调用父类 getter
                ", updateTime=" + getUpdateTime() + // 调用父类 getter
                '}';
    }
}
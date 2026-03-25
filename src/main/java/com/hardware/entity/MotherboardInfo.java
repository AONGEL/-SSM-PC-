// src/main/java/com/hardware/entity/MotherboardInfo.java
package com.hardware.entity;

import javax.validation.constraints.NotBlank;
import java.util.Date;

/**
 * 主板信息实体类
 * 对应数据库表: motherboard_info
 * 继承自 HardwareInfo，包含主板特有的参数。
 */
public class MotherboardInfo extends HardwareInfo {
    // 芯片组 (如 B650, Z790) - 数据库字段名: chipset
    @NotBlank(message = "芯片组不能为空")
    private String chipset;

    // CPU接口 (如 AM5, LGA1700) - 数据库字段名: cpu_interface
    @NotBlank(message = "CPU接口不能为空")
    private String cpuInterface;

    // 内存插槽数量 - 数据库字段名: memory_slots
    private Integer memorySlots;

    // 最大内存容量 (GB) - 数据库字段名: max_memory
    private Integer maxMemory;

    // 内存类型 (如 DDR4, DDR5) - 数据库字段名: memory_type
    private String memoryType;

    // 供电相数 (如 8+2相) - 数据库字段名: power_phase
    private String powerPhase;

    // SATA接口数量 - 数据库字段名: sata_ports
    private Integer sataPorts;

    // M.2插槽数量 - 数据库字段名: m2_slots
    private Integer m2Slots;

    // 发布日期 - 数据库字段名: release_date
    private Date releaseDate;

    // --- 构造函数 ---
    public MotherboardInfo() {
        super(); // 调用父类构造函数
    }

    public MotherboardInfo(String brand, String model) {
        super(brand, model); // 调用父类构造函数
    }

    // --- Getter 和 Setter ---
    public String getChipset() {
        return chipset;
    }

    public void setChipset(String chipset) {
        this.chipset = chipset;
    }

    public String getCpuInterface() {
        return cpuInterface;
    }

    public void setCpuInterface(String cpuInterface) {
        this.cpuInterface = cpuInterface;
    }

    public Integer getMemorySlots() {
        return memorySlots;
    }

    public void setMemorySlots(Integer memorySlots) {
        this.memorySlots = memorySlots;
    }

    public Integer getMaxMemory() {
        return maxMemory;
    }

    public void setMaxMemory(Integer maxMemory) {
        this.maxMemory = maxMemory;
    }

    public String getMemoryType() {
        return memoryType;
    }

    public void setMemoryType(String memoryType) {
        this.memoryType = memoryType;
    }

    public String getPowerPhase() {
        return powerPhase;
    }

    public void setPowerPhase(String powerPhase) {
        this.powerPhase = powerPhase;
    }

    public Integer getSataPorts() {
        return sataPorts;
    }

    public void setSataPorts(Integer sataPorts) {
        this.sataPorts = sataPorts;
    }

    public Integer getM2Slots() {
        return m2Slots;
    }

    public void setM2Slots(Integer m2Slots) {
        this.m2Slots = m2Slots;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    @Override
    public String toString() {
        return "MotherboardInfo{" +
                "id=" + getId() + // 调用父类 getter
                ", brand='" + getBrand() + // 调用父类 getter
                "', model='" + getModel() + // 调用父类 getter
                "', chipset='" + chipset + '\'' +
                ", cpuInterface='" + cpuInterface + '\'' +
                ", memorySlots=" + memorySlots +
                ", maxMemory=" + maxMemory +
                ", memoryType='" + memoryType + '\'' +
                ", powerPhase='" + powerPhase + '\'' +
                ", sataPorts=" + sataPorts +
                ", m2Slots=" + m2Slots +
                ", releaseDate=" + releaseDate +
                ", createTime=" + getCreateTime() + // 调用父类 getter
                ", updateTime=" + getUpdateTime() + // 调用父类 getter
                '}';
    }
}
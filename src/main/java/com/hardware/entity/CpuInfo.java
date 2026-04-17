package com.hardware.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * CPU参数实体类
 * 对应数据库表: cpu_info
 * 包含CPU的品牌、型号、接口、核心数、频率、功耗等详细信息。
 */
public class CpuInfo {
    private Integer id; // CPU ID
    private String brand; // 品牌
    private String model; // 型号
    private String interfaceType; // 接口类型
    private Integer cores; // 核心数
    private Integer threads; // 线程数
    private BigDecimal baseFrequency; // 基础频率 (GHz)
    private BigDecimal maxFrequency; // 最大睿频 (GHz)
    private Integer tdp; // 基础功耗 (W)
    private String integratedGraphics; // 核显型号
    private Date releaseDate; // 发布日期
    private Date createTime; // 创建时间
    private Date updateTime; // 更新时间

    // Constructors
    public CpuInfo() {}

    public CpuInfo(String brand, String model) {
        this.brand = brand;
        this.model = model;
    }

    // Getters and Setters
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

    public String getInterfaceType() {
        return interfaceType;
    }

    public void setInterfaceType(String interfaceType) {
        this.interfaceType = interfaceType;
    }

    public Integer getCores() {
        return cores;
    }

    public void setCores(Integer cores) {
        this.cores = cores;
    }

    public Integer getThreads() {
        return threads;
    }

    public void setThreads(Integer threads) {
        this.threads = threads;
    }

    public BigDecimal getBaseFrequency() {
        return baseFrequency;
    }

    public void setBaseFrequency(BigDecimal baseFrequency) {
        this.baseFrequency = baseFrequency;
    }

    public BigDecimal getMaxFrequency() {
        return maxFrequency;
    }

    public void setMaxFrequency(BigDecimal maxFrequency) {
        this.maxFrequency = maxFrequency;
    }

    public Integer getTdp() {
        return tdp;
    }

    public void setTdp(Integer tdp) {
        this.tdp = tdp;
    }

    public String getIntegratedGraphics() {
        return integratedGraphics;
    }

    public void setIntegratedGraphics(String integratedGraphics) {
        this.integratedGraphics = integratedGraphics;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
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
        return "CpuInfo{" +
                "id=" + id +
                ", brand='" + brand + '\'' +
                ", model='" + model + '\'' +
                ", interfaceType='" + interfaceType + '\'' +
                ", cores=" + cores +
                ", threads=" + threads +
                ", baseFrequency=" + baseFrequency +
                ", maxFrequency=" + maxFrequency +
                ", tdp=" + tdp +
                ", integratedGraphics='" + integratedGraphics + '\'' +
                ", releaseDate=" + releaseDate +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}

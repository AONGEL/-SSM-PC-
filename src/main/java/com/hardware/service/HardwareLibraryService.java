// src/main/java/com/hardware/service/HardwareLibraryService.java
package com.hardware.service;

import com.hardware.entity.*;

import java.util.List;

public interface HardwareLibraryService {
    // --- 保留：查询硬件信息 ---
    List<CpuInfo> getAllCpus();
    List<GpuInfo> getAllGpus();
    List<MotherboardInfo> getAllMotherboards();

    CpuInfo getCpuById(Integer id);
    GpuInfo getGpuById(Integer id);
    MotherboardInfo getMotherboardById(Integer id);

    // --- 保留：搜索硬件信息 ---
    List<CpuInfo> searchCpus(String term);
    List<GpuInfo> searchGpus(String term);
    List<MotherboardInfo> searchMotherboards(String term);

    // --- 保留：根据ID获取硬件信息 (通用方法) ---
    Object getHardwareById(String tableName, Integer id);

}
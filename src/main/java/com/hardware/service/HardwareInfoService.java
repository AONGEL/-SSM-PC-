package com.hardware.service;

import com.hardware.entity.*;
import java.util.List;

public interface HardwareInfoService {

    // --- CPU 相关 ---
    List<CpuInfo> getAllCpus();
    CpuInfo getCpuById(Integer id);
    // --- 搜索CPU ---
    List<CpuInfo> searchCpus(String term);

    // --- GPU 相关 ---
    List<GpuInfo> getAllGpus();
    GpuInfo getGpuById(Integer id);
    // --- 搜索GPU ---
    List<GpuInfo> searchGpus(String term);

    // --- 主板 相关 ---
    List<MotherboardInfo> getAllMotherboards();
    MotherboardInfo getMotherboardById(Integer id);
    // --- 搜索主板 ---
    List<MotherboardInfo> searchMotherboards(String term);


}
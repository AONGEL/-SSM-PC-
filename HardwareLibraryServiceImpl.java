// src/main/java/com/hardware/service/impl/HardwareLibraryServiceImpl.java
package com.hardware.service.impl;



import com.hardware.dao.HardwareInfoDao;
import com.hardware.entity.*;
import com.hardware.service.HardwareLibraryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HardwareLibraryServiceImpl implements HardwareLibraryService {

    @Autowired
    private HardwareInfoDao hardwareInfoDao;

    // --- 保留：查询硬件信息 ---
    @Override
    public List<CpuInfo> getAllCpus() {
        return hardwareInfoDao.selectAllCpus();
    }

    @Override
    public List<GpuInfo> getAllGpus() {
        return hardwareInfoDao.selectAllGpus();
    }

    @Override
    public List<MotherboardInfo> getAllMotherboards() {
        return hardwareInfoDao.selectAllMotherboards();
    }

    @Override
    public CpuInfo getCpuById(Integer id) {
        return hardwareInfoDao.selectCpuById(id);
    }

    @Override
    public GpuInfo getGpuById(Integer id) {
        return hardwareInfoDao.selectGpuById(id);
    }

    @Override
    public MotherboardInfo getMotherboardById(Integer id) {
        return hardwareInfoDao.selectMotherboardById(id);
    }

    // --- 搜索硬件信息 ---
    @Override
    public List<CpuInfo> searchCpus(String term) {
        return hardwareInfoDao.searchCpus(term);
    }

    @Override
    public List<GpuInfo> searchGpus(String term) {
        return hardwareInfoDao.searchGpus(term);
    }

    @Override
    public List<MotherboardInfo> searchMotherboards(String term) {
        return hardwareInfoDao.searchMotherboards(term);
    }

    // --- 根据ID获取硬件信息 (通用方法) ---
    @Override
    public Object getHardwareById(String tableName, Integer id) {
        switch (tableName) {
            case "cpu_info":
                return getCpuById(id);
            case "gpu_info":
                return getGpuById(id);
            case "motherboard_info":
                return getMotherboardById(id);
            default:
                throw new IllegalArgumentException("Unsupported table name: " + tableName);
        }
    }


}
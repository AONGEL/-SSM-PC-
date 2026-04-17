package com.hardware.service.impl;

import com.hardware.dao.CpuInfoDao;
import com.hardware.dao.GpuInfoDao;
import com.hardware.dao.MotherboardInfoDao;
import com.hardware.entity.*;
import com.hardware.service.HardwareInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class HardwareInfoServiceImpl implements HardwareInfoService {

    @Autowired
    private CpuInfoDao cpuInfoDao;

    @Autowired
    private GpuInfoDao gpuInfoDao;

    @Autowired
    private MotherboardInfoDao motherboardInfoDao;

    // --- CPU 相关 ---
    @Override
    public List<CpuInfo> getAllCpus() {
        return cpuInfoDao.selectAll();
    }

    @Override
    public CpuInfo getCpuById(Integer id) {
        return cpuInfoDao.selectById(id);
    }

    // --- 实现：搜索CPU ---
    @Override
    public List<CpuInfo> searchCpus(String term) {
        System.out.println("HardwareInfoServiceImpl: searchCpus called with term: " + term); // 添加日志
        List<CpuInfo> results = cpuInfoDao.searchCpus(term); // 假设 CpuInfoDao 有此方法
        System.out.println("HardwareInfoServiceImpl: searchCpus returned " + (results != null ? results.size() : "null") + " results"); // 添加日志
        return results;
    }

    // --- GPU 相关 ---
    @Override
    public List<GpuInfo> getAllGpus() {
        return gpuInfoDao.selectAll();
    }

    @Override
    public GpuInfo getGpuById(Integer id) {
        return gpuInfoDao.selectById(id);
    }

    // --- 实现：搜索GPU ---
    @Override
    public List<GpuInfo> searchGpus(String term) {
        System.out.println("HardwareInfoServiceImpl: searchGpus called with term: " + term); // 添加日志
        List<GpuInfo> results = gpuInfoDao.searchGpus(term); // 假设 GpuInfoDao 有此方法
        System.out.println("HardwareInfoServiceImpl: searchGpus returned " + (results != null ? results.size() : "null") + " results"); // 添加日志
        return results;
    }

    // --- 主板 相关 ---
    @Override
    public List<MotherboardInfo> getAllMotherboards() {
        return motherboardInfoDao.selectAll();
    }

    @Override
    public MotherboardInfo getMotherboardById(Integer id) {
        return motherboardInfoDao.selectById(id);
    }

    // --- 实现：搜索主板 ---
    @Override
    public List<MotherboardInfo> searchMotherboards(String term) {
        System.out.println("HardwareInfoServiceImpl: searchMotherboards called with term: " + term); // 添加日志
        List<MotherboardInfo> results = motherboardInfoDao.searchMotherboards(term); // 确保这里调用了正确的 DAO 方法
        System.out.println("HardwareInfoServiceImpl: searchMotherboards returned " + (results != null ? results.size() : "null") + " results"); // 添加日志
        return results;
    }


}
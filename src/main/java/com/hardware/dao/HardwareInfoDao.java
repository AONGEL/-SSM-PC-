package com.hardware.dao;

import com.hardware.entity.*;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface HardwareInfoDao {

    // --- CPU 相关 ---
    List<CpuInfo> selectAllCpus();
    CpuInfo selectCpuById(@Param("id") Integer id);
    List<CpuInfo> searchCpus(@Param("term") String term);
    int updateCpuInfo(CpuInfo cpuInfo);
    int insertCpuInfo(CpuInfo cpuInfo);
    int deleteCpuInfo(@Param("id") Integer id);

    // --- GPU 相关 ---
    List<GpuInfo> selectAllGpus();
    GpuInfo selectGpuById(@Param("id") Integer id);
    List<GpuInfo> searchGpus(@Param("term") String term);
    int updateGpuInfo(GpuInfo gpuInfo);
    int insertGpuInfo(GpuInfo gpuInfo);
    int deleteGpuInfo(@Param("id") Integer id);

    // --- 主板相关 ---
    List<MotherboardInfo> selectAllMotherboards();
    MotherboardInfo selectMotherboardById(@Param("id") Integer id);
    List<MotherboardInfo> searchMotherboards(@Param("term") String term);
    int updateMotherboardInfo(MotherboardInfo motherboardInfo);
    int insertMotherboardInfo(MotherboardInfo motherboardInfo);
    int deleteMotherboardInfo(@Param("id") Integer id);
}
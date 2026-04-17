package com.hardware.dao;

import com.hardware.entity.CpuInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * CPU参数数据访问接口
 * 定义对CPU参数表的各种数据库操作方法。
 * 与 CpuInfoMapper.xml 中的SQL语句相对应。
 */
public interface CpuInfoDao {

    /**
     * 查询所有CPU信息
     * @return CPU信息列表
     */
    List<CpuInfo> selectAll();

    /**
     * 根据ID查询CPU信息
     * @param id CPU ID
     * @return CPU信息对象
     */
    CpuInfo selectById(@Param("id") Integer id);

    /**
     * 根据型号查询CPU信息
     * @param model CPU型号
     * @return CPU信息对象
     */
    CpuInfo selectByModel(@Param("model") String model);

    /**
     * 插入新的CPU信息
     * @param cpuInfo CPU信息对象
     * @return 插入影响的行数
     */
    int insert(CpuInfo cpuInfo);

    /**
     * 更新CPU信息
     * @param cpuInfo CPU信息对象
     * @return 更新影响的行数
     */
    int update(CpuInfo cpuInfo);

    /**
     * 根据ID删除CPU信息
     * @param id CPU ID
     * @return 删除影响的行数
     */
    int deleteById(@Param("id") Integer id);

    // --- 新增：搜索CPU ---
    /**
     * 根据关键词搜索CPU (品牌或型号)
     * @param term 搜索关键词
     * @return 匹配的CPU列表
     */
    List<CpuInfo> searchCpus(@Param("term") String term);
}
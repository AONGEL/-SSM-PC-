package com.hardware.dao;

import com.hardware.entity.GpuInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * GPU参数数据访问接口
 * 定义对GPU参数表的各种数据库操作方法。
 * 与 GpuInfoMapper.xml 中的SQL语句相对应。
 */
public interface GpuInfoDao {

    /**
     * 查询所有GPU信息
     * @return GPU信息列表
     */
    List<GpuInfo> selectAll();

    /**
     * 根据ID查询GPU信息
     * @param id GPU ID
     * @return GPU信息对象
     */
    GpuInfo selectById(@Param("id") Integer id);

    /**
     * 根据型号查询GPU信息
     * @param model GPU型号
     * @return GPU信息对象
     */
    GpuInfo selectByModel(@Param("model") String model);

    /**
     * 插入新的GPU信息
     * @param gpuInfo GPU信息对象
     * @return 插入影响的行数
     */
    int insert(GpuInfo gpuInfo);

    /**
     * 更新GPU信息
     * @param gpuInfo GPU信息对象
     * @return 更新影响的行数
     */
    int update(GpuInfo gpuInfo);

    /**
     * 根据ID删除GPU信息
     * @param id GPU ID
     * @return 删除影响的行数
     */
    int deleteById(@Param("id") Integer id);

    // --- 新增：搜索GPU ---
    /**
     * 根据关键词搜索GPU (品牌或型号)
     * @param term 搜索关键词
     * @return 匹配的GPU列表
     */
    List<GpuInfo> searchGpus(@Param("term") String term);
}
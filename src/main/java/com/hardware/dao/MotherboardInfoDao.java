package com.hardware.dao;

import com.hardware.entity.MotherboardInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 主板参数数据访问接口
 * 定义对主板参数表的各种数据库操作方法。
 * 与 MotherboardInfoMapper.xml 中的SQL语句相对应。
 */
public interface MotherboardInfoDao {

    /**
     * 查询所有主板信息
     * @return 主板信息列表
     */
    List<MotherboardInfo> selectAll();

    /**
     * 根据ID查询主板信息
     * @param id 主板 ID
     * @return 主板信息对象
     */
    MotherboardInfo selectById(@Param("id") Integer id);

    /**
     * 根据型号查询主板信息
     * @param model 主板型号
     * @return 主板信息对象
     */
    MotherboardInfo selectByModel(@Param("model") String model);

    /**
     * 插入新的主板信息
     * @param motherboardInfo 主板信息对象
     * @return 插入影响的行数
     */
    int insert(MotherboardInfo motherboardInfo);

    /**
     * 更新主板信息
     * @param motherboardInfo 主板信息对象
     * @return 更新影响的行数
     */
    int update(MotherboardInfo motherboardInfo);

    /**
     * 根据ID删除主板信息
     * @param id 主板 ID
     * @return 删除影响的行数
     */
    int deleteById(@Param("id") Integer id);

    // --- 新增：搜索主板 ---
    /**
     * 根据关键词搜索主板 (品牌或型号)
     * @param term 搜索关键词
     * @return 匹配的主板列表
     */
    List<MotherboardInfo> searchMotherboards(@Param("term") String term);
}
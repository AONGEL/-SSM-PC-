package com.hardware.dao;

import com.hardware.entity.ForumSection;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 论坛分区数据访问接口
 */
public interface ForumSectionDao {

    /**
     * 查询所有分区
     * @return 分区列表
     */
    List<ForumSection> selectAll();

    /**
     * 根据ID查询分区
     * @param id 分区ID
     * @return 分区对象
     */
    ForumSection selectById(@Param("id") Integer id);
}

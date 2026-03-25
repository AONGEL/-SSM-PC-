package com.hardware.service;

import com.hardware.entity.ForumSection;

import java.util.List;

/**
 * 论坛分区业务逻辑接口
 */
public interface ForumSectionService {

    /**
     * 获取所有论坛分区列表
     * @return 分区列表
     */
    List<ForumSection> getAllSections();

    /**
     * 根据ID获取论坛分区
     * @param id 分区ID
     * @return 分区对象
     */
    ForumSection getSectionById(Integer id); // 新增此方法
}

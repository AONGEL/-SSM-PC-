package com.hardware.service.impl;

import com.hardware.dao.ForumSectionDao;
import com.hardware.entity.ForumSection;
import com.hardware.service.ForumSectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 论坛分区业务逻辑实现类
 */
@Service
public class ForumSectionServiceImpl implements ForumSectionService {

    @Autowired
    private ForumSectionDao forumSectionDao;

    @Override
    public List<ForumSection> getAllSections() {
        return forumSectionDao.selectAll();
    }

    @Override
    public ForumSection getSectionById(Integer id) { // 实现新增方法
        return forumSectionDao.selectById(id);
    }
}

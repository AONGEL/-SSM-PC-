package com.hardware.service.impl;

import com.hardware.dao.ParamReferenceDao;
import com.hardware.entity.ParamReference;
import com.hardware.service.ParamReferenceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 参数引用业务逻辑实现类
 */
@Service
@Transactional
public class ParamReferenceServiceImpl implements ParamReferenceService {

    @Autowired
    private ParamReferenceDao paramReferenceDao;

    @Override
    public List<ParamReference> getReferencesByPostId(Integer postId) {
        return paramReferenceDao.selectByPostId(postId);
    }

    @Override
    public List<ParamReference> getReferencesByReplyId(Integer replyId) {
        return paramReferenceDao.selectByReplyId(replyId);
    }

    @Override
    public ParamReference addReference(ParamReference paramReference) {
        int rowsAffected = paramReferenceDao.insert(paramReference);
        if (rowsAffected != 1) {
            throw new RuntimeException("Failed to add ParamReference: " + paramReference.getParamTable() + " ID: " + paramReference.getParamId());
        }
        return paramReferenceDao.selectById(paramReference.getId()); // 需要为ParamReferenceDao添加selectById方法，或者返回传入的对象
    }

    @Override
    public boolean deleteReference(Integer id) {
        int rowsAffected = paramReferenceDao.deleteById(id);
        return rowsAffected == 1;
    }
}

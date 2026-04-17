package com.hardware.service;

import com.hardware.entity.ParamReference;

import java.util.List;

/**
 * 参数引用业务逻辑接口
 */
public interface ParamReferenceService {

    /**
     * 根据帖子ID获取所有引用列表
     * @param postId 帖子ID
     * @return 引用列表
     */
    List<ParamReference> getReferencesByPostId(Integer postId);

    /**
     * 根据回复ID获取所有引用列表
     * @param replyId 回复ID
     * @return 引用列表
     */
    List<ParamReference> getReferencesByReplyId(Integer replyId);

    /**
     * 添加新的参数引用
     * @param paramReference 参数引用对象
     * @return 添加成功后的对象
     */
    ParamReference addReference(ParamReference paramReference);

    /**
     * 删除参数引用
     * @param id 引用ID
     * @return 是否删除成功
     */
    boolean deleteReference(Integer id);
}

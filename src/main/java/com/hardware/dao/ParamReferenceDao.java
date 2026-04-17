package com.hardware.dao;

import com.hardware.entity.ParamReference;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 参数引用数据访问接口
 */
public interface ParamReferenceDao {

    /**
     * 根据ID查询引用
     * @param id 引用记录ID
     * @return 引用对象
     */
    ParamReference selectById(@Param("id") Integer id); // 新增方法

    /**
     * 根据帖子ID查询所有引用
     * @param postId 帖子ID
     * @return 引用列表
     */
    List<ParamReference> selectByPostId(@Param("postId") Integer postId);

    /**
     * 根据回复ID查询所有引用
     * @param replyId 回复ID
     * @return 引用列表
     */
    List<ParamReference> selectByReplyId(@Param("replyId") Integer replyId);

    /**
     * 插入新的参数引用记录
     * @param paramReference 参数引用对象
     * @return 插入影响的行数
     */
    int insert(ParamReference paramReference);

    /**
     * 根据ID删除参数引用记录
     * @param id 引用记录ID
     * @return 删除影响的行数
     */
    int deleteById(@Param("id") Integer id);
}
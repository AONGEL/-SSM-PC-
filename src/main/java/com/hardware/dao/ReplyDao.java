package com.hardware.dao;

import com.hardware.entity.Reply;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 回复数据访问接口
 */
public interface ReplyDao {
    /**
     * 查询所有回复
     * @return 回复列表
     */
    List<Reply> selectAll();

    /**
     * 根据ID查询回复
     * @param id 回复ID
     * @return 回复对象
     */
    Reply selectById(@Param("id") Integer id);

    /**
     * 根据帖子ID查询回复
     * @param postId 帖子ID
     * @return 回复列表
     */
    List<Reply> selectByPostId(@Param("postId") Integer postId);

    /**
     * 根据用户ID查询回复
     * @param userId 用户ID
     * @return 回复列表
     */
    List<Reply> selectByUserId(@Param("userId") Integer userId);

    /**
     * 插入新回复
     * @param reply 回复对象
     * @return 插入影响的行数
     */
    int insert(Reply reply);

    /**
     * 更新回复
     * @param reply 回复对象
     * @return 更新影响的行数
     */
    int update(Reply reply);

    /**
     * 根据ID删除回复
     * @param id 回复ID
     * @return 删除影响的行数
     */
    int deleteById(@Param("id") Integer id);

    /**
     * 根据帖子ID分页查询回复
     * @param postId 帖子ID
     * @param offset 偏移量
     * @param limit 限制数量
     * @return 回复列表
     */
    List<Reply> selectByPostIdWithPagination(@Param("postId") Integer postId,
                                             @Param("offset") Integer offset,
                                             @Param("limit") Integer limit);

    /**
     * 统计帖子的回复数量
     * @param postId 帖子ID
     * @return 回复数量
     */
    int countRepliesByPostId(@Param("postId") Integer postId);

    // 添加按用户ID分页查询方法
    List<Reply> selectByUserIdWithPagination(@Param("userId") Integer userId,
                                             @Param("offset") Integer offset,
                                             @Param("limit") Integer limit);

    // 添加按用户ID计数方法
    int countByUserId(@Param("userId") Integer userId);



}
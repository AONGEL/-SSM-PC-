package com.hardware.dao;

import com.hardware.entity.Post;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 帖子数据访问接口
 * 定义对帖子表的各种数据库操作方法。
 * 与 PostMapper.xml 中的SQL语句相对应。
 */
public interface PostDao {

    /**
     * 查询所有帖子
     * @return 帖子列表
     */
    List<Post> selectAllPosts(); // 替换原来的 selectAll()

    /**
     * 查询最新的帖子
     * @param limit 限制返回的数量
     * @return 最新帖子列表
     */
    List<Post> selectLatestPosts(@Param("limit") int limit);

    /**
     * 根据ID查询帖子
     * @param id 帖子ID
     * @return 帖子对象
     */
    Post selectById(@Param("id") Integer id);

    /**
     * 根据分区ID查询帖子
     * @param sectionId 分区ID
     * @return 帖子列表
     */
    List<Post> selectBySectionId(@Param("sectionId") Integer sectionId);

    /**
     * 根据用户ID查询帖子
     * @param userId 用户ID
     * @return 帖子列表
     */
    List<Post> selectByUserId(@Param("userId") Integer userId);

    /**
     * 插入新帖子
     * @param post 帖子对象
     * @return 插入影响的行数
     */
    int insert(Post post);

    /**
     * 更新帖子信息 (如标题、内容、锁定状态)
     * @param post 帖子对象
     * @return 更新影响的行数
     */
    int update(Post post);

    /**
     * 根据ID删除帖子
     * @param id 帖子ID
     * @return 删除影响的行数
     */
    int deleteById(@Param("id") Integer id);

    /**
     * 增加帖子浏览次数
     * @param id 帖子ID
     * @return 更新影响的行数
     */
    int incrementViewCount(@Param("id") Integer id);

    //锁定
    int lockPost(@Param("id") Integer id);
    int unlockPost(@Param("id") Integer id);
    //置顶
    int pinPost(@Param("id") Integer id, @Param("level") Integer level);
    int unpinPost(@Param("id") Integer id);


    List<Post> selectByUserIdWithPagination(@Param("userId") Integer userId, @Param("offset") Integer offset, @Param("limit") Integer limit);
    int countByUserId(@Param("userId") Integer userId);

}

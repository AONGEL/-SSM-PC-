package com.hardware.dao;

import com.hardware.entity.PostFavorite;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface PostFavoriteDao {
    // 添加收藏
    int insert(PostFavorite favorite);

    // 取消收藏
    int deleteByUserAndPost(@Param("userId") Integer userId, @Param("postId") Integer postId);

    // 查询用户是否已收藏某帖子
    PostFavorite findByUserAndPost(@Param("userId") Integer userId, @Param("postId") Integer postId);

    // 分页获取用户收藏列表
    List<PostFavorite> selectByUserIdWithPagination(@Param("userId") Integer userId,
                                                    @Param("offset") Integer offset,
                                                    @Param("limit") Integer limit);

    // 获取用户收藏总数
    int countByUserId(@Param("userId") Integer userId);

    // 获取帖子被收藏数量
    int countByPostId(@Param("postId") Integer postId);
}
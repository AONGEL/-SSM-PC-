package com.hardware.service;

import com.hardware.entity.PostFavorite;
import java.util.List;

public interface PostFavoriteService {
    // 收藏帖子
    boolean favoritePost(Integer userId, Integer postId);

    // 取消收藏
    boolean cancelFavorite(Integer userId, Integer postId);

    // 检查用户是否已收藏该帖子
    boolean isPostFavorited(Integer userId, Integer postId);

    // 分页获取用户收藏列表
    List<PostFavorite> getFavoritesByUserId(Integer userId, Integer pageNum, Integer pageSize);

    // 获取用户收藏总数
    int countFavoritesByUserId(Integer userId);

    // 获取帖子被收藏数量
    int countFavoritesByPostId(Integer postId);


}
package com.hardware.service.impl;

import com.hardware.dao.PostFavoriteDao;
import com.hardware.entity.PostFavorite;
import com.hardware.service.PostFavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional
public class PostFavoriteServiceImpl implements PostFavoriteService {

    @Autowired
    private PostFavoriteDao postFavoriteDao;

    @Override
    public boolean favoritePost(Integer userId, Integer postId) {
        // 先检查是否已收藏
        PostFavorite existing = postFavoriteDao.findByUserAndPost(userId, postId);
        if (existing != null) {
            return true; // 已经收藏，直接返回
        }

        PostFavorite favorite = new PostFavorite();
        favorite.setUserId(userId);
        favorite.setPostId(postId);
        return postFavoriteDao.insert(favorite) > 0;
    }

    @Override
    public boolean cancelFavorite(Integer userId, Integer postId) {
        return postFavoriteDao.deleteByUserAndPost(userId, postId) > 0;
    }

    @Override
    public boolean isPostFavorited(Integer userId, Integer postId) {
        return postFavoriteDao.findByUserAndPost(userId, postId) != null;
    }

    @Override
    public List<PostFavorite> getFavoritesByUserId(Integer userId, Integer pageNum, Integer pageSize) {
        int offset = (pageNum - 1) * pageSize;
        return postFavoriteDao.selectByUserIdWithPagination(userId, offset, pageSize);
    }

    @Override
    public int countFavoritesByUserId(Integer userId) {
        return postFavoriteDao.countByUserId(userId);
    }

    @Override
    public int countFavoritesByPostId(Integer postId) {
        return postFavoriteDao.countByPostId(postId);
    }
}
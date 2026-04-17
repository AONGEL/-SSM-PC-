package com.hardware.service.impl;

import com.hardware.dao.PostDao;
import com.hardware.entity.Post;
import com.hardware.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

/**
 * 帖子业务逻辑实现类
 */
@Service
@Transactional
public class PostServiceImpl implements PostService {

    @Autowired
    private PostDao postDao;

    @Override
    public List<Post> getAllPosts() {
        return postDao.selectAllPosts();
    }

    @Override
    public List<Post> getPostsByUserId(Integer userId) {
        return postDao.selectByUserId(userId);
    }

    @Override
    public Post getPostById(Integer id) {
        return postDao.selectById(id);
    }

    @Override
    public List<Post> getPostsBySectionId(Integer sectionId) {
        return postDao.selectBySectionId(sectionId);
    }

    @Override
    public Post addPost(Post post) {
        int rowsAffected = postDao.insert(post);
        if (rowsAffected != 1) {
            throw new RuntimeException("Failed to add Post: " + post.getTitle());
        }
        return postDao.selectById(post.getId());
    }
    // 确保所有的查询方法能够正确返回sectionName字段
    @Override
    public List<Post> getLatestPosts(int limit) {
        System.out.println("Service: getLatestPosts called with limit: " + limit);
        List<Post> latestPosts = postDao.selectLatestPosts(limit);
        System.out.println("Service: Fetched " + latestPosts.size() + " latest posts from DAO.");
        return latestPosts; // 现在每个Post对象都包含sectionName
    }

    @Override
    public Post updatePost(Post post) {
        int rowsAffected = postDao.update(post);
        if (rowsAffected != 1) {
            throw new IllegalArgumentException("Post not found or update failed for ID: " + post.getId());
        }
        return postDao.selectById(post.getId());
    }

    @Override
    public boolean deletePost(Integer id) {
        int rowsAffected = postDao.deleteById(id);
        return rowsAffected == 1;
    }

    @Override
    public boolean incrementViewCount(Integer id) {
        int rowsAffected = postDao.incrementViewCount(id);
        return rowsAffected == 1;
    }

    @Override
    public boolean lockPost(Integer id) {
        int rowsAffected = postDao.lockPost(id);
        return rowsAffected == 1;
    }

    @Override
    public boolean unlockPost(Integer id) {
        int rowsAffected = postDao.unlockPost(id);
        return rowsAffected == 1;
    }

    @Override
    public boolean pinPost(Integer id, Integer level) {
        // 验证level是否合法
        if (level < 0 || level > 9) {
            throw new IllegalArgumentException("Invalid pin level: " + level);
        }
        int rowsAffected = postDao.pinPost(id, level);
        return rowsAffected == 1;
    }

    @Override
    public boolean unpinPost(Integer id) {
        int rowsAffected = postDao.unpinPost(id);
        return rowsAffected == 1;
    }

    @Override
    public int countPostsByUserId(Integer userId) {
        if (userId == null) {
            return 0;
        }
        return postDao.countByUserId(userId);
    }

    @Override
    public List<Post> getPostsByUserIdWithPagination(Integer userId, Integer pageNum, Integer pageSize) {
        int offset = (pageNum - 1) * pageSize;
        return postDao.selectByUserIdWithPagination(userId, offset, pageSize);
    }




}

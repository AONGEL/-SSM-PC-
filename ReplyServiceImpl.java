package com.hardware.service.impl;

import com.hardware.dao.ReplyDao;
import com.hardware.entity.Post;
import com.hardware.entity.Reply;
import com.hardware.entity.Notification;
import com.hardware.service.NotificationService;
import com.hardware.service.PostService;
import com.hardware.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;

/**
 * 回复业务逻辑实现类
 */
@Service
@Transactional
public class ReplyServiceImpl implements ReplyService {

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private PostService postService;

    @Autowired
    private ReplyDao replyDao;

    @Override
    public List<Reply> getAllReplies() {
        return replyDao.selectAll();
    }

    @Override
    public Reply getReplyById(Integer id) {
        return replyDao.selectById(id);
    }

    @Override
    public List<Reply> getRepliesByUserId(Integer userId) {
        return replyDao.selectByUserId(userId);
    }

    @Override
    public List<Reply> getRepliesByPostId(Integer postId) {
        return replyDao.selectByPostId(postId);
    }

    @Override
    public Reply addReply(Reply reply) {
        // 1. 保存回复
        int rowsAffected = replyDao.insert(reply);
        if (rowsAffected != 1) {
            throw new RuntimeException("Failed to add Reply: " + reply.getContent());
        }

        // 2. 重新获取回复，确保ID已生成
        Reply savedReply = replyDao.selectById(reply.getId());
        if (savedReply == null) {
            throw new RuntimeException("无法获取刚刚保存的回复，ID: " + reply.getId());
        }

        // 3. 获取帖子详情
        Post post = postService.getPostById(savedReply.getPostId());
        if (post == null) {
            System.err.println("警告：回复创建成功，但对应的帖子不存在。帖子ID: " + savedReply.getPostId());
            return savedReply;
        }

        // 4. 发送通知给帖子作者，如果回复者不是作者
        if (!Objects.equals(savedReply.getUserId(), post.getUserId())) {
            try {
                // 确保帖子ID有效
                if (post.getId() != null && post.getId() > 0) {
                    // 修复：使用正确的通知类型和relatedId
                    notificationService.createNotification(
                            post.getUserId(),
                            "REPLY", // 使用标准化的通知类型
                            post.getId() // relatedId设置为帖子ID
                    );
                    System.out.println("成功为用户 " + post.getUserId() + " 创建回复通知，帖子ID: " + post.getId());
                } else {
                    System.err.println("错误：帖子ID无效，无法创建通知。帖子ID: " + post.getId());
                }
            } catch (Exception e) {
                System.err.println("创建通知时出错: " + e.getMessage());
                // 不抛出异常，避免影响回复保存
            }
        }

        return savedReply;
    }

    // 实现分页查询
    @Override
    public List<Reply> getRepliesByPostIdWithPagination(Integer postId, Integer pageNum, Integer pageSize) {
        if (pageNum < 1) pageNum = 1;
        if (pageSize < 1) pageSize = 10;

        int offset = (pageNum - 1) * pageSize;
        return replyDao.selectByPostIdWithPagination(postId, offset, pageSize);
    }

    // 实现计数方法
    @Override
    public int countRepliesByPostId(Integer postId) {
        return replyDao.countRepliesByPostId(postId);
    }

    @Override
    public Reply updateReply(Reply reply) {
        if (reply == null || reply.getId() == null) {
            throw new IllegalArgumentException("回复ID不能为空");
        }

        int rowsAffected = replyDao.update(reply);
        if (rowsAffected != 1) {
            throw new IllegalArgumentException("Reply not found or update failed for ID: " + reply.getId());
        }
        return replyDao.selectById(reply.getId());
    }

    @Override
    public boolean deleteReply(Integer replyId, Integer userId) {
        System.out.println("Service: deleteReply called for replyId: " + replyId + ", userId: " + userId); // 调试日志
        Reply existingReply = replyDao.selectById(replyId);
        if (existingReply == null) {
            System.err.println("Service: Reply with ID " + replyId + " not found for deletion.");
            return false;
        }

        if (!Objects.equals(existingReply.getUserId(), userId)) {
            System.err.println("Service: User with ID " + userId + " is not the author of reply ID " + replyId + ". Cannot delete.");
            return false;
        }

        int rowsAffected = replyDao.deleteById(replyId);
        boolean deleted = rowsAffected == 1;
        if (deleted) {
            System.out.println("Service: Successfully deleted reply ID " + replyId + " by user ID " + userId);
        } else {
            System.err.println("Service: Failed to delete reply ID " + replyId + " by user ID " + userId + ". Rows affected: " + rowsAffected);
        }
        return deleted;
    }

    @Override
    public List<Reply> getRepliesByUserIdWithPagination(Integer userId, Integer pageNum, Integer pageSize) {
        if (pageNum < 1) pageNum = 1;
        if (pageSize < 1) pageSize = 10;

        int offset = (pageNum - 1) * pageSize;
        return replyDao.selectByUserIdWithPagination(userId, offset, pageSize);
    }

    @Override
    public int countRepliesByUserId(Integer userId) {
        return replyDao.countByUserId(userId);
    }

    // 实现通知相关方法

    @Override
    public List<Notification> getUserNotifications(Integer userId) {
        return notificationService.getUserNotifications(userId);
    }

    @Override
    public void markNotificationAsRead(Integer notificationId) {
        notificationService.markAsRead(notificationId);
    }

    @Override
    public void deleteNotification(Integer notificationId) {
        // 先标记为已读，再删除
        notificationService.markAsRead(notificationId);
        notificationService.deleteNotification(notificationId);
    }

    @Override
    public void markAllNotificationsAsRead(Integer userId) {
        notificationService.markAllAsRead(userId);
    }

    @Override
    public int countUnreadNotifications(Integer userId) {
        return notificationService.countUnreadNotifications(userId);
    }

    // 添加新方法：为帖子作者创建回复通知
    @Override
    public void createReplyNotification(Integer postId, Integer replyAuthorId, Integer postAuthorId) {
        // 验证参数
        if (postId == null || postId <= 0) {
            throw new IllegalArgumentException("无效的帖子ID");
        }
        if (replyAuthorId == null || replyAuthorId <= 0) {
            throw new IllegalArgumentException("无效的回复作者ID");
        }
        if (postAuthorId == null || postAuthorId <= 0) {
            throw new IllegalArgumentException("无效的帖子作者ID");
        }

        // 仅当回复者不是帖子作者时创建通知
        if (!Objects.equals(replyAuthorId, postAuthorId)) {
            try {
                notificationService.createNotification(
                        postAuthorId,
                        "REPLY",  // 标准化通知类型
                        postId    // relatedId设置为帖子ID
                );
                System.out.println("成功为帖子作者 " + postAuthorId + " 创建回复通知，帖子ID: " + postId);
            } catch (Exception e) {
                System.err.println("创建回复通知时出错: " + e.getMessage());
                // 记录错误但不中断流程
            }
        }
    }
}
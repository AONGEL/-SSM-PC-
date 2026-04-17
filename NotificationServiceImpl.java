// src/main/java/com/hardware/service/impl/NotificationServiceImpl.java
package com.hardware.service.impl;

import com.hardware.dao.NotificationDao;
import com.hardware.entity.Notification;
import com.hardware.entity.Post;
import com.hardware.service.NotificationService;
import com.hardware.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional
public class NotificationServiceImpl implements NotificationService {

    @Autowired
    private NotificationDao notificationDao;

    @Autowired
    private PostService postService;

    @Override
    public boolean createNotification(Integer recipientId, String type, Integer relatedId) {
        Notification notification = new Notification();
        notification.setRecipientId(recipientId);
        notification.setType(type);
        notification.setRelatedId(relatedId);
        notification.setReadStatus(false);

        int affectedRows = notificationDao.insert(notification);
        return affectedRows == 1;
    }

    @Override
    public List<Notification> getUnreadNotifications(Integer recipientId) {
        return notificationDao.selectUnreadByRecipientId(recipientId);
    }

    @Override
    public boolean markAsRead(Integer notificationId) {
        int affectedRows = notificationDao.markAsRead(notificationId);
        return affectedRows == 1;
    }

    // 修正：正确实现markAllAsRead方法，返回int
    @Override
    public int markAllAsRead(Integer recipientId) {
        if (recipientId == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }

        System.out.println("开始标记用户 " + recipientId + " 的所有通知为已读");
        int affectedRows = notificationDao.markAllAsRead(recipientId);
        System.out.println("成功标记 " + affectedRows + " 条通知为已读");
        return affectedRows;
    }

    @Override
    public boolean deleteNotification(Integer notificationId) {
        int affectedRows = notificationDao.deleteById(notificationId);
        return affectedRows == 1;
    }

    @Override
    public int countUnreadNotifications(Integer recipientId) {
        return notificationDao.countUnreadNotifications(recipientId);
    }

    // 实现缺失的方法
    @Override
    public List<Notification> getUserNotifications(Integer userId) {
        return notificationDao.findByRecipientId(userId);
    }

    // 实现缺失的方法
    @Override
    public List<Notification> getUserNotificationsWithPostInfo(Integer userId) {
        List<Notification> notifications = notificationDao.findByRecipientId(userId);

        for (Notification notification : notifications) {
            if (notification.getRelatedId() != null && notification.getRelatedId() > 0) {
                try {
                    Post post = postService.getPostById(notification.getRelatedId());
                    if (post != null) {
                        notification.setPostTitle(post.getTitle());
                        if (notification.getType() == null) {
                            notification.setType("REPLY");
                        }
                    } else {
                        notification.setPostTitle("帖子已被删除");
                    }
                } catch (Exception e) {
                    System.err.println("获取帖子信息失败: " + e.getMessage());
                    notification.setPostTitle("获取帖子信息失败");
                }
            } else {
                notification.setPostTitle("未知帖子");
            }
        }

        return notifications;
    }

    @Override
    public Notification getNotificationById(Integer id) {
        return notificationDao.findById(id);
    }

    @Override
    public int markPostNotificationsAsRead(Integer userId, Integer postId) {
        if (userId == null || postId == null) {
            throw new IllegalArgumentException("用户ID和帖子ID不能为空");
        }

        return notificationDao.markPostNotificationsAsRead(userId, postId);
    }

    // 实现新方法：删除所有通知
    @Override
    public void deleteAllNotifications(Integer userId) {
        if (userId == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }

        System.out.println("开始删除用户 " + userId + " 的所有通知");
        notificationDao.deleteAllByUserId(userId);
        System.out.println("成功删除用户 " + userId + " 的所有通知");
    }
}
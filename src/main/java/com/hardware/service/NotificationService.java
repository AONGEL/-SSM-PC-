package com.hardware.service;

import com.hardware.entity.Notification;
import java.util.List;

/**
 * 通知业务逻辑接口
 */
public interface NotificationService {
    /**
     * 创建并发送通知
     * @param recipientId 接收者ID
     * @param type 通知类型
     * @param relatedId 相关ID (如帖子ID)
     * @return 是否创建成功
     */
    boolean createNotification(Integer recipientId, String type, Integer relatedId);

    /**
     * 获取用户的所有通知
     * @param userId 接收者ID
     * @return 通知列表
     */
    List<Notification> getUserNotifications(Integer userId);

    List<Notification> getUnreadNotifications(Integer recipientId);

    /**
     * 将通知标记为已读
     * @param notificationId 通知ID
     * @return 是否更新成功
     */
    boolean markAsRead(Integer notificationId);

    /**
     * 将所有通知标记为已读
     * @param recipientId 接收者ID
     */
    int markAllAsRead(Integer recipientId);

    /**
     * 删除通知
     * @param notificationId 通知ID
     * @return 是否删除成功
     */
    boolean deleteNotification(Integer notificationId);

    /**
     * 获取用户未读通知数量
     * @param recipientId 接收者ID
     * @return 未读通知数量
     */
    int countUnreadNotifications(Integer recipientId);

    /**
     * 将特定帖子的通知标记为已读
     * @param recipientId 接收者ID
     * @param postId 帖子ID
     * @return 被标记为已读的通知数量
     */
    int markPostNotificationsAsRead(Integer recipientId, Integer postId);

    /**
     * 根据ID获取通知
     * @param id 通知ID
     * @return 通知对象
     */
    Notification getNotificationById(Integer id);

    List<Notification> getUserNotificationsWithPostInfo(Integer userId);
    void deleteAllNotifications(Integer userId); // 添加新方法

}
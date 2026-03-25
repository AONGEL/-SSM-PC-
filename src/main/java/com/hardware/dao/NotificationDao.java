package com.hardware.dao;

import com.hardware.entity.Notification;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 通知数据访问接口
 */
public interface NotificationDao {
    /**
     * 插入新通知
     * @param notification 通知对象
     * @return 插入影响的行数
     */
    int insert(Notification notification);

    /**
     * 根据通知ID查询通知
     * @param id 通知ID
     * @return 通知对象
     */
    Notification selectById(@Param("id") Integer id);

    /**
     * 根据接收者ID查询未读通知
     * @param recipientId 接收者ID
     * @return 未读通知列表
     */
    List<Notification> selectUnreadByRecipientId(@Param("recipientId") Integer recipientId);

    /**
     * 标记通知为已读
     * @param id 通知ID
     * @return 更新影响的行数
     */
    int markAsRead(@Param("id") Integer id);

    /**
     * 标记所有通知为已读
     * @param recipientId 接收者ID
     * @return 更新影响的行数
     */
    int markAllAsRead(@Param("recipientId") Integer recipientId);

    /**
     * 删除通知
     * @param id 通知ID
     * @return 删除影响的行数
     */
    int deleteById(@Param("id") Integer id);

    /**
     * 统计用户未读通知数量
     * @param recipientId 接收者ID
     * @return 未读通知数量
     */
    int countUnreadNotifications(@Param("recipientId") Integer recipientId);

    int markPostNotificationsAsRead(@Param("userId") Integer userId, @Param("postId") Integer postId);

    List<Notification> findByRecipientId(@Param("recipientId") Integer recipientId);

    /**
     * 根据ID查询通知
     * @param id 通知ID
     * @return 通知对象
     */
    Notification findById(Integer id);

    void deleteAllByUserId(@Param("userId") Integer userId);


}
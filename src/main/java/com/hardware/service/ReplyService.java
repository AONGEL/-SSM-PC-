package com.hardware.service;

import com.hardware.entity.Reply;
import com.hardware.entity.Notification;
import java.util.List;

/**
 * 回复业务逻辑接口
 */
public interface ReplyService {
    /**
     * 获取所有回复列表
     * @return 回复列表
     */
    List<Reply> getAllReplies();

    /**
     * 根据ID获取回复
     * @param id 回复ID
     * @return 回复对象
     */
    Reply getReplyById(Integer id);

    /**
     * 根据帖子ID获取回复列表
     * @param postId 帖子ID
     * @return 回复列表
     */
    List<Reply> getRepliesByPostId(Integer postId);

    /**
     * 添加新回复
     * @param reply 回复对象
     * @return 添加成功后的回复对象
     * 注意: 此方法会为原帖作者生成通知，且通知的relatedId必须设置为帖子ID(postId)，而非回复ID
     */
    Reply addReply(Reply reply);

    /**
     * 更新回复
     * @param reply 回复对象 (必须包含ID)
     * @return 更新成功后的回复对象
     */
    Reply updateReply(Reply reply);

    /**
     * 删除回复 (仅作者可删除)
     * @param replyId 要删除的回复ID
     * @param userId 当前登录用户的ID
     * @return true 如果删除成功，false 如果用户无权删除或回复不存在
     */
    boolean deleteReply(Integer replyId, Integer userId);

    // 添加分页查询方法
    List<Reply> getRepliesByPostIdWithPagination(Integer postId, Integer pageNum, Integer pageSize);

    // 添加计数方法
    int countRepliesByPostId(Integer postId);

    /**
     * 根据用户ID获取回复列表
     * @param userId 用户ID
     * @return 回复列表
     */
    List<Reply> getRepliesByUserId(Integer userId);

    /**
     * 根据用户ID分页获取回复列表
     * @param userId 用户ID
     * @param pageNum 页码
     * @param pageSize 每页大小
     * @return 回复列表
     */
    List<Reply> getRepliesByUserIdWithPagination(Integer userId, Integer pageNum, Integer pageSize);

    /**
     * 获取用户回复总数
     * @param userId 用户ID
     * @return 回复总数
     */
    int countRepliesByUserId(Integer userId);

    /**
     * 获取用户收到的通知列表
     * @param userId 用户ID
     * @return 通知列表
     */
    List<Notification> getUserNotifications(Integer userId);

    /**
     * 标记通知为已读
     * @param notificationId 通知ID
     */
    void markNotificationAsRead(Integer notificationId);

    /**
     * 删除通知
     * @param notificationId 通知ID
     */
    void deleteNotification(Integer notificationId);

    /**
     * 标记用户所有通知为已读
     * @param userId 用户ID
     */
    void markAllNotificationsAsRead(Integer userId);

    /**
     * 获取用户未读通知数量
     * @param userId 用户ID
     * @return 未读通知数量
     */
    int countUnreadNotifications(Integer userId);

    /**
     * 为帖子作者创建回复通知
     * @param postId 帖子ID (将作为通知的relatedId)
     * @param replyAuthorId 回复作者ID
     * @param postAuthorId 帖子作者ID (通知接收者)
     */
    void createReplyNotification(Integer postId, Integer replyAuthorId, Integer postAuthorId);


}
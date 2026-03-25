package com.hardware.service;

import com.hardware.entity.User;

import java.util.List;

/**
 * 用户业务逻辑接口
 * 定义用户相关的业务操作方法。
 * 由 UserServiceImpl 实现。
 */
public interface UserService {

    /**
     * 用户注册
     * @param username 用户名
     * @param password 明文密码 (服务层会进行MD5加密)
     * @return 注册成功的用户对象
     * @throws IllegalArgumentException 如果用户名已存在或密码不符合要求
     */
    User register(String username, String password);

    /**
     * 用户登录
     * @param username 用户名
     * @param password 明文密码 (服务层会进行MD5加密后与数据库比较)
     * @return 登录成功的用户对象，如果用户名或密码错误则返回null
     */
    User login(String username, String password);

    /**
     * 根据ID查询用户
     * @param id 用户ID
     * @return 用户对象
     */
    User getUserById(Integer id);

    /**
     * 更新用户信息 (头像、用户名等)
     * @param user 用户对象 (必须包含ID)
     * @return 更新后的用户对象
     * @throws IllegalArgumentException 如果用户不存在
     */
    User updateUserInfo(User user);

    /**
     * 更新用户密码
     * @param userId 用户ID
     * @param oldPassword 旧明文密码
     * @param newPassword 新明文密码
     * @return 更新后的用户对象
     * @throws IllegalArgumentException 如果旧密码错误或用户不存在
     */
    User updatePassword(Integer userId, String oldPassword, String newPassword);

    /**
     * 根据用户名查询用户
     * @param username 用户名
     * @return 用户对象
     */
    User getUserByUsername(String username);

    // --- 新增方法 ---
    /**
     * 根据用户ID获取其发布的帖子列表
     * @param userId 用户ID
     * @return 帖子列表
     */
    List<com.hardware.entity.Post> getUserPosts(Integer userId);

    /**
     * 根据用户ID获取其发布的回复列表
     * @param userId 用户ID
     * @return 回复列表
     */
    List<com.hardware.entity.Reply> getUserReplies(Integer userId);

    /**
     * 更新用户角色
     * @param userId 用户ID
     * @param newRole 新角色
     * @return true 如果更新成功，false 如果用户不存在或更新失败
     */
    boolean updateUserRole(Integer userId, String newRole);

    /**
     * 获取所有用户
     * @return 用户列表
     */
    List<User> getAllUsers();



    boolean addUser(User user);
    boolean updateUser(User user);
    boolean deleteUser(Integer id);
    User authenticate(String username, String password);

    // 添加获取用户未读通知数量的方法
    int countUnreadNotifications(Integer userId);

}
package com.hardware.service.impl;

import com.hardware.dao.PostDao;
import com.hardware.dao.ReplyDao;
import com.hardware.dao.UserDao;
import com.hardware.entity.Post;
import com.hardware.entity.Reply;
import com.hardware.entity.User;
import com.hardware.service.NotificationService;
import com.hardware.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private NotificationService notificationService;
    @Autowired
    private PostDao postDao;

    @Autowired
    private ReplyDao replyDao;

    private static final MessageDigest md5Digest;
    static {
        try {
            md5Digest = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("MD5 algorithm not available", e);
        }
    }

    private String encryptPassword(String plainPassword) {
        byte[] hashBytes = md5Digest.digest(plainPassword.getBytes());
        StringBuilder sb = new StringBuilder();
        for (byte b : hashBytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }

    @Override
    public User register(String username, String password) {
        User existingUser = userDao.selectByUsername(username);
        if (existingUser != null) {
            throw new IllegalArgumentException("Username already exists: " + username);
        }

        String encryptedPassword = encryptPassword(password);
        User user = new User(username, encryptedPassword);
        int rowsAffected = userDao.insert(user);
        if (rowsAffected != 1) {
            throw new RuntimeException("Failed to register user: " + username);
        }
        return user;
    }

    @Override
    public User login(String username, String password) {
        String encryptedPassword = encryptPassword(password);
        return userDao.selectByUsernameAndPassword(username, encryptedPassword);
    }

    @Override
    public User getUserById(Integer id) {
        return userDao.selectById(id);
    }

    @Override
    public User updateUserInfo(User user) {
        int rowsAffected = userDao.update(user);
        if (rowsAffected != 1) {
            throw new IllegalArgumentException("User not found or update failed for ID: " + user.getId());
        }
        return userDao.selectById(user.getId());
    }

    @Override
    public User updatePassword(Integer userId, String oldPassword, String newPassword) {
        String encryptedOldPassword = encryptPassword(oldPassword);
        String encryptedNewPassword = encryptPassword(newPassword);

        int rowsAffected = userDao.updatePassword(userId, encryptedNewPassword, encryptedOldPassword);
        if (rowsAffected != 1) {
            throw new IllegalArgumentException("Old password is incorrect or user not found for ID: " + userId);
        }
        return userDao.selectById(userId);
    }

    @Override
    public User getUserByUsername(String username) {
        return userDao.selectByUsername(username);
    }

    @Override
    public boolean addUser(User user) {
        int affectedRows = userDao.insert(user);
        return affectedRows == 1;
    }

    @Override
    public boolean updateUser(User user) {
        int affectedRows = userDao.update(user);
        return affectedRows == 1;
    }

    @Override
    public boolean deleteUser(Integer id) {
        int affectedRows = userDao.deleteById(id);
        return affectedRows == 1;
    }

    @Override
    public User authenticate(String username, String password) {
        return userDao.selectByUsernameAndPassword(username, password);
    }

    @Override
    public List<Post> getUserPosts(Integer userId) {
        return postDao.selectByUserId(userId);
    }

    @Override
    public List<Reply> getUserReplies(Integer userId) {
        return replyDao.selectByUserId(userId);
    }

    @Override
    public boolean updateUserRole(Integer userId, String newRole) {
        User existingUser = userDao.selectById(userId);
        if (existingUser == null) {
            return false;
        }

        int rowsAffected = userDao.updateRole(userId, newRole);
        return rowsAffected == 1;
    }

    @Override
    public List<User> getAllUsers() {
        return userDao.selectAll();
    }

    // 实现获取用户未读通知数量的方法
    @Override
    public int countUnreadNotifications(Integer userId) {
        return notificationService.countUnreadNotifications(userId);
    }

}
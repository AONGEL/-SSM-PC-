package com.hardware.dao;

import com.hardware.entity.User;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface UserDao {
    List<User> selectAll();
    User selectById(@Param("id") Integer id);
    User selectByUsername(@Param("username") String username);
    int insert(User user);
    int update(User user);
    int updatePassword(@Param("userId") Integer userId,
                       @Param("newPassword") String newPassword,
                       @Param("oldPassword") String oldPassword);
    int updateRole(@Param("userId") Integer userId, @Param("role") String role);
    int deleteById(@Param("id") Integer id);
    User selectByUsernameAndPassword(@Param("username") String username,
                                     @Param("password") String password);
}
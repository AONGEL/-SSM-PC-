package com.hardware.service;

import com.hardware.entity.Post;
import java.util.List;

/**
 * 帖子业务逻辑接口
 */
public interface PostService {
    /**
     * 获取所有帖子列表
     * @return 帖子列表
     */
    List<Post> getAllPosts();

    /**
     * 根据ID获取帖子
     * @param id 帖子ID
     * @return 帖子对象
     */
    Post getPostById(Integer id);

    /**
     * 根据分区ID获取帖子列表
     * @param sectionId 分区ID
     * @return 帖子列表
     */
    List<Post> getPostsBySectionId(Integer sectionId);

    /**
     * 添加新帖子
     * @param post 帖子对象
     * @return 添加成功后的帖子对象
     */
    Post addPost(Post post);

    /**
     * 获取最新的帖子列表
     * @param limit 限制返回的数量
     * @return 最新的帖子列表
     */
    List<Post> getLatestPosts(int limit);

    /**
     * 更新帖子
     * @param post 帖子对象 (必须包含ID)
     * @return 更新成功后的帖子对象
     */
    Post updatePost(Post post);

    /**
     * 删除帖子
     * @param id 帖子ID
     * @return 是否删除成功
     */
    boolean deletePost(Integer id);

    /**
     * 增加帖子浏览次数
     * @param id 帖子ID
     * @return 是否更新成功
     */
    boolean incrementViewCount(Integer id);

    boolean lockPost(Integer id);
    boolean unlockPost(Integer id);
    boolean pinPost(Integer id, Integer level);
    boolean unpinPost(Integer id);

    /**
     * 根据用户ID获取帖子列表
     * @param userId 用户ID
     * @return 帖子列表
     */
    List<Post> getPostsByUserId(Integer userId);

    /**
     * 根据用户ID分页获取帖子列表
     * @param userId 用户ID
     * @param pageNum 页码
     * @param pageSize 每页大小
     * @return 帖子列表
     */
    List<Post> getPostsByUserIdWithPagination(Integer userId, Integer pageNum, Integer pageSize);

    /**
     * 获取用户帖子总数
     * @param userId 用户ID
     * @return 帖子总数
     */
    int countPostsByUserId(Integer userId);

    /**
     * 根据 ID 获取 CPU 信息
     * @param id CPU ID
     * @return CPU 对象
     */
    com.hardware.entity.CpuInfo getCpuById(Integer id);

    /**
     * 根据 ID 获取显卡信息
     * @param id 显卡 ID
     * @return 显卡对象
     */
    com.hardware.entity.GpuInfo getGpuById(Integer id);

    /**
     * 根据 ID 获取主板信息
     * @param id 主板 ID
     * @return 主板对象
     */
    com.hardware.entity.MotherboardInfo getMotherboardById(Integer id);

    /**
     * 根据 ID 获取内存信息
     * @param id 内存 ID
     * @return 内存对象
     */
    com.hardware.entity.MemoryInfo getMemoryById(Integer id);

    /**
     * 根据 ID 获取存储设备信息
     * @param id 存储设备 ID
     * @return 存储设备对象
     */
    com.hardware.entity.StorageInfo getStorageById(Integer id);
}
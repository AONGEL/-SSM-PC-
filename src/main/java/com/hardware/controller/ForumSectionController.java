package com.hardware.controller;

import com.hardware.entity.ForumSection;
import com.hardware.entity.Post;
import com.hardware.service.ForumSectionService;
import com.hardware.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * 论坛分区控制器
 * 处理与论坛分区相关的请求。
 */
@Controller
@RequestMapping("/forum/section") // 所有请求路径以 /forum/section 开头
public class ForumSectionController {

    @Autowired
    private ForumSectionService forumSectionService;

    @Autowired
    private PostService postService; // 注入PostService

    /**
     * 显示所有论坛分区列表
     * @param model Model对象，用于向视图传递数据
     * @return 视图名称 "section-list"
     */
    @GetMapping // 处理 /forum/section 的 GET 请求
    public String listSections(Model model) {
        List<ForumSection> sections = forumSectionService.getAllSections();
        model.addAttribute("sections", sections); // 将分区列表传递给视图
        return "section-list"; // 返回视图名称，对应 /WEB-INF/jsp/section-list.jsp
    }

    /**
     * 显示指定分区下的帖子列表
     * @param id 分区ID
     * @param model Model对象，用于向视图传递数据
     * @return 视图名称 "post-list"
     */
    @GetMapping("/{id}/posts") // 处理 /forum/section/{id}/posts 的 GET 请求
    public String listPostsBySection(@PathVariable Integer id, Model model) {
        // 获取分区信息 (用于页面显示当前分区名称和描述)
        ForumSection section = forumSectionService.getSectionById(id);
        if (section == null) {
            model.addAttribute("errorMessage", "分区不存在");
            return "error"; // 返回错误页面 (需要创建 WEB-INF/jsp/error.jsp)
        }
        // 获取该分区下的帖子列表
        List<Post> posts = postService.getPostsBySectionId(id);
        model.addAttribute("posts", posts);
        model.addAttribute("section", section); // 将分区信息也传递给视图，以便在 post-list.jsp 中使用
        return "post-list"; // 返回视图名称，对应 /WEB-INF/jsp/post-list.jsp
    }
}

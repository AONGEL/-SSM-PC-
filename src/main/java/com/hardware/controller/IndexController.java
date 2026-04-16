// src/main/java/com/hardware/controller/IndexController.java
package com.hardware.controller;

import com.hardware.entity.Post;
import com.hardware.entity.ForumSection;
import com.hardware.service.PostService;
import com.hardware.service.ForumSectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class IndexController {
    @Autowired
    private PostService postService;

    @Autowired
    private ForumSectionService forumSectionService;

    @GetMapping("/")
    public String index(Model model) {
        // 获取最新帖子（按回复数排序，置顶优先）
        List<Post> latestPosts = postService.getLatestPosts(10);
        model.addAttribute("latestPosts", latestPosts);
        
        // 获取所有论坛分区
        List<ForumSection> sections = forumSectionService.getAllSections();
        model.addAttribute("sections", sections);
        
        return "index";
    }

    // 如果有使用到所有帖子的方法
    @GetMapping("/all-posts")
    public String allPosts(Model model) {
        List<Post> allPosts = postService.getAllPosts();
        model.addAttribute("posts", allPosts);
        return "post-list";
    }
}
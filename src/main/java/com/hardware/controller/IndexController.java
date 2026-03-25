// src/main/java/com/hardware/controller/IndexController.java
package com.hardware.controller;

import com.hardware.entity.Post;
import com.hardware.service.PostService;
import com.hardware.service.ForumSectionService; // 获取板块名称
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class IndexController {
    @Autowired
    private PostService postService;

    @GetMapping("/")
    public String index(Model model) {
        List<Post> latestPosts = postService.getLatestPosts(3);
        model.addAttribute("latestPosts", latestPosts);
        return "index";
    }

    // 如果有使用到所有帖子的方法
    @GetMapping("/all-posts")
    public String allPosts(Model model) {
        List<Post> allPosts = postService.getAllPosts(); // 确保这里使用的是新的方法
        model.addAttribute("posts", allPosts);
        return "post-list";
    }
}
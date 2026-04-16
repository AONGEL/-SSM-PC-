// src/main/java/com/hardware/controller/IndexController.java
package com.hardware.controller;

import com.hardware.entity.Post;
import com.hardware.entity.ForumSection;
import com.hardware.entity.User;
import com.hardware.service.PostService;
import com.hardware.service.ForumSectionService;
import com.hardware.service.UserService;
import com.hardware.service.ReplyService;
import com.hardware.service.PostFavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class IndexController {
    @Autowired
    private PostService postService;

    @Autowired
    private ForumSectionService forumSectionService;

    @Autowired
    private UserService userService;

    @Autowired
    private ReplyService replyService;

    @Autowired
    private PostFavoriteService postFavoriteService;

    @GetMapping("/")
    public String index(Model model, HttpSession session) {
        // 获取最新帖子（按回复数排序，置顶优先）
        List<Post> latestPosts = postService.getLatestPosts(10);
        model.addAttribute("latestPosts", latestPosts);
        
        // 获取所有论坛分区
        List<ForumSection> sections = forumSectionService.getAllSections();
        model.addAttribute("sections", sections);
        
        // 获取当前用户信息
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser != null) {
            // 刷新用户信息（包含头像）
            User freshUser = userService.getUserById(currentUser.getId());
            model.addAttribute("currentUser", freshUser);
            
            // 获取用户发帖数
            int postCount = userService.getUserPosts(currentUser.getId()).size();
            model.addAttribute("postCount", postCount);
            
            // 获取用户回复数
            int replyCount = userService.getUserReplies(currentUser.getId()).size();
            model.addAttribute("replyCount", replyCount);
            
            // 获取用户收藏数
            int favoriteCount = postFavoriteService.countFavoritesByUserId(currentUser.getId());
            model.addAttribute("favoriteCount", favoriteCount);
        }
        
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
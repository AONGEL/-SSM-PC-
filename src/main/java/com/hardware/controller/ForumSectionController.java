package com.hardware.controller;

import com.hardware.entity.ForumSection;
import com.hardware.entity.Post;
import com.hardware.entity.User;
import com.hardware.service.ForumSectionService;
import com.hardware.service.PostService;
import com.hardware.service.UserService;
import com.hardware.service.ReplyService;
import com.hardware.service.PostFavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/forum/section")
public class ForumSectionController {

    @Autowired
    private ForumSectionService forumSectionService;

    @Autowired
    private PostService postService;

    @Autowired
    private UserService userService;

    @Autowired
    private ReplyService replyService;

    @Autowired
    private PostFavoriteService postFavoriteService;

    @GetMapping
    public String listSections(Model model, HttpSession session) {
        List<ForumSection> sections = forumSectionService.getAllSections();
        model.addAttribute("sections", sections);
        
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser != null) {
            User freshUser = userService.getUserById(currentUser.getId());
            model.addAttribute("currentUser", freshUser);
            model.addAttribute("postCount", userService.getUserPosts(currentUser.getId()).size());
            model.addAttribute("replyCount", userService.getUserReplies(currentUser.getId()).size());
            model.addAttribute("favoriteCount", postFavoriteService.countFavoritesByUserId(currentUser.getId()));
        }
        
        return "section-list";
    }

    @GetMapping("/{id}/posts")
    public String listPostsBySection(@PathVariable Integer id, 
                                     @RequestParam(defaultValue = "1") Integer pageNum,
                                     @RequestParam(defaultValue = "10") Integer pageSize,
                                     Model model, HttpSession session) {
        ForumSection section = forumSectionService.getSectionById(id);
        if (section == null) {
            model.addAttribute("errorMessage", "分区不存在");
            return "error";
        }
        
        // 获取该分区下的所有帖子（用于计算总数）
        List<Post> allPosts = postService.getPostsBySectionId(id);
        int totalPosts = allPosts.size();
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
        
        // 确保页码有效
        if (pageNum < 1) pageNum = 1;
        if (pageNum > totalPages && totalPages > 0) pageNum = totalPages;
        
        // 计算起始和结束索引进行分页
        int startIndex = (pageNum - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalPosts);
        
        List<Post> posts;
        if (startIndex < totalPosts) {
            posts = allPosts.subList(startIndex, endIndex);
        } else {
            posts = java.util.Collections.emptyList();
        }
        
        model.addAttribute("posts", posts);
        model.addAttribute("section", section);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalPosts", totalPosts);
        
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser != null) {
            User freshUser = userService.getUserById(currentUser.getId());
            model.addAttribute("currentUser", freshUser);
            model.addAttribute("postCount", userService.getUserPosts(currentUser.getId()).size());
            model.addAttribute("replyCount", userService.getUserReplies(currentUser.getId()).size());
            model.addAttribute("favoriteCount", postFavoriteService.countFavoritesByUserId(currentUser.getId()));
        }
        
        return "post-list";
    }
}

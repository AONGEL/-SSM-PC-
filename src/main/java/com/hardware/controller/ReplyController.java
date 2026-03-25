package com.hardware.controller;

import com.hardware.entity.Reply;
import com.hardware.entity.User;
import com.hardware.service.ReplyService;
import com.hardware.service.UserService;
import com.hardware.service.PostService;
import com.hardware.service.ParamReferenceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import java.util.Collections;
import java.util.HashSet;
import java.util.Arrays;
// import org.springframework.web.bind.annotation.*; // 重复 import，已移除

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Set;
import java.util.ArrayList;
import com.hardware.entity.ParamReference;

/**
 * 回复控制器
 * 处理与回复相关的请求，如创建、删除等。
 * 注意：帖子详情页的回复提交目前在 PostController 中处理。
 * 这里可以用于独立的回复管理功能，或者将 PostController 中的回复逻辑迁移到此处。
 */
@Controller
@RequestMapping("/reply") // 所有请求路径以 /reply 开头
public class ReplyController {

    @Autowired
    private ReplyService replyService;

    @Autowired
    private PostService postService; // 用于验证帖子是否存在

    @Autowired
    private UserService userService; // 用于验证用户是否存在 (可选)

    @Autowired
    private ParamReferenceService paramReferenceService; // 注入

    // 如果我们将 PostController 中的 createReply 方法迁移到这里，可以这样做：
    /**
     * 处理创建回复的表单提交 (替代 PostController 中的逻辑)
     * @param postId 帖子ID (从表单隐藏域或URL获取)
     * @param reply 回复对象，从表单数据自动绑定
     * @param bindingResult 用于验证表单数据
     * @param session HTTP会话，用于获取当前登录用户ID
     * @param model Model对象，用于传递错误信息
     * @return 成功后重定向到帖子详情页，失败则返回帖子详情页并显示错误
     */
    @PostMapping("/create") // 处理 /reply/create 的 POST 请求
    public String createReply(@RequestParam Integer postId, @Valid Reply reply, BindingResult bindingResult, HttpSession session, Model model) {
        System.out.println("ReplyController - createReply method called for Post ID: " + postId); // 调试日志
        System.out.println("Reply object: " + reply);
        System.out.println("Binding result has errors: " + bindingResult.hasErrors());

        // 1. 验证用户是否登录
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            System.out.println("User is not logged in.");
            model.addAttribute("errorMessage", "请先登录");
            return "redirect:/user/login";
        }

        // 2. 验证帖子是否存在 (可选，但推荐)
        if (postService.getPostById(postId) == null) {
            System.out.println("Post not found for ID: " + postId);
            model.addAttribute("errorMessage", "帖子不存在");
            return "error"; // 或者返回到首页
        }

        // 3. 设置回复的帖子ID和用户ID
        reply.setPostId(postId);
        reply.setUserId(currentUser.getId());

        // 4. 验证表单数据 (内容不能为空)
        if (bindingResult.hasErrors()) {
            System.out.println("Validation errors found for reply.");
            // 如果验证失败，需要重新加载帖子详情和回复列表
            // 这里需要获取帖子和已有回复，然后返回详情页 (逻辑较复杂，可能需要 Service)
            // 为了简化，我们暂时只处理成功情况
            // List<Reply> replies = replyService.getRepliesByPostId(postId);
            // model.addAttribute("post", postService.getPostById(postId));
            // model.addAttribute("replies", replies);
            model.addAttribute("errorMessage", "回复内容不能为空。");
            return "redirect:/post/" + postId; // 返回帖子详情页，显示错误 (或在详情页显示)
        }

        // --- 解析并保存参数引用 ---
        String replyContent = reply.getContent();
        List<ParamReference> referencesToSave = parseAndCreateReferences(replyContent, null, reply.getId()); // postId 为 null, replyId 为当前回复ID (注意：reply.getId() 此时为 null)


        try {
            System.out.println("Attempting to save reply...");
            Reply savedReply = replyService.addReply(reply); // 这里 reply.getId() 会被设置
            System.out.println("Reply saved successfully with ID: " + savedReply.getId());

            // --- 解析并保存参数引用 (使用新获取的 reply ID) ---
            List<ParamReference> newReferencesToSave = parseAndCreateReferences(replyContent, null, savedReply.getId()); // postId 为 null, replyId 为新回复ID
            if (!newReferencesToSave.isEmpty()) {
                for (ParamReference ref : newReferencesToSave) {
                    paramReferenceService.addReference(ref);
                    System.out.println("Saved reference for reply: " + ref);
                }
            }

            // 6. 保存成功后，重定向到帖子详情页
            return "redirect:/post/" + postId; // 重定向到帖子详情页
        } catch (Exception e) {
            System.out.println("Error saving reply: " + e.getMessage());
            e.printStackTrace(); // 打印异常堆栈

            model.addAttribute("errorMessage", "回复失败: " + e.getMessage());
            return "redirect:/post/" + postId; // 返回帖子详情页，显示错误
        }
    }

    // --- 解析内容并创建 ParamReference 对象 (与 PostController 相同) ---
    private List<ParamReference> parseAndCreateReferences(String content, Integer postId, Integer replyId) {
        List<ParamReference> references = new ArrayList<>();
        String regex = "\\[([a-zA-Z_]+):(\\d+)\\]";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(content);

        while (matcher.find()) {
            String tableName = matcher.group(1);
            Integer id = Integer.parseInt(matcher.group(2));

            if (isValidTableName(tableName)) {
                ParamReference ref = new ParamReference();
                ref.setPostId(postId);
                ref.setReplyId(replyId);
                ref.setParamTable(tableName);
                ref.setParamId(id);
                references.add(ref);
            } else {
                System.out.println("Invalid table name in reference: " + tableName);
            }
        }
        return references;
    }

    private boolean isValidTableName(String tableName) {
        Set<String> validTables = Collections.unmodifiableSet(
                new HashSet<>(Arrays.asList("cpu_info", "gpu_info", "motherboard_info", "memory_info", "storage_info"))
        );
        return validTables.contains(tableName);
    }

    /**
     * 处理删除回复请求 (DELETE)
     */
    @DeleteMapping("/{id}") // 处理 /reply/{id} 的 DELETE 请求
    @ResponseBody // 返回简单的成功/失败信息
    public String deleteReply(@PathVariable Integer id, HttpSession session) {
        // 获取当前登录用户
        com.hardware.entity.User currentUser = (com.hardware.entity.User) session.getAttribute("currentUser");
        if (currentUser == null) {
            // 如果用户未登录，返回错误
            return "unauthorized"; // 或 JSON {"status": "error", "message": "Unauthorized"}
        }

        System.out.println("Controller: deleteReply called for replyId: " + id + ", by user: " + currentUser.getId()); // 调试日志

        // 调用服务层删除回复
        boolean deleted = replyService.deleteReply(id, currentUser.getId());
        if (deleted) {
            return "success"; // 或 JSON {"status": "success"}
        } else {
            // 可能是用户无权删除或回复不存在
            return "failed"; // 或 JSON {"status": "error", "message": "Failed to delete or unauthorized"}
        }
    }

}
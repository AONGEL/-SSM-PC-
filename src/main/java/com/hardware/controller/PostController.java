package com.hardware.controller;

import com.hardware.entity.*;
import com.hardware.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

/**
 * 帖子控制器
 * 处理与帖子相关的请求，如查看详情、创建、编辑等。
 */
@Controller
@RequestMapping("/post") // 所有请求路径以 /post 开头
public class PostController {

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private PostService postService;

    @Autowired
    private ReplyService replyService;

    @Autowired
    private UserService userService; // 注入UserService

    @Autowired
    private ForumSectionService forumSectionService; // 注入ForumSectionService

    @Autowired
    private ParamReferenceService paramReferenceService; // 注入 ParamReferenceService

    @Autowired
    private PostFavoriteService postFavoriteService;

    /**
     * 显示帖子详情页
     * @param id 帖子ID
     * @param model Model对象，用于向视图传递数据
     * @return 视图名称 "post-detail" 或 "post-deleted"
     */
    @GetMapping("/{id}")
    public String viewPost(@PathVariable Integer id,
                           @RequestParam(defaultValue = "1") Integer pageNum,
                           @RequestParam(defaultValue = "6") Integer pageSize,
                           Model model, HttpSession session) {
        System.out.println("viewPost method called for ID: " + id);

        // 1. 获取帖子详情
        Post post = postService.getPostById(id);
        if (post == null) {
            System.out.println("Post with ID " + id + " not found. Forwarding to deleted page.");
            return "post-deleted";
        }

        // 2. 检查帖子是否已被删除（假设Post类中有isDeleted字段）
        // 修复：使用正确的判断方式，根据您的实体类结构调整
        if (post.getIsDeleted() != null && post.getIsDeleted()) {
            System.out.println("Post with ID " + id + " has been deleted. Forwarding to deleted page.");
            return "post-deleted";
        }

        // 3. 增加帖子浏览次数
        postService.incrementViewCount(id);

        // 4. 获取该帖子下的分页回复
        int totalReplies = replyService.countRepliesByPostId(id);
        int totalPages = (int) Math.ceil((double) totalReplies / pageSize);
        List<Reply> replies = replyService.getRepliesByPostIdWithPagination(id, pageNum, pageSize);

        // 5. 将数据传递给视图
        model.addAttribute("post", post);
        model.addAttribute("replies", replies);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalReplies", totalReplies);

        // 6. 添加一个空的 Reply 对象，供回复表单使用
        model.addAttribute("reply", new Reply());

        // 7. 获取当前用户的通知
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser != null) {
            // 7.1 获取未读通知数量
            int unreadCount = notificationService.countUnreadNotifications(currentUser.getId());

            // 7.2 获取用户的所有通知列表
            List<Notification> userNotifications = notificationService.getUserNotifications(currentUser.getId());
            model.addAttribute("userNotifications", userNotifications);

            // 8. 传递收藏相关数据
            // 检查是否已收藏
            boolean isFavorited = postFavoriteService.isPostFavorited(currentUser.getId(), id);
            model.addAttribute("isFavorited", isFavorited);

            // 获取收藏数量
            int favoriteCount = postFavoriteService.countFavoritesByPostId(id);
            model.addAttribute("favoriteCount", favoriteCount);
        }

        return "post-detail";
    }

    /**
     * 显示创建帖子的表单页面
     * @param sectionId 分区ID (通过URL参数传递)
     * @param model Model对象，用于向视图传递数据
     * @return 视图名称 "post-create"
     */
    @GetMapping("/create") // 处理 /post/create?sectionId={id} 的 GET 请求
    public String showCreatePostForm(@RequestParam Integer sectionId, Model model) {
        System.out.println("showCreatePostForm method called with sectionId: " + sectionId); // 调试日志
        model.addAttribute("sectionId", sectionId); // 将分区ID传递给视图
        model.addAttribute("post", new Post()); // 添加一个空的Post对象给表单使用
        return "post-create"; // 返回视图名称，对应 /WEB-INF/jsp/post-create.jsp
    }

    /**
     * 处理创建帖子的表单提交
     * @param post 帖子对象，从表单数据自动绑定
     * @param bindingResult 用于验证表单数据
     * @param session HTTP会话，用于获取当前登录用户ID
     * @param model Model对象，用于传递错误信息
     * @return 成功后重定向到帖子详情页，失败则返回创建页面
     */
    @PostMapping("/create") // 处理 /post/create 的 POST 请求
    public String createPost(@Valid Post post, BindingResult bindingResult, HttpSession session, Model model) {
        System.out.println("createPost method called!"); // 调试日志
        System.out.println("Post object: " + post);
        System.out.println("Binding result has errors: " + bindingResult.hasErrors());

        // 1. 验证用户是否登录
        User currentUser = (User) session.getAttribute("currentUser");
        System.out.println("Current user: " + currentUser);

        if (currentUser == null) {
            System.out.println("User is not logged in.");
            model.addAttribute("errorMessage", "请先登录");
            return "redirect:/user/login";
        }

        // 2. 设置帖子作者ID
        post.setUserId(currentUser.getId());
        System.out.println("Set userId: " + post.getUserId());

        // 3. 设置初始浏览次数
        post.setViewCount(0);

        // 4. 设置初始锁定状态
        post.setIsLocked(false);

        // 5. 验证表单数据 (标题和内容不能为空) - 仅验证用户输入
        if (bindingResult.hasErrors()) {
            System.out.println("Validation errors found.");
            model.addAttribute("sectionId", post.getSectionId());
            return "post-create"; // 返回创建页面，显示错误信息
        }

        // 6. 手动检查服务器设置的字段 (可选，作为额外安全检查)
        if (post.getUserId() == null || post.getSectionId() == null) {
            System.out.println("Error: userId or sectionId is null after setting.");
            model.addAttribute("errorMessage", "创建帖子失败: 内部错误，用户或分区信息缺失。");
            model.addAttribute("sectionId", post.getSectionId());
            return "post-create";
        }

        // --- 新增：解析并保存参数引用 ---
        String postContent = post.getContent();
        List<ParamReference> referencesToSave = parseAndCreateReferences(postContent, post.getId(), null); // postId 为当前帖子ID, replyId 为 null
        // --- /新增 ---

        // 7. 调用Service保存帖子
        try {
            System.out.println("Attempting to save post...");
            Post savedPost = postService.addPost(post);
            System.out.println("Post saved successfully with ID: " + savedPost.getId());

            // --- 新增：保存参数引用 ---
            if (!referencesToSave.isEmpty()) {
                for (ParamReference ref : referencesToSave) {
                    paramReferenceService.addReference(ref); // 假设 service 有 addReference 方法
                    System.out.println("Saved reference: " + ref);
                }
            }
            // --- /新增 ---

            // 8. 保存成功后，重定向到新帖子的详情页
            return "redirect:/post/" + savedPost.getId();
        } catch (Exception e) {
            System.out.println("Error saving post: " + e.getMessage());
            e.printStackTrace(); // 打印异常堆栈
            model.addAttribute("errorMessage", "创建帖子失败: " + e.getMessage());
            model.addAttribute("sectionId", post.getSectionId());
            return "post-create";
        }
    }

    /**
     * 显示编辑帖子的表单页面
     * @param id 帖子ID
     * @param session HTTP会话，用于验证当前用户是否为作者
     * @param model Model对象，用于向视图传递数据
     * @return 视图名称 "post-edit" 或重定向
     */
    @GetMapping("/{id}/edit") // 处理 /post/{id}/edit 的 GET 请求
    public String showEditPostForm(@PathVariable Integer id, HttpSession session, Model model) {
        System.out.println("showEditPostForm method called for ID: " + id); // 调试日志
        // 1. 获取帖子详情
        Post post = postService.getPostById(id);
        if (post == null) {
            // --- 修改：如果编辑时帖子不存在，也返回删除提示页面 ---
            System.out.println("Post with ID " + id + " not found for editing. Forwarding to deleted page."); // 调试日志
            return "post-deleted"; // 返回视图名称，对应 /WEB-INF/jsp/post-deleted.jsp
            // --- /修改 ---
        }

        // 2. 验证用户是否登录
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            model.addAttribute("errorMessage", "请先登录");
            return "redirect:/user/login";
        }

        // 3. 验证当前用户是否为帖子作者
        if (!post.getUserId().equals(currentUser.getId())) {
            model.addAttribute("errorMessage", "您没有权限编辑此帖子");
            // 可以重定向到帖子详情页，或返回错误页
            return "redirect:/post/" + id; // 重定向到帖子详情页
        }

        // 4. 将帖子信息传递给视图
        model.addAttribute("post", post);
        return "post-edit"; // 返回视图名称，对应 /WEB-INF/jsp/post-edit.jsp
    }

    /**
     * 处理编辑帖子的表单提交
     * @param id 帖子ID (从URL路径变量获取)
     * @param updatedPost 更新后的帖子对象，从表单数据自动绑定
     * @param bindingResult 用于验证表单数据
     * @param session HTTP会话，用于验证当前用户是否为作者
     * @param model Model对象，用于传递错误信息
     * @return 成功后重定向到帖子详情页，失败则返回编辑页面
     */
    @PostMapping("/{id}/edit") // 处理 /post/{id}/edit 的 POST 请求
    public String updatePost(@PathVariable Integer id, @Valid Post updatedPost, BindingResult bindingResult, HttpSession session, Model model) {
        System.out.println("updatePost method called for ID: " + id); // 调试日志
        System.out.println("Updated Post object: " + updatedPost);
        System.out.println("Binding result has errors: " + bindingResult.hasErrors());

        // 1. 验证用户是否登录
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            model.addAttribute("errorMessage", "请先登录");
            return "redirect:/user/login";
        }

        // 2. 获取原帖子
        Post existingPost = postService.getPostById(id);
        if (existingPost == null) {
            // --- 修改：如果更新时帖子不存在，也返回删除提示页面 ---
            System.out.println("Post with ID " + id + " not found for updating. Forwarding to deleted page."); // 调试日志
            return "post-deleted"; // 返回视图名称，对应 /WEB-INF/jsp/post-deleted.jsp
            // --- /修改 ---
        }

        // 3. 验证当前用户是否为帖子作者
        if (!existingPost.getUserId().equals(currentUser.getId())) {
            model.addAttribute("errorMessage", "您没有权限编辑此帖子");
            return "redirect:/post/" + id; // 重定向到帖子详情页
        }

        // 4. 验证表单数据 (标题和内容不能为空)
        if (bindingResult.hasErrors()) {
            System.out.println("Validation errors found.");
            model.addAttribute("post", updatedPost); // 重新传递更新后的对象给表单
            return "post-edit"; // 返回编辑页面，显示错误信息
        }

        // 5. 设置ID和不变的字段
        updatedPost.setId(id);
        updatedPost.setUserId(existingPost.getUserId()); // 保持原作者ID不变
        updatedPost.setSectionId(existingPost.getSectionId()); // 保持原分区ID不变
        updatedPost.setCreateTime(existingPost.getCreateTime()); // 保持创建时间不变
        updatedPost.setViewCount(existingPost.getViewCount()); // 保持浏览次数不变
        // updateTime 会在 update SQL 中自动更新

        // --- 新增：解析并保存参数引用 ---
        String postContent = updatedPost.getContent();
        // 先删除旧的引用 (可选，取决于业务逻辑)
        // paramReferenceService.deleteReferencesByPostId(id); // 假设 service 有此方法
        List<ParamReference> referencesToSave = parseAndCreateReferences(postContent, id, null); // postId 为当前帖子ID, replyId 为 null
        // --- /新增 ---

        // 6. 调用Service更新帖子
        try {
            System.out.println("Attempting to update post...");
            Post savedPost = postService.updatePost(updatedPost);
            System.out.println("Post updated successfully with ID: " + savedPost.getId());

            // --- 新增：保存参数引用 ---
            if (!referencesToSave.isEmpty()) {
                for (ParamReference ref : referencesToSave) {
                    paramReferenceService.addReference(ref); // 假设 service 有 addReference 方法
                    System.out.println("Saved reference: " + ref);
                }
            }
            // --- /新增 ---

            // 7. 更新成功后，重定向到帖子详情页
            return "redirect:/post/" + savedPost.getId();
        } catch (Exception e) {
            System.out.println("Error updating post: " + e.getMessage());
            e.printStackTrace(); // 打印异常堆栈
            model.addAttribute("errorMessage", "更新帖子失败: " + e.getMessage());
            model.addAttribute("post", updatedPost);
            return "post-edit";
        }
    }

    /**
     * 删除帖子
     * @param id 帖子ID
     * @param session HTTP会话，用于验证当前用户是否为作者或管理员
     * @param model Model对象，用于传递错误信息
     * @return 成功后重定向到分区列表页，失败则返回错误页或帖子详情页
     */
    @PostMapping("/{id}/delete") // 处理 /post/{id}/delete 的 POST 请求
    public String deletePost(@PathVariable Integer id, HttpSession session, Model model) {
        System.out.println("deletePost method called for ID: " + id); // 调试日志

        // 1. 验证用户是否登录
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            model.addAttribute("errorMessage", "请先登录");
            return "redirect:/user/login";
        }

        // 2. 获取原帖子
        Post existingPost = postService.getPostById(id);
        if (existingPost == null) {
            // --- 修改：如果删除时帖子不存在，也返回删除提示页面 ---
            System.out.println("Post with ID " + id + " not found for deletion. Forwarding to deleted page."); // 调试日志
            return "post-deleted"; // 返回视图名称，对应 /WEB-INF/jsp/post-deleted.jsp
            // --- /修改 ---
        }

        // 3. 验证当前用户是否为帖子作者 或 管理员
        boolean isAuthor = existingPost.getUserId().equals(currentUser.getId());
        boolean isAdmin = "ADMIN".equals(currentUser.getRole()); // 检查用户角色

        if (!isAuthor && !isAdmin) { // 只有作者或管理员才能删除
            model.addAttribute("errorMessage", "您没有权限删除此帖子");
            return "redirect:/post/" + id; // 重定向到帖子详情页
        }

        // 4. 调用Service删除帖子（软删除）
        try {
            System.out.println("Attempting to delete post...");
            boolean deleted = postService.deletePost(id);
            if (deleted) {
                System.out.println("Post deleted successfully with ID: " + id);
                // 5. 删除成功后，重定向到帖子所属分区的列表页
                return "redirect:/forum/section/" + existingPost.getSectionId() + "/posts";
            } else {
                // 删除失败（例如，数据库操作返回0行影响）
                model.addAttribute("errorMessage", "删除帖子失败，可能帖子已被删除。");
                return "redirect:/forum/section/" + existingPost.getSectionId() + "/posts"; // 或者返回错误页
            }
        } catch (Exception e) {
            System.out.println("Error deleting post: " + e.getMessage());
            e.printStackTrace(); // 打印异常堆栈
            model.addAttribute("errorMessage", "删除帖子失败: " + e.getMessage());
            return "redirect:/post/" + id; // 或者返回错误页
        }
    }

    /**
     * 处理创建回复的表单提交
     * @param postId 帖子ID (从URL路径变量获取)
     * @param reply 回复对象，从表单数据自动绑定
     * @param bindingResult 用于验证表单数据
     * @param session HTTP会话，用于获取当前登录用户ID
     * @param model Model对象，用于传递错误信息
     * @return 成功后重定向到帖子详情页，失败则返回帖子详情页并显示错误
     */
    @PostMapping("/{postId}/reply")
    public String createReply(@PathVariable Integer postId, @Valid Reply reply, BindingResult bindingResult, HttpSession session, Model model) {
        System.out.println("createReply method called for Post ID: " + postId);

        // 1. 验证用户是否登录
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            System.out.println("User is not logged in.");
            model.addAttribute("errorMessage", "请先登录");
            return "redirect:/user/login";
        }

        // 2. 验证帖子是否存在
        Post post = postService.getPostById(postId);
        if (post == null) {
            System.out.println("Post not found for ID: " + postId + " when replying. Forwarding to deleted page.");
            return "post-deleted";
        }

        // --- 检查帖子是否被锁定 ---
        if (post.getIsLocked() != null && post.getIsLocked() &&
                !"ADMIN".equals(currentUser.getRole())) {
            model.addAttribute("errorMessage", "此帖子已被锁定，只有管理员可以回复。");
            // 重新加载帖子详情和回复列表
            List<Reply> replies = replyService.getRepliesByPostId(postId);
            model.addAttribute("post", post);
            model.addAttribute("replies", replies);
            return "post-detail";
        }

        // 3. 设置回复的帖子ID和用户ID
        reply.setPostId(postId);
        reply.setUserId(currentUser.getId());

        // 4. 验证表单数据
        if (bindingResult.hasErrors()) {
            System.out.println("Validation errors found for reply.");
            List<Reply> replies = replyService.getRepliesByPostId(postId);
            model.addAttribute("post", post);
            model.addAttribute("replies", replies);
            model.addAttribute("errorMessage", "回复内容不能为空。");
            return "post-detail";
        }

        // --- 新增：先保存回复，获取ID，再解析并保存参数引用 ---
        try {
            System.out.println("Attempting to save reply...");
            Reply savedReply = replyService.addReply(reply); // 此时 savedReply.getId() 已经是新生成的ID
            System.out.println("Reply saved successfully with ID: " + savedReply.getId());

            // 解析内容中的引用
            String replyContent = savedReply.getContent(); // 使用保存后的回复内容
            List<ParamReference> referencesToSave = parseAndCreateReferences(replyContent, null, savedReply.getId()); // postId 为 null, replyId 为新回复ID

            if (!referencesToSave.isEmpty()) {
                for (ParamReference ref : referencesToSave) {
                    paramReferenceService.addReference(ref);
                    System.out.println("Saved reference for reply: " + ref);
                }
            }
            // --- /新增 ---

            // 6. 保存成功后，重定向到帖子详情页
            return "redirect:/post/" + postId; // 重定向到帖子详情页
        } catch (Exception e) {
            System.out.println("Error saving reply: " + e.getMessage());
            e.printStackTrace(); // 打印异常堆栈
            // 如果保存失败，需要重新加载帖子详情和回复列表
            List<Reply> replies = replyService.getRepliesByPostId(postId);
            model.addAttribute("post", post);
            model.addAttribute("replies", replies);
            model.addAttribute("errorMessage", "回复失败: " + e.getMessage());
            return "post-detail"; // 返回帖子详情页，显示错误
        }
    }

    // ---解析内容并创建 ParamReference 对象 ---
    private List<ParamReference> parseAndCreateReferences(String content, Integer postId, Integer replyId) {
        List<ParamReference> references = new ArrayList<>();
        // 正则表达式匹配 [表名:ID] 格式
        // [a-zA-Z_]+ 匹配表名 (字母和下划线)
        // \d+ 匹配ID (数字)
        String regex = "\\[([a-zA-Z_]+):(\\d+)\\]";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(content);

        while (matcher.find()) {
            String tableName = matcher.group(1); // 捕获组1：表名
            Integer id = Integer.parseInt(matcher.group(2)); // 捕获组2：ID

            // 验证表名是否合法 (可选，但推荐)
            if (isValidTableName(tableName)) {
                ParamReference ref = new ParamReference();
                ref.setPostId(postId);
                ref.setReplyId(replyId);
                ref.setParamTable(tableName);
                ref.setParamId(id);
                // 可以在这里查询数据库获取硬件名称作为 referenceText (可选)
                // ref.setReferenceText(...);
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
     * 锁定帖子 (仅管理员)
     */
    @PostMapping("/{id}/lock")
    public String lockPost(@PathVariable Integer id, HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            model.addAttribute("errorMessage", "您没有权限执行此操作");
            return "redirect:/post/" + id;
        }

        boolean locked = postService.lockPost(id);
        if (!locked) {
            model.addAttribute("errorMessage", "锁定帖子失败，帖子可能不存在");
        }
        return "redirect:/post/" + id;
    }

    /**
     * 解锁帖子 (仅管理员)
     */
    @PostMapping("/{id}/unlock")
    public String unlockPost(@PathVariable Integer id, HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            model.addAttribute("errorMessage", "您没有权限执行此操作");
            return "redirect:/post/" + id;
        }

        boolean unlocked = postService.unlockPost(id);
        if (!unlocked) {
            model.addAttribute("errorMessage", "解锁帖子失败，帖子可能不存在");
        }
        return "redirect:/post/" + id;
    }

    /**
     * 置顶帖子 (仅管理员)
     * @param level 置顶级别，0-9
     */
    @PostMapping("/{id}/pin")
    public String pinPost(@PathVariable Integer id,
                          @RequestParam(defaultValue = "1") Integer level,
                          HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            model.addAttribute("errorMessage", "您没有权限执行此操作");
            return "redirect:/post/" + id;
        }

        boolean pinned = postService.pinPost(id, level);
        if (!pinned) {
            model.addAttribute("errorMessage", "置顶帖子失败，帖子可能不存在");
        }
        return "redirect:/post/" + id;
    }

    /**
     * 取消置顶帖子 (仅管理员)
     */
    @PostMapping("/{id}/unpin")
    public String unpinPost(@PathVariable Integer id, HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            model.addAttribute("errorMessage", "您没有权限执行此操作");
            return "redirect:/post/" + id;
        }

        boolean unpinned = postService.unpinPost(id);
        if (!unpinned) {
            model.addAttribute("errorMessage", "取消置顶失败，帖子可能不存在");
        }
        return "redirect:/post/" + id;
    }

    // 收藏/取消收藏帖子 (AJAX请求)
    @PostMapping("/{id}/toggle-favorite")
    @ResponseBody
    public Map<String, Object> toggleFavorite(@PathVariable Integer id, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", false);

        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.put("message", "请先登录");
            return response;
        }

        try {
            // 检查是否已收藏
            boolean isFavorited = postFavoriteService.isPostFavorited(currentUser.getId(), id);

            if (isFavorited) {
                // 取消收藏
                boolean result = postFavoriteService.cancelFavorite(currentUser.getId(), id);
                if (result) {
                    response.put("success", true);
                    response.put("isFavorited", false);
                    response.put("message", "已取消收藏");
                    response.put("favoriteCount", postFavoriteService.countFavoritesByPostId(id));
                    return response;
                }
            } else {
                // 收藏帖子
                boolean result = postFavoriteService.favoritePost(currentUser.getId(), id);
                if (result) {
                    response.put("success", true);
                    response.put("isFavorited", true);
                    response.put("message", "收藏成功");
                    response.put("favoriteCount", postFavoriteService.countFavoritesByPostId(id));
                    return response;
                }
            }

            response.put("message", "操作失败");
            return response;
        } catch (Exception e) {
            response.put("message", "操作失败: " + e.getMessage());
            return response;
        }
    }

    @GetMapping("/detail/{id}")
    public String postDetail(
            @PathVariable Integer id,
            Model model,
            HttpSession session) {

        // 1. 检查帖子是否存在
        Post post = postService.getPostById(id);
        if (post == null) {
            model.addAttribute("errorMessage", "帖子不存在或已被删除");
            return "error";
        }

        // 2. 增加浏览量
        postService.incrementViewCount(id);

        // 3. 获取帖子回复 - 修复：使用 replyService 而不是 postService
        List<Reply> replies = replyService.getRepliesByPostId(id);

        // 4. 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");

        // 5. 添加到模型
        model.addAttribute("post", post);
        model.addAttribute("replies", replies);
        model.addAttribute("currentUser", currentUser);

        return "post/detail";
    }
}
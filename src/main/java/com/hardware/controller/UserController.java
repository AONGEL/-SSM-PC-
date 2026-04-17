package com.hardware.controller;

import com.hardware.entity.*;
import com.hardware.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private PostFavoriteService postFavoriteService;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private PostService postService;

    @Autowired
    private ReplyService replyService;

    @Autowired
    private UserService userService;

    @Autowired
    private CertificationApplicationService certificationApplicationService;

    @GetMapping("/login")
    public String showLoginPage() {
        return "user/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password,
                        HttpSession session, Model model) {
        User user = userService.login(username, password);
        if (user != null) {
            session.setAttribute("currentUser", user);
            return "redirect:/";
        } else {
            model.addAttribute("errorMessage", "用户名或密码错误");
            return "user/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/register")
    public String showRegisterPage() {
        return "user/register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username, @RequestParam String password, Model model) {
        try {
            User newUser = userService.register(username, password);
            model.addAttribute("successMessage", "注册成功，请登录");
            return "redirect:/user/login";
        } catch (IllegalArgumentException e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "user/register";
        }
    }

    @GetMapping("/profile")
    public String showProfile(
            @RequestParam(defaultValue = "1") Integer pagePosts,
            @RequestParam(defaultValue = "1") Integer pageReplies,
            @RequestParam(defaultValue = "5") Integer pageSize,
            Model model,
            HttpSession session) {

        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login";
        }

        try {
            User user = userService.getUserById(currentUser.getId());
            if (user == null) {
                session.invalidate();
                model.addAttribute("errorMessage", "用户信息不存在，请重新登录");
                return "redirect:/user/login";
            }

            int totalPosts = postService.countPostsByUserId(currentUser.getId());
            int totalPagesPosts = (int) Math.ceil((double) totalPosts / pageSize);
            pagePosts = Math.max(1, Math.min(pagePosts, totalPagesPosts));
            List<Post> userPosts = postService.getPostsByUserIdWithPagination(currentUser.getId(), pagePosts, pageSize);

            int totalReplies = replyService.countRepliesByUserId(currentUser.getId());
            int totalPagesReplies = (int) Math.ceil((double) totalReplies / pageSize);
            pageReplies = Math.max(1, Math.min(pageReplies, totalPagesReplies));
            List<Reply> userReplies = replyService.getRepliesByUserIdWithPagination(currentUser.getId(), pageReplies, pageSize);

            int startPostIndex = (pagePosts - 1) * pageSize + 1;
            int endPostIndex = Math.min(startPostIndex + userPosts.size() - 1, totalPosts);
            int startReplyIndex = (pageReplies - 1) * pageSize + 1;
            int endReplyIndex = Math.min(startReplyIndex + userReplies.size() - 1, totalReplies);

            // 获取认证申请 - 按提交时间排序取最新
            List<CertificationApplication> applications = certificationApplicationService.getApplicationsByUserId(currentUser.getId());
            CertificationApplication latestApplication = null;
            if (applications != null && !applications.isEmpty()) {
                applications.sort((a1, a2) -> a2.getSubmittedAt().compareTo(a1.getSubmittedAt()));
                latestApplication = applications.get(0);
            }

            model.addAttribute("latestCertificationApplication", latestApplication);

            // 获取未读通知数量
            int unreadNotificationCount = notificationService.countUnreadNotifications(currentUser.getId());

            // 获取收藏总数
            int totalFavorites = postFavoriteService.countFavoritesByUserId(currentUser.getId());

            model.addAttribute("user", user);
            model.addAttribute("userPosts", userPosts);
            model.addAttribute("userReplies", userReplies);
            model.addAttribute("latestCertificationApplication", latestApplication);
            model.addAttribute("unreadNotificationCount", unreadNotificationCount);
            model.addAttribute("totalFavorites", totalFavorites);

            model.addAttribute("currentPagePosts", pagePosts);
            model.addAttribute("totalPagesPosts", totalPagesPosts);
            model.addAttribute("totalPosts", totalPosts);
            model.addAttribute("startPostIndex", startPostIndex);
            model.addAttribute("endPostIndex", endPostIndex);

            model.addAttribute("currentPageReplies", pageReplies);
            model.addAttribute("totalPagesReplies", totalPagesReplies);
            model.addAttribute("totalReplies", totalReplies);
            model.addAttribute("startReplyIndex", startReplyIndex);
            model.addAttribute("endReplyIndex", endReplyIndex);

            return "user/profile";

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "加载个人资料时发生错误: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/edit-avatar")
    public String showEditAvatarPage(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login";
        }
        return "user/edit-avatar";
    }

    @PostMapping("/update-avatar")
    @ResponseBody
    public Map<String, Object> updateAvatar(@RequestParam("avatarPath") String avatarPath,
                                            HttpSession session,
                                            Model model) {
        Map<String, Object> response = new HashMap<>();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "用户未登录");
            return response;
        }
        try {
            // 校验头像路径
            if (avatarPath == null || !avatarPath.matches("^/static/avatar/([1-9]|10)\\.png$")) {
                response.put("success", false);
                response.put("message", "无效的头像路径：" + avatarPath);
                return response;
            }

            // 设置新头像
            currentUser.setAvatar(avatarPath);

            // 使用 updateUserInfo 的返回值更新 Session
            User updatedUser = userService.updateUserInfo(currentUser);
            session.setAttribute("currentUser", updatedUser);

            response.put("success", true);
            response.put("message", "头像更新成功");
            response.put("avatarPath", avatarPath);
            return response;
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "更新头像失败：" + e.getMessage());
            return response;
        }
    }

    @GetMapping("/edit-username")
    public String showEditUsernamePage(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login";
        }

        User userForm = new User();
        userForm.setUsername(currentUser.getUsername());
        model.addAttribute("user", userForm);
        model.addAttribute("currentUser", currentUser);
        return "user/edit-username";
    }

    @PostMapping("/update-username")
    public String updateUsername(@Valid User user, @RequestParam("password") String password,
                                 BindingResult bindingResult, HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login";
        }

        if (!user.getUsername().equals(currentUser.getUsername())) {
            User existingUser = userService.getUserByUsername(user.getUsername());
            if (existingUser != null) {
                model.addAttribute("errorMessage", "该用户名已被使用，请选择其他用户名");
                model.addAttribute("currentUser", currentUser);
                return "user/edit-username";
            }
        }

        String currentPasswordHash = currentUser.getPassword();
        String enteredPasswordHash = encryptPassword(password);

        if (!currentPasswordHash.equals(enteredPasswordHash)) {
            model.addAttribute("passwordError", "密码不正确");
            model.addAttribute("currentUser", currentUser);
            return "user/edit-username";
        }

        try {
            currentUser.setUsername(user.getUsername());
            userService.updateUserInfo(currentUser);
            session.setAttribute("currentUser", currentUser);

            model.addAttribute("successMessage", "用户名更新成功");
            return "redirect:/user/profile";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "更新用户名失败: " + e.getMessage());
            model.addAttribute("currentUser", currentUser);
            return "user/edit-username";
        }
    }

    @GetMapping("/edit-password")
    public String showEditPasswordPage(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login";
        }
        return "user/edit-password";
    }

    @PostMapping("/update-password")
    public String updatePassword(
            @RequestParam("oldPassword") String oldPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            HttpSession session, Model model
    ) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login";
        }

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("confirmPasswordError", "两次输入的密码不一致");
            return "user/edit-password";
        }

        if (newPassword.length() < 8) {
            model.addAttribute("newPasswordError", "新密码至少需要8个字符");
            return "user/edit-password";
        }

        String currentPasswordHash = currentUser.getPassword();
        String oldPasswordHash = encryptPassword(oldPassword);

        if (!currentPasswordHash.equals(oldPasswordHash)) {
            model.addAttribute("oldPasswordError", "当前密码不正确");
            return "user/edit-password";
        }

        try {
            User updatedUser = userService.updatePassword(currentUser.getId(), oldPassword, newPassword);
            session.setAttribute("currentUser", updatedUser);
            model.addAttribute("successMessage", "密码更新成功");
            return "redirect:/user/profile";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "密码更新失败: " + e.getMessage());
            return "user/edit-password";
        }
    }

    @GetMapping("/admin/user-list")
    public String showUserList(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/";
        }
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "admin/user-list";
    }

    private String encryptPassword(String plainPassword) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashBytes = md.digest(plainPassword.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("MD5 algorithm not available", e);
        }
    }

    @GetMapping("/notifications")
    public String getNotifications(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login";
        }

        // 使用已实现的方法
        List<Notification> notifications = notificationService.getUserNotificationsWithPostInfo(currentUser.getId());
        int unreadCount = notificationService.countUnreadNotifications(currentUser.getId());

        model.addAttribute("notifications", notifications);
        model.addAttribute("unreadCount", unreadCount);
        model.addAttribute("user", currentUser);

        return "user/notifications";
    }

    @GetMapping("/notifications/{id}/read")
    public String markNotificationAsRead(@PathVariable Integer id, HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login";
        }

        Notification notification = notificationService.getNotificationById(id);
        if (notification == null || !notification.getRecipientId().equals(currentUser.getId())) {
            model.addAttribute("errorMessage", "通知不存在或无权操作");
            return "redirect:/user/notifications";
        }

        notificationService.markAsRead(id);
        return "redirect:/user/notifications";
    }

    @GetMapping("/notifications/{id}/delete")
    public String deleteNotification(@PathVariable Integer id, HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login";
        }

        Notification notification = notificationService.getNotificationById(id);
        if (notification == null || !notification.getRecipientId().equals(currentUser.getId())) {
            model.addAttribute("errorMessage", "通知不存在或无权操作");
            return "redirect:/user/notifications";
        }

        notificationService.deleteNotification(id);
        return "redirect:/user/notifications";
    }

    @GetMapping("/favorites")
    public String getFavorites(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login";
        }

        List<PostFavorite> favorites = postFavoriteService.getFavoritesByUserId(currentUser.getId(), 1, 10);
        int totalFavorites = postFavoriteService.countFavoritesByUserId(currentUser.getId());

        model.addAttribute("favorites", favorites);
        model.addAttribute("totalFavorites", totalFavorites);
        model.addAttribute("user", currentUser);

        return "user/favorites";
    }

    /**
     * 简化：直接删除所有通知，而不是标记为已读
     */
    @GetMapping("/notifications/delete-all")
    public String deleteAllNotifications(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login";
        }

        try {
            // 调用已实现的方法
            notificationService.deleteAllNotifications(currentUser.getId());
            session.setAttribute("successMessage", "已成功清空所有通知");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "清空通知失败: " + e.getMessage());
        }

        return "redirect:/user/notifications";
    }
}
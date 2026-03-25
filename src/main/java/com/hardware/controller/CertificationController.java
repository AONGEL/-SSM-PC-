// src/main/java/com/hardware/controller/CertificationController.java
package com.hardware.controller;

import com.hardware.entity.CertificationApplication;
import com.hardware.entity.CertificationQuestion;
import com.hardware.entity.User;
import com.hardware.service.CertificationApplicationService;
import com.hardware.service.CertificationQuestionService;
import com.hardware.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

@Controller
@RequestMapping("/certification") // 所有请求路径以 /certification 开头
public class CertificationController {

    @Autowired
    private CertificationApplicationService certificationApplicationService;

    @Autowired
    private CertificationQuestionService certificationQuestionService;

    @Autowired
    private UserService userService; // 注入UserService

    // --- 移除：公共方法 refreshCurrentUserInSession ---
    // 为了避免在非 profile 页面刷新过时信息，暂时移除此方法
    // 如果需要在其他地方刷新，可以单独实现逻辑
    // --- /移除 ---

    /**
     * 显示认证说明页面
     */
    @GetMapping("/info")
    public String showCertificationInfo(HttpSession session, Model model) {
        // --- 移除：调用 refreshCurrentUserInSession ---
        // --- /移除 ---

        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login";
        }

        // --- 修改：只检查是否存在 *待审核* 的申请 ---
        List<CertificationApplication> existingPendingApps = certificationApplicationService.getApplicationsByUserIdAndStatus(currentUser.getId(), "pending");
        if (!existingPendingApps.isEmpty()) {
            // 如果有待审核的申请，重定向到申请状态页或提示信息
            model.addAttribute("existingApplication", existingPendingApps.get(0)); // 简单处理，取第一个
            return "user/certification-status"; // 需要创建这个页面
        }
        // --- /修改 ---

        // 如果没有待审核的申请，检查是否有 *被拒绝* 或 *待商议* 的申请
        // 这些状态不阻止用户重新申请，所以继续往下执行
        List<CertificationApplication> existingApps = certificationApplicationService.getApplicationsByUserId(currentUser.getId());
        CertificationApplication latestRejectedOrDiscussion = null;
        for (CertificationApplication app : existingApps) {
            if ("rejected".equals(app.getApplicationStatus()) || "pending_discussion".equals(app.getApplicationStatus())) {
                latestRejectedOrDiscussion = app; // 找到最后一个符合条件的
            }
        }
        if (latestRejectedOrDiscussion != null) {
            // 将被拒绝或待商议的申请信息传递给 JSP 页面，用于显示状态
            model.addAttribute("latestRejectedOrDiscussionApplication", latestRejectedOrDiscussion);
        }

        return "user/certification-info"; // 返回认证说明页面
    }

    /**
     * 显示认证答题页面
     */
    @GetMapping("/apply")
    public String showCertificationExam(HttpSession session, Model model) {
        // --- 移除：调用 refreshCurrentUserInSession ---
        // --- /移除 ---

        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login";
        }

        // --- 修改：只检查是否存在 *待审核* (pending) 的申请 ---
        List<CertificationApplication> existingPendingApps = certificationApplicationService.getApplicationsByUserIdAndStatus(currentUser.getId(), "pending");
        if (!existingPendingApps.isEmpty()) {
            // 如果有待审核的申请，重定向到申请状态页或提示信息
            model.addAttribute("existingApplication", existingPendingApps.get(0));
            return "user/certification-status";
        }
        // --- /修改 ---

        // 如果没有待审核的申请，可以继续答题流程
        // 获取活跃的认证题目
        List<CertificationQuestion> fillBlankQuestions = certificationQuestionService.getActiveQuestionsByType("fill_blank");
        List<CertificationQuestion> openEndedQuestions = certificationQuestionService.getActiveQuestionsByType("open_ended");

        model.addAttribute("fillBlankQuestions", fillBlankQuestions);
        model.addAttribute("openEndedQuestions", openEndedQuestions);
        model.addAttribute("startTime", new Date().getTime()); // 传递开始时间戳给前端计时

        return "user/certification-exam"; // 返回答题页面
    }

    /**
     * 处理认证申请提交
     */
    @PostMapping("/apply")
    @ResponseBody // 返回 JSON 响应，或者可以返回页面重定向
    public String submitCertificationApplication(@RequestBody CertificationApplication application, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login";
        }

        // 设置用户ID和提交时间
        application.setUserId(currentUser.getId());
        // application.setSubmittedAt(new Date()); // MyBatis会自动处理
        // application.setExamDuration(...); // 由前端传递
        application.setApplicationStatus("pending");

        try {
            CertificationApplication savedApplication = certificationApplicationService.submitApplication(application);
            // 提交成功，返回成功页面的路径 (或者返回JSON表示成功)
            return "redirect:/certification/success"; // 这需要一个对应的处理方法
        } catch (Exception e) {
            e.printStackTrace();
            // 提交失败，返回失败页面的路径 (或者返回JSON表示失败)
            return "redirect:/certification/failure";
        }
    }

    /**
     * 认证申请提交成功后跳转的页面
     */
    @GetMapping("/success")
    public String showSuccessPage() {
        return "user/certification-success"; // 需要创建这个页面
    }

    /**
     * 认证申请提交失败后跳转的页面
     */
    @GetMapping("/failure")
    public String showFailurePage() {
        return "user/certification-failure"; // 需要创建这个页面
    }

    // --- 新增：管理员查看所有认证申请列表 ---
    /**
     * 管理员：查看所有认证申请列表 (需要在 Service 中实现方法)
     */
    @GetMapping("/admin/applications")
    public String viewAllApplications(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/"; // 非管理员重定向
        }

        // 获取所有申请
        List<CertificationApplication> applications = certificationApplicationService.getAllApplications(); // 假设 Service 有此方法

        // 为了在页面上显示用户名，需要将用户名加载到 Application 对象中
        for (CertificationApplication app : applications) {
            User applicant = userService.getUserById(app.getUserId()); // 调用UserService获取用户信息
            if (applicant != null) {
                app.setApplicantUsername(applicant.getUsername()); // 设置用户名 (修正：使用 setApplicantUsername)
            } else {
                app.setApplicantUsername("Unknown User (ID: " + app.getUserId() + ")"); // 如果用户不存在
            }
        }

        model.addAttribute("applications", applications);
        return "admin/certification-applications"; // 返回管理员认证申请列表页面
    }
    // --- /新增 ---

    /**
     * 管理员：查看待审核列表 (旧方法，可能保留用于特定用途)
     * @deprecated 使用 {@link #viewAllApplications(HttpSession, Model)} 替代
     */
    @Deprecated
    @GetMapping("/admin/review")
    public String showReviewList(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            // 或者返回错误页面
            return "redirect:/"; // 非管理员重定向到首页
        }

        List<CertificationApplication> pendingApps = certificationApplicationService.getApplicationsByStatus("pending");

        // 获取原始问题列表
        List<CertificationQuestion> fillBlankQuestions = certificationQuestionService.getActiveQuestionsByType("fill_blank");
        List<CertificationQuestion> openEndedQuestions = certificationQuestionService.getActiveQuestionsByType("open_ended");

        // --- 新增：获取用户信息 ---
        List<Map<String, Object>> appsWithUserInfo = new ArrayList<>(); // 使用ArrayList和HashMap
        for (CertificationApplication app : pendingApps) {
            Map<String, Object> appInfo = new HashMap<>(); // 使用HashMap
            appInfo.put("application", app);

            User applicant = userService.getUserById(app.getUserId());
            if (applicant != null) {
                appInfo.put("applicantUsername", applicant.getUsername());
            } else {
                appInfo.put("applicantUsername", "Unknown User (ID: " + app.getUserId() + ")"); // 如果用户不存在
            }
            appsWithUserInfo.add(appInfo);
        }
        // --- /新增 ---

        model.addAttribute("appsWithUserInfo", appsWithUserInfo); // 传递包含用户信息的列表
        model.addAttribute("fillBlankQuestions", fillBlankQuestions); // 传递填空题
        model.addAttribute("openEndedQuestions", openEndedQuestions); // 传递简答题

        return "admin/certification-review"; // 返回管理员审核页面
    }

    /**
     * 管理员：处理认证申请 (通过/不通过/待商议) - 适用于 /admin/review 页面
     * @deprecated 使用 {@link #approveApplication(Integer, String, HttpSession)}, {@link #rejectApplication(Integer, String, HttpSession)}, {@link #markAsPendingDiscussion(Integer, String, HttpSession)} 替代
     */
    @Deprecated
    @PostMapping("/admin/review/{id}") // 确保路径与 fetch URL 一致
    public String processApplication(@PathVariable Integer id, @RequestParam String status, @RequestParam(required = false) String remarks, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/"; // 非管理员重定向
        }

        // 注意：这个方法调用的 updateApplicationStatus 也需要修改返回类型
        certificationApplicationService.updateApplicationStatus(id, status, remarks);
        return "redirect:/certification/admin/review"; // 重定向回审核列表
    }

    // --- 新增：管理员批准认证申请 ---
    /**
     * 管理员批准认证申请
     */
    @PostMapping("/admin/approve/{id}")
    @ResponseBody // 返回简单的成功/失败信息
    public String approveApplication(@PathVariable Integer id, @RequestParam(required = false) String remarks, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "unauthorized"; // 或 JSON {"status": "error", "message": "Unauthorized"}
        }

        System.out.println("Controller: approveApplication called for application ID: " + id + ", remarks: " + remarks); // 调试日志

        try {
            // 调用 Service 更新状态，并更新用户角色 (修正：使用返回的 boolean)
            boolean approved = certificationApplicationService.updateApplicationStatus(id, "approved", remarks);
            if (approved) {
                System.out.println("Controller: Successfully approved application ID: " + id); // 调试日志
                return "success"; // 或 JSON {"status": "success"}
            } else {
                System.err.println("Controller: Failed to approve application ID: " + id); // 调试日志
                return "failed"; // 或 JSON {"status": "error", "message": "Failed to approve"}
            }
        } catch (Exception e) {
            System.err.println("Controller: Exception during approval of application ID " + id + ": " + e.getMessage()); // 调试日志
            e.printStackTrace();
            return "error"; // 或 JSON {"status": "error", "message": "An error occurred"}
        }
    }
    // --- /新增 ---

    // --- 新增：管理员拒绝认证申请 ---
    /**
     * 管理员拒绝认证申请
     */
    @PostMapping("/admin/reject/{id}")
    @ResponseBody
    public String rejectApplication(@PathVariable Integer id, @RequestParam String remarks, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "unauthorized";
        }

        System.out.println("Controller: rejectApplication called for application ID: " + id + ", remarks: " + remarks); // 调试日志

        try {
            // 调用 Service 更新状态 (修正：使用返回的 boolean)
            boolean rejected = certificationApplicationService.updateApplicationStatus(id, "rejected", remarks);
            if (rejected) {
                System.out.println("Controller: Successfully rejected application ID: " + id); // 调试日志
                return "success";
            } else {
                System.err.println("Controller: Failed to reject application ID: " + id); // 调试日志
                return "failed";
            }
        } catch (Exception e) {
            System.err.println("Controller: Exception during rejection of application ID " + id + ": " + e.getMessage()); // 调试日志
            e.printStackTrace();
            return "error";
        }
    }
    // --- /新增 ---

    // --- 新增：管理员将认证申请标记为待商议 ---
    /**
     * 管理员将认证申请标记为待商议
     */
    @PostMapping("/admin/pending_discussion/{id}")
    @ResponseBody
    public String markAsPendingDiscussion(@PathVariable Integer id, @RequestParam(required = false) String remarks, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "unauthorized";
        }

        System.out.println("Controller: markAsPendingDiscussion called for application ID: " + id + ", remarks: " + remarks); // 调试日志

        try {
            // 调用 Service 更新状态 (修正：使用返回的 boolean)
            boolean marked = certificationApplicationService.updateApplicationStatus(id, "pending_discussion", remarks);
            if (marked) {
                System.out.println("Controller: Successfully marked application ID: " + id + " as pending discussion"); // 调试日志
                return "success";
            } else {
                System.err.println("Controller: Failed to mark application ID: " + id + " as pending discussion"); // 调试日志
                return "failed";
            }
        } catch (Exception e) {
            System.err.println("Controller: Exception during marking application ID " + id + " as pending discussion: " + e.getMessage()); // 调试日志
            e.printStackTrace();
            return "error";
        }
    }
    // --- /新增 ---

    // --- 新增：管理员将认证申请重置为待审核 ---
    /**
     * 管理员将认证申请重置为待审核
     */
    @PostMapping("/admin/reset_to_pending/{id}")
    @ResponseBody
    public String resetToPending(@PathVariable Integer id, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            return "unauthorized";
        }

        System.out.println("Controller: resetToPending called for application ID: " + id); // 调试日志

        try {
            // 调用 Service 重置申请状态 (修正：使用返回的 boolean)
            boolean reset = certificationApplicationService.resetApplicationToPending(id); // 假设 Service 有此方法

            if (reset) {
                System.out.println("Controller: Successfully reset application ID: " + id + " to pending"); // 调试日志
                return "success";
            } else {
                System.err.println("Controller: Failed to reset application ID: " + id + " to pending"); // 调试日志
                return "failed";
            }
        } catch (Exception e) {
            System.err.println("Controller: Exception during resetting application ID " + id + " to pending: " + e.getMessage()); // 调试日志
            e.printStackTrace();
            return "error";
        }
    }
    // --- /新增 ---

    /**
     * 管理员：撤销认证
     */
    @PostMapping("/admin/revoke/{userId}") // 确保路径是 /certification/admin/revoke/{userId}
    @ResponseBody // 返回 JSON 或简单字符串
    public String revokeCertification(@PathVariable Integer userId, @RequestParam(required = false) String reason, HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            // 返回错误 JSON 或字符串
            return "{\"status\":\"error\", \"message\":\"Unauthorized\"}"; // 示例 JSON
            // 或者 return "unauthorized";
        }

        System.out.println("Controller: revokeCertification called for userId: " + userId + ", reason: " + reason); // 添加日志

        boolean revoked = certificationApplicationService.revokeCertification(userId, reason);
        if (revoked) {
            System.out.println("Controller: Successfully revoked certification for userId: " + userId); // 添加日志
            return "{\"status\":\"success\"}"; // 示例 JSON
            // 或者 return "success";
        } else {
            System.out.println("Controller: Failed to revoke certification for userId: " + userId); // 添加日志
            return "{\"status\":\"error\", \"message\":\"Failed to revoke\"}"; // 示例 JSON
            // 或者 return "failed";
        }
    }

}
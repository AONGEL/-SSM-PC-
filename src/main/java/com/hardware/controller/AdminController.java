// src/main/java/com/hardware/controller/AdminController.java
package com.hardware.controller;

import com.hardware.entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * 管理员控制器
 * 提供管理后台的入口、主页及导航功能。
 */
@Controller
@RequestMapping("/admin") // 所有请求路径以 /admin 开头
public class AdminController {

    /**
     * 显示管理后台主页
     * @param session HTTP会话，用于验证管理员身份
     * @param model Model对象，用于向视图传递数据
     * @return 管理后台主页视图名
     */
    @GetMapping // 处理 /admin 的 GET 请求，即管理后台主页
    public String adminHome(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");

        // 检查用户是否登录且角色为 ADMIN
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            // 非管理员或未登录，重定向到首页或其他页面
            return "redirect:/";
        }

        // 可以在这里添加一些管理后台首页需要的数据，例如统计信息
        // model.addAttribute("statistics", someStatisticsObject);

        return "admin/index"; // 返回视图名称，对应 /WEB-INF/jsp/admin/index.jsp
    }
}
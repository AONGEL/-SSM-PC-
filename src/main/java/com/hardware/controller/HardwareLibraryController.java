// src/main/java/com/hardware/controller/HardwareLibraryController.java
package com.hardware.controller;


import com.hardware.entity.*;
import com.hardware.service.HardwareLibraryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/hardware-library") // 统一的请求路径前缀
public class HardwareLibraryController {

    @Autowired
    private HardwareLibraryService hardwareLibraryService;

    // --- 公开浏览页面 ---
    @GetMapping // 显示硬件库首页，按类型分类展示
    public String showHardwareLibrary(Model model) {
        // 获取所有类型的硬件信息
        List<CpuInfo> cpus = hardwareLibraryService.getAllCpus();
        List<GpuInfo> gpus = hardwareLibraryService.getAllGpus();
        List<MotherboardInfo> motherboards = hardwareLibraryService.getAllMotherboards();

        model.addAttribute("cpus", cpus);
        model.addAttribute("gpus", gpus);
        model.addAttribute("motherboards", motherboards);

        return "hardware/hardware-library"; // 返回视图名称
    }


    // --- 公开搜索接口 ---
    @GetMapping("/search")
    @ResponseBody // 返回JSON
    public List<?> searchHardware(@RequestParam String term, @RequestParam String type) {
        // 根据类型进行搜索
        switch (type.toLowerCase()) {
            case "cpu":
                return hardwareLibraryService.searchCpus(term);
            case "gpu":
                return hardwareLibraryService.searchGpus(term);
            case "motherboard":
                return hardwareLibraryService.searchMotherboards(term);
            default:
                return new java.util.ArrayList<>(); // 返回空列表
        }
    }

    // --- API: 获取单个硬件详情 ---
    @GetMapping("/api/detail/{table}/{id}")
    @ResponseBody
    public Object getHardwareDetail(@PathVariable String table, @PathVariable Integer id) {
        return hardwareLibraryService.getHardwareById(table, id);
    }
}
package com.hardware.controller;

import com.hardware.entity.*;
import com.hardware.service.HardwareInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Arrays;

/**
 * 硬件信息控制器
 * 处理与CPU、GPU、主板等硬件信息相关的请求。
 * 依赖 HardwareInfoService 处理业务逻辑。
 */
@Controller
@RequestMapping("/hardware") // 所有请求路径以 /hardware 开头
public class HardwareInfoController {

    @Autowired
    private HardwareInfoService hardwareInfoService;

    // --- 搜索硬件 (用于引用功能) ---
    /**
     * 搜索硬件
     * @param term 搜索关键词
     * @param table 搜索的表 (cpu_info, gpu_info, motherboard_info)
     * @return 搜索结果列表 (JSON)
     */
    @GetMapping("/search")
    @ResponseBody
    public List<Map<String, Object>> searchHardware(@RequestParam String term, @RequestParam String table) {
        System.out.println("HardwareController: searchHardware called with term: " + term + ", table: " + table); // 添加日志

        // 验证表名
        if (!isValidTableNameForSearch(table)) {
            System.out.println("HardwareController: Invalid table name provided for search: " + table); // 添加日志
            return new ArrayList<>(); // 返回空列表 (Java 8 兼容)
        }

        List<?> results;
        switch (table) {
            case "cpu_info":
                System.out.println("HardwareController: Calling service.searchCpus for term: " + term); // 添加日志
                results = hardwareInfoService.searchCpus(term);
                break;
            case "gpu_info":
                System.out.println("HardwareController: Calling service.searchGpus for term: " + term); // 添加日志
                results = hardwareInfoService.searchGpus(term);
                break;
            case "motherboard_info": // 确认这里是否正确处理了 motherboard_info
                System.out.println("HardwareController: Calling service.searchMotherboards for term: " + term); // 添加日志
                results = hardwareInfoService.searchMotherboards(term);
                break;
            default:
                // This should not happen due to validation, but just in case
                System.out.println("HardwareController: Unexpected table name in switch: " + table); // 添加日志
                results = new ArrayList<>(); // Java 8 兼容
        }
        System.out.println("HardwareController: Service returned " + (results != null ? results.size() : "null") + " results for table: " + table); // 添加日志


        // 将结果转换为前端需要的格式 (包含 id, brand, model)
        // 假设实体类有 getId(), getBrand(), getModel() 方法
        List<Map<String, Object>> resultList = new ArrayList<>(); // Java 8 兼容
        for (Object item : results) {
            Map<String, Object> map = new HashMap<>(); // Java 8 兼容
            if (item instanceof CpuInfo) {
                CpuInfo cpu = (CpuInfo) item;
                map.put("id", cpu.getId());
                map.put("brand", cpu.getBrand());
                map.put("model", cpu.getModel());
                resultList.add(map);
            } else if (item instanceof GpuInfo) {
                GpuInfo gpu = (GpuInfo) item;
                map.put("id", gpu.getId());
                map.put("brand", gpu.getBrand());
                map.put("model", gpu.getModel());
                resultList.add(map);
            } else if (item instanceof MotherboardInfo) {
                MotherboardInfo mb = (MotherboardInfo) item;
                map.put("id", mb.getId());
                map.put("brand", mb.getBrand());
                map.put("model", mb.getModel());
                resultList.add(map);
            }

        }

        return resultList;
    }

    // 验证搜索时的表名是否合法
    private boolean isValidTableNameForSearch(String name) {
        List<String> validTables = Arrays.asList("cpu_info", "gpu_info", "motherboard_info");
        boolean isValid = validTables.contains(name);
        System.out.println("HardwareController: isValidTableNameForSearch('" + name + "') = " + isValid); // 添加日志
        return isValid;

    }

    // --- CPU 相关页面 ---
    @GetMapping("/cpu")
    public String listCpus(Model model) {
        List<CpuInfo> cpus = hardwareInfoService.getAllCpus();
        model.addAttribute("cpus", cpus);
        return "hardware/cpu-list"; // 对应 /WEB-INF/jsp/hardware/cpu-list.jsp
    }

    @GetMapping("/cpu/{id}")
    public String viewCpu(@PathVariable Integer id, Model model) {
        CpuInfo cpu = hardwareInfoService.getCpuById(id);
        if (cpu == null) {
            model.addAttribute("errorMessage", "CPU not found");
            return "error"; // 返回错误页面
        }
        model.addAttribute("cpu", cpu);
        return "hardware/cpu-detail"; // 对应 /WEB-INF/jsp/hardware/cpu-detail.jsp
    }

    // --- GPU 相关页面 ---
    @GetMapping("/gpu")
    public String listGpus(Model model) {
        List<GpuInfo> gpus = hardwareInfoService.getAllGpus();
        model.addAttribute("gpus", gpus);
        return "hardware/gpu-list";
    }

    @GetMapping("/gpu/{id}")
    public String viewGpu(@PathVariable Integer id, Model model) {
        GpuInfo gpu = hardwareInfoService.getGpuById(id);
        if (gpu == null) {
            model.addAttribute("errorMessage", "GPU not found");
            return "error";
        }
        model.addAttribute("gpu", gpu);
        return "hardware/gpu-detail";
    }

    // ---主板 相关页面 ---
    @GetMapping("/motherboard")
    public String listMotherboards(Model model) {
        List<MotherboardInfo> motherboards = hardwareInfoService.getAllMotherboards();
        model.addAttribute("motherboards", motherboards);
        return "hardware/motherboard-list";
    }

    @GetMapping("/motherboard/{id}")
    public String viewMotherboard(@PathVariable Integer id, Model model) {
        MotherboardInfo motherboard = hardwareInfoService.getMotherboardById(id);
        if (motherboard == null) {
            model.addAttribute("errorMessage", "Motherboard not found");
            return "error";
        }
        model.addAttribute("motherboard", motherboard);
        return "hardware/motherboard-detail";
    }


}
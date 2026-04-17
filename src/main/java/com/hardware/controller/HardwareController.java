package com.hardware.controller;

import com.hardware.entity.*;
import com.hardware.service.HardwareInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors; // 添加这一行导入

/**
 * 硬件信息API控制器
 * 提供用于前端获取硬件详情的API接口。
 * 搜索功能由 HardwareInfoController 提供。
 */
@RestController // 使用 @RestController，自动将返回对象序列化为JSON
@RequestMapping("/api/hardware") // 所有请求路径以 /api/hardware 开头
public class HardwareController {

    @Autowired
    private HardwareInfoService hardwareInfoService;

    // --- 移除 /api/hardware/search 搜索API ---
    // 搜索功能由 HardwareInfoController 的 /hardware/search 提供

    /**
     * 获取单个硬件详细信息 API
     * @param table 硬件表名 (cpu_info, gpu_info, motherboard_info)
     * @param id 硬件ID
     * @return 包含硬件详情的 ResponseEntity
     */
    @GetMapping("/detail/{table}/{id}") // 处理 /api/hardware/detail/{table}/{id} 的 GET 请求
    public ResponseEntity<?> getHardwareDetail(@PathVariable String table, @PathVariable Integer id) {
        Object result;
        switch (table.toLowerCase()) {
            case "cpu_info":
                result = hardwareInfoService.getCpuById(id);
                break;
            case "gpu_info":
                result = hardwareInfoService.getGpuById(id);
                break;
            case "motherboard_info":
                result = hardwareInfoService.getMotherboardById(id);
                break;

            default:
                return ResponseEntity.badRequest().build(); // 如果table参数无效，返回400
        }

        if (result == null) {
            return ResponseEntity.notFound().build(); // 如果找不到对应ID的硬件，返回404
        }

        return ResponseEntity.ok(result); // 返回200 OK和硬件详情
    }
}
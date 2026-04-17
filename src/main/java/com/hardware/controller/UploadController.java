package com.hardware.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * 文件上传控制器
 * 提供用于前端上传文件（如图片）的API接口。
 * 文件将保存到相对于 Tomcat 部署目录的 uploads 文件夹中。
 * 上传的图片会进行缩放处理。
 */
@Controller
@RequestMapping("/upload") // 所有请求路径以 /upload 开头
public class UploadController {

    // 定义上传文件的存储目录 (相对于 webapp 根目录)
    private static final String UPLOAD_DIR = "/uploads/";

    // 定义图片最大宽度
    private static final int MAX_WIDTH = 800; // 例如，最大宽度为800像素
    // 定义图片最大高度
    private static final int MAX_HEIGHT = 600; // 例如，最大高度为600像素

    /**
     * 处理图片上传请求
     * @param file 上传的文件
     * @param request HttpServletRequest 对象，用于获取上下文路径
     * @return 包含上传结果信息的 ResponseEntity
     */
    @PostMapping("/image") // 处理 /upload/image 的 POST 请求
    public ResponseEntity<Map<String, Object>> uploadImage(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();

        // 1. 检查文件是否为空
        if (file.isEmpty()) {
            response.put("success", false);
            response.put("message", "请选择要上传的文件");
            return ResponseEntity.badRequest().body(response);
        }

        // 2. 检查文件类型 (只允许图片)
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            response.put("success", false);
            response.put("message", "文件类型不正确，只允许上传图片文件 (jpg, png, gif等)");
            return ResponseEntity.badRequest().body(response);
        }

        // 3. 检查文件大小 (例如，限制为 5MB)
        long maxSize = 5 * 1024 * 1024; // 5MB in bytes
        if (file.getSize() > maxSize) {
            response.put("success", false);
            response.put("message", "文件大小不能超过 5MB");
            return ResponseEntity.badRequest().body(response);
        }

        try {
            // 4. 生成唯一的文件名 (使用UUID和时间戳)
            String originalFilename = file.getOriginalFilename();
            String fileExtension = originalFilename != null ? originalFilename.substring(originalFilename.lastIndexOf('.')).toLowerCase() : ".jpg";
            String uniqueFilename = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + "_" + UUID.randomUUID().toString().substring(0, 8) + fileExtension;

            // 5. 获取服务器端存储路径 (使用 Web 应用根路径)
            String webAppRootPath = request.getSession().getServletContext().getRealPath("/");
            System.out.println("Web App Root Path from getRealPath: " + webAppRootPath); // 调试日志

            // 构建上传路径
            Path uploadPath = Paths.get(webAppRootPath, UPLOAD_DIR.substring(1)); // 去掉开头的 '/'
            System.out.println("Calculated Upload Path: " + uploadPath); // 调试日志

            // 确保上传目录存在
            if (!Files.exists(uploadPath)) {
                System.out.println("Upload directory does not exist, attempting to create: " + uploadPath); // 调试日志
                try {
                    Files.createDirectories(uploadPath);
                    System.out.println("Upload directory created successfully.");
                } catch (IOException createDirEx) {
                    System.err.println("Failed to create upload directory: " + createDirEx.getMessage());
                    response.put("success", false);
                    response.put("message", "无法创建上传目录: " + createDirEx.getMessage());
                    return ResponseEntity.status(500).body(response);
                }
            } else {
                System.out.println("Upload directory already exists: " + uploadPath);
            }

            // 6. 构建完整文件路径
            Path filePath = uploadPath.resolve(uniqueFilename);

            // --- 图片缩放处理 (在 transferTo 之前进行) ---
            System.out.println("Reading image from upload stream..."); // 调试日志
            BufferedImage originalImage = null;
            try (InputStream inputStream = file.getInputStream()) { // 使用 try-with-resources 确保流关闭
                originalImage = ImageIO.read(inputStream);
            }
            if (originalImage == null) {
                response.put("success", false);
                response.put("message", "无法读取上传的图片文件");
                return ResponseEntity.badRequest().body(response);
            }

            int originalWidth = originalImage.getWidth();
            int originalHeight = originalImage.getHeight();
            System.out.println("Original image dimensions: " + originalWidth + "x" + originalHeight); // 调试日志

            // 计算缩放后的尺寸
            double scale = Math.min((double) MAX_WIDTH / originalWidth, (double) MAX_HEIGHT / originalHeight);
            // 如果图片本身小于等于最大尺寸，则不需要缩放
            if (scale >= 1.0) {
                System.out.println("Image does not need scaling, dimensions are within limits. Scale: " + scale); // 调试日志
                // 直接保存原始图片
                System.out.println("Attempting to save original image to: " + filePath); // 调试日志
                file.transferTo(filePath.toFile()); // 尝试 transferTo
            } else {
                System.out.println("Scaling image with scale factor: " + scale); // 调试日志
                int newWidth = (int) (originalWidth * scale);
                int newHeight = (int) (originalHeight * scale);
                System.out.println("New dimensions after scaling: " + newWidth + "x" + newHeight); // 调试日志

                // 创建缩放后的图片
                Image scaledImage = originalImage.getScaledInstance(newWidth, newHeight, Image.SCALE_SMOOTH);
                BufferedImage bufferedScaledImage = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_RGB);
                Graphics2D g2d = bufferedScaledImage.createGraphics();
                g2d.drawImage(scaledImage, 0, 0, null);
                g2d.dispose(); // 释放资源

                // 保存缩放后的图片
                System.out.println("Attempting to save scaled image to: " + filePath); // 调试日志
                ImageIO.write(bufferedScaledImage, fileExtension.substring(1), filePath.toFile()); // 去掉点号
            }
            // --- /图片缩放处理 ---

            // 8. 构建访问URL (相对于应用根路径)
            String fileUrl = request.getContextPath() + UPLOAD_DIR + uniqueFilename;

            // 9. 返回成功信息和文件URL
            response.put("success", true);
            response.put("message", "上传成功");
            response.put("url", fileUrl); // 返回图片的访问路径

            return ResponseEntity.ok(response);

        } catch (IOException e) {
            e.printStackTrace(); // 记录错误日志
            response.put("success", false);
            response.put("message", "文件上传失败: " + e.getMessage());
            return ResponseEntity.status(500).body(response); // 返回500内部服务器错误
        }
    }
}
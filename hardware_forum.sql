/*
 Navicat Premium Dump SQL

 Source Server         : AONGEL-SQL
 Source Server Type    : MySQL
 Source Server Version : 50726 (5.7.26)
 Source Host           : localhost:3306
 Source Schema         : hardware_forum

 Target Server Type    : MySQL
 Target Server Version : 50726 (5.7.26)
 File Encoding         : 65001

 Date: 17/04/2026 16:51:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for certification_application
-- ----------------------------
DROP TABLE IF EXISTS `certification_application`;
CREATE TABLE `certification_application`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '申请人ID',
  `application_status` enum('pending','approved','rejected','pending_discussion') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'pending' COMMENT '申请状态: pending(待审核), approved(通过), rejected(不通过), pending_discussion(待商议)',
  `submitted_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
  `exam_duration` int(11) NULL DEFAULT NULL COMMENT '答题时长(秒)',
  `answers` json NULL COMMENT '用户答案 (存储为JSON格式)',
  `admin_remarks` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '管理员备注/留言',
  `reviewed_at` timestamp NULL DEFAULT NULL COMMENT '审核时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of certification_application
-- ----------------------------
INSERT INTO `certification_application` VALUES (1, 3, 'approved', '2026-01-09 15:35:25', 136, '{\"fill_blank_1\": \"LGA1700\", \"fill_blank_2\": \"12\", \"open_ended_3\": \"CPU的TDP是了设计功耗，用于来表示该CPU的一个热功耗设计，可以根据此来判断要去选择的散热器（不过早期没有更换到12代的intel的cpu的TDP虚标严重）\", \"open_ended_4\": \"测试测试\"}', '', '2026-01-09 20:49:10');
INSERT INTO `certification_application` VALUES (2, 4, 'pending_discussion', '2026-01-09 20:50:00', 4, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\"}', '5', '2026-01-09 20:50:15');
INSERT INTO `certification_application` VALUES (3, 5, 'rejected', '2026-01-09 20:50:57', 2, '{\"fill_blank_1\": \"2\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"2\", \"open_ended_4\": \"2\"}', '', '2026-01-09 20:51:10');
INSERT INTO `certification_application` VALUES (4, 7, 'approved', '2026-01-09 22:06:53', 4, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\"}', '', '2026-01-09 22:07:05');
INSERT INTO `certification_application` VALUES (5, 5, 'approved', '2026-01-09 22:30:20', 4, '{\"fill_blank_1\": \"2\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"2\", \"open_ended_4\": \"2\"}', '', '2026-01-09 22:31:03');
INSERT INTO `certification_application` VALUES (6, 4, 'approved', '2026-01-09 22:30:35', 2, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\"}', '', '2026-01-09 22:31:07');
INSERT INTO `certification_application` VALUES (7, 8, 'rejected', '2026-01-09 22:37:18', 3, '{\"fill_blank_1\": \"2\", \"fill_blank_2\": \"1\", \"open_ended_3\": \"3\", \"open_ended_4\": \"3\"}', '', '2026-01-09 22:37:42');
INSERT INTO `certification_application` VALUES (8, 8, 'pending_discussion', '2026-01-09 22:38:00', 7, '{\"fill_blank_1\": \"2\", \"fill_blank_2\": \"1\", \"open_ended_3\": \"3\", \"open_ended_4\": \"3\"}', '测试', '2026-01-09 22:38:16');
INSERT INTO `certification_application` VALUES (9, 8, 'approved', '2026-01-09 22:38:27', 2, '{\"fill_blank_1\": \"2\", \"fill_blank_2\": \"1\", \"open_ended_3\": \"3\", \"open_ended_4\": \"3\"}', '', '2026-01-10 00:19:44');
INSERT INTO `certification_application` VALUES (10, 9, 'pending_discussion', '2026-01-11 14:18:17', 2, '{\"fill_blank_1\": \"22\", \"fill_blank_2\": \"33\", \"open_ended_3\": \"44\", \"open_ended_4\": \"4455\"}', '22', '2026-01-11 14:19:07');
INSERT INTO `certification_application` VALUES (11, 9, 'rejected', '2026-01-11 14:19:17', 1, '{\"fill_blank_1\": \"22\", \"fill_blank_2\": \"33\", \"open_ended_3\": \"44\", \"open_ended_4\": \"4455\"}', '', '2026-01-11 14:19:27');
INSERT INTO `certification_application` VALUES (12, 9, 'approved', '2026-01-11 14:19:36', 2, '{\"fill_blank_1\": \"22\", \"fill_blank_2\": \"33\", \"open_ended_3\": \"44\", \"open_ended_4\": \"4455\"}', '', '2026-01-11 14:19:45');
INSERT INTO `certification_application` VALUES (13, 8, 'rejected', '2026-01-11 19:29:27', 8, '{\"fill_blank_1\": \"2\", \"fill_blank_2\": \"1\", \"open_ended_3\": \"3\", \"open_ended_4\": \"3\", \"open_ended_5\": \"\"}', '', '2026-01-11 19:29:44');
INSERT INTO `certification_application` VALUES (14, 6, 'rejected', '2026-01-14 13:26:03', 2, '{\"fill_blank_1\": \"\", \"fill_blank_2\": \"\", \"open_ended_3\": \"\", \"open_ended_4\": \"\", \"open_ended_5\": \"\"}', '', '2026-01-14 14:30:31');
INSERT INTO `certification_application` VALUES (15, 6, 'approved', '2026-01-14 14:30:55', 1, '{\"fill_blank_1\": \"\", \"fill_blank_2\": \"\", \"open_ended_3\": \"\", \"open_ended_4\": \"\", \"open_ended_5\": \"\"}', '', '2026-01-14 14:31:08');
INSERT INTO `certification_application` VALUES (16, 6, 'pending_discussion', '2026-01-14 14:35:44', 1, '{\"fill_blank_1\": \"\", \"fill_blank_2\": \"\", \"open_ended_3\": \"\", \"open_ended_4\": \"\", \"open_ended_5\": \"\"}', '111', '2026-01-14 14:36:40');
INSERT INTO `certification_application` VALUES (17, 8, 'pending_discussion', '2026-01-14 14:35:59', 1, '{\"fill_blank_1\": \"2\", \"fill_blank_2\": \"1\", \"open_ended_3\": \"3\", \"open_ended_4\": \"3\", \"open_ended_5\": \"\"}', '222', '2026-01-14 14:36:43');
INSERT INTO `certification_application` VALUES (18, 5, 'approved', '2026-01-14 14:36:19', 1, '{\"fill_blank_1\": \"2\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"2\", \"open_ended_4\": \"2\", \"open_ended_5\": \"\"}', '', '2026-01-14 14:36:44');
INSERT INTO `certification_application` VALUES (19, 8, 'approved', '2026-01-14 14:37:05', 3, '{\"fill_blank_1\": \"2\", \"fill_blank_2\": \"1\", \"open_ended_3\": \"3\", \"open_ended_4\": \"3\", \"open_ended_5\": \"\"}', '', '2026-01-14 14:37:24');
INSERT INTO `certification_application` VALUES (20, 7, 'pending_discussion', '2026-01-14 18:04:39', 1, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\", \"open_ended_5\": \"\"}', '1', '2026-01-14 18:05:04');
INSERT INTO `certification_application` VALUES (21, 7, 'approved', '2026-01-14 18:06:26', 1, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\", \"open_ended_5\": \"\"}', '', '2026-01-14 18:07:02');
INSERT INTO `certification_application` VALUES (22, 6, 'rejected', '2026-01-14 18:18:23', 1, '{\"fill_blank_1\": \"\", \"fill_blank_2\": \"\", \"open_ended_3\": \"\", \"open_ended_4\": \"\", \"open_ended_5\": \"\"}', '', '2026-01-14 18:41:43');
INSERT INTO `certification_application` VALUES (23, 6, 'rejected', '2026-01-14 18:43:17', 1, '{\"fill_blank_1\": \"\", \"fill_blank_2\": \"\", \"open_ended_3\": \"\", \"open_ended_4\": \"\", \"open_ended_5\": \"\"}', '', '2026-01-14 19:12:01');
INSERT INTO `certification_application` VALUES (24, 6, 'pending_discussion', '2026-01-14 19:12:27', 12, '{\"fill_blank_1\": \"56\", \"fill_blank_2\": \"56\", \"open_ended_3\": \"134\", \"open_ended_4\": \"789\", \"open_ended_5\": \"gyubh、\"}', '666', '2026-01-14 19:12:46');
INSERT INTO `certification_application` VALUES (25, 6, 'rejected', '2026-01-14 19:27:13', 1, '{\"fill_blank_1\": \"56\", \"fill_blank_2\": \"56\", \"open_ended_3\": \"134\", \"open_ended_4\": \"789\", \"open_ended_5\": \"gyubh、\"}', '', '2026-02-02 12:12:41');
INSERT INTO `certification_application` VALUES (26, 4, 'approved', '2026-02-02 12:10:46', 2, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\", \"open_ended_5\": \"\"}', '', '2026-02-02 12:12:44');
INSERT INTO `certification_application` VALUES (27, 4, 'pending_discussion', '2026-02-02 12:28:24', 2, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\", \"open_ended_5\": \"\"}', '暂时待定', '2026-02-02 12:34:23');
INSERT INTO `certification_application` VALUES (28, 4, 'rejected', '2026-02-02 12:44:12', 2, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\", \"open_ended_5\": \"\"}', '', '2026-02-02 12:44:26');
INSERT INTO `certification_application` VALUES (29, 4, 'approved', '2026-02-02 12:45:38', 1, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\", \"open_ended_5\": \"\"}', '', '2026-02-02 12:46:26');
INSERT INTO `certification_application` VALUES (30, 5, 'rejected', '2026-02-02 12:45:49', 1, '{\"fill_blank_1\": \"2\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"2\", \"open_ended_4\": \"2\", \"open_ended_5\": \"\"}', '', '2026-02-02 12:46:23');
INSERT INTO `certification_application` VALUES (31, 4, 'pending_discussion', '2026-02-02 13:54:54', 1, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\", \"open_ended_5\": \"\"}', '111', '2026-02-02 13:55:14');
INSERT INTO `certification_application` VALUES (32, 4, 'rejected', '2026-02-02 14:07:45', 1, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\", \"open_ended_5\": \"\"}', '', '2026-02-02 14:08:40');
INSERT INTO `certification_application` VALUES (33, 4, 'rejected', '2026-02-02 14:09:38', 1, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\", \"open_ended_5\": \"\"}', '', '2026-02-02 14:09:50');
INSERT INTO `certification_application` VALUES (34, 4, 'pending_discussion', '2026-02-03 16:27:50', 12, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\", \"open_ended_5\": \"666\"}', 'xxx', '2026-02-03 16:28:16');
INSERT INTO `certification_application` VALUES (35, 4, 'rejected', '2026-02-03 16:36:15', 2, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\", \"open_ended_5\": \"666\"}', '', '2026-02-03 16:36:35');
INSERT INTO `certification_application` VALUES (36, 4, 'rejected', '2026-02-03 16:38:25', 2, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\", \"open_ended_5\": \"666\"}', '', '2026-02-03 16:39:41');
INSERT INTO `certification_application` VALUES (37, 4, 'pending_discussion', '2026-02-03 17:05:57', 1, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\", \"open_ended_5\": \"666\"}', '1', '2026-02-03 17:06:18');
INSERT INTO `certification_application` VALUES (38, 4, 'rejected', '2026-02-03 17:06:57', 1, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\", \"open_ended_5\": \"666\"}', '', '2026-02-03 17:14:43');
INSERT INTO `certification_application` VALUES (39, 4, 'rejected', '2026-02-03 17:14:58', 4, '{\"fill_blank_1\": \"1\", \"fill_blank_2\": \"2\", \"open_ended_3\": \"3\", \"open_ended_4\": \"4\", \"open_ended_5\": \"666\"}', '', '2026-02-03 20:11:49');
INSERT INTO `certification_application` VALUES (40, 8, 'rejected', '2026-02-04 13:50:52', 2, '{\"fill_blank_1\": \"2\", \"fill_blank_2\": \"1\", \"open_ended_3\": \"3\", \"open_ended_4\": \"3\", \"open_ended_5\": \"\"}', '', '2026-02-04 14:14:19');
INSERT INTO `certification_application` VALUES (41, 8, 'rejected', '2026-02-04 14:14:32', 1, '{\"fill_blank_1\": \"2\", \"fill_blank_2\": \"1\", \"open_ended_3\": \"3\", \"open_ended_4\": \"3\", \"open_ended_5\": \"\"}', '', '2026-02-04 14:31:31');
INSERT INTO `certification_application` VALUES (42, 8, 'pending_discussion', '2026-02-04 14:32:53', 1, '{\"fill_blank_1\": \"2\", \"fill_blank_2\": \"1\", \"open_ended_3\": \"3\", \"open_ended_4\": \"3\", \"open_ended_5\": \"\"}', '112233', '2026-02-04 14:33:10');
INSERT INTO `certification_application` VALUES (43, 8, 'approved', '2026-02-04 14:33:22', 2, '{\"fill_blank_1\": \"2\", \"fill_blank_2\": \"1\", \"open_ended_3\": \"3\", \"open_ended_4\": \"3\", \"open_ended_5\": \"\"}', '', '2026-02-04 14:33:43');
INSERT INTO `certification_application` VALUES (44, 11, 'rejected', '2026-03-06 13:06:19', 85, '{\"fill_blank_1\": \"\", \"fill_blank_2\": \"\", \"open_ended_3\": \"\", \"open_ended_4\": \"\", \"open_ended_5\": \"\"}', '', '2026-03-31 15:36:43');
INSERT INTO `certification_application` VALUES (45, 14, 'pending', '2026-04-15 20:24:05', 17, '{\"fill_blank_1\": \"xxxx\", \"fill_blank_2\": \"AAAA\", \"open_ended_3\": \"测试测试\", \"open_ended_4\": \"测试测试\", \"open_ended_5\": \"无\"}', NULL, NULL);

-- ----------------------------
-- Table structure for certification_question
-- ----------------------------
DROP TABLE IF EXISTS `certification_question`;
CREATE TABLE `certification_question`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_type` enum('fill_blank','open_ended') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '题目类型: fill_blank(填空), open_ended(简答)',
  `question_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '题目内容',
  `is_active` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of certification_question
-- ----------------------------
INSERT INTO `certification_question` VALUES (1, 'fill_blank', 'Intel i5-13400F 的接口类型是 [____]。', 1, '2026-01-09 15:05:28', '2026-01-09 15:05:28');
INSERT INTO `certification_question` VALUES (2, 'fill_blank', 'AMD RX9070 的显存容量是 [____] GB。', 1, '2026-01-09 15:05:28', '2026-01-11 19:16:27');
INSERT INTO `certification_question` VALUES (3, 'open_ended', '请简述什么是CPU的TDP，并解释它对散热器选择的影响。', 1, '2026-01-09 15:05:28', '2026-01-09 15:05:28');
INSERT INTO `certification_question` VALUES (4, 'open_ended', '在组装一台电脑时，如何确保所选的CPU、主板、内存条之间是兼容的？', 1, '2026-01-09 15:05:28', '2026-01-11 19:20:26');
INSERT INTO `certification_question` VALUES (5, 'open_ended', '给你5k元，你试着组装一台PC，仅主机（但必须有机箱），玩怪物猎人荒野，要能1080p较为流畅的游玩。', 1, '2026-01-11 19:20:14', '2026-01-11 19:20:14');

-- ----------------------------
-- Table structure for cpu_info
-- ----------------------------
DROP TABLE IF EXISTS `cpu_info`;
CREATE TABLE `cpu_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'CPU ID',
  `brand` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '品牌 (Intel, AMD)',
  `model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '型号 (如: i5-13400F)',
  `interface_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接口类型 (如: LGA1700, AM5)',
  `cores` int(11) NULL DEFAULT NULL COMMENT '核心数',
  `threads` int(11) NULL DEFAULT NULL COMMENT '线程数',
  `base_frequency` decimal(4, 2) NULL DEFAULT NULL COMMENT '基础频率 (GHz)',
  `max_frequency` decimal(4, 2) NULL DEFAULT NULL COMMENT '最大睿频 (GHz)',
  `tdp` int(11) NULL DEFAULT NULL COMMENT '基础功耗 (W)',
  `integrated_graphics` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '核显型号 (如: UHD770)',
  `release_date` date NULL DEFAULT NULL COMMENT '发布日期',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `model`(`model`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10019 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'CPU参数表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cpu_info
-- ----------------------------
INSERT INTO `cpu_info` VALUES (1, 'AMD', 'Ryzen 5 1600', 'AM4', 6, 12, 3.20, 3.60, 65, 'None', '2017-04-01', '2026-01-12 14:42:53', '2026-01-12 14:53:21');
INSERT INTO `cpu_info` VALUES (2, 'AMD', 'Ryzen 7 1700', 'AM4', 8, 16, 3.00, 3.70, 65, 'None', '2017-04-01', '2026-01-12 14:42:53', '2026-01-12 14:53:22');
INSERT INTO `cpu_info` VALUES (3, 'AMD', 'Ryzen 5 2600', 'AM4', 6, 12, 3.40, 3.90, 65, 'None', '2018-04-19', '2026-01-12 14:42:53', '2026-01-12 14:53:22');
INSERT INTO `cpu_info` VALUES (4, 'AMD', 'Ryzen 7 2700', 'AM4', 8, 16, 3.20, 4.10, 65, 'None', '2018-04-19', '2026-01-12 14:42:53', '2026-01-12 14:53:23');
INSERT INTO `cpu_info` VALUES (5, 'AMD', 'Ryzen 5 3600', 'AM4', 6, 12, 3.60, 4.20, 65, 'None', '2019-07-07', '2026-01-12 14:42:53', '2026-01-12 14:53:23');
INSERT INTO `cpu_info` VALUES (6, 'AMD', 'Ryzen 7 3700X', 'AM4', 8, 16, 3.60, 4.40, 65, 'None', '2019-07-07', '2026-01-12 14:42:53', '2026-01-12 14:53:23');
INSERT INTO `cpu_info` VALUES (7, 'AMD', 'Ryzen 5 5600X', 'AM4', 6, 12, 3.70, 4.60, 65, 'None', '2020-11-05', '2026-01-12 14:42:53', '2026-01-12 14:53:24');
INSERT INTO `cpu_info` VALUES (8, 'AMD', 'Ryzen 7 5800X', 'AM4', 8, 16, 3.80, 4.70, 105, 'None', '2020-11-05', '2026-01-12 14:42:53', '2026-01-12 14:53:24');
INSERT INTO `cpu_info` VALUES (9, 'AMD', 'Ryzen 5 7600X', 'AM5', 6, 12, 4.70, 5.30, 105, 'None', '2022-09-27', '2026-01-12 14:42:53', '2026-01-12 14:53:25');
INSERT INTO `cpu_info` VALUES (10, 'AMD', 'Ryzen 7 7700X', 'AM5', 8, 16, 4.50, 5.40, 105, 'None', '2022-09-27', '2026-01-12 14:42:53', '2026-01-12 14:53:30');
INSERT INTO `cpu_info` VALUES (11, 'AMD', 'Ryzen 9 7900X', 'AM5', 12, 24, 4.70, 5.60, 170, 'None', '2022-09-27', '2026-01-12 14:42:53', '2026-01-12 14:53:28');
INSERT INTO `cpu_info` VALUES (12, 'AMD', 'Ryzen 5 8600G', 'AM5', 6, 12, 4.30, 5.00, 65, 'Radeon 760M', '2024-01-01', '2026-01-12 14:42:53', '2026-01-12 14:53:31');
INSERT INTO `cpu_info` VALUES (13, 'AMD', 'Ryzen 7 8700G', 'AM5', 8, 16, 4.20, 5.10, 65, 'Radeon 780M', '2024-01-01', '2026-01-12 14:42:53', '2026-01-12 14:53:32');
INSERT INTO `cpu_info` VALUES (14, 'AMD', 'Ryzen 9 8945HS', 'AM5', 8, 16, 4.00, 5.20, 45, 'Radeon 780M', '2024-01-01', '2026-01-12 14:42:53', '2026-01-12 14:53:33');
INSERT INTO `cpu_info` VALUES (1000, 'Intel', 'Core i5-7600K', 'LGA1151', 4, 4, 3.80, 4.20, 91, 'HD 630', '2017-01-01', '2026-01-12 14:42:53', '2026-01-12 14:54:10');
INSERT INTO `cpu_info` VALUES (1001, 'Intel', 'Core i7-7700K', 'LGA1151', 4, 8, 4.20, 4.50, 91, 'HD 630', '2017-01-01', '2026-01-12 14:42:53', '2026-01-12 14:54:12');
INSERT INTO `cpu_info` VALUES (1002, 'Intel', 'Core i5-8400', 'LGA1151', 6, 6, 2.80, 4.00, 65, 'UHD 630', '2017-10-01', '2026-01-12 14:42:53', '2026-01-12 14:54:13');
INSERT INTO `cpu_info` VALUES (1003, 'Intel', 'Core i7-8700K', 'LGA1151', 6, 12, 3.70, 4.70, 95, 'UHD 630', '2017-10-01', '2026-01-12 14:42:53', '2026-01-12 14:54:15');
INSERT INTO `cpu_info` VALUES (1004, 'Intel', 'Core i5-9400F', 'LGA1151', 6, 6, 2.90, 4.10, 65, NULL, '2019-01-01', '2026-01-12 14:42:53', '2026-01-12 14:54:16');
INSERT INTO `cpu_info` VALUES (1005, 'Intel', 'Core i7-9700K', 'LGA1151', 8, 8, 3.60, 4.90, 95, 'UHD 630', '2019-01-01', '2026-01-12 14:42:53', '2026-01-12 14:54:18');
INSERT INTO `cpu_info` VALUES (1006, 'Intel', 'Core i5-10400F', 'LGA1200', 6, 12, 2.90, 4.30, 65, NULL, '2020-04-30', '2026-01-12 14:42:53', '2026-01-12 14:54:20');
INSERT INTO `cpu_info` VALUES (1007, 'Intel', 'Core i7-10700K', 'LGA1200', 8, 16, 3.80, 5.10, 125, 'UHD 630', '2020-04-30', '2026-01-12 14:42:53', '2026-01-12 14:54:22');
INSERT INTO `cpu_info` VALUES (1008, 'Intel', 'Core i5-11400F', 'LGA1200', 6, 12, 2.60, 4.40, 65, NULL, '2021-03-30', '2026-01-12 14:42:53', '2026-01-12 14:54:24');
INSERT INTO `cpu_info` VALUES (1009, 'Intel', 'Core i7-11700K', 'LGA1200', 8, 16, 3.60, 5.00, 125, 'UHD 750', '2021-03-30', '2026-01-12 14:42:53', '2026-01-12 14:54:25');
INSERT INTO `cpu_info` VALUES (10010, 'Intel', 'Core i5-12400F', 'LGA1700', 6, 12, 2.50, 4.40, 65, NULL, '2022-01-01', '2026-01-12 14:42:53', '2026-01-12 14:54:28');
INSERT INTO `cpu_info` VALUES (10011, 'Intel', 'Core i7-12700K', 'LGA1700', 12, 20, 3.60, 5.00, 125, 'UHD 770', '2022-01-01', '2026-01-12 14:42:53', '2026-01-12 14:54:31');
INSERT INTO `cpu_info` VALUES (10012, 'Intel', 'Core i5-13400F', 'LGA1700', 10, 16, 2.50, 4.60, 65, NULL, '2022-10-20', '2026-01-12 14:42:53', '2026-01-12 14:54:34');
INSERT INTO `cpu_info` VALUES (10013, 'Intel', 'Core i7-13700K', 'LGA1700', 16, 24, 3.40, 5.40, 125, 'UHD 770', '2022-10-20', '2026-01-12 14:42:53', '2026-01-12 14:54:35');
INSERT INTO `cpu_info` VALUES (10014, 'Intel', 'Core i5-14400F', 'LGA1700', 10, 16, 2.50, 4.70, 65, NULL, '2023-10-17', '2026-01-12 14:42:53', '2026-01-12 14:54:37');
INSERT INTO `cpu_info` VALUES (10015, 'Intel', 'Core i7-14700K', 'LGA1700', 20, 28, 3.40, 5.60, 125, 'UHD 770', '2023-10-17', '2026-01-12 14:42:53', '2026-01-12 14:54:39');
INSERT INTO `cpu_info` VALUES (10016, 'Intel', 'Core Ultra 5 125H', 'BGA', 14, 18, 3.50, 4.50, 45, 'Arc Graphics', '2024-01-01', '2026-01-12 14:42:53', '2026-01-12 14:54:42');
INSERT INTO `cpu_info` VALUES (10017, 'Intel', 'Core Ultra 7 155H', 'BGA', 16, 22, 3.80, 4.80, 45, 'Arc Graphics', '2024-01-01', '2026-01-12 14:42:53', '2026-01-12 14:54:44');
INSERT INTO `cpu_info` VALUES (10018, 'Intel', 'Core Ultra 9 185H', 'BGA', 16, 22, 4.00, 5.10, 45, 'Arc Graphics', '2024-01-01', '2026-01-12 14:42:53', '2026-01-12 14:54:46');

-- ----------------------------
-- Table structure for forum_section
-- ----------------------------
DROP TABLE IF EXISTS `forum_section`;
CREATE TABLE `forum_section`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分区ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分区名称 (如: 硬件故障区)',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '分区描述',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '分区创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '论坛分区表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_section
-- ----------------------------
INSERT INTO `forum_section` VALUES (1, '硬件故障区', '讨论硬件故障、维修、升级等问题', '2025-12-20 23:28:01');
INSERT INTO `forum_section` VALUES (2, '参数分析区', '分享和讨论硬件参数、性能评测、技术分析', '2025-12-20 23:28:01');
INSERT INTO `forum_section` VALUES (3, '装机咨询区', '新手装机、配置推荐、兼容性咨询', '2025-12-20 23:28:01');
INSERT INTO `forum_section` VALUES (4, '灌水闲聊区', '如果不知道聊什么、可以来这里随便聊点', '2026-02-04 16:29:30');
INSERT INTO `forum_section` VALUES (5, '新品发售区', '进行一些处在fake news的新闻或者公开了相关信息产品的讨论的地方', '2026-02-04 16:32:04');
INSERT INTO `forum_section` VALUES (6, '二手交易区', '可以转载闲鱼、转转的二手链接来增加曝光度（请自觉遵循法律法规，平台不负责）', '2026-02-04 16:34:35');

-- ----------------------------
-- Table structure for gpu_info
-- ----------------------------
DROP TABLE IF EXISTS `gpu_info`;
CREATE TABLE `gpu_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'GPU ID',
  `brand` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '品牌 (NVIDIA, AMD)',
  `model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '型号 (如: RTX 4070)',
  `memory_size` int(11) NULL DEFAULT NULL COMMENT '显存容量 (GB)',
  `memory_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '显存类型 (GDDR6, GDDR6X)',
  `memory_bus_width` int(11) NULL DEFAULT NULL COMMENT '显存位宽 (bit)',
  `base_clock` int(11) NULL DEFAULT NULL COMMENT '基础频率 (MHz)',
  `boost_clock` int(11) NULL DEFAULT NULL COMMENT '加速频率 (MHz)',
  `tdp` int(11) NULL DEFAULT NULL COMMENT '整卡功耗 (W)',
  `interface_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '接口类型 (PCIe 4.0 x16)',
  `release_date` date NULL DEFAULT NULL COMMENT '发布日期',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `model`(`model`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 192 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'GPU参数表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gpu_info
-- ----------------------------
INSERT INTO `gpu_info` VALUES (1, 'NVIDIA', 'GeForce GTX 1050', 2, 'GDDR5', 64, 1354, 1455, 75, 'PCIe 3.0 x16', '2016-10-25', '2026-01-12 14:51:53', '2026-01-12 14:56:28');
INSERT INTO `gpu_info` VALUES (2, 'NVIDIA', 'GeForce GTX 1060 6GB', 6, 'GDDR5', 192, 1506, 1708, 120, 'PCIe 3.0 x16', '2016-07-01', '2026-01-12 14:51:53', '2026-01-12 14:56:28');
INSERT INTO `gpu_info` VALUES (3, 'NVIDIA', 'GeForce GTX 1070', 8, 'GDDR5', 256, 1506, 1683, 150, 'PCIe 3.0 x16', '2016-06-10', '2026-01-12 14:51:53', '2026-01-12 14:56:28');
INSERT INTO `gpu_info` VALUES (4, 'NVIDIA', 'GeForce GTX 1080', 8, 'GDDR5X', 256, 1607, 1733, 180, 'PCIe 3.0 x16', '2016-05-27', '2026-01-12 14:51:53', '2026-01-12 14:56:29');
INSERT INTO `gpu_info` VALUES (5, 'NVIDIA', 'GeForce RTX 2060', 6, 'GDDR6', 192, 1365, 1680, 160, 'PCIe 3.0 x16', '2019-01-07', '2026-01-12 14:51:53', '2026-01-12 14:56:29');
INSERT INTO `gpu_info` VALUES (6, 'NVIDIA', 'GeForce RTX 2070', 8, 'GDDR6', 256, 1410, 1620, 175, 'PCIe 3.0 x16', '2018-10-17', '2026-01-12 14:51:53', '2026-01-12 14:56:30');
INSERT INTO `gpu_info` VALUES (7, 'NVIDIA', 'GeForce RTX 2080', 8, 'GDDR6', 256, 1515, 1710, 215, 'PCIe 3.0 x16', '2018-09-20', '2026-01-12 14:51:53', '2026-01-12 14:56:30');
INSERT INTO `gpu_info` VALUES (8, 'NVIDIA', 'GeForce RTX 3060', 12, 'GDDR6', 128, 1320, 1777, 170, 'PCIe 4.0 x16', '2021-02-25', '2026-01-12 14:51:53', '2026-01-12 14:56:31');
INSERT INTO `gpu_info` VALUES (9, 'NVIDIA', 'GeForce RTX 3060 Ti', 8, 'GDDR6', 256, 1410, 1665, 200, 'PCIe 4.0 x16', '2020-12-02', '2026-01-12 14:51:53', '2026-01-12 14:56:32');
INSERT INTO `gpu_info` VALUES (10, 'NVIDIA', 'GeForce RTX 3070', 8, 'GDDR6', 256, 1500, 1725, 220, 'PCIe 4.0 x16', '2020-10-29', '2026-01-12 14:51:53', '2026-01-12 14:56:33');
INSERT INTO `gpu_info` VALUES (11, 'NVIDIA', 'GeForce RTX 3080', 10, 'GDDR6X', 320, 1440, 1710, 320, 'PCIe 4.0 x16', '2020-09-17', '2026-01-12 14:51:53', '2026-01-12 14:56:34');
INSERT INTO `gpu_info` VALUES (12, 'NVIDIA', 'GeForce RTX 3090', 24, 'GDDR6X', 384, 1395, 1695, 350, 'PCIe 4.0 x16', '2020-09-24', '2026-01-12 14:51:53', '2026-01-12 14:56:34');
INSERT INTO `gpu_info` VALUES (13, 'NVIDIA', 'GeForce RTX 4060', 8, 'GDDR6', 128, 1830, 2475, 115, 'PCIe 4.0 x8', '2023-05-24', '2026-01-12 14:51:53', '2026-01-12 14:56:35');
INSERT INTO `gpu_info` VALUES (14, 'NVIDIA', 'GeForce RTX 4060 Ti', 16, 'GDDR6', 128, 2310, 2535, 160, 'PCIe 4.0 x8', '2023-05-18', '2026-01-12 14:51:53', '2026-01-12 14:56:36');
INSERT INTO `gpu_info` VALUES (15, 'NVIDIA', 'GeForce RTX 4070', 12, 'GDDR6X', 192, 1920, 2475, 200, 'PCIe 4.0 x16', '2023-04-13', '2026-01-12 14:51:53', '2026-01-12 14:56:37');
INSERT INTO `gpu_info` VALUES (16, 'NVIDIA', 'GeForce RTX 4070 Super', 12, 'GDDR6X', 192, 1980, 2475, 220, 'PCIe 4.0 x16', '2024-01-17', '2026-01-12 14:51:53', '2026-01-12 14:56:38');
INSERT INTO `gpu_info` VALUES (17, 'NVIDIA', 'GeForce RTX 4080', 16, 'GDDR6X', 256, 2205, 2505, 285, 'PCIe 4.0 x16', '2022-11-16', '2026-01-12 14:51:53', '2026-01-12 14:56:39');
INSERT INTO `gpu_info` VALUES (18, 'NVIDIA', 'GeForce RTX 4090', 24, 'GDDR6X', 384, 2230, 2520, 450, 'PCIe 4.0 x16', '2022-10-12', '2026-01-12 14:51:53', '2026-01-12 14:56:40');
INSERT INTO `gpu_info` VALUES (19, 'NVIDIA', 'GeForce RTX 5060', 8, 'GDDR7', 128, 2000, 2600, 120, 'PCIe 5.0 x8', '2025-01-01', '2026-01-12 14:51:53', '2026-01-12 14:56:44');
INSERT INTO `gpu_info` VALUES (20, 'NVIDIA', 'GeForce RTX 5070', 12, 'GDDR7', 192, 2100, 2700, 210, 'PCIe 5.0 x16', '2025-01-01', '2026-01-12 14:51:53', '2026-01-12 14:56:45');
INSERT INTO `gpu_info` VALUES (21, 'NVIDIA', 'GeForce RTX 5080', 16, 'GDDR7', 256, 2200, 2800, 280, 'PCIe 5.0 x16', '2025-01-01', '2026-01-12 14:51:53', '2026-01-12 14:56:45');
INSERT INTO `gpu_info` VALUES (22, 'AMD', 'Radeon RX 560', 4, 'GDDR5', 128, 1176, 1275, 75, 'PCIe 3.0 x16', '2017-04-18', '2026-01-12 14:51:53', '2026-01-12 14:56:46');
INSERT INTO `gpu_info` VALUES (23, 'AMD', 'Radeon RX 570', 4, 'GDDR5', 256, 1168, 1244, 120, 'PCIe 3.0 x16', '2017-04-18', '2026-01-12 14:51:53', '2026-01-12 14:56:47');
INSERT INTO `gpu_info` VALUES (24, 'AMD', 'Radeon RX 580', 4, 'GDDR5', 256, 1257, 1340, 185, 'PCIe 3.0 x16', '2017-04-18', '2026-01-12 14:51:53', '2026-01-12 14:56:49');
INSERT INTO `gpu_info` VALUES (25, 'AMD', 'Radeon RX 5700', 8, 'GDDR6', 256, 1465, 1725, 180, 'PCIe 4.0 x16', '2019-07-07', '2026-01-12 14:51:53', '2026-01-12 14:56:51');
INSERT INTO `gpu_info` VALUES (26, 'AMD', 'Radeon RX 5700 XT', 8, 'GDDR6', 256, 1605, 1905, 225, 'PCIe 4.0 x16', '2019-07-07', '2026-01-12 14:51:53', '2026-01-12 14:56:52');
INSERT INTO `gpu_info` VALUES (27, 'AMD', 'Radeon RX 6600', 8, 'GDDR6', 128, 2044, 2589, 132, 'PCIe 4.0 x8', '2021-10-13', '2026-01-12 14:51:53', '2026-01-12 14:56:54');
INSERT INTO `gpu_info` VALUES (28, 'AMD', 'Radeon RX 6600 XT', 8, 'GDDR6', 128, 2359, 2589, 160, 'PCIe 4.0 x8', '2021-07-30', '2026-01-12 14:51:53', '2026-01-12 14:56:55');
INSERT INTO `gpu_info` VALUES (29, 'AMD', 'Radeon RX 6700 XT', 12, 'GDDR6', 192, 2424, 2581, 180, 'PCIe 4.0 x16', '2021-03-18', '2026-01-12 14:51:53', '2026-01-12 14:56:56');
INSERT INTO `gpu_info` VALUES (30, 'AMD', 'Radeon RX 6800', 16, 'GDDR6', 256, 1815, 2105, 250, 'PCIe 4.0 x16', '2020-11-18', '2026-01-12 14:51:53', '2026-01-12 14:56:58');
INSERT INTO `gpu_info` VALUES (31, 'AMD', 'Radeon RX 6800 XT', 16, 'GDDR6', 256, 2015, 2250, 250, 'PCIe 4.0 x16', '2020-11-18', '2026-01-12 14:51:53', '2026-01-12 14:56:59');
INSERT INTO `gpu_info` VALUES (32, 'AMD', 'Radeon RX 6900 XT', 16, 'GDDR6', 256, 2015, 2250, 300, 'PCIe 4.0 x16', '2020-12-08', '2026-01-12 14:51:53', '2026-01-12 14:57:01');
INSERT INTO `gpu_info` VALUES (33, 'AMD', 'Radeon RX 7600', 8, 'GDDR6', 128, 2250, 2655, 165, 'PCIe 4.0 x8', '2023-05-25', '2026-01-12 14:51:53', '2026-01-12 14:57:02');
INSERT INTO `gpu_info` VALUES (34, 'AMD', 'Radeon RX 7700 XT', 12, 'GDDR6', 192, 2544, 2655, 245, 'PCIe 4.0 x16', '2023-09-20', '2026-01-12 14:51:53', '2026-01-12 14:57:04');
INSERT INTO `gpu_info` VALUES (35, 'AMD', 'Radeon RX 7800 XT', 16, 'GDDR6', 256, 2124, 2500, 263, 'PCIe 4.0 x16', '2023-09-20', '2026-01-12 14:51:53', '2026-01-12 14:57:05');
INSERT INTO `gpu_info` VALUES (36, 'AMD', 'Radeon RX 7900 GRE', 16, 'GDDR6', 256, 2167, 2500, 263, 'PCIe 4.0 x16', '2023-12-14', '2026-01-12 14:51:53', '2026-01-12 14:57:06');
INSERT INTO `gpu_info` VALUES (37, 'AMD', 'Radeon RX 7900 XTX', 24, 'GDDR6', 384, 2300, 2500, 355, 'PCIe 4.0 x16', '2022-12-13', '2026-01-12 14:51:53', '2026-01-12 14:57:07');
INSERT INTO `gpu_info` VALUES (38, 'AMD', 'Radeon RX 7900 XT', 20, 'GDDR6', 384, 2000, 2500, 300, 'PCIe 4.0 x16', '2022-12-13', '2026-01-12 14:51:53', '2026-01-12 14:57:08');
INSERT INTO `gpu_info` VALUES (39, 'AMD', 'Radeon RX 9060XT', 16, 'GDDR6', 128, 2300, 2700, 160, 'PCIe 5.0 x16', '2025-01-01', '2026-01-12 14:51:53', '2026-02-02 16:19:34');
INSERT INTO `gpu_info` VALUES (40, 'AMD', 'Radeon RX 9070', 16, 'GDDR6', 256, 2400, 2800, 220, 'PCIe 5.0 x16', '2025-01-01', '2026-01-12 14:51:53', '2026-02-02 16:20:06');
INSERT INTO `gpu_info` VALUES (41, 'AMD', 'Radeon RX 9070XT', 24, 'GDDR6', 256, 2500, 2900, 304, 'PCIe 5.0 x16', '2025-01-01', '2026-01-12 14:51:53', '2026-02-02 16:20:18');

-- ----------------------------
-- Table structure for motherboard_info
-- ----------------------------
DROP TABLE IF EXISTS `motherboard_info`;
CREATE TABLE `motherboard_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主板ID',
  `brand` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '品牌 (ASUS, MSI, Gigabyte)',
  `model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '型号 (如: B650M-A)',
  `chipset` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '芯片组 (如: B650, Z790)',
  `cpu_interface` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '支持的CPU接口 (如: AM5, LGA1700)',
  `memory_slots` int(11) NULL DEFAULT NULL COMMENT '内存插槽数量',
  `max_memory` int(11) NULL DEFAULT NULL COMMENT '最大支持内存容量 (GB)',
  `memory_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支持的内存类型 (DDR4, DDR5)',
  `power_phase` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '供电相数 (如: 8+2相)',
  `sata_ports` int(11) NULL DEFAULT NULL COMMENT 'SATA接口数量',
  `m2_slots` int(11) NULL DEFAULT NULL COMMENT 'M.2插槽数量',
  `release_date` date NULL DEFAULT NULL COMMENT '发布日期',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `model`(`model`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 68 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '主板参数表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of motherboard_info
-- ----------------------------
INSERT INTO `motherboard_info` VALUES (1, 'ASUS', 'PRIME B350M-A', 'B350', 'AM4', 4, 64, 'DDR4', '8+2相', 6, 2, '2017-04-01', '2026-01-12 14:51:53', '2026-01-12 14:55:38');
INSERT INTO `motherboard_info` VALUES (2, 'MSI', 'B450M PRO-VDH', 'B450', 'AM4', 4, 64, 'DDR4', '6+2相', 6, 2, '2018-04-01', '2026-01-12 14:51:53', '2026-01-12 14:55:39');
INSERT INTO `motherboard_info` VALUES (3, 'Gigabyte', 'B550M AORUS ELITE', 'B550', 'AM4', 4, 128, 'DDR4', '12+2相', 6, 2, '2020-06-16', '2026-01-12 14:51:53', '2026-01-12 14:55:40');
INSERT INTO `motherboard_info` VALUES (4, 'ASUS', 'ROG STRIX B550-F GAMING', 'B550', 'AM4', 4, 128, 'DDR4', '14+2相', 6, 2, '2020-06-16', '2026-01-12 14:51:53', '2026-01-12 14:55:40');
INSERT INTO `motherboard_info` VALUES (5, 'ASUS', 'PRIME B650M-A', 'B650', 'AM5', 4, 128, 'DDR5', '8+2相', 6, 2, '2022-09-27', '2026-01-12 14:51:53', '2026-01-12 14:55:41');
INSERT INTO `motherboard_info` VALUES (6, 'MSI', 'PRO B650M-A WIFI', 'B650', 'AM5', 4, 128, 'DDR5', '12+2相', 6, 2, '2022-09-27', '2026-01-12 14:51:53', '2026-01-12 14:55:44');
INSERT INTO `motherboard_info` VALUES (7, 'Gigabyte', 'B650 AORUS ELITE AX', 'B650', 'AM5', 4, 128, 'DDR5', '12+2相', 6, 2, '2022-09-27', '2026-01-12 14:51:53', '2026-01-12 14:55:43');
INSERT INTO `motherboard_info` VALUES (8, 'ASUS', 'ROG STRIX B650E-F GAMING', 'B650E', 'AM5', 4, 128, 'DDR5', '14+2相', 6, 2, '2022-09-27', '2026-01-12 14:51:53', '2026-01-12 14:55:46');
INSERT INTO `motherboard_info` VALUES (9, 'ASUS', 'PRIME H270-PLUS', 'H270', 'LGA1151', 4, 64, 'DDR4', '8+2相', 6, 2, '2017-01-01', '2026-01-12 14:51:53', '2026-01-12 14:55:47');
INSERT INTO `motherboard_info` VALUES (10, 'MSI', 'B360M PRO-VDH', 'B360', 'LGA1151', 4, 64, 'DDR4', '6+2相', 6, 2, '2018-04-01', '2026-01-12 14:51:53', '2026-01-12 14:55:48');
INSERT INTO `motherboard_info` VALUES (11, 'Gigabyte', 'Z390 AORUS PRO', 'Z390', 'LGA1151', 4, 64, 'DDR4', '12+2相', 6, 2, '2018-10-01', '2026-01-12 14:51:53', '2026-01-12 14:55:48');
INSERT INTO `motherboard_info` VALUES (12, 'ASUS', 'ROG STRIX Z390-E GAMING', 'Z390', 'LGA1151', 4, 64, 'DDR4', '14+2相', 6, 2, '2018-10-01', '2026-01-12 14:51:53', '2026-01-12 14:55:49');
INSERT INTO `motherboard_info` VALUES (13, 'ASUS', 'PRIME B460M-A', 'B460', 'LGA1200', 4, 128, 'DDR4', '8+2相', 6, 2, '2020-04-30', '2026-01-12 14:51:53', '2026-01-12 14:55:50');
INSERT INTO `motherboard_info` VALUES (14, 'MSI', 'B560M PRO-VDH', 'B560', 'LGA1200', 4, 128, 'DDR4', '12+2相', 6, 2, '2021-03-30', '2026-01-12 14:51:53', '2026-01-12 14:55:51');
INSERT INTO `motherboard_info` VALUES (15, 'Gigabyte', 'Z590 AORUS ELITE AX', 'Z590', 'LGA1200', 4, 128, 'DDR4', '12+2相', 6, 2, '2021-03-30', '2026-01-12 14:51:53', '2026-01-12 14:55:51');
INSERT INTO `motherboard_info` VALUES (16, 'ASUS', 'ROG STRIX Z590-F GAMING', 'Z590', 'LGA1200', 4, 128, 'DDR4', '14+2相', 6, 2, '2021-03-30', '2026-01-12 14:51:53', '2026-01-12 14:55:52');
INSERT INTO `motherboard_info` VALUES (17, 'ASUS', 'PRIME B760M-A', 'B760', 'LGA1700', 4, 128, 'DDR5', '8+2相', 6, 2, '2022-01-01', '2026-01-12 14:51:53', '2026-01-12 14:55:53');
INSERT INTO `motherboard_info` VALUES (18, 'MSI', 'B760M MORTAR WIFI', 'B760', 'LGA1700', 4, 128, 'DDR5', '12+2相', 6, 2, '2022-01-01', '2026-01-12 14:51:53', '2026-01-12 14:55:57');

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  `recipient_id` int(11) NOT NULL COMMENT '接收者ID',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '通知类型 (REPLY_TO_POST)',
  `related_id` int(11) NOT NULL COMMENT '相关ID (帖子ID)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `read_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '已读状态: 0-未读, 1-已读',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `recipient_id`(`recipient_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户通知表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notifications
-- ----------------------------
INSERT INTO `notifications` VALUES (17, 1, 'REPLY', 24, '2026-04-16 10:54:49', 0);
INSERT INTO `notifications` VALUES (13, 9, 'REPLY', 18, '2026-02-03 19:31:57', 0);
INSERT INTO `notifications` VALUES (15, 1, 'REPLY', 24, '2026-04-16 10:50:20', 0);
INSERT INTO `notifications` VALUES (16, 1, 'REPLY', 24, '2026-04-16 10:50:40', 0);
INSERT INTO `notifications` VALUES (18, 1, 'REPLY', 23, '2026-04-16 11:06:44', 0);
INSERT INTO `notifications` VALUES (19, 1, 'REPLY', 23, '2026-04-16 11:07:36', 0);
INSERT INTO `notifications` VALUES (20, 1, 'REPLY', 23, '2026-04-16 11:09:59', 0);

-- ----------------------------
-- Table structure for param_change_history
-- ----------------------------
DROP TABLE IF EXISTS `param_change_history`;
CREATE TABLE `param_change_history`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '历史记录ID',
  `table_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '被修改的表名 (cpu_info, gpu_info等)',
  `record_id` int(11) NOT NULL COMMENT '被修改的记录ID',
  `field_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '被修改的字段名',
  `old_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '修改前的值',
  `new_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改后的值',
  `operator_id` int(11) NOT NULL COMMENT '操作用户ID',
  `operator_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作者类型 (USER, ADMIN)',
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '修改原因或备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `operator_id`(`operator_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '参数修改历史表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of param_change_history
-- ----------------------------

-- ----------------------------
-- Table structure for param_reference
-- ----------------------------
DROP TABLE IF EXISTS `param_reference`;
CREATE TABLE `param_reference`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '引用记录ID',
  `post_id` int(11) NULL DEFAULT NULL COMMENT '引用所在的帖子ID (可空)',
  `reply_id` int(11) NULL DEFAULT NULL COMMENT '引用所在的回复ID (可空)',
  `param_table` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '引用的参数表名 (cpu_info, gpu_info等)',
  `param_id` int(11) NOT NULL COMMENT '引用的参数记录ID',
  `reference_text` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '引用时的文本描述 (如: B650M主板)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '引用时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `post_id`(`post_id`) USING BTREE,
  INDEX `reply_id`(`reply_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 78 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '参数引用表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of param_reference
-- ----------------------------
INSERT INTO `param_reference` VALUES (1, NULL, 9, 'cpu_info', 1, NULL, '2026-01-06 23:03:47');
INSERT INTO `param_reference` VALUES (2, NULL, 12, 'cpu_info', 3, NULL, '2026-01-10 01:04:51');
INSERT INTO `param_reference` VALUES (3, NULL, 13, 'cpu_info', 1, NULL, '2026-01-10 01:05:13');
INSERT INTO `param_reference` VALUES (4, NULL, 14, 'cpu_info', 3, NULL, '2026-01-10 01:05:25');
INSERT INTO `param_reference` VALUES (5, NULL, 15, 'cpu_info', 3, NULL, '2026-01-10 11:27:22');
INSERT INTO `param_reference` VALUES (6, NULL, 16, 'cpu_info', 3, NULL, '2026-01-10 11:33:59');
INSERT INTO `param_reference` VALUES (7, NULL, 17, 'cpu_info', 3, NULL, '2026-01-10 11:48:15');
INSERT INTO `param_reference` VALUES (8, NULL, 18, 'cpu_info', 1, NULL, '2026-01-10 11:49:03');
INSERT INTO `param_reference` VALUES (9, NULL, 19, 'cpu_info', 2, NULL, '2026-01-10 11:49:11');
INSERT INTO `param_reference` VALUES (10, NULL, 20, 'cpu_info', 3, NULL, '2026-01-10 11:54:08');
INSERT INTO `param_reference` VALUES (11, NULL, 21, 'gpu_info', 2, NULL, '2026-01-10 12:06:53');
INSERT INTO `param_reference` VALUES (12, NULL, 22, 'motherboard_info', 2, NULL, '2026-01-10 12:07:01');
INSERT INTO `param_reference` VALUES (13, NULL, NULL, 'gpu_info', 2, NULL, '2026-01-10 12:21:59');
INSERT INTO `param_reference` VALUES (14, NULL, NULL, 'cpu_info', 2, NULL, '2026-01-10 16:22:25');
INSERT INTO `param_reference` VALUES (15, 13, NULL, 'cpu_info', 2, NULL, '2026-01-10 17:29:20');
INSERT INTO `param_reference` VALUES (16, 13, NULL, 'cpu_info', 2, NULL, '2026-01-10 17:44:34');
INSERT INTO `param_reference` VALUES (17, 13, NULL, 'cpu_info', 2, NULL, '2026-01-10 18:02:47');
INSERT INTO `param_reference` VALUES (18, 13, NULL, 'cpu_info', 2, NULL, '2026-01-10 18:17:16');
INSERT INTO `param_reference` VALUES (19, NULL, NULL, 'motherboard_info', 2, NULL, '2026-01-10 19:38:52');
INSERT INTO `param_reference` VALUES (20, NULL, NULL, 'cpu_info', 2, NULL, '2026-01-10 19:42:28');
INSERT INTO `param_reference` VALUES (21, 16, NULL, 'cpu_info', 2, NULL, '2026-01-10 19:42:42');
INSERT INTO `param_reference` VALUES (22, NULL, 28, 'cpu_info', 2, NULL, '2026-01-10 19:55:48');
INSERT INTO `param_reference` VALUES (23, 15, NULL, 'motherboard_info', 2, NULL, '2026-01-10 20:29:04');
INSERT INTO `param_reference` VALUES (24, 15, NULL, 'cpu_info', 2, NULL, '2026-01-10 20:29:04');
INSERT INTO `param_reference` VALUES (25, 15, NULL, 'motherboard_info', 2, NULL, '2026-01-10 20:29:14');
INSERT INTO `param_reference` VALUES (26, 15, NULL, 'cpu_info', 2, NULL, '2026-01-10 20:29:14');
INSERT INTO `param_reference` VALUES (27, 15, NULL, 'gpu_info', 2, NULL, '2026-01-10 20:35:22');
INSERT INTO `param_reference` VALUES (28, 15, NULL, 'motherboard_info', 2, NULL, '2026-01-10 20:35:22');
INSERT INTO `param_reference` VALUES (29, 15, NULL, 'cpu_info', 2, NULL, '2026-01-10 20:35:22');
INSERT INTO `param_reference` VALUES (30, 15, NULL, 'cpu_info', 2, NULL, '2026-01-10 20:58:33');
INSERT INTO `param_reference` VALUES (31, 15, NULL, 'gpu_info', 2, NULL, '2026-01-10 20:58:33');
INSERT INTO `param_reference` VALUES (32, 15, NULL, 'motherboard_info', 2, NULL, '2026-01-10 20:58:33');
INSERT INTO `param_reference` VALUES (33, 15, NULL, 'cpu_info', 2, NULL, '2026-01-10 20:58:33');
INSERT INTO `param_reference` VALUES (34, NULL, 29, 'cpu_info', 2, NULL, '2026-01-10 20:58:42');
INSERT INTO `param_reference` VALUES (35, NULL, 32, 'gpu_info', 1, NULL, '2026-01-11 11:33:28');
INSERT INTO `param_reference` VALUES (36, 13, NULL, 'cpu_info', 2, NULL, '2026-01-11 12:05:32');
INSERT INTO `param_reference` VALUES (37, 13, NULL, 'cpu_info', 2, NULL, '2026-01-11 12:05:32');
INSERT INTO `param_reference` VALUES (38, NULL, 33, 'cpu_info', 2, NULL, '2026-01-11 12:06:01');
INSERT INTO `param_reference` VALUES (39, NULL, 35, 'cpu_info', 2, NULL, '2026-01-11 14:17:21');
INSERT INTO `param_reference` VALUES (40, 16, NULL, 'cpu_info', 2, NULL, '2026-01-11 14:17:34');
INSERT INTO `param_reference` VALUES (41, 16, NULL, 'cpu_info', 2, NULL, '2026-01-11 14:17:34');
INSERT INTO `param_reference` VALUES (42, NULL, NULL, 'gpu_info', 1, NULL, '2026-01-11 14:17:50');
INSERT INTO `param_reference` VALUES (43, NULL, 37, 'cpu_info', 2, NULL, '2026-01-11 18:29:59');
INSERT INTO `param_reference` VALUES (44, NULL, 38, 'gpu_info', 2, NULL, '2026-01-11 22:06:49');
INSERT INTO `param_reference` VALUES (45, NULL, 38, 'motherboard_info', 1, NULL, '2026-01-11 22:06:49');
INSERT INTO `param_reference` VALUES (46, NULL, 38, 'motherboard_info', 2, NULL, '2026-01-11 22:06:49');
INSERT INTO `param_reference` VALUES (47, NULL, 38, 'cpu_info', 1, NULL, '2026-01-11 22:06:49');
INSERT INTO `param_reference` VALUES (48, NULL, 39, 'cpu_info', 1, NULL, '2026-01-11 22:08:49');
INSERT INTO `param_reference` VALUES (49, NULL, 40, 'cpu_info', 1, NULL, '2026-01-11 22:39:22');
INSERT INTO `param_reference` VALUES (50, NULL, 40, 'cpu_info', 2, NULL, '2026-01-11 22:39:22');
INSERT INTO `param_reference` VALUES (51, NULL, 40, 'gpu_info', 1, NULL, '2026-01-11 22:39:22');
INSERT INTO `param_reference` VALUES (52, NULL, 40, 'gpu_info', 2, NULL, '2026-01-11 22:39:22');
INSERT INTO `param_reference` VALUES (53, NULL, 40, 'motherboard_info', 1, NULL, '2026-01-11 22:39:22');
INSERT INTO `param_reference` VALUES (54, NULL, 40, 'motherboard_info', 2, NULL, '2026-01-11 22:39:22');
INSERT INTO `param_reference` VALUES (55, NULL, 41, 'cpu_info', 11, NULL, '2026-01-12 14:59:01');
INSERT INTO `param_reference` VALUES (56, NULL, 42, 'cpu_info', 1, NULL, '2026-01-12 20:33:44');
INSERT INTO `param_reference` VALUES (57, NULL, 47, 'cpu_info', 13, NULL, '2026-01-12 22:52:58');
INSERT INTO `param_reference` VALUES (58, NULL, 50, 'cpu_info', 11, NULL, '2026-01-14 15:47:07');
INSERT INTO `param_reference` VALUES (59, 17, NULL, 'gpu_info', 1, NULL, '2026-01-14 15:47:26');
INSERT INTO `param_reference` VALUES (60, NULL, NULL, 'cpu_info', 1, NULL, '2026-02-02 15:15:50');
INSERT INTO `param_reference` VALUES (61, NULL, 52, 'cpu_info', 1004, NULL, '2026-02-02 18:51:28');
INSERT INTO `param_reference` VALUES (62, NULL, 54, 'cpu_info', 10, NULL, '2026-02-02 20:31:43');
INSERT INTO `param_reference` VALUES (63, NULL, 56, 'cpu_info', 10012, NULL, '2026-02-03 12:02:01');
INSERT INTO `param_reference` VALUES (64, NULL, 59, 'cpu_info', 10010, NULL, '2026-02-03 19:23:45');
INSERT INTO `param_reference` VALUES (65, NULL, NULL, 'cpu_info', 2, NULL, '2026-02-04 15:14:45');
INSERT INTO `param_reference` VALUES (66, NULL, NULL, 'cpu_info', 10, NULL, '2026-03-10 19:48:52');
INSERT INTO `param_reference` VALUES (67, NULL, NULL, 'cpu_info', 1, NULL, '2026-03-31 14:59:09');
INSERT INTO `param_reference` VALUES (68, NULL, 67, 'cpu_info', 1009, NULL, '2026-03-31 14:59:20');
INSERT INTO `param_reference` VALUES (69, NULL, 72, 'cpu_info', 10017, NULL, '2026-03-31 15:35:21');
INSERT INTO `param_reference` VALUES (70, NULL, NULL, 'motherboard_info', 1, NULL, '2026-03-31 15:37:43');
INSERT INTO `param_reference` VALUES (71, NULL, 78, 'cpu_info', 1004, NULL, '2026-04-16 11:06:44');
INSERT INTO `param_reference` VALUES (72, NULL, 79, 'gpu_info', 4, NULL, '2026-04-16 11:07:36');
INSERT INTO `param_reference` VALUES (73, NULL, 80, 'cpu_info', 5, NULL, '2026-04-16 11:09:59');
INSERT INTO `param_reference` VALUES (74, NULL, 80, 'motherboard_info', 1, NULL, '2026-04-16 11:09:59');
INSERT INTO `param_reference` VALUES (75, NULL, 80, 'gpu_info', 3, NULL, '2026-04-16 11:09:59');
INSERT INTO `param_reference` VALUES (76, NULL, NULL, 'gpu_info', 1, NULL, '2026-04-17 14:43:38');
INSERT INTO `param_reference` VALUES (77, NULL, 82, 'cpu_info', 2, NULL, '2026-04-17 16:20:52');

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '帖子ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '帖子标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '帖子内容',
  `user_id` int(11) NOT NULL COMMENT '发帖用户ID',
  `section_id` int(11) NOT NULL COMMENT '所属分区ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发帖时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `is_locked` tinyint(1) NULL DEFAULT 0 COMMENT '是否锁定 (0: 否, 1: 是)',
  `view_count` int(11) NULL DEFAULT 0 COMMENT '浏览次数',
  `pin_level` int(11) NULL DEFAULT 0 COMMENT '置顶级别，0为不置顶，数值越大置顶级别越高',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `section_id`(`section_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 38 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES (22, '111', '222\r\n[cpu_info:1]', 1, 1, '2026-03-31 14:59:08', '2026-04-17 14:37:53', 0, 9, 0);
INSERT INTO `post` VALUES (23, '测试', '![](/uploads/20260331153731_cf6061f1.png)\r\n[motherboard_info:1]\r\n123', 1, 5, '2026-03-31 15:37:43', '2026-04-16 11:12:29', 0, 8, 0);
INSERT INTO `post` VALUES (24, 'Ultra 7 265K对比14700KF测试报告', '正值中国的双十一，电脑硬件市场就迎来了一则重磅新闻——Intel推出了全新架构的酷睿Ultra 200S系列台式处理器。这一代处理器搭载全新的Arrow Lake架构，内置了独立的NPU，在散热和能耗上有了巨幅的提升。\r\n![](/uploads/20260416104138_b5d4522d.png)\r\n本次推出的型号共计五款，分别是Ultra 9 285K、Ultra 7 265K/KF以及Ultra 5 245K/KF，其中K表示（核显）和KF则表示（无核显），本篇文章我们重点关注Ultra 7 265K，并将通过实测对比14700KF。\r\n![](/uploads/20260416104212_04a6da19.png)\r\n我们先简单过一遍Ultra 7 265K和14700KF的参数规格。Ultra 7 265K配备了20核20线程，基础频率为3.9GHz，最大睿频可达5.5GHz，并拥有33MB的三级缓存。由于英特尔在底层结构下大刀阔斧的改革拿出的全新的Arrow Lake架构，即便放弃了超线程，依旧能让Ultra 7 265K拥有相比以往更出色的每瓦性能和用户体验。包括降低了约40%的整体功耗、超过15%左右的代际多线程性能提升。\r\n\r\n14700KF同为20核，拥有28线程，主频高于Ultra 7 265K。但是因为架构的原因，差不多的性能下，它125W的散热设计功耗，远高于Ultra 7 265K的65W。\r\n\r\n测试平台\r\n\r\n以下为测试平台的具体配置，均为各自的处理器选取了最合适的主板，搭配4090显卡，其他配置也尽量保持一致。\r\n\r\n![](/uploads/20260416104305_7098248f.png)\r\n\r\n基准测试\r\n\r\n通过CPU-Z跑分可以看出，尽管Ultra7 265KF单核得分稍逊i7-14700K，但到了多核跑分环节，Ultra7 265KF的15481.8分，是要超出i7-14700K的13415.9分一大截的。也就是说，线程更少的Ultra7 265KF，在多核能力上反而更强。\r\n![](/uploads/20260416104342_9c5b94d0.png)\r\n在Cinebench R23和Cinebench R24的测试中，两者依旧重复了CPU-Z的表现，Ultra7 265KF单核表现稍弱，但在多核测试中都会大幅度反超，其在多核上的表现确实让人眼前一亮。\r\n![](/uploads/20260416104422_d9e96712.png)\r\n', 1, 2, '2026-04-16 10:44:29', '2026-04-17 16:45:39', 0, 62, 0);
INSERT INTO `post` VALUES (21, '12312', '[cpu_info:10]\r\n撒大苏打', 1, 6, '2026-03-10 19:48:52', '2026-03-28 00:33:50', 0, 5, 0);
INSERT INTO `post` VALUES (20, '测试帖子', '[cpu_info:2]', 1, 1, '2026-02-04 15:14:45', '2026-04-17 14:37:51', 1, 53, 0);
INSERT INTO `post` VALUES (25, '111', '![](/uploads/20260416144716_cada3fb8.png)', 1, 1, '2026-04-16 14:47:20', '2026-04-16 14:47:20', 0, 1, 0);
INSERT INTO `post` VALUES (26, '1213', '12312', 1, 1, '2026-04-16 20:38:00', '2026-04-16 20:38:00', 0, 1, 0);
INSERT INTO `post` VALUES (27, '2233', '4555566', 1, 1, '2026-04-16 20:38:08', '2026-04-16 20:38:08', 0, 1, 0);
INSERT INTO `post` VALUES (28, '123123123', '3245234234', 1, 1, '2026-04-16 20:38:18', '2026-04-16 20:38:18', 0, 1, 0);
INSERT INTO `post` VALUES (29, '1231231231', '123123123', 1, 1, '2026-04-16 20:38:26', '2026-04-16 20:38:26', 0, 1, 0);
INSERT INTO `post` VALUES (30, '1231231231212', '3123123123142134324', 1, 1, '2026-04-16 20:38:38', '2026-04-16 20:38:38', 0, 1, 0);
INSERT INTO `post` VALUES (31, '23123', '34524234', 1, 1, '2026-04-16 20:55:15', '2026-04-16 20:55:15', 0, 1, 0);
INSERT INTO `post` VALUES (32, '1231233', '3453252343', 1, 1, '2026-04-16 20:55:31', '2026-04-16 20:55:31', 0, 1, 0);
INSERT INTO `post` VALUES (33, '123123123412423', 'erqewrq', 1, 1, '2026-04-16 20:55:39', '2026-04-16 20:55:42', 0, 2, 0);
INSERT INTO `post` VALUES (34, 'sadasd', '21312', 1, 2, '2026-04-16 20:56:25', '2026-04-16 20:56:25', 0, 1, 0);
INSERT INTO `post` VALUES (35, '123123', '1231231', 1, 1, '2026-04-16 21:10:44', '2026-04-16 21:10:44', 0, 1, 0);
INSERT INTO `post` VALUES (36, '1231231231', '12312', 1, 1, '2026-04-16 22:19:21', '2026-04-16 22:19:21', 0, 1, 0);
INSERT INTO `post` VALUES (37, '用户发帖', '![](/uploads/20260417144323_a5f236ab.png)\r\n信息图表\r\n[gpu_info:1]', 3, 1, '2026-04-17 14:43:38', '2026-04-17 14:43:38', 0, 1, 0);

-- ----------------------------
-- Table structure for post_favorite
-- ----------------------------
DROP TABLE IF EXISTS `post_favorite`;
CREATE TABLE `post_favorite`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '收藏记录ID',
  `user_id` int(11) NOT NULL COMMENT '收藏用户ID',
  `post_id` int(11) NOT NULL COMMENT '被收藏的帖子ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_user_post`(`user_id`, `post_id`) USING BTREE,
  INDEX `post_id`(`post_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子收藏表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of post_favorite
-- ----------------------------
INSERT INTO `post_favorite` VALUES (6, 3, 16, '2026-01-13 20:09:53');
INSERT INTO `post_favorite` VALUES (13, 1, 16, '2026-02-02 21:14:38');
INSERT INTO `post_favorite` VALUES (3, 1, 17, '2026-01-13 14:07:02');
INSERT INTO `post_favorite` VALUES (4, 1, 15, '2026-01-13 14:07:10');
INSERT INTO `post_favorite` VALUES (14, 11, 15, '2026-02-03 21:04:15');
INSERT INTO `post_favorite` VALUES (15, 1, 20, '2026-03-06 16:26:17');
INSERT INTO `post_favorite` VALUES (16, 1, 18, '2026-03-10 19:46:36');
INSERT INTO `post_favorite` VALUES (17, 14, 24, '2026-04-16 10:50:08');
INSERT INTO `post_favorite` VALUES (18, 13, 24, '2026-04-16 10:50:43');
INSERT INTO `post_favorite` VALUES (19, 3, 24, '2026-04-16 10:54:44');
INSERT INTO `post_favorite` VALUES (21, 1, 24, '2026-04-17 16:45:42');

-- ----------------------------
-- Table structure for post_like
-- ----------------------------
DROP TABLE IF EXISTS `post_like`;
CREATE TABLE `post_like`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '点赞记录ID',
  `user_id` int(11) NOT NULL COMMENT '点赞用户ID',
  `post_id` int(11) NOT NULL COMMENT '被点赞的帖子ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_user_post`(`user_id`, `post_id`) USING BTREE,
  INDEX `post_id`(`post_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子点赞表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of post_like
-- ----------------------------

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '回复ID',
  `post_id` int(11) NOT NULL COMMENT '所属帖子ID',
  `user_id` int(11) NOT NULL COMMENT '回复用户ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '回复内容',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '回复时间',
  `parent_reply_id` int(11) NULL DEFAULT NULL COMMENT '父回复ID (用于楼中楼)',
  `parent_id` int(11) NULL DEFAULT 0 COMMENT '父回复ID，0表示直接回复帖子',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `post_id`(`post_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `parent_reply_id`(`parent_reply_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 84 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '回复表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reply
-- ----------------------------
INSERT INTO `reply` VALUES (1, 1, 2, '这是对帖子1的第一条回复。', '2025-12-30 10:05:00', NULL, 0);
INSERT INTO `reply` VALUES (2, 1, 1, '这是对帖子1的第二条回复。', '2025-12-30 10:10:00', NULL, 0);
INSERT INTO `reply` VALUES (3, 2, 1, '这是对帖子2的回复。', '2025-12-30 11:05:00', NULL, 0);
INSERT INTO `reply` VALUES (4, 1, 2, '回复测试', '2026-01-02 21:29:41', NULL, 0);
INSERT INTO `reply` VALUES (5, 2, 2, '回复测试', '2026-01-02 21:29:53', NULL, 0);
INSERT INTO `reply` VALUES (6, 3, 2, '回复测试', '2026-01-02 21:30:06', NULL, 0);
INSERT INTO `reply` VALUES (7, 7, 2, '![](/uploads/20260106204850_cb1f9722.jpg)', '2026-01-06 20:48:52', NULL, 0);
INSERT INTO `reply` VALUES (8, 1, 2, '![](/uploads/20260106213145_618b0fee.jpg)\r\ncall back', '2026-01-06 21:31:52', NULL, 0);
INSERT INTO `reply` VALUES (9, 11, 1, '[cpu_info:1]i5\r\n', '2026-01-06 23:03:47', NULL, 0);
INSERT INTO `reply` VALUES (10, 3, 2, '111', '2026-01-09 13:54:14', NULL, 0);
INSERT INTO `reply` VALUES (11, 11, 2, '![](/uploads/20260109142000_5ef38c81.jpg)', '2026-01-09 14:20:04', NULL, 0);
INSERT INTO `reply` VALUES (30, 16, 1, '1·111', '2026-01-10 22:25:47', NULL, 0);
INSERT INTO `reply` VALUES (34, 15, 9, '112233', '2026-01-11 13:58:15', NULL, 0);
INSERT INTO `reply` VALUES (26, 15, 3, '![](/uploads/20260110193859_ab1a92c6.png)', '2026-01-10 19:39:07', NULL, 0);
INSERT INTO `reply` VALUES (25, 13, 3, '![](/uploads/20260110181721_114a6904.png)', '2026-01-10 18:17:22', NULL, 0);
INSERT INTO `reply` VALUES (21, 8, 3, '[gpu_info:2]', '2026-01-10 12:06:53', NULL, 0);
INSERT INTO `reply` VALUES (22, 8, 3, '[motherboard_info:2]', '2026-01-10 12:07:01', NULL, 0);
INSERT INTO `reply` VALUES (24, 13, 3, '![](/uploads/20260110174448_ce230737.png)', '2026-01-10 17:44:50', NULL, 0);
INSERT INTO `reply` VALUES (28, 15, 1, '[cpu_info:2]', '2026-01-10 19:55:48', NULL, 0);
INSERT INTO `reply` VALUES (33, 15, 3, '2233![](/uploads/20260111120557_48fa11c5.png)[cpu_info:2]', '2026-01-11 12:06:01', NULL, 0);
INSERT INTO `reply` VALUES (35, 16, 1, '测试![](/uploads/20260111141716_467532e5.png)[cpu_info:2]', '2026-01-11 14:17:21', NULL, 0);
INSERT INTO `reply` VALUES (36, 18, 9, '![](/uploads/20260111141834_7f2c3c54.png)', '2026-01-11 14:18:36', NULL, 0);
INSERT INTO `reply` VALUES (37, 15, 3, '[cpu_info:2]![](/uploads/20260111182957_97d602b4.png)', '2026-01-11 18:29:58', NULL, 0);
INSERT INTO `reply` VALUES (38, 15, 1, '[gpu_info:2][motherboard_info:1][motherboard_info:2][cpu_info:1]', '2026-01-11 22:06:49', NULL, 0);
INSERT INTO `reply` VALUES (39, 18, 1, '[cpu_info:1]', '2026-01-11 22:08:49', NULL, 0);
INSERT INTO `reply` VALUES (40, 15, 3, '[cpu_info:1][cpu_info:2][gpu_info:1][gpu_info:2][motherboard_info:1][motherboard_info:2]', '2026-01-11 22:39:22', NULL, 0);
INSERT INTO `reply` VALUES (41, 17, 1, '[cpu_info:11]', '2026-01-12 14:59:01', NULL, 0);
INSERT INTO `reply` VALUES (42, 16, 3, '测试\r\n[cpu_info:1]', '2026-01-12 20:33:44', NULL, 0);
INSERT INTO `reply` VALUES (43, 15, 1, '1', '2026-01-12 21:14:06', NULL, 0);
INSERT INTO `reply` VALUES (44, 15, 1, '3', '2026-01-12 21:14:09', NULL, 0);
INSERT INTO `reply` VALUES (45, 15, 1, '10', '2026-01-12 21:14:12', NULL, 0);
INSERT INTO `reply` VALUES (46, 15, 1, '88787878', '2026-01-12 21:14:17', NULL, 0);
INSERT INTO `reply` VALUES (47, 15, 1, '测试[cpu_info:13]![](/uploads/20260112225257_ad80e248.png)', '2026-01-12 22:52:58', NULL, 0);
INSERT INTO `reply` VALUES (48, 15, 1, '测试\r\n回复', '2026-01-13 14:07:17', NULL, 0);
INSERT INTO `reply` VALUES (49, 15, 1, '112233', '2026-01-14 01:01:31', NULL, 0);
INSERT INTO `reply` VALUES (50, 17, 1, '![](/uploads/20260114154700_3f399ba1.jpg)[cpu_info:11]', '2026-01-14 15:47:07', NULL, 0);
INSERT INTO `reply` VALUES (51, 16, 1, '测试', '2026-02-02 18:27:54', NULL, 0);
INSERT INTO `reply` VALUES (52, 16, 1, '[cpu_info:1004]', '2026-02-02 18:51:28', NULL, 0);
INSERT INTO `reply` VALUES (53, 16, 1, '![](/uploads/20260202185228_d64406e9.png)', '2026-02-02 18:52:29', NULL, 0);
INSERT INTO `reply` VALUES (54, 16, 1, '[cpu_info:10]', '2026-02-02 20:31:43', NULL, 0);
INSERT INTO `reply` VALUES (55, 16, 3, '1122', '2026-02-02 22:57:32', NULL, 0);
INSERT INTO `reply` VALUES (56, 19, 3, '测试回复通知[cpu_info:10012]', '2026-02-03 12:02:01', NULL, 0);
INSERT INTO `reply` VALUES (57, 16, 11, '12123123', '2026-02-03 19:08:39', NULL, 0);
INSERT INTO `reply` VALUES (58, 19, 11, '21312312', '2026-02-03 19:08:50', NULL, 0);
INSERT INTO `reply` VALUES (59, 19, 1, '[cpu_info:10010]', '2026-02-03 19:23:45', NULL, 0);
INSERT INTO `reply` VALUES (60, 18, 1, '1111', '2026-02-03 19:31:57', NULL, 0);
INSERT INTO `reply` VALUES (61, 16, 1, '1122', '2026-02-03 19:33:42', NULL, 0);
INSERT INTO `reply` VALUES (62, 16, 1, '222', '2026-02-03 19:37:15', NULL, 0);
INSERT INTO `reply` VALUES (63, 16, 1, '23123', '2026-02-03 19:39:44', NULL, 0);
INSERT INTO `reply` VALUES (64, 20, 1, '111', '2026-02-04 15:15:00', NULL, 0);
INSERT INTO `reply` VALUES (65, 20, 11, '回复测试提醒', '2026-03-06 16:29:24', NULL, 0);
INSERT INTO `reply` VALUES (66, 20, 1, '![](/uploads/20260310194811_a67ac113.jpg)', '2026-03-10 19:48:14', NULL, 0);
INSERT INTO `reply` VALUES (67, 22, 1, '[cpu_info:1009]', '2026-03-31 14:59:20', NULL, 0);
INSERT INTO `reply` VALUES (68, 22, 1, '![](/uploads/20260331145944_7808d337.png)', '2026-03-31 14:59:46', NULL, 0);
INSERT INTO `reply` VALUES (72, 20, 1, '[cpu_info:10017]', '2026-03-31 15:35:21', NULL, 0);
INSERT INTO `reply` VALUES (71, 20, 1, '![](/uploads/20260331153507_afc96096.png)', '2026-03-31 15:35:09', NULL, 0);
INSERT INTO `reply` VALUES (73, 24, 1, '生产力测试\r\n\r\n接下来，我们看一下双方在内容创作方面的性能差异。\r\n\r\n在V-Ray的对比中，Ultra7 265KF获得了35708分，依旧是远远高过了i7-14700K的29917分。\r\n![](/uploads/20260416104522_275906fb.png)\r\n随后对比的PS、PR、3dsmark、maya测试中，Ultra 7 265KF和i7-14700K互有胜负。在视频渲染和3D建模等生产力测试中，Ultra 7 265KF的表现更为突出。\r\n\r\n这和Ultra7 265KF内置独立NPU，自带13T的AI算力，以及全新升级，采用Xe-LPG架构、支持 XeSS、Xe 媒体引擎、矢量引擎、DX12U 等技术，具备 8TOPS AI 算力的核显有着很大的关系。\r\n\r\n要注意的是，测试分数中还没有体现二者在能耗和散热上的差距，在实际操作中，同样的软件，Ultra7 265KF明显发热更低，噪音控制也更好。\r\n\r\n游戏测试\r\n\r\n接下来是游戏爱好者最关心的游戏测试。首先是网络游戏的对比。相比14700K，Ultra7 265KF在网络游戏上的表现稍逊一些，不过因为本身网游帧数动辄数百帧，这点差距其实不大。\r\n![](/uploads/20260416104556_bcbb64ba.png)\r\n但随后在3A游戏环节，Ultra7 265KF绝大部分游戏中都是帧率更高的一个，而且领先幅度并不低。\r\n![](/uploads/20260416104625_795e850d.png)\r\n而在包括《全面战争：三国》这样的RTS游戏中，Ultra7 265KF更是全面压倒14700K，领先优势进一步扩大。\r\n![](/uploads/20260416104659_3af355ee.png)\r\n游戏测试下来，除了网游之外，各类单机游戏，Ultra7 265KF大都可以获得更高的帧率。同时，帧数依旧没有体现出Ultra7 265KF在温度和功耗上的优势。双方在功耗上的差距甚至能达到40%，Ultra7 265KF游戏时的温度也明显更低，如果想搭建ITX小机箱的话，这样低功耗的平台，显然更具优势。\r\n\r\n温度和功耗的表现，可以参考《永劫无间》以及《绝地求生》的游戏实测，无需水冷，仅仅搭载Bi5F散热方案，Ultra7 265KF即可降温度控制在53℃，表现相当优异。', '2026-04-16 10:47:08', NULL, 0);
INSERT INTO `reply` VALUES (74, 24, 1, '总结\r\n\r\n经过一系列详细的实测，作为全新一代的处理器，Ultra7 265K在散热和功耗上的表现让人印象深刻。对比14700K，尽管价格稍高，但新平台的特性和优势已经显现；对比 U9 285K，只是少了4个E核，但价格却便宜1600元，性价比也很突出，可以说是目前新平台中性价比极高的存在了。\r\n\r\n', '2026-04-16 10:47:52', NULL, 0);
INSERT INTO `reply` VALUES (75, 24, 14, '虽然是浪费晶圆的FW，但对我这种看看股票，在意视频编解码的人还是有点吸引力，看这销量 大跳水指日可待', '2026-04-16 10:50:20', NULL, 0);
INSERT INTO `reply` VALUES (76, 24, 13, '从单核牙膏倒吸和多核成绩好来看，大核缩了，主要加强了小核性能', '2026-04-16 10:50:40', NULL, 0);
INSERT INTO `reply` VALUES (77, 24, 3, '平台贵了很多，性能倒退，有任何升级必要！真要升，转AMD吧', '2026-04-16 10:54:49', NULL, 0);
INSERT INTO `reply` VALUES (78, 23, 3, '[cpu_info:1004]', '2026-04-16 11:06:44', NULL, 0);
INSERT INTO `reply` VALUES (79, 23, 3, '[gpu_info:4]', '2026-04-16 11:07:36', NULL, 0);
INSERT INTO `reply` VALUES (80, 23, 3, '[cpu_info:5]ryzen 3600 +[motherboard_info:1]+[gpu_info:3]GTX 1070 ', '2026-04-16 11:09:59', NULL, 0);
INSERT INTO `reply` VALUES (81, 33, 1, '13123123', '2026-04-16 20:55:41', NULL, 0);
INSERT INTO `reply` VALUES (82, 24, 1, '![](/uploads/20260417162047_f985d068.png)\r\n[cpu_info:2]', '2026-04-17 16:20:52', NULL, 0);
INSERT INTO `reply` VALUES (83, 24, 1, '   123', '2026-04-17 16:27:45', NULL, 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'MD5加密后的密码',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'USER' COMMENT '用户角色 (USER, CERTIFIED, ADMIN)',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '/static/avatar/1.png' COMMENT '用户头像路径',
  `certification_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '认证原因或备注 (仅认证用户)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '系统管理员', '8dc4ad329ad18e849649e50f4c3feaf7', '2025-12-20 23:28:01', 'ADMIN', '/static/avatar/9.png', NULL);
INSERT INTO `user` VALUES (2, '123456', 'e10adc3949ba59abbe56e057f20f883e', '2025-12-30 22:08:22', 'USER', '/static/avatar/1.png', NULL);
INSERT INTO `user` VALUES (3, 'DORORO', '8dc4ad329ad18e849649e50f4c3feaf7', '2026-01-06 16:25:52', 'CERTIFIED', '/static/avatar/6.png', NULL);
INSERT INTO `user` VALUES (4, '测试', '698d51a19d8a121ce581499d7b701668', '2026-01-09 20:49:45', 'USER', '/static/avatar/8.png', NULL);
INSERT INTO `user` VALUES (5, '测试2', '698d51a19d8a121ce581499d7b701668', '2026-01-09 20:50:47', 'USER', '/static/avatar/2.png', NULL);
INSERT INTO `user` VALUES (6, '测试3', '698d51a19d8a121ce581499d7b701668', '2026-01-09 21:21:02', 'USER', '/static/avatar/1.png', NULL);
INSERT INTO `user` VALUES (7, 'AONGEL2', '8dc4ad329ad18e849649e50f4c3feaf7', '2026-01-09 22:06:41', 'USER', '/static/avatar/1.png', NULL);
INSERT INTO `user` VALUES (8, '测试4', '698d51a19d8a121ce581499d7b701668', '2026-01-09 22:36:57', 'CERTIFIED', '/static/avatar/1.png', NULL);
INSERT INTO `user` VALUES (9, 'KY', '4297f44b13955235245b2497399d7a93', '2026-01-11 13:57:31', 'USER', '/static/avatar/1.png', NULL);
INSERT INTO `user` VALUES (10, '未注册', '698d51a19d8a121ce581499d7b701668', '2026-02-03 16:41:57', 'USER', '/static/avatar/1.png', NULL);
INSERT INTO `user` VALUES (11, 'ssss', '8f60c8102d29fcd525162d02eed4566b', '2026-02-03 18:33:35', 'USER', '/static/avatar/4.png', NULL);
INSERT INTO `user` VALUES (12, '123', '202cb962ac59075b964b07152d234b70', '2026-03-07 13:58:40', 'USER', '/static/avatar/4.png', NULL);
INSERT INTO `user` VALUES (13, '213', '979d472a84804b9f647bc185a877a8b5', '2026-03-07 14:09:00', 'USER', '/static/avatar/1.png', NULL);
INSERT INTO `user` VALUES (14, '1234567', 'fcea920f7412b5da7be0cf42b8c93759', '2026-03-10 18:48:10', 'USER', '/static/avatar/1.png', NULL);

SET FOREIGN_KEY_CHECKS = 1;

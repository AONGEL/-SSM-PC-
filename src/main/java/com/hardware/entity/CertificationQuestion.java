package com.hardware.entity;

import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CertificationQuestion {
    private Integer id;
    private String questionType; // fill_blank, open_ended
    private String questionContent;
    private Boolean isActive;
    private Date createdAt;
    private Date updatedAt;

    // Constructors
    public CertificationQuestion() {}
    public CertificationQuestion(String questionType, String questionContent, Boolean isActive) {
        this.questionType = questionType;
        this.questionContent = questionContent;
        this.isActive = isActive;
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getQuestionType() { return questionType; }
    public void setQuestionType(String questionType) { this.questionType = questionType; }

    public String getQuestionContent() { return questionContent; }
    public void setQuestionContent(String questionContent) { this.questionContent = questionContent; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean active) { isActive = active; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    @Override
    public String toString() {
        return "CertificationQuestion{" +
                "id=" + id +
                ", questionType='" + questionType + '\'' +
                ", questionContent='" + questionContent + '\'' +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }

    // --- 新增方法：生成带中文提示的问题内容 ---
    public String getFormattedQuestionContent() {
        if ("fill_blank".equals(this.questionType)) {
            // 匹配 [____] 或 [_____...] 格式的占位符
            String regex = "\\[(\\s*_*\\s*)\\]";
            Pattern pattern = Pattern.compile(regex);
            Matcher matcher = pattern.matcher(this.questionContent);

            StringBuffer sb = new StringBuffer();
            int blankCounter = 1;
            while (matcher.find()) {
                // 替换为中文提示，例如 (第一空), (第二空)...
                String replacement = "(第" + getChineseNumber(blankCounter) + "空)";
                matcher.appendReplacement(sb, replacement);
                blankCounter++;
            }
            matcher.appendTail(sb);
            return sb.toString();
        } else {
            // 对于简答题，直接返回原内容
            return this.questionContent;
        }
    }

    // 辅助方法：将数字转换为中文数字 (简单处理1-10)
    private String getChineseNumber(int num) {
        String[] chineseNumbers = {"零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十"};
        if (num >= 1 && num <= 10) {
            return chineseNumbers[num];
        } else {
            // 如果超过10，可以返回阿拉伯数字或其他处理方式
            return String.valueOf(num); // 或者抛出异常
        }
    }
    // --- /新增方法 ---
}
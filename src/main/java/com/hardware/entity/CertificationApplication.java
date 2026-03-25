package com.hardware.entity;

import java.util.Date;
import java.util.Map;

public class CertificationApplication {
    private Integer id;
    private Integer userId;
    private String applicationStatus; // pending, approved, rejected, pending_discussion
    private Date submittedAt;
    private Integer examDuration; // in seconds
    private String answers; // Store as JSON string
    private String adminRemarks;
    private Date reviewedAt;

    // --- 新增：关联的用户名 ---
    private String applicantUsername;
    // --- /新增 ---

    // Constructors
    public CertificationApplication() {}
    public CertificationApplication(Integer userId, String answers, Integer examDuration) {
        this.userId = userId;
        this.answers = answers;
        this.examDuration = examDuration;
        this.applicationStatus = "pending"; // Default status
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public String getApplicationStatus() { return applicationStatus; }
    public void setApplicationStatus(String applicationStatus) { this.applicationStatus = applicationStatus; }

    public Date getSubmittedAt() { return submittedAt; }
    public void setSubmittedAt(Date submittedAt) { this.submittedAt = submittedAt; }

    public Integer getExamDuration() { return examDuration; }
    public void setExamDuration(Integer examDuration) { this.examDuration = examDuration; }

    public String getAnswers() { return answers; }
    public void setAnswers(String answers) { this.answers = answers; }

    public String getAdminRemarks() { return adminRemarks; }
    public void setAdminRemarks(String adminRemarks) { this.adminRemarks = adminRemarks; }

    public Date getReviewedAt() { return reviewedAt; }
    public void setReviewedAt(Date reviewedAt) { this.reviewedAt = reviewedAt; }

    // --- 新增：getter/setter for applicantUsername ---
    public String getApplicantUsername() {
        return applicantUsername;
    }

    public void setApplicantUsername(String applicantUsername) {
        this.applicantUsername = applicantUsername;
    }
    // --- /新增 ---

    @Override
    public String toString() {
        return "CertificationApplication{" +
                "id=" + id +
                ", userId=" + userId +
                ", applicationStatus='" + applicationStatus + '\'' +
                ", submittedAt=" + submittedAt +
                ", examDuration=" + examDuration +
                ", answers='" + answers + '\'' +
                ", adminRemarks='" + adminRemarks + '\'' +
                ", reviewedAt=" + reviewedAt +
                // 添加 applicantUsername 到 toString
                ", applicantUsername='" + applicantUsername + '\'' +
                '}';
    }
}
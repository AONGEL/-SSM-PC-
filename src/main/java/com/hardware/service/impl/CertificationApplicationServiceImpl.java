package com.hardware.service.impl;

import com.hardware.dao.CertificationApplicationDao;
import com.hardware.entity.CertificationApplication;
import com.hardware.service.CertificationApplicationService;
import com.hardware.service.UserService; // 注入UserService
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.Date; // 导入 Date 类
import java.util.List;

@Service
@Transactional
public class CertificationApplicationServiceImpl implements CertificationApplicationService {

    @Autowired
    private CertificationApplicationDao certificationApplicationDao;

    @Autowired
    private UserService userService; // 注入UserService

    @Override
    public List<CertificationApplication> getAllApplications() {
        System.out.println("Service: getAllApplications called"); // 调试日志
        // 调用 DAO 获取所有申请
        List<CertificationApplication> applications = certificationApplicationDao.selectAll();
        System.out.println("Service: Fetched " + applications.size() + " applications from DAO."); // 调试日志
        return applications;
    }

    @Override
    public CertificationApplication getApplicationById(Integer id) {
        return certificationApplicationDao.selectById(id);
    }

    @Override
    public List<CertificationApplication> getApplicationsByUserId(Integer userId) {
        return certificationApplicationDao.selectByUserId(userId);
    }

    @Override
    public List<CertificationApplication> getApplicationsByStatus(String status) {
        return certificationApplicationDao.selectByStatus(status);
    }

    @Override
    public List<CertificationApplication> getApplicationsByUserIdAndStatus(Integer userId, String status) {
        return certificationApplicationDao.selectByUserIdAndStatus(userId, status);
    }

    @Override
    public CertificationApplication submitApplication(CertificationApplication application) {
        int rowsAffected = certificationApplicationDao.insert(application);
        if (rowsAffected != 1) {
            throw new RuntimeException("Failed to submit certification application for user: " + application.getUserId());
        }
        return certificationApplicationDao.selectById(application.getId());
    }

    // --- 修正：updateApplicationStatus 返回 boolean ---
    @Override
    public boolean updateApplicationStatus(Integer id, String status, String remarks) {
        System.out.println("Service: updateApplicationStatus called for ID: " + id + ", new status: " + status + ", remarks: " + remarks); // 调试日志
        CertificationApplication application = certificationApplicationDao.selectById(id);
        if (application == null) {
            System.err.println("Service: Application not found for ID: " + id);
            return false; // 应用不存在，返回失败
        }

        Integer userId = application.getUserId();
        String previousStatus = application.getApplicationStatus();

        application.setApplicationStatus(status);
        application.setAdminRemarks(remarks);
        application.setReviewedAt(new Date()); // 设置审核时间

        int rowsAffected = certificationApplicationDao.update(application);
        boolean success = rowsAffected == 1;
        if (!success) {
            System.err.println("Service: Failed to update application status for ID: " + id + ". Rows affected: " + rowsAffected);
            return false; // 更新失败，返回失败
        }

        // 根据新的状态更新用户角色
        if ("approved".equals(status)) {
            // 申请通过，更新用户角色为 CERTIFIED
            boolean roleUpdated = userService.updateUserRole(userId, "CERTIFIED");
            if (!roleUpdated) {
                // 记录警告或抛出异常，因为用户角色更新失败
                String errorMsg = "Failed to update user role to CERTIFIED for user ID: " + userId + ". Rolling back application status update.";
                System.err.println(errorMsg);
                // 注意：这里可能需要手动回滚 application 状态，或者依赖 Spring 的事务回滚机制（如果 roleUpdated 失败抛出异常）
                // 为了简单起见，这里不手动回滚，但实际生产环境可能需要更复杂的处理
                throw new RuntimeException(errorMsg); // 抛出异常以触发事务回滚
            } else {
                System.out.println("Service: Successfully updated user role to CERTIFIED for user ID: " + userId);
            }
        } else if ("rejected".equals(status)) {
            // 申请被拒，通常不改变用户角色（除非有特殊规则，比如从 CERTIFIED 降级）
            // 这里假设被拒后用户角色不变，仍然是 USER 或 CERTIFIED (如果之前是)
            // (不需要额外代码，因为角色未变)
        } else if ("pending_discussion".equals(status)) {
            // 待商议，不改变用户角色
            // (不需要额外代码)
        }
        // 如果状态是 "pending"，通常不会从管理员端直接更新回来，所以不处理

        System.out.println("Service: Successfully updated application status for ID: " + id + " to " + status);
        return true; // 更新成功，返回 true
    }
    // --- /修正 ---

    // --- 实现撤销认证 ---
    @Override
    public boolean revokeCertification(Integer userId, String reason) {
        System.out.println("Service: revokeCertification called for userId: " + userId + ", reason: " + reason); // 添加日志
        com.hardware.entity.User user = userService.getUserById(userId);
        if (user == null) {
            System.err.println("Service: User with ID " + userId + " not found for revocation.");
            return false;
        }
        System.out.println("Service: Found user: " + user.getUsername() + ", current role: " + user.getRole()); // 添加日志

        if (!"CERTIFIED".equals(user.getRole())) {
            System.err.println("Service: User with ID " + userId + " is not currently certified. Current role: " + user.getRole());
            return false; // 或者抛出异常
        }

        // 更新用户角色
        System.out.println("Service: Attempting to update role for user ID " + userId + " to USER"); // 添加日志
        boolean roleUpdated = userService.updateUserRole(userId, "USER");
        System.out.println("Service: updateUserRole returned: " + roleUpdated); // 添加日志
        if (roleUpdated) {
            System.out.println("Service: Successfully revoked certification for user ID " + userId);
            // 可选：记录撤销原因，例如更新认证申请表或创建新的撤销记录表
            // certificationApplicationDao.updateRevocationReason(userId, reason);
        } else {
            System.err.println("Service: Failed to update role when revoking certification for user ID " + userId);
        }
        return roleUpdated;
    }
    // --- /实现 ---

    // --- 实现：重置申请状态 ---
    @Override
    public boolean resetApplicationToPending(Integer id) {
        System.out.println("Service: resetApplicationToPending called for ID: " + id); // 调试日志
        CertificationApplication application = certificationApplicationDao.selectById(id);
        if (application == null) {
            System.err.println("Service: Application with ID " + id + " not found for reset.");
            return false;
        }

        // 检查当前状态是否允许重置，例如只能从 'pending_discussion' 重置
        if (!"pending_discussion".equals(application.getApplicationStatus())) {
            System.err.println("Service: Application with ID " + id + " is not in 'pending_discussion' state, cannot reset. Current state: " + application.getApplicationStatus());
            return false; // 或者允许从其他状态重置，根据业务需求调整
        }

        // 更新状态为 'pending'
        application.setApplicationStatus("pending");
        application.setAdminRemarks(null); // 可选：清空之前的备注
        application.setReviewedAt(null); // 可选：清空审核时间

        int rowsAffected = certificationApplicationDao.update(application);
        boolean success = rowsAffected == 1;
        if (success) {
            System.out.println("Service: Successfully reset application ID " + id + " to 'pending'."); // 调试日志
        } else {
            System.err.println("Service: Failed to reset application ID " + id + " to 'pending'. Rows affected: " + rowsAffected); // 调试日志
        }
        return success;
    }
    // --- /实现 ---
}
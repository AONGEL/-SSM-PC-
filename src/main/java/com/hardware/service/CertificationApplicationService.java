// src/main/java/com/hardware/service/CertificationApplicationService.java
package com.hardware.service;

import com.hardware.entity.CertificationApplication;
import java.util.List;

public interface CertificationApplicationService {

    List<CertificationApplication> getAllApplications();

    CertificationApplication getApplicationById(Integer id);

    List<CertificationApplication> getApplicationsByUserId(Integer userId);

    List<CertificationApplication> getApplicationsByStatus(String status);

    List<CertificationApplication> getApplicationsByUserIdAndStatus(Integer userId, String status);

    CertificationApplication submitApplication(CertificationApplication application);

    // --- 修正：updateApplicationStatus 返回 boolean ---
    boolean updateApplicationStatus(Integer id, String status, String remarks);
    // --- /修正 ---

    boolean revokeCertification(Integer userId, String reason);

    boolean resetApplicationToPending(Integer id);
}
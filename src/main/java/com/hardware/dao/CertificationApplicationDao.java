package com.hardware.dao;

import com.hardware.entity.CertificationApplication;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CertificationApplicationDao {

    /**
     * 查询所有认证申请
     * @return 认证申请列表
     */
    List<CertificationApplication> selectAll();

    CertificationApplication selectById(@Param("id") Integer id);

    List<CertificationApplication> selectByUserId(@Param("userId") Integer userId);

    List<CertificationApplication> selectByStatus(@Param("status") String status);


    List<CertificationApplication> selectByUserIdAndStatus(@Param("userId") Integer userId, @Param("status") String status);

    int insert(CertificationApplication application);

    int update(CertificationApplication application);

    int deleteById(@Param("id") Integer id);
}
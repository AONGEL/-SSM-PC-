package com.hardware.dao;

import com.hardware.entity.CertificationQuestion;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CertificationQuestionDao {

    List<CertificationQuestion> selectAll();

    List<CertificationQuestion> selectByTypeAndActive(@Param("type") String type, @Param("active") Boolean active);

    CertificationQuestion selectById(@Param("id") Integer id);

    int insert(CertificationQuestion question);

    int update(CertificationQuestion question);

    int deleteById(@Param("id") Integer id);
}
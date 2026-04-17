package com.hardware.service.impl;

import com.hardware.dao.CertificationQuestionDao;
import com.hardware.entity.CertificationQuestion;
import com.hardware.service.CertificationQuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CertificationQuestionServiceImpl implements CertificationQuestionService {

    @Autowired
    private CertificationQuestionDao certificationQuestionDao;

    @Override
    public List<CertificationQuestion> getAllQuestions() {
        return certificationQuestionDao.selectAll();
    }

    @Override
    public List<CertificationQuestion> getActiveQuestionsByType(String type) {
        return certificationQuestionDao.selectByTypeAndActive(type, true);
    }

    @Override
    public CertificationQuestion getQuestionById(Integer id) {
        return certificationQuestionDao.selectById(id);
    }

    @Override
    public CertificationQuestion addQuestion(CertificationQuestion question) {
        int rowsAffected = certificationQuestionDao.insert(question);
        if (rowsAffected != 1) {
            throw new RuntimeException("Failed to add certification question: " + question.getQuestionContent());
        }
        return certificationQuestionDao.selectById(question.getId());
    }

    @Override
    public CertificationQuestion updateQuestion(CertificationQuestion question) {
        int rowsAffected = certificationQuestionDao.update(question);
        if (rowsAffected != 1) {
            throw new RuntimeException("Failed to update certification question ID: " + question.getId());
        }
        return certificationQuestionDao.selectById(question.getId());
    }

    @Override
    public boolean deleteQuestion(Integer id) {
        int rowsAffected = certificationQuestionDao.deleteById(id);
        return rowsAffected == 1;
    }
}
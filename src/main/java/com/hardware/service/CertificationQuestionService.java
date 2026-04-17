package com.hardware.service;

import com.hardware.entity.CertificationQuestion;

import java.util.List;

public interface CertificationQuestionService {

    List<CertificationQuestion> getAllQuestions();

    List<CertificationQuestion> getActiveQuestionsByType(String type);

    CertificationQuestion getQuestionById(Integer id);

    CertificationQuestion addQuestion(CertificationQuestion question);

    CertificationQuestion updateQuestion(CertificationQuestion question);

    boolean deleteQuestion(Integer id);
}
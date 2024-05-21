package QandA.service;

import java.util.List;
import java.util.Map;

import QandA.dto.QandA;
import QandA.dto.QandAComment;

public interface QandAService {
    List<QandA> getAllQandAs();
    QandA getQandAById(int id);
    void addQandA(QandA qanda);
    void updateQandA(QandA qanda);
    void deleteQandA(int seq);
    void addComment(QandAComment comment);
    void deleteComment(int commentId);
    void increaseLikes(int seq);
    void increaseViews(int seq);
    void updateImagePath(int seq, String imagePath);
    void updateAttachmentPath(int seq, String attachmentPath);
    
    boolean checkUserRecommendation(Map<String, Object> paramMap);
    // 추천 추가
    void addUserRecommendation(int userno, int seq);
    
    List<QandA> getAllSelectQandAs(Map<String, Object> paramMap);
    
    List<QandAComment> getCommentsByQandAId(int qandaId);
}

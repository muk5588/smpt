package QandA.dao;

import java.util.List;
import java.util.Map;

import QandA.dto.QandA;
import QandA.dto.QandAComment;
import QandA.dto.QandARecommendation;

public interface QandADao {
    public List<QandA> getAllQandAs();
    public QandA getQandAById(int id);
    public void addQandA(QandA qanda);
    public void updateQandA(QandA qanda);
    public void deleteQandA(int seq);
    public void addComment(QandAComment comment);
    public void deleteComment(int commentId);
    public void increaseLikes(int id);
    public void increaseViews(int id);
    
    public void updateImagePath(int id, String imagePath);
    public void updateAttachmentPath(int id, String attachmentPath);
    
    int checkUserRecommendation(Map<String, Object> paramMap);
    // 추천 추가
	void addUserRecommendation(Map<String, Object> paramMap);
    
	List<QandA> getAllSelectQandAs(Map<String, Object> paramMap);
	
	List<QandAComment> getCommentsByQandAId(int qandaId);
}

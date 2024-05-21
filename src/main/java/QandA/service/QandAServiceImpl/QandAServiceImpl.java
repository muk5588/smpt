package QandA.service.QandAServiceImpl;

import QandA.dao.QandADao;
import QandA.dto.QandA;
import QandA.dto.QandAComment;
import QandA.dto.QandARecommendation;
import QandA.service.QandAService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class QandAServiceImpl implements QandAService {

    private final QandADao qandADao;

    @Autowired
    public QandAServiceImpl(QandADao qandADao) {
        this.qandADao = qandADao;
    }

    @Override
    public List<QandA> getAllQandAs() {
        return qandADao.getAllQandAs();
    }

    @Override
    public QandA getQandAById(int id) {
        return qandADao.getQandAById(id);
    }

    @Override
    public void addQandA(QandA qanda) {
        qandADao.addQandA(qanda);
    }

    @Override
    public void updateQandA(QandA qanda) {
        qandADao.updateQandA(qanda);
    }

    @Override
    public void deleteQandA(int seq) {
        qandADao.deleteQandA(seq);
    }
    
    @Override
    public void addComment(QandAComment comment) {
        qandADao.addComment(comment);
    }
    @Override
    public void deleteComment(int commentId) {
        qandADao.deleteComment(commentId);
    }

    @Override
    public void increaseLikes(int seq) {
        qandADao.increaseLikes(seq);
    }

    @Override
    public void increaseViews(int seq) {
        qandADao.increaseViews(seq);
    }

    @Override
    public void updateImagePath(int seq, String imagePath) {
        qandADao.updateImagePath(seq, imagePath);
    }

    @Override
    public void updateAttachmentPath(int seq, String attachmentPath) {
        qandADao.updateAttachmentPath(seq, attachmentPath);
    }
    

    public boolean checkUserRecommendation(Map<String, Object> paramMap) {
        return qandADao.checkUserRecommendation(paramMap) > 0;
    }

    @Override
    public void addUserRecommendation(int userno, int seq) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userno", userno);
        paramMap.put("seq", seq);
        qandADao.addUserRecommendation(paramMap);
    }
    
    @Override
    public List<QandA> getAllSelectQandAs(Map<String, Object> paramMap) {
        return qandADao.getAllSelectQandAs(paramMap);
    }
    
    @Override
    public List<QandAComment> getCommentsByQandAId(int qandaId) {
        return qandADao.getCommentsByQandAId(qandaId);
    }
 
}

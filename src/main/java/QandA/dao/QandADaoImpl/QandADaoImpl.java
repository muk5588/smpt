package QandA.dao.QandADaoImpl;

import QandA.dao.QandADao;
import QandA.dto.QandA;
import QandA.dto.QandAComment;
import QandA.dto.QandARecommendation;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class QandADaoImpl implements QandADao {

    private final SqlSession sqlSession;
    
    private static final String NAMESPACE = "QandA.dao.QandADao";

    @Autowired
    public QandADaoImpl(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public List<QandA> getAllQandAs() {
        return sqlSession.selectList("QandA.dao.QandADao.getAllQandAs");
    }

    @Override
    public QandA getQandAById(int id) {
        return sqlSession.selectOne("QandA.dao.QandADao.getQandAById", id);
    }

    @Override
    public void addQandA(QandA qanda) {
        sqlSession.insert("QandA.dao.QandADao.addQandA", qanda);
    }

    @Override
    public void updateQandA(QandA qanda) {
        sqlSession.update("QandA.dao.QandADao.updateQandA", qanda);
    }

    @Override
    public void deleteQandA(int seq) {
        sqlSession.delete("QandA.dao.QandADao.deleteQandA", seq);
    }

    @Override
    public void addComment(QandAComment comment) {
        sqlSession.insert(NAMESPACE + ".addComment", comment);
    }

    @Override
    public void deleteComment(int commentId) {
        sqlSession.delete("QandA.dao.QandADao.deleteComment", commentId);
    }

    @Override
    public void increaseLikes(int id) {
        sqlSession.update("QandA.dao.QandADao.increaseLikes", id);
    }

    @Override
    public void increaseViews(int id) {
        sqlSession.update("QandA.dao.QandADao.increaseViews", id);
    }

    @Override
    public void updateImagePath(int id, String imagePath) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("imagePath", imagePath);
        sqlSession.update("QandA.dao.QandADao.updateImagePath", params);
    }

    @Override
    public void updateAttachmentPath(int id, String attachmentPath) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("attachmentPath", attachmentPath);
        sqlSession.update("QandA.dao.QandADao.updateAttachmentPath", params);
    }
    
    @Override
    public int checkUserRecommendation(Map<String, Object> paramMap) {
        return sqlSession.selectOne(NAMESPACE + ".checkUserRecommendation", paramMap);
    }

    @Override
    public void addUserRecommendation(Map<String, Object> paramMap) {
        sqlSession.insert(NAMESPACE + ".addUserRecommendation", paramMap);
    }
    
    @Override
    public List<QandA> getAllSelectQandAs(Map<String, Object> paramMap) {
        return sqlSession.selectList(NAMESPACE + ".getAllSelectQandAs", paramMap);
    }
    
    @Override
    public List<QandAComment> getCommentsByQandAId(int qandaId) {
        return sqlSession.selectList("QandA.dao.QandADao.getCommentsByQandAId", qandaId);
    }

}

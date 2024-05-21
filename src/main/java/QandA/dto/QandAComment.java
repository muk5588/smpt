package QandA.dto;

import java.util.Date;

public class QandAComment {
    private int id;
    private int qandaId;
    private int userno;
    private String content;
    private Date createDate;
    private Date updateDate;

    public QandAComment() {
    }

    public QandAComment(int id, int qandaId, int userno, String content, Date createDate, Date updateDate) {
        this.id = id;
        this.qandaId = qandaId;
        this.userno = userno;
        this.content = content;
        this.createDate = createDate;
        this.updateDate = updateDate;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQandaId() {
        return qandaId;
    }

    public void setQandaId(int qandaId) {
        this.qandaId = qandaId;
    }

    public int getUserno() {
        return userno;
    }

    public void setUserno(int userno) {
        this.userno = userno;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    @Override
    public String toString() {
        return "QandAComment{" +
                "id=" + id +
                ", qandaId=" + qandaId +
                ", userno=" + userno +
                ", content='" + content + '\'' +
                ", createDate=" + createDate +
                ", updateDate=" + updateDate +
                '}';
    }
}

package QandA.dto;

import java.util.Date;

public class QandARecommendation {
    private int id;
    private int userno;
    private int seq;
    private Date recommendDate;

    public QandARecommendation() {
    	
    }
    
    
    
    @Override
	public String toString() {
		return "QandARecommendation [id=" + id + ", userno=" + userno + ", seq=" + seq + ", recommendDate="
				+ recommendDate + "]";
	}

    

	public QandARecommendation(int id, int userno, int seq, Date recommendDate) {
		super();
		this.id = id;
		this.userno = userno;
		this.seq = seq;
		this.recommendDate = recommendDate;
	}



	// Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserno() {
        return userno;
    }

    public void setUserno(int userno) {
        this.userno = userno;
    }

    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

    public Date getRecommendDate() {
        return recommendDate;
    }

    public void setRecommendDate(Date recommendDate) {
        this.recommendDate = recommendDate;
    }
}

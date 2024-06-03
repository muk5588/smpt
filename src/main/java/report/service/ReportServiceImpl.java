package report.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.Item;
import report.dao.ReportDao;
import report.dto.BoardReport;
import report.dto.BoardReportType;
import report.dto.CommReport;
import report.dto.ItemReport;
import report.dto.ItemReportType;
@Service
public class ReportServiceImpl implements ReportService{
@Autowired
ReportDao reportDao;
private static Logger logger = LoggerFactory.getLogger(ReportServiceImpl.class);

	private static final Map<Integer, String> categoryUrlMap = new HashMap<>();
	
	static {
	    categoryUrlMap.put(11, "redirect:/story");
	    categoryUrlMap.put(12, "redirect:/tip");
	    categoryUrlMap.put(13, "redirect:/recomm");
	    categoryUrlMap.put(21, "redirect:/photo");
	    categoryUrlMap.put(31, "redirect:/board");
	    categoryUrlMap.put(32, "redirect:/board");
	    categoryUrlMap.put(41, "redirect:/qanda");
	    categoryUrlMap.put(42, "redirect:/Free");
	    categoryUrlMap.put(43, "redirect:/notice");
	    categoryUrlMap.put(51, "redirect:/board");
	    categoryUrlMap.put(52, "redirect:/board");
	}
    @Override
    public List<BoardReportType> reportType() {
        return reportDao.reportType();
    }

    @Override
    public void reportBoard(BoardReport boardReport) {
        reportDao.reportBoard(boardReport);
    }

    @Override
    public List<BoardReportType> commReportType() {
        return reportDao.commReportType();
    }

    @Override
    public void reportComm(CommReport commReport) {
        reportDao.reportComm(commReport);
    }

    @Override
    public List<BoardReport> boardlist() {
        return reportDao.boardlist();
    }

    @Override
    public List<CommReport> commlist() {
        return reportDao.commlist();
    }

    @Override
    public void deleteReport(int reportno) {
        reportDao.deleteReport(reportno);
    }

    @Override
    public void deleteCommReport(int reportno) {
        reportDao.deleteCommReport(reportno);
    }

	@Override
	public List<ItemReportType> getItemReportType() {
		return reportDao.getItemReportType();
	}

	@Override
	public Item getItemByItemNo(int itemNo) {
		return reportDao.getItemByItemNo(itemNo);
	}

	@Override
	public int insertItemReport(ItemReport itemReport) {
		return reportDao.insertItemReport(itemReport);
	}

	@Override
	public List<ItemReport> itemlist() {
		return reportDao.itemlist();
	}

	@Override
	public void deleteItemReport(int reportno) {
		reportDao.deleteItemReport(reportno);
	}

    @Override
    public List<BoardReport> reportboardlist() {
        return reportDao.reportboardlist();
    }

    @Override
    public List<CommReport> reportcommlist() {
        return reportDao.reportcommlist();
    }

    @Override
    public List<ItemReport> reportitemlist() {
        return reportDao.reportitemlist();
    }

    @Override
    public List<BoardReport> userbyboardlist(int userNo) {
        return reportDao.userbyboardlist(userNo);
    }

    @Override
    public List<CommReport> userbycommlist(int userNo) {
        return reportDao.userbycommlist(userNo);    }

    @Override
    public List<ItemReport> userbyitemlist(int userNo) {
        return reportDao.userbyitemlist(userNo);
    }

	@Override
	public String getURL(String categoryNo) {
		String URL = "";
		if(categoryNo != null && !categoryNo.equals("")) {
			int tempCategory = Integer.valueOf(categoryNo);
			URL = categoryUrlMap.get(tempCategory);
			logger.debug("categoryNo : {}",tempCategory);
			logger.debug("URL!!!! : {}",URL);
		}
		
		return URL;
	}


}

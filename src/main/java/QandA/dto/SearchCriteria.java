package QandA.dto;

public class SearchCriteria extends Criteria {

    private String searchType = "";
    private String keyword = "";
    private String sortType = "latest"; // 기본값을 최신순으로 설정

    public String getSearchType() {
        return searchType;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getSortType() {
        return sortType;
    }

    public void setSortType(String sortType) {
        this.sortType = sortType;
    }

    @Override
    public String toString() {
        return super.toString() + " SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
    }
}

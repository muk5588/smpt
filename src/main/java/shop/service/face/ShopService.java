package shop.service.face;

import java.math.BigDecimal;
import java.util.List;

import dto.Item;
import dto.ItemFile;
import util.Paging;
import util.ShopPaging;

public interface ShopService {

    /**
     * 페이징 처리
     * @param shopPaging - 페이징 객체
     * @return - 페이징 객체
     */
//    public ShopPaging getPagging(ShopPaging shopPaging);

    /**
     * 상품 목록 조회
     * @param shopPaging 
     * @return - 상품 목록
     */
//    public List<Item> list(ShopPaging shopPaging);

    /**
     * 가격 범위로 상품 목록 조회
     * @param minPrice - 최소 가격
     * @param maxPrice - 최대 가격
     * @return - 상품 목록
     */
//    public List<Item> listByPriceRange(BigDecimal minPrice, BigDecimal maxPrice);

    /**
     * 검색어로 상품 목록 조회
     * @param search - 검색어
     * @return - 상품 목록
     */
//    public List<Item> searchItems(String search);

    /**
     * 상품 번호로 상품 정보 조회
     * @param itemNo - 상품 번호
     * @return - 조회된 상품 정보
     */
    public Item getItemByItemNo(int itemNo);

	public ShopPaging getPaging(int curPage, ShopPaging paging);

	public List<Item> selectItems(ShopPaging paging);

	public List<ItemFile> selectTitleImgFile(List<Item> items);

}

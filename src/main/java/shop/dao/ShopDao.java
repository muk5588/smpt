package shop.dao;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import dto.Item;
import util.Paging;

@Repository("ShopDao")
public interface ShopDao {

    List<Item> getList(Paging shopPaging);

    int selectCntAll(Paging shopPaging);

    Item getItemByItemNo(int itemNo);

    List<Item> selectBySearch(String search);

    List<Item> getListByPriceRange(Map<String, Object> params);

}

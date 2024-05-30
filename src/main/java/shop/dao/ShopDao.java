package shop.dao;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import dto.Item;
import util.ShopPaging;

@Repository("ShopDao")
public interface ShopDao {

	public List<Item> getList(ShopPaging shopPaging);

	public int selectCntAll(ShopPaging shopPaging);

	public Item getItemByItemNo(int itemNo);

	public List<Item> selectBySearch(String search);

	public List<Item> getListByPriceRange(Map<String, Object> params);

}

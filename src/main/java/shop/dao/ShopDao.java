package shop.dao;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import dto.Item;
import dto.ItemFile;
import util.ShopPaging;

@Repository("ShopDao")
public interface ShopDao {

//   public List<Item> getList(ShopPaging shopPaging);
//
//   public int selectCntAll(ShopPaging shopPaging);

   public Item getItemByItemNo(int itemNo);

   
//   public List<Item> selectBySearch(String search);
//
//   public List<Item> getListByPriceRange(Map<String, Object> params);
   
   
   

  public int selectCnt(ShopPaging paging);

   public List<Item> selectItems(ShopPaging paging);

   public List<ItemFile> selectTitleImgFile(@Param("items")List<Item> items);

//public List<Item> getList(ShopPaging shopPaging);

}
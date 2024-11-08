package shop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import dto.Item;
import dto.ItemFile;

public interface ShopFileDao {

	public List<ItemFile> getTitleImgs();

	public List<ItemFile> getItemFilesByItemNo(int itemNo);
	
}

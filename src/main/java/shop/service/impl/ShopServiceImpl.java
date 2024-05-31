package shop.service.impl;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.Item;
import dto.ItemFile;
import shop.dao.ShopDao;
import shop.service.face.ShopService;
import util.Paging;
import util.ShopPaging;

@Service
public class ShopServiceImpl implements ShopService {

    private Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired private ShopDao shopDao;

//    @Override
//    public ShopPaging getPagging(ShopPaging shopPaging) {
//        int totalCount = shopDao.selectCntAll(shopPaging);
//        return new ShopPaging(totalCount, shopPaging.getCurPage());
//    }

//    @Override
//    public List<Item> list(ShopPaging shopPaging) {
//        return shopDao.getList(shopPaging);
//    }

//    @Override
//    public List<Item> listByPriceRange(BigDecimal minPrice, BigDecimal maxPrice) {
//        Map<String, Object> params = new HashMap<>();
//        params.put("minPrice", minPrice);
//        params.put("maxPrice", maxPrice);
//        return shopDao.getListByPriceRange(params);
//    }


    @Override
    public Item getItemByItemNo(int itemNo) {
        return shopDao.getItemByItemNo(itemNo);
    }

//    @Override
//    public List<Item> searchItems(String search) {
//        return shopDao.selectBySearch(search);
//    }

    public ShopPaging getPaging(int curPage, ShopPaging paging) {
        int totalCount = shopDao.selectCnt(paging);
        logger.info("totalCount : {}", totalCount);
        ShopPaging pagingres = new ShopPaging(totalCount, curPage);
        pagingres.setSearch(paging.getSearch());
        pagingres.setMinPrice(paging.getMinPrice());
        pagingres.setMaxPrice(paging.getMaxPrice());
        return pagingres;
    }
	@Override
	public List<Item> selectItems(ShopPaging paging) {
		return shopDao.selectItems(paging);
	}//selectItems(Paging paging)


	@Override
	public List<ItemFile> selectTitleImgFile(List<Item> items) {
	    if (items == null || items.isEmpty()) {
	        return Collections.emptyList(); // 빈 리스트 반환
	    }
	    return shopDao.selectTitleImgFile(items);
	}
}

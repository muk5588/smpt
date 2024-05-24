package shop.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.Item;
import shop.dao.ShopDao;
import shop.service.face.ShopService;
import util.Paging;

@Service
public class ShopServiceImpl implements ShopService {

    private Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired private ShopDao shopDao;

    @Override
    public Paging getPagging(Paging shopPaging) {
        int totalCount = shopDao.selectCntAll(shopPaging);
        return new Paging(totalCount, shopPaging.getCurPage());
    }

    @Override
    public List<Item> list(Paging shopPaging) {
        return shopDao.getList(shopPaging);
    }

    @Override
    public List<Item> listByPriceRange(BigDecimal minPrice, BigDecimal maxPrice, Paging shopPaging) {
        Map<String, Object> params = new HashMap<>();
        params.put("minPrice", minPrice);
        params.put("maxPrice", maxPrice);
        params.put("startNo", shopPaging.getStartNo()); // 페이징 시작 번호
        params.put("endNo", shopPaging.getEndNo()); // 페이징 종료 번호
        return shopDao.getListByPriceRange(params);
    }


    @Override
    public Item getItemByItemNo(int itemNo) {
        return shopDao.getItemByItemNo(itemNo);
    }

    @Override
    public List<Item> searchItems(String search) {
        return shopDao.selectBySearch(search);
    }
}

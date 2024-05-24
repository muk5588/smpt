package shop.controller;

import java.math.BigDecimal;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dto.Item;
import dto.ItemFile;
import shop.service.face.ShopFileService;
import shop.service.face.ShopService;
import util.Paging;

@Controller
@RequestMapping("/shop")
public class ShopController {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired private ShopService shopService;
    @Autowired private ShopFileService shopFileService;
   // @Autowired private util.ExchangeRateUtils exchangeRateUtils;

    @RequestMapping("/main")
    public String shopMain() {
        return "redirect:/shop/";
    }

    @RequestMapping("/")
    public String list(Model model, Paging shopPaging,
                       @RequestParam(value="curPage", required = false, defaultValue = "0") int curPage,
                       @RequestParam(required = false) String search,
                       @RequestParam(required = false) BigDecimal minPrice,
                       @RequestParam(required = false) BigDecimal maxPrice) {
        // 페이징 설정
        shopPaging.setCurPage(curPage);
        // 페이징 정보 설정
        shopPaging = shopService.getPagging(shopPaging);

        // 가격 필터 적용하여 아이템 리스트 가져오기
        List<Item> items;
        if (search == null || search.isEmpty()) {
            if (minPrice == null && maxPrice == null) {
                // 가격 필터가 없는 경우 모든 아이템 가져오기
                items = shopService.list(shopPaging);
            } else {
                // 가격 필터가 있는 경우 해당 가격 범위의 아이템 가져오기
                items = shopService.listByPriceRange(minPrice, maxPrice, shopPaging);
            }
        } else {
            // 검색어가 있는 경우 검색된 아이템 가져오기
            items = shopService.searchItems(search);
        }

        // 검색어와 가격 필터를 로그로 출력
        logger.debug("Search : {}", search);
        logger.debug("Min Price : {}", minPrice);
        logger.debug("Max Price : {}", maxPrice);

        // 모델에 페이징 정보와 현재 페이지, 검색어, 가격대를 추가
        model.addAttribute("paging", shopPaging);
        model.addAttribute("curPage", curPage);
        model.addAttribute("search", search);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);

        // 대표 이미지 파일 정보 조회 및 모델에 추가
        List<ItemFile> files = shopFileService.getTitleImgs();
        //BigDecimal[] exchangeRates = exchangeRateUtils.getExchangeRate();
        
        logger.debug("Title IMG files: {}", files);
        logger.debug("Item Check: {}", items);
        
        model.addAttribute("files", files);
        model.addAttribute("item", items);
        //model.addAttribute("exchangeRates", exchangeRates);
        
        return "/shop/main";
    }



    @RequestMapping("/detail")
    public void detail(@RequestParam("itemNo") int itemNo, Model model) {
        logger.debug("Detail itemNo : {}", itemNo);
        
        // 상품 정보 조회
        Item item = shopService.getItemByItemNo(itemNo);
        logger.debug("Detail item : {}", item);
        
        // 상품 정보 파일 조회
        List<ItemFile> files = shopFileService.getItemFilesByItemNo(itemNo);
        logger.debug("Detail item files : {}", files);

        // 모델에 상품 정보와 파일 정보 추가
        model.addAttribute("item", item);
        model.addAttribute("files", files);
    }
}

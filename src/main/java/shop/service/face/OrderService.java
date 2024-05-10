package shop.service.face;

import java.util.List;
import java.util.Map;

import dto.OrderItem;
import dto.UserOrder;

public interface OrderService {

	public int[] getItemNosByorderDatas(String[] orderDatas);

	/**
	 * 장바구니에서 결제 선택한 상품의 데이터 가공
	 * @param orderNumbers - 장바구니 번호 배열
	 * @return
	 */
	public Map<String, Object> userorderProc(int[] orderNumbers);

	/**
	 * UserOrder 객체 생성 ( 기본값 현재 로그인한 회원 정보)
	 * @return
	 */
	public UserOrder makeUserOrder();

	/**
	 * 결제 정보에서 입력받은 정보를 토대로 UserOrder객체 insert
	 * @param userOrder
	 * @return
	 */
	public int insertUserOrder(UserOrder userOrder);

	/**
	 * 결제한 목록을 장바구니 -> 주문 상세로 인서트
	 * @param orderDatas
	 * @param userOrder 
	 * @return
	 */
	public int insertOrderItems(String orderDatas, UserOrder userOrder);

	
	
}

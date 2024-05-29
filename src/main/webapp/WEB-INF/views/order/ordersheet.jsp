<%@page import="java.util.UUID"%>
<%@page import="dto.Item"%>
<%@page import="dto.OrderItem"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="/WEB-INF/views/layout/header.jsp"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function DaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }

                if (data.userSelectedType === 'R') {
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    document.getElementById("extraAddress").value = extraAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                document.getElementById('postCode').value = data.zonecode;
                document.getElementById("address").value = addr;
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>        
<% 
    List<Item> items = (List<Item>)request.getAttribute("items");
    String itemNames = "";
    int i =0;
    for(Item o: items){
        itemNames += o.getItemName();
        if( i != 0){
            itemNames += " , ";
        }
        i++;
    }
    request.setAttribute("itemNames", itemNames);
    String uuid = UUID.randomUUID().toString().split("-")[4];
    uuid += UUID.randomUUID().toString().split("-")[4];
    request.setAttribute("uuid", uuid);
%>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript">
    IMP.init('imp21765258')

    var today = new Date();   
    var hours = today.getHours(); // 시
    var minutes = today.getMinutes();  // 분
    var seconds = today.getSeconds();  // 초
    var milliseconds = today.getMilliseconds();
    var makeMerchantUid = '' +hours +  minutes + seconds + milliseconds;
        

function requestPay() {
	

IMP.request_pay({
	
	pg: "html5_inicis",						//pg 모듈 설정
	
	pay_method: "card",						//결제 수단 (필수)
// 	merchant_uid: ${userOrder.orderNo}+makeMerchantUid,	// 고유 주문번호(필수) (unique)
	merchant_uid: '${uuid}' + makeMerchantUid,	// 고유 주문번호(필수) (unique)
// 	amount: document.getElementById("totalPrice").value,		// 결제 금액 (필수)
	amount: 1,		// 결제 금액 (필수)
	
	name: '${itemNames}',				//주문 상품 이름
	
	buyer_email: '${dto1.email}',		// 주문자 정보들
	buyer_name: document.getElementById("userName").value,					// 주문자 정보들
	buyer_tel: document.getElementById("phone").value,				// 주문자 정보들
	buyer_addr: document.getElementById("address").value,	// 주문자 정보들
	buyer_postcode: document.getElementById("postCode").value					// 주문자 정보들
	
}, function (rsp) { // callback
   //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
	
    console.log( rsp )
    console.log( rsp.imp_uid )
    //rsp.imp_uid -> 결제 실패시 null 반환
    var imp_uid = rsp.imp_uid
    if( rsp.success && imp_uid ){
    var form = $("#orderForm");

    $("<input>")
    .append(
    	$("<input>")
    	.attr({
    		type:"text"
    		, name:"impUid"
    		, value: rsp.imp_uid
    	}) )
    .appendTo(form)
    
    $("<input>")
    .append(
    	$("<input>")
    	.attr({
    		type:"text"
    		, name:"method"
    		, value: 'card'
    	}) )
    .appendTo(form)
    
    $("<input>")
    .append(
    	$("<input>")
    	.attr({
    		type:"text"
    		, name:"pay"
    		, value: "Y"
    	}) )
    .appendTo(form)
    
    $("<input>")
    .append(
    	$("<input>")
    	.attr({
    		type:"text"
    		, name:"userNo"
    		, value: ${dto1.userno}
    	}) )
    .appendTo(form)
    
    $("<input>")
    .append(
    	$("<input>")
    	.attr({
    		type:"text"
    		, name:"merchantUid"
    		, value: rsp.merchant_uid
    	}) )
    .appendTo(form)
    
    $("<input>")
    .append(
    	$("<input>")
    	.attr({
    		type:"text"
    		, name:"paraMount"
    		, value: rsp.paid_amount
    	}) )
    .appendTo(form)
    
    
   	alert('결제를 완료 했습니다')
   	
    form.submit();
    }else{
    	alert('결제 오류 입니다 [원인] : ' + rsp.error_msg)

    }
</script>
<script type="text/javascript">
    $(function(){
        $("#payBtn").click(function(){
            console.log("결제버튼 클릭")
            requestPay();
        });
    });
</script>
<link rel="stylesheet" href="/resources/css/order/ordersheet.css">
</head>
<body>

<div class="container mt-5">
    <h1 class="mb-4">결제하기</h1>
    <a href="/">
        <button class="btn btn-secondary mb-4">메인 페이지로</button>
    </a>
    
    <div id="orderwrap">
        <form method="post" action="./completed" id="orderForm" class="mb-4">
            <div class="mb-3">
                <label for="userName" class="form-label">주문자명</label>
                <input type="text" class="form-control" name="userName" id="userName" value="${userOrder.userName }">
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">핸드폰번호</label>
                <input type="text" class="form-control" name="phone" id="phone" value="${userOrder.phone }">
            </div>
            <div class="mb-3">
                <label for="postCode" class="form-label">배송지 우편주소</label>
                <input type="text" class="form-control" name="postCode" id="postCode" value="${userOrder.postCode }" readonly>
                <button type="button" class="btn btn-outline-primary mt-2" onclick="DaumPostcode()">우편번호 찾기</button>
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">주소</label>
                <input type="text" class="form-control" name="address" id="address" value="${userOrder.address }" readonly>
            </div>
            <div class="mb-3">
                <label for="detailAddress" class="form-label">상세 주소</label>
                <input type="text" class="form-control" name="detailAddress" id="detailAddress" value="${userOrder.detailAddress }">
                <input type="text" class="form-control mt-2" name="extraAddress" id="extraAddress" value="${userOrder.extraAddress}" readonly>
            </div>
        </form>
        
        <table class="table table-bordered">
            <thead class="table-light">
                <tr>
                    <th>상품명</th>
                    <th>수량</th>
                    <th>이미지</th>
                    <th>가격</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty baskets}">
                        <c:set var="sum" value="0"/>
                        <c:forEach items="${items}" var="item">
                            <c:forEach items="${baskets}" var="basket">
                                <c:if test="${item.itemNo eq basket.itemNo}">
                                    <tr>
                                        <td>${item.itemName}</td>
                                        <td>${basket.quantity}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty imgFiles}">
                                                    <c:forEach items="${imgFiles}" var="file">
                                                        <c:if test="${file.itemNo eq item.itemNo}">
                                                            <img alt="ItemImg" src="/resources/img/shop/upload/${file.storedName}" class="img-thumbnail" width="100">
                                                        </c:if>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="/resources/img/shop/nullimg.jpg" alt="notready" class="img-thumbnail" width="100">
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            ${item.price * basket.quantity}
                                            <c:set var="i" value="${item.price * basket.quantity}"/>
                                        </td>
                                        <c:set var="sum" value="${sum + i}"/>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                        <c:forEach items="${orderDatas}" var="orderData">
                            <input type="hidden" name="orderDatas" value="${orderData}"/>
                        </c:forEach>
                    </c:when>
                    <c:when test="${empty baskets}">
                        <c:set var="sum" value="0"/>
                        <c:forEach items="${items}" var="item">
                            <tr>
                                <td>${item.itemName}</td>
                                <td>${quantity}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty imgFiles}">
                                            <c:forEach items="${imgFiles}" var="file">
                                                <c:if test="${file.itemNo eq item.itemNo}">
                                                    <img alt="ItemImg" src="/resources/itemUpload/${file.storedName}" class="img-thumbnail" width="100">
                                                </c:if>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="/resources/img/shop/nullimg.jpg" alt="notready" class="img-thumbnail" width="100">
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    ${item.price * quantity}
                                    <c:set var="i" value="${item.price * quantity}"/>
                                </td>
                                <c:set var="sum" value="${sum + i}"/>
                            </tr>
                            <input name="itemNo" value="${item.itemNo}" hidden>
                            <input name="quantity" value="${quantity}" hidden>
                        </c:forEach>
                    </c:when>
                </c:choose>
                <tr>
                    <td>총계:</td>
                    <td colspan="3">
                        <fmt:setLocale value="ko_KR"/>
                        <fmt:formatNumber type="currency" value="${sum}"/>
                        <input type="hidden" name="totalPrice" id="totalPrice" value="${sum}">
                    </td>
                </tr>
            </tbody>
        </table>
        <button id="payBtn" class="btn btn-primary">결제하기</button>
    </div>
</div>

<c:import url="/WEB-INF/views/layout/footer.jsp"/>

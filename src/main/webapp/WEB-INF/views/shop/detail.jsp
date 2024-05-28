<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
        <jsp:include page="/WEB-INF/views/layout/boardmenu.jsp" />
        
<script>
    function incrementQuantity() {
        var quantityInput = document.getElementById('quantity');
        var currentValue = parseInt(quantityInput.value);
        var remain = parseInt("${item.remain}");
        if (currentValue < remain) {
            quantityInput.value = currentValue + 1;
        } else {
            alert("남은 재고를 초과할 수 없습니다.");
        }
    }

    function decrementQuantity() {
        var quantityInput = document.getElementById('quantity');
        var currentValue = parseInt(quantityInput.value);
        if (currentValue > 1) {
            quantityInput.value = currentValue - 1;
        }
    }
</script>
<script type="text/javascript">
$(function(){
	
    $(document).ready(function () {
        //전체 로딩 끝난 후 리뷰 내용 AJAX 통신을 위해.
		console.log("확인용")
		handelGetReview()
    })
	
	//장바구니 담기 버튼
	 $("#addToCartBtn").click(function() {
         // isLogin 변수에는 로그인 상태를 나타내는 값이 있어야 합니다.
         // 만약 이 값이 서버에서 제공되는 변수라면 그 값을 사용해야 합니다.
         // 예: var isLogin = ${isLogin};
			var itemNo = ${item.itemNo}
			var quantity = $("#quantity").val()
         if (${empty isLogin or isLogin < 1}) {
             //로그인 페이지로 이동
             alert("로그인 이후 이용이 가능합니다")
//              $(location).attr('href', './login')
             window.location.href = "/login"; // 로그인 페이지의 URL로 변경해주세요.
         } else {
        	 $.ajax({
                 type: "get"
                 , url: "../basket/insert"
                 , data: {
                     itemNo: itemNo
                     , quantity : quantity
                 }
                 , dataType: "json"
                 , success: function (res) {
                	 console.log(res)
//     				console.log("AJAX 성공")
//     				console.log(res)
					$(function () {
	                	window.location.href = "../basket/userbasket";
	            	})

                 }
                 , error: function () {
                     console.log("AJAX 실패")
                 }
             })
        	 
         }
     });

	 //구매하기 버튼 클릭
     $("#purchaseBtn").click(function() {
		var itemNo = ${item.itemNo}
		var quantity = $("#quantity").val()
		$(function () {
           	window.location.href = '../order/ordersheet?itemNo='+itemNo+'&quantity=' +quantity;
       	})
     });
	
	 //리뷰 AJAX 통신
	function handelGetReview(){
		console.log("getReview")
		
		var itemNo = '${item.itemNo}'
		 $.ajax({
             type: "get"
             , url: "../review/loadreview"
             , data: {
                 itemNo: itemNo
             }
             , dataType: "JSON"
             , success: function (res) {
            	 console.log(res)
            	 //view에 보이도록 추가.
                 renderReviews(res);
           		
             }
             , error: function () {
                 console.log("AJAX 실패")
             }
         })
    	 
	};
	
    function renderReviews(reviews) {
        var reviewHtml = '';
        if (reviews.length > 0) {
            reviews.forEach(function(review) {
                reviewHtml += '<div class="review">';
                reviewHtml += '<h5>' + review.reviewTitle + '</h5>';
                reviewHtml += '<h6>' + review.nickname + '</h6>';
                reviewHtml += '<p>' + review.reviewContent + '</p>';
                reviewHtml += '<small>작성일: ' + new Date(review.createReviewDate).toLocaleDateString() + '</small>';
                reviewHtml += '</div><hr>';
            });
        } else {
            reviewHtml = '<p>리뷰가 아직 작성되지 않았습니다</p>';
        }

        $("#reviewWrap").html(reviewHtml);
    }
	
})
</script>
</head>
<body>

 <div class="container">
    <h1>상품 정보</h1>
    <a href="/">
        <button>메인 페이지로</button>
    </a>
        
    <div id="itemwarp" style="border: 1px solid #ccc; padding: 20px; margin-top: 20px;">
        <div class="row">
            <div class="col-md-4">
                <!-- 상품 이미지 -->
                <c:choose>
                    <c:when test="${not empty files}">
                        <c:forEach items="${files}" var="file">
                            <c:if test="${not empty file}">
                                <img alt="ItemImg" src="/resources/img/shop/upload/${file.storedName}" class="img-fluid">
                            </c:if>
                            <c:if test="${empty files.itemNo}">
                                <img src="/resources/img/shop/nullimg.jpg" alt="notready" class="img-fluid">
                            </c:if>
                        </c:forEach>
                    </c:when>
                    <c:when test="${empty imgFiles}">
                        <img src="/resources/img/shop/nullimg.jpg" alt="notready" class="img-fluid">
                    </c:when>
                </c:choose>
            </div>
            <div class="col-md-8">
                <!-- 상품 정보 -->
                <table class="table">
                    <tbody>
                        <tr>
                            <th scope="row">상품명</th>
                            <td>${item.itemName}</td>
                        </tr>
                        <tr>
                            <th scope="row">가격</th>
                            <td><fmt:setLocale value="ko_KR"/><fmt:formatNumber type="currency" value="${item.price}" /></td>
                        </tr>
                        <tr>
                            <th scope="row">상품 설명</th>
                            <td>${item.itemComm}</td>
                        </tr>
                        <tr>
                            <th scope="row">재고</th>
                            <td>${item.remain}</td>
                        </tr>
                        <tr>
                            <th scope="row">수량</th>
                            <td>
                                <!-- 수량 선택기에 증가 및 감소 버튼 추가 -->
                                <div class="quantity-selector">
                                    <input type="text" id="quantity" name="quantity" value="1" readonly="readonly">
                                    <button type="button" onclick="incrementQuantity()">+</button>
                                    <button type="button" onclick="decrementQuantity()">-</button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                
                <!-- 장바구니 담기 버튼 -->
                <button type="button" id="addToCartBtn">장바구니 담기</button>
                <!-- 구매하기 버튼 -->
                <button type="button" id="purchaseBtn">구매하기</button>
            </div>
        </div>
    </div>
    
    <form id="" action="" hidden="hidden" method="post"></form>
</div>

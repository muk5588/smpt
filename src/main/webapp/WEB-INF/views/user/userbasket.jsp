<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<title>장바구니</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/css/common/paging.css">
<link rel="stylesheet" type="text/css" href="/resources/css/user/userbasket.css">
<c:import url="/WEB-INF/views/layout/header.jsp"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<c:import url="/WEB-INF/views/layout/boardmenu.jsp"/>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
    /* 새로운 스타일 */
    .custom-table th, .custom-table td {
        padding: 62px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    .custom-table tr:hover {
        background-color: #f5f5f5;
    }

    .custom-table img {
        max-width: 100px;
        height: auto;
    }

    .custom-table .quantity {
        margin: 0 5px;
    }

    .custom-table .deleteBtn {
        margin-right: 5px;
    }
</style>
<script>
$(document).ready(function() {
    // 장바구니 항목 삭제 버튼 클릭 이벤트
    $(".deleteBtn").click(function() {
        var basketNo = $(this).data("basketno");

        if (!basketNo) {
            console.error("장바구니 항목 번호를 찾을 수 없습니다.");
            return;
        }

        if (confirm("해당 상품을 삭제하시겠습니까?")) {
            // AJAX를 통해 항목 삭제 요청
            $.ajax({
                type: "POST",
                url: "./delete",
                data: { basketNo: basketNo },
                success: function (response) {
                    // 삭제 후 화면 새로고침
                    location.reload();
                },
                error: function (xhr, status, error) {
                    console.error(xhr.responseText);
                }
            });
        }
    });
});
</script>
<script type="text/javascript">
    $(function () {
    	$("#buyBtn").click(function () {
   		 var basketList = [];
   	        $("input[name=deleteNo]:checked").each(function () {
   	            var basketRow = $(this).closest("tr");
   	            var quantity = basketRow.find(".quantity").text().trim();
   	            var basket = {
   	                basketNo: $(this).val(),
   	                quantity: quantity
   	            };
   	                console.log(basket)
   	            basketList.push(basket);
            });
			console.log(basketList)
            $.ajax({
                type: "POST",
                url: "./buyBasket",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(basketList),
                dataType: "json",
                success: function (res) {
                    console.log("AJAX 성공");
                    console.log(res);
                    
                    if(res && res.length){
                    // 응답받은 데이터로 URL 파라미터 생성
                    var urlQueryString = res.map(function (basket) {
                        return 'basketNo=' + basket.basketNo + '&quantity=' + basket.quantity;
                    }).join('&');
	                    
	                    window.location.href = "../order/ordersheet?" + urlQueryString;
	                }else{
	                	alert("처리과정에 에러가 발생하였습니다")
	                	window.location.href = '/basket/userbasket'
	                }

                },
                error: function () {
                    console.log("AJAX 실패");
                }
            });
        }
    });
});
        });
        
        $(".deleteBtn").click(function(e){
        	console.log("deleteBtn")
        	var basketNo = $(e.target).val();
        	console.log(basketNo)
        	
            $.ajax({
                type: "get",
                url: "./deleteBasket",
                data: {
                    basketNo: basketNo
                },
                dataType: "json",
                success: function (res) {
                    console.log("AJAX 성공")
                    console.log(res)
					if( res > 0 ){
	                   $(function () {
	                   	 window.location.reload();                    
	                   })
					}
                },
                error: function () {
                    console.log("AJAX 실패")
                }
            });
        	
        })

    })

</script>

</head>
<body>

   <div class="container">

        <h1>장바구니</h1>
        <a href="/">
            <button>메인 페이지로</button>
        </a>
        
<div id="basketwrap">
<table class="custom-table">
<c:choose>
    <c:when test="${not empty baskets and not empty items }">
        <tr>
            <th>상품명</th>
            <th>이미지</th>
            <th>가격</th>
            <th>담은 날짜</th>
            <th>재고</th>
            <th>상세 보기</th>
            <th>삭제</th>
        </tr>
    <c:forEach items="${baskets}" var="basket">
    <c:forEach items="${items}" var="item">
    <c:if test="${basket.itemNo eq item.itemNo and not empty basket.itemNo and not empty item.itemNo}">
        <tr>
         <!-- 상품 상세 페이지로 이동하는 링크 -->
         <td>${item.itemName}</td>
         <td>
            <c:choose>
                <c:when test="${not empty itemFiles}">
                    <c:forEach items="${itemFiles}" var="file">
                        <c:if test="${not empty item.itemNo and file.itemNo eq item.itemNo}">
                            <!-- 해당 상품에 대한 이미지 파일이 존재하는 경우 -->
                            <img alt="ItemImg" src="/resources/itemUpload/${file.storedName}">
                        </c:if>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- 이미지 파일이 없는 경우 -->
                    <img src="/resources/img/shop/nullimg.jpg" alt="notready">
                </c:otherwise>
            </c:choose>
         </td>
         <td><fmt:setLocale value="ko_KR"/><fmt:formatNumber type="currency" value="${item.price}"/></td>
         <td><fmt:formatDate value="${basket.additionalDate}" pattern="yy-MM-dd" /></td>
         <td class="max-quantity">재고 : ${item.remain}</td>
         <td><div class="buygo"><a href="/shop/detail?itemNo=${item.itemNo}">${item.itemName}</div></td>
         <td>
            <button class="deleteBtn" data-basketno="${basket.basketNo}">삭제</button>
         </td>

        </tr>
    </c:if>
    </c:forEach>
    </c:forEach>
    </c:when>
    <c:when test="${empty baskets }">
        <tr>
            <td>장바구니 목록이 비었습니다</td>
        </tr>
    </c:when>
</c:choose>
</table>
</div>
       
    </div>
    <!-- .container End -->


<c:import url="/WEB-INF/views/layout/footer.jsp"/>
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
<script>
$(document).ready(function() {
    // 장바구니 항목 삭제 버튼 클릭 이벤트
    $(".deleteBtn").click(function() {
        var checkedBasketNos = $("input[name='deleteNo']:checked").map(function(){
            return $(this).val();
        }).get();

        if (checkedBasketNos.length === 0) {
            alert("삭제할 항목을 선택하세요.");
            return;
        }

        if (confirm("선택한 항목을 삭제하시겠습니까?")) {
            // AJAX를 통해 선택된 항목 삭제 요청
            $.ajax({
                type: "POST",
                url: "./delete",
                traditional: true,
                data: { basketNo: checkedBasketNos },
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

    $(".decrement-button").click(function() {
        var quantityElement = $(this).siblings(".quantity");
        var currentValue = parseInt(quantityElement.text());
        if (currentValue > 1) {
            quantityElement.text(currentValue - 1);
        }
    });

    $(".increment-button").click(function() {
        var quantityElement = $(this).siblings(".quantity");
        var currentValue = parseInt(quantityElement.text());
        var remain = parseInt($(this).closest("tr").find(".max-quantity").text().split(":")[1].trim()); // 최대 재고량 가져오기
        if (!isNaN(remain)) { // 최대 재고량이 숫자인지 확인
            if (currentValue < remain) {
                quantityElement.text(currentValue + 1);
            } else {
                alert("남은 재고를 초과할 수 없습니다.");
            }
        } else {
            alert("최대 재고량이 올바르게 표시되지 않았습니다.");
        }
    });

    // 구매하기 버튼 클릭 이벤트
    $("#buyBtn").click(function() {
        var datas = [];
        var urlData = [];
        $("input[name=deleteNo]:checked").each(function() {
            var no = $(this).val();
            datas.push(no);
            var param = 'res=' + $(this).val();
            urlData.push(param);
        });
        var urlQueryString = urlData.join('&');
        console.log(datas); // 체크된 상품들의 값 확인용

        $.ajaxSettings.traditional = true;
        $.ajax({
            type: "POST",
            url: "./buyBasket",
            data: {
                basketNo: datas
            },
            dataType: "json",
            success: function (res) {
                console.log("AJAX 성공")
                console.log(res)

                // 선택된 항목을 구매하는 사이트로 이동
                window.location.href = "/your-purchase-site-url?" + urlQueryString;
            },
            error: function () {
                console.log("AJAX 실패")
            }
        });
    });
});

</script>
</head>
<body>

   <div class="container">

        <h1>장바구니</h1>
        <a href="/">
            <button>메인 페이지로</button>
        </a>
        
<div id="basketwrap">
<table>
<c:choose>
    <c:when test="${not empty baskets and not empty items }">
        <tr>
            <th>상품명</th>
            <th>수량</th>
            <th>이미지</th>
            <th>가격</th>
            <th>담은 날짜</th>
            <th>동작</th>
        </tr>
    <c:forEach items="${baskets }" var="basket">
    <c:forEach items="${items }" var="item">
    <c:if test="${basket.itemNo eq item.itemNo and not empty basket.itemNo and not empty item.itemNo}">
        <tr>
            <td>${item.itemName }</td>
            <td>
                <button class="decrement-button" data-itemNo="${item.itemNo}">-</button>
                <span class="quantity">${basket.quantity }</span>
                <button class="increment-button" data-itemNo="${item.itemNo}">+</button>
            </td>
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
            <td><fmt:setLocale value="ko_KR"/><fmt:formatNumber type="currency" value="${item.price}"/>* ${basket.quantity}=${item.price * basket.quantity }</td>
            <td><fmt:formatDate value="${basket.additionalDate}" pattern="yy-MM-dd HH:mm" /></td>
            <td>
                <div class="form-check form-switch">
                <button class="deleteBtn">삭제</button>
                </div>
                <div class="form-check form-switch">
                    <input class="form-check-input buy-checkbox" name="deleteNo" type="checkbox" value="${basket.basketNo}">
                    <label class="form-check-label">구매하기</label>
                </div>
            </td>
             <td class="max-quantity">재고 : ${item.remain}</td>
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
<div ><button id="buyBtn">구매하기</button></div>
</div>
       

    </div>
    <!-- .container End -->

    <c:import url="/WEB-INF/views/layout/shopPaging.jsp"/>

<c:import url="/WEB-INF/views/layout/footer.jsp"/>
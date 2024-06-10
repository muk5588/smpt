<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp"/>
<link rel="stylesheet" href="/resources/css/shop/detail.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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
$(function () {


    $(document).ready(function () {
        handelGetReview()
    })

    //장바구니 담기 버튼
    $("#addToCartBtn").click(function () {
        // isLogin 변수에는 로그인 상태를 나타내는 값이 있어야 합니다.
        // 만약 이 값이 서버에서 제공되는 변수라면 그 값을 사용해야 합니다.
        // 예: var isLogin = ${isLogin};
        var itemNo =
        ${item.itemNo}
        var quantity = $("#quantity").val()
        if (${empty isLogin or isLogin < 1}) {
            //로그인 페이지로 이동
            alert("로그인 이후 이용이 가능합니다")
//          $(location).attr('href', './login')
            window.location.href = "/login";
        } else {
            $.ajax({
                type: "get"
                , url: "../basket/insert"
                , data: {
                    itemNo: itemNo
                    , quantity: quantity
                }
                , dataType: "json"
                , success: function (res) {
                    console.log(res)
// 				console.log("AJAX 성공")
// 				console.log(res)
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

    // 구매하기 버튼 클릭
    $("#purchaseBtn").click(function () {
        var itemNo = ${item.itemNo};
        var quantity = $("#quantity").val();
        if (${empty isLogin or isLogin < 1}) {
            // 로그인 페이지로 이동
            alert("로그인 이후 이용이 가능합니다");
            window.location.href = "/login";
        } else {
            // 로그인 상태일 때 주문서 페이지로 이동
            window.location.href = '../order/ordersheet?itemNo=' + itemNo + '&quantity=' + quantity;
        }
    });

    //신고하기 버튼 클릭
    $("#reportBtn").click(function () {
        var itemNo = ${item.itemNo}
            $(function () {
                window.location.href = '../report/itemReport?itemNo=' + itemNo;
            })
    })

    //리뷰 AJAX 통신
    function handelGetReview() {
        console.log("getReview")

        var itemNo = '${item.itemNo}'
        $.ajax({
            type: "get"
            , url: "./review/loadreview"
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
        var userno_d = ${dto1.userno};
        if (reviews.length > 0) {
            reviews.forEach(function (review) {
                reviewHtml += '<div class="review">';
                reviewHtml += '<div class="tit">';
                reviewHtml += '<h5>' + review.reviewTitle + '</h5>';
                reviewHtml += '<h6>' + review.nickname + '</h6>';
                reviewHtml += '</div>';
                reviewHtml += '<div class="tit">';
                reviewHtml += '<p>' + review.reviewContent + '</p>';
                if (userno_d === review.userNo) {
                    reviewHtml += '<div>';
                    reviewHtml += '<a class="editReviewBtn" data-review-No="' + review.reviewNo + '" data-review-title="' + review.reviewTitle + '" data-review-content="' + review.reviewContent + '">수정</a>';
                    reviewHtml += '<a class="deleteReviewBtn" data-review-No="' + review.reviewNo + '"> 삭제</a>';
                    reviewHtml += '</div>';
                } else if (${dto1.gradeno == 0 || dto1.gradeno == 5000}) {
                    reviewHtml += '<div>';
                    reviewHtml += '<a class="deleteReviewBtn" data-review-No="' + review.reviewNo + '"> 삭제</a>';
                    reviewHtml += '</div>';
                }
                reviewHtml += '</div>';
                reviewHtml += '<small> ' + new Date(review.createReviewDate).toLocaleDateString().replace(/\.$/, '') + '</small>';
                reviewHtml += '</div><hr>';
                // 수정 버튼 추가



            });
        } else {
            reviewHtml = '<p>리뷰가 아직 작성되지 않았습니다</p>';
        }
        $("#reviewWrap").html(reviewHtml);
    }

    $('#reviewWrap').on('click', '.deleteReviewBtn', function () {
        var reviewNo = $(this).data('review-no');
        if (confirm('정말 이 리뷰를 삭제하시겠습니까?')) {
            $.ajax({
                url: '/shop/review/deletereview',
                type: 'POST',
                data: {
                    reviewNo: reviewNo
                },
                dataType: "JSON",
                success: function (res) {

                    // 페이지를 새로고침하거나, 삭제된 리뷰를 제거하는 등의 후속 작업을 여기에 추가
                    location.reload();
                },
                error: function () {
                    location.reload();

                }
            });
        }
    });

    $(document).ready(function () {
        // 리뷰 수정 버튼 클릭 이벤트
        $(document).on('click', '.editReviewBtn', function () {
            // 해당 리뷰의 정보 가져오기
            var reviewNo = $(this).data('review-no'); // 변수명을 수정하였습니다.
            var reviewTitle = $(this).data('review-title');
            var reviewContent = $(this).data('review-content');

            // 팝업 창 옵션 설정
            var popOption = "width=500,height=500,top=300,left=300";

            // 수정 팝업 창 열기
            var openUrl = '/shop/review/updateReviewForm?reviewNo=' + reviewNo + '&reviewTitle=' + encodeURIComponent(reviewTitle) + '&reviewContent=' + encodeURIComponent(reviewContent);
            window.open(openUrl, 'popup', popOption);
        });
    });


    popupsendForm.onclick = function () {
        let popOption = "width = 500px, height=500px, top=300px, left=300px"
        let openUrl = '/shop/review/writeReviewForm?itemNo=${item.itemNo}'
        window.open(openUrl, 'popup', popOption);
    }
})
</script>
</head>
<body>

 <div class="container">
    <h1>상품 정보</h1>
    <div class="mainbtn">
    <a href="/">
        <button>메인 페이지로</button>
    </a>
      </div>
    <div id="itemwarp" style="border: 1px solid #ccc; padding: 20px; margin-top: 20px;">
        <div class="row">
            <div class="col-md-4">
                <!-- 상품 이미지 -->

					<c:choose>
					    <c:when test="${empty files}">
					        <!-- 이미지 파일이 없는 경우 -->
					        <img src="/resources/img/shop/nullimg.jpg" alt="notready" class="img-fluid">
					    </c:when>
					    <c:otherwise>
					        <!-- 이미지 파일이 있는 경우 -->
					        <c:forEach items="${files}" var="file">
					            <!-- 상품 이미지 파일 경로 -->
					            <img src="/resources/itemUpload/${file.storedName}" alt="ItemImg" class="img-fluid">
					        </c:forEach>
					    </c:otherwise>
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
                            <th scope="row">재고</th>
                            <td>${item.remain}</td>
                        </tr>
                        <tr>
                            <th scope="row">수량</th>
                            <td>
                                <!-- 수량 선택기에 증가 및 감소 버튼 추가 -->
                                <div class="quantity-selector">
                                    <input type="text" id="quantity" name="quantity" value="0" readonly="readonly">
                                    <button type="button" onclick="incrementQuantity()">+</button>
                                    <button type="button" onclick="decrementQuantity()">-</button>
                                </div>
                            </td>
                        </tr>
                    <tr>
                <td style="text-align: left;" colspan="2">
                    <!-- 장바구니 담기 버튼 -->
                    <button type="button" id="addToCartBtn">장바구니 담기</button>
                    <!-- 구매하기 버튼 -->
                    <button type="button" id="purchaseBtn">구매하기</button>
                    <!-- 신고하기 버튼 -->
                    <button type="button" id="reportBtn">신고하기</button>
                </td>
            </tr>
			<tr>
                <td colspan="2"><a style="font-size: 1.3em">상품설명</a><br>${item.itemComm}</td>
            </tr>

        </table>

    </div>

    <form id="" action="" hidden="hidden" method="post"></form>

    <div id="reviewWrap">


    </div>
    <br>
    <c:if test="${countMyOrder > 0}">
        <button id="popupsendForm">리뷰 쓰기</button>
    </c:if>


</div>


<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

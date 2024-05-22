<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
           <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<jsp:include page="/WEB-INF/views/layout/boardmenu.jsp" />
<style type="text/css">
    .wrap {
        width: 1100px;
    }

    .itemImg img {
        max-width: 100%;
        height: auto;
        transition: transform 0.3s ease; /* Smooth transition for the image scaling */
    }

    .itemImg:hover img {
        transform: scale(1.2); /* Scale the image to 1.2 times its original size on hover */
    }

    .exchange-card {
        position: fixed;
        top: 50%;
        right: 100;
        transform: translateY(-50%);
        width: 250px;
        cursor: pointer;
        background-color: #fff;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        z-index: 1000;
        padding: 10px;
    }

    .exchange-rates {
        display: none;
    }

    .exchange-card:hover .exchange-rates {
        display: block;
    }

    .exchange-card .card-body {
        position: relative;
    }
     /* 왼쪽 사이드바 스타일 */
        .filter {
        position: fixed;
        top: 50%;
        left:100;
        transform: translateY(-50%);
        width: 250px;
        cursor: pointer;
        background-color: #fff;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        z-index: 1000;
        padding: 10px;
        }
</style>
<script type="text/javascript">
    $(function () {
        var blank_pattern = /^\s+|\s+$/g;

        $("#searchForm").submit(function (e) {
            console.log("#searchForm submit");

            var searchTerm = $("#search").val().trim(); // Remove leading and trailing whitespace

            if (!searchTerm) {
                alert("검색어를 입력해주세요");
                return false;
            }

            if (searchTerm.length === 0) {
                alert(' 공백만 입력되었습니다 ');
                return false;
            }

            $("#search").val(searchTerm);
        });
    });
</script>

</head>
<body>

<div class="exchange-card">
    <div class="card-body">
        <h5 class="card-title">환율 정보</h5>
        <div class="exchange-rates">
            <p class="card-text">미국 달러(USD) 환율 정보: ${exchangeRates[0]}</p>
            <p class="card-text">일본 엔(JPY) 환율 정보: ${exchangeRates[1]}</p>
            <p class="card-text">중국 위안(CNY) 환율 정보: ${exchangeRates[2]}</p>
            <p class="card-text">태국 바트(THB) 환율 정보: ${exchangeRates[3]}</p>
            <p class="card-text">유럽 유로(EUR) 환율 정보: ${exchangeRates[4]}</p>
        </div>
    </div>
</div>
<div class="filter">
    <!-- 검색 필터 폼 -->
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">검색 필터</h5>
            <form action="" method="get" id="filterForm">
                <!-- 필터 요소 -->
                <div class="mb-3">
				    <label for="priceRange">가격대</label>
				    <input type="text" id="minPrice" name="minPrice" placeholder="최소 가격" class="form-control">
				    <input type="text" id="maxPrice" name="maxPrice" placeholder="최대 가격" class="form-control">
				</div>
                <!-- 카테고리 필터 -->
                <button type="submit" class="btn btn-primary">필터 적용</button>
            </form>
        </div>
    </div>
</div>


<div class="wrap mx-auto mt-3">
    <div class="container">
        <h1>상품 구매</h1>
        <a href="../main" class="btn btn-primary mb-2">메인 페이지로</a>
        <a href="../basket/userbasket" class="btn btn-secondary mb-2">장바구니</a>
        <div>
            <form action="" method="get" id="searchForm" class="d-flex my-3">
            
                <input type="text" name="search" id="search" value="${search}" class="form-control me-2">
                <input hidden="hidden" name="curPage" value="${curPage}">
                <button id="searchBtn" class="btn btn-outline-success">검색</button>
            </form>
        </div>
        <hr>
        
        <c:set var="imgFiles" value="${files }"/>
        <div id="itemwarp">
            <div class="row">
                <c:forEach var="item" items="${item }">
      <div class="col-md-4 col-sm-6 mb-4">
			    <div class="card h-100">
			        <a href="./detail?itemNo=${item.itemNo}" class="text-decoration-none">
			            <div class="itemImg card-img-top">
			                <c:choose>
			                    <c:when test="${not empty imgFiles}">
			                        <c:forEach items="${files}" var="files">
			                            <c:if test="${not empty files.itemNo and item.itemNo eq files.itemNo}">
			                                <img alt="ItemImg" src="/resources/img/shop/upload/${files.storedName}" class="img-fluid">
			                            </c:if>
			                        </c:forEach>
			                    </c:when>
			                    <c:otherwise>
			                        <img src="/resources/img/shop/nullimg.jpg" alt="notready" class="img-fluid">
			                    </c:otherwise>
			                </c:choose>
			            </div>
			            <div class="card-body">
			                <h5 class="card-title">${item.itemName}</h5>
			                <p class="card-text">
			                    <fmt:setLocale value="ko_KR"/>
			                    <fmt:formatNumber type="currency" value="${item.price}" />
			                </p>
			            </div>
			        </a>
			    </div>
			</div>

                </c:forEach>
            </div>
        </div>
    </div>
    <!-- .container End -->
    <jsp:include page="/WEB-INF/views/layout/shopPaging.jsp" />
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

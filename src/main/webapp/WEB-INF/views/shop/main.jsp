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
<style type="text/css">
    .wrap {
        width: 1100px;
    }

    table, th {
        text-align: center;
    }

    .exchange-card {
        position: fixed;
        top: 50%;
        right: 0;
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
</style>
<script type="text/javascript">
    $(function () {
        var blank_pattern = /^\s+|\s+$/g;

        $("#searchForm").submit(function (e) {
            console.log("#searchForm submit")

            var searchTerm = $("#search").val().trim(); // 입력값의 앞뒤 공백 제거

            if (!searchTerm) {
                alert("검색어를 입력해주세요")
                return false;
            }

            if (searchTerm.length === 0) {
                alert(' 공백만 입력되었습니다 ');
                return false;
            }

            $("#search").val(searchTerm)
        })
    })
</script>
</head>
<body>

<div class="exchange-card">
    <div class="card-body">
        <h5 class="card-title">환율 정보 </h5>
        <div class="exchange-rates">
            <p class="card-text">미국 달러(USD) 환율 정보: ${exchangeRates[0]}</p>
            <p class="card-text">일본 엔(JPY) 환율 정보: ${exchangeRates[1]}</p>
            <p class="card-text">중국 위안(CNY) 환율 정보: ${exchangeRates[2]}</p>
            <p class="card-text">태국 바트(THB) 환율 정보: ${exchangeRates[3]}</p>
            <p class="card-text">유럽 유로(EUR) 환율 정보: ${exchangeRates[4]}</p>
        </div>
    </div>
</div>

<div class="wrap mx-auto">
    <div class="container">
        <h1>상품 구매</h1>
        <a href="../main">
            <button>메인 페이지로</button>
        </a>
        <a href="../basket/userbasket">
        	<button>장바구니</button>
        </a>
        <div>
            <form action="" method="get" id="searchForm">
                <input type="text" name="search" id="search" value="${search}">
                <input hidden="hidden" name="curPage" value="${curPage}">
                <button id="searchBtn">검색</button>
            </form>
        </div>
        <hr>
        
    	<c:set var="imgFiles" property="${files }"/>
        <div id="itemwarp">
            <ul>
            <c:forEach var="item" items="${item }">
                <div class="oneItem">
                    <li style="list-style: none; border: 1px solid #ccc;">
                        <div class="itemImg">
                            <a href="./detail?itemNo=${item.itemNo }">
                                <c:choose>
                                    <c:when test="${not empty imgFiles}">
                                        <c:forEach items="${files}" var="files">
                                            <c:if test="${not empty files.itemNo and item.itemNo eq files.itemNo}">
                                                <img alt="ItemImg" src="/resources/img/shop/upload/${files.storedName }">
                                            </c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/resources/img/shop/nullimg.jpg" alt="notready">
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </div>
                        <div class="itemInfo">
                            <a href="./detail?itemNo=${item.itemNo }">
                                ${item.itemName}<br>
                                <fmt:setLocale value="ko_KR"/>
                                <fmt:formatNumber type="currency" value="${item.price}" />
                            </a>
                        </div>
                    </li>
                </div>
            </c:forEach>
            </ul>
        </div>
    </div>
    <!-- .container End -->
    <c:import url="/WEB-INF/views/layout/shopPaging.jsp"/>
</div>

<c:import url="/WEB-INF/views/layout/footer.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/resources/css/common/paging.css">
<link rel="stylesheet" type="text/css" href="/resources/css/shop/list.css">
<style>
 button {
        background: #87cefa;
        color: white;
        border: none;
        padding: 0.5em 1em;
        cursor: pointer;
        transition: background 0.3s ease;
    }

    button:hover {
        background: #39a9db;
    }

    button:disabled {
        background: #ccc;
        cursor: not-allowed;
    }
    #searchForm {
        display: flex;
        gap: 10px;
        align-items: center;
        margin-bottom: 10px;
        float: right;
    }

    #searchForm select, #searchForm input[type="text"] {
        padding: 0.5em;
        border: 1px solid #ddd;
        border-radius: 4px;
    }

    #searchForm button {
        padding: 0.5em 1em;
    }
</style>
<script type="text/javascript">
    $(function () {
        var blank_pattern = /^\s+|\s+$/g;

        $("#searchForm").submit(function (e) {
            var searchTerm = $("#search").val().trim();

            if (!searchTerm) {
                alert("검색어를 입력해주세요");
                return false;
            }

            if (searchTerm.length === 0) {
                alert('공백만 입력되었습니다');
                return false;
            }

            $("#search").val(searchTerm);
        });

        // 상품이 존재하지 않을 때 알림창 띄우기
        <c:if test="${empty items}">
            alert("상품이 존재하지 않습니다.");
        </c:if>
    });
    
    
</script>


<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
<jsp:include page="/WEB-INF/views/layout/boardmenu.jsp"/>

<div class="wrap mx-auto">
    <div class="container">
        <h1>상품 페이지</h1>
        <form action="" method="get" id="searchForm">
            <input type="text" name="search" id="search" placeholder="검색하실 상품명을 작성해 주세요" value="${param.search}">
            <input type="text" name="minPrice" placeholder="최소 가격" value="${param.minPrice}">
            <input type="text" name="maxPrice" placeholder="최대 가격" value="${param.maxPrice}">
            <input hidden="hidden" name="curPage" value="${curPage}">
            <button id="searchBtn">검색</button>
        </form>
        <hr>
        <div class="oneAll">
            <c:forEach var="item" items="${items}">
                <ul class="oneItem">
                    <li style="list-style: none; border: 1px solid #ccc;">
                        <div class="item Img">
                            <a href="./detail?itemNo=${item.itemNo}">
                                <c:choose>
                                    <c:when test="${not empty itemFiles}">
                                        <c:forEach items="${itemFiles}" var="imgFile">
                                            <c:if test="${item.itemNo == imgFile.itemNo}">
                                                <img alt="ItemImg" src="/resources/itemUpload/${imgFile.storedName}" class="img-fluid">
                                            </c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/resources/img/shop/nullimg.jpg" alt="notready" class="img-fluid">
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </div>
                        <div class="item Info">
                            <a href="./detail?itemNo=${item.itemNo}">
                                ${item.itemName}<br>
                                <fmt:setLocale value="ko_KR"/>
                                <fmt:formatNumber type="currency" value="${item.price}"/>
                            </a>
                        </div>
                    </li>
                </ul>
            </c:forEach>
        </div>
    </div>
    <c:import url="/WEB-INF/views/layout/shopPaging.jsp"/>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

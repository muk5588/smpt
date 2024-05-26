<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <title>Q&A 게시판</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
    <style>
        .pagination-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .search-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            margin-bottom: 20px;
        }
        .recommend-count {
            color: red;
            font-weight: bold;
        }
        .table th, .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <c:import url="/WEB-INF/views/layout/header.jsp"/>
    <jsp:include page="/WEB-INF/views/layout/boardmenu.jsp"/>

    <div class="container mt-3">
        <h1 class="text-center mb-4">Q&A 게시판</h1>

        <!-- 정렬 옵션 추가 -->
        <div class="row mb-4">
            <div class="col text-end">
                <select id="sortType" class="form-select w-auto d-inline-block">
                    <option value="latest" ${sortType eq 'latest' ? 'selected' : ''}>최신순</option>
                    <option value="popular" ${sortType eq 'popular' ? 'selected' : ''}>추천순</option>
                    <option value="views" ${sortType eq 'views' ? 'selected' : ''}>조회순</option>
                </select>
                <button id="sortBtn" class="btn btn-outline-secondary">정렬</button>
            </div>
        </div>

        <!-- 게시글 목록 테이블 -->
        <table class="table table-hover">
            <thead>
                <tr>
                    <th scope="col">번호</th>
                    <th scope="col">제목</th>
                    <th scope="col">글쓴이</th>
                    <th scope="col">날짜</th>
                    <th scope="col">조회수</th>
                    <th scope="col">추천수</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="qanda" items="${list}">
                    <tr>
                        <th scope="row">${qanda.boardNo}</th>
                        <td><a href="/qanda/detail?boardNo=${qanda.boardNo}" class="text-decoration-none">${qanda.title}</a></td>
                        <td>${qanda.nickname}</td>
                        <td><fmt:formatDate value="${qanda.createDate}" pattern="yyyy-MM-dd" /></td>
                        <td>${qanda.boardview}</td>
                        <td class="recommend-count">${qanda.recommendCount}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- 로그인 상태일 때만 글 등록 버튼 표시 -->
        <c:if test="${isLogin}">
            <div class="text-center my-3">
                <a href="/qanda/create" class="btn btn-primary">글 등록</a>
            </div>
        </c:if>

        <!-- 페이징 -->
        <div class="pagination-container">
            <ul class="pagination">
                <c:if test="${pageMaker.prev}">
                    <li class="page-item"><a class="page-link" href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
                </c:if>
                <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
                    <li class="page-item ${pageMaker.page == idx ? 'active' : ''}"><a class="page-link" href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
                </c:forEach>
                <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
                    <li class="page-item"><a class="page-link" href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
                </c:if>
            </ul>
        </div>

        <!-- 검색 창 -->
        <div class="search-container">
            <form class="d-flex">
                <select name="searchType" class="form-select w-auto me-2">
                    <option value="n" ${scri.searchType == null ? 'selected' : ''}>-----</option>
                    <option value="t" ${scri.searchType eq 't' ? 'selected' : ''}>제목</option>
                    <option value="c" ${scri.searchType eq 'c' ? 'selected' : ''}>내용</option>
                    <option value="w" ${scri.searchType eq 'w' ? 'selected' : ''}>작성자</option>
                    <option value="tc" ${scri.searchType eq 'tc' ? 'selected' : ''}>제목+내용</option>
                </select>
                <input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" class="form-control w-auto me-2" />
                <button id="searchBtn" class="btn btn-outline-primary">검색</button>
            </form>
        </div>

        <script>
            $(function() {
                $('#searchBtn').click(function(event) {
                    event.preventDefault();
                    let searchType = $("select[name=searchType] option:selected").val();
                    let keyword = encodeURIComponent($('#keywordInput').val());
                    let url = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + searchType + "&keyword=" + keyword;
                    self.location = url;
                });

                // 정렬 버튼 스크립트
                $('#sortBtn').click(function() {
                    let sortType = $('#sortType option:selected').val();
                    let url = "list" + '${pageMaker.makeQuery(1)}' + "&sortType=" + sortType;
                    self.location = url;
                });
            });
        </script>
    </div>

    <c:import url="/WEB-INF/views/layout/footer.jsp"/>
</body>
</html>

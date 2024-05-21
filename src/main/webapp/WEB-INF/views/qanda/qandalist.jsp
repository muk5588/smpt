<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Q&A 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        th, td { text-align: center; }
        .title-cell { width: 40%; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-3">
    <h1>Q&A 목록</h1>
    <a href="/qanda/qandaForm" class="btn btn-primary mb-3">글쓰기</a>
    <div class="input-group mb-3">
        <select class="form-select" name="searchType">
            <option value="title">제목</option>
            <option value="content">내용</option>
        </select>
        <input type="text" class="form-control" name="keyword" placeholder="검색어를 입력하세요">
        <button class="btn btn-primary" type="button">검색</button>
    </div>

    <div class="input-group mb-3">
        <label class="input-group-text" for="sortSelect">정렬 기준</label>
        <select class="form-select" id="sortSelect" onchange="location = this.value;">
            <option value="/qanda/qandalist?sort=latest" ${sort == 'latest' ? 'selected' : ''}>최신순</option>
            <option value="/qanda/qandalist?sort=popular" ${sort == 'popular' ? 'selected' : ''}>인기순</option>
            <option value="/qanda/qandalist?sort=views" ${sort == 'views' ? 'selected' : ''}>조회순</option>
        </select>
    </div>

    <table class="table table-striped">
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col" class="title-cell">제목</th>
                <th scope="col">작성일</th>
                <th scope="col">조회수</th>
                <th scope="col">추천수</th>
                <th scope="col">수정</th>
                <th scope="col">삭제</th>
                <th scope="col">작성자</th> <!-- 작성자 컬럼 추가 -->
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${qandas}" var="qanda" varStatus="status">
                <tr>
                    <td>${status.count}</td>
                    <td class="title-cell">
                        <!-- 제목을 클릭하는 링크에 onclick 이벤트 추가 -->
                        <a href="/qanda/detail/${qanda.seq}?action=increaseViews">${qanda.title}</a>
                    </td>
                    <td><small><fmt:formatDate value="${qanda.createDate}" pattern="yyyy년 MM월 dd일 HH시 mm분" timeZone="Asia/Seoul"/></small></td>
                    <td>${qanda.views}</td>
                    <td>${qanda.good}</td>
                    <td><a href="/qanda/edit/${qanda.seq}" class="btn btn-warning">수정</a></td>
                    <td>
                        <form action="/qanda/delete/${qanda.seq}" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                            <button type="submit" class="btn btn-danger">삭제</button>
                        </form>
                    </td>
                    <td>${qanda.userid}</td> <!-- 작성자 표시 -->
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <li class="page-item"><a class="page-link" href="?page=${currentPage - 1}">Previous</a></li>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${i == currentPage ? 'active' : ''}"><a class="page-link" href="?page=${i}">${i}</a></li>
            </c:forEach>
            <li class="page-item"><a class="page-link" href="?page=${currentPage + 1}">Next</a></li>
        </ul>
    </nav>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</body>
</html>

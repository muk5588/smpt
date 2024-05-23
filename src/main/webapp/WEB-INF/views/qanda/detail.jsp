<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행정보 공유 게시물 조회</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<script>
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('alreadyRecommended') === 'true') {
            alert('이미 추천하셨습니다');
        }
    };
</script>
<style>
.uploaded-image {
    width: 100%;
    height: auto;
    max-width: 400px;
    object-fit: cover;
    margin-bottom: 10px;
}

.detail-container {
    margin-top: 20px;
}

.detail-header {
    margin-bottom: 20px;
    border-bottom: 1px solid #dee2e6;
    padding-bottom: 10px;
}

.detail-content {
    margin-bottom: 20px;
}

.detail-buttons {
    text-align: right;
    margin-top: 20px;
}

.flex-column {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.card {
    margin-bottom: 20px;
}

.comment-section {
    margin-top: 30px;
}

.comment-form {
    margin-top: 20px;
}
</style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/layout/header.jsp" />

    <div class="container detail-container">
        <div class="card">
            <div class="card-header detail-header">
                <h2>${detail.title}</h2>
                <p>
                    <strong>작성자:</strong> ${detail.nickname}
                </p>
                <p><strong>조회수:</strong> ${detail.boardview}</p> <!-- 조회수 표시 -->
            </div>
            <div class="card-body detail-content">
                <p>${detail.content}</p>
                <c:if test="${not empty detail.imagePath}">
                    <div class="flex-column">
                        <c:forEach var="imagePath" items="${fn:split(detail.imagePath, ',')}">
                            <img src="${imagePath}" alt="Attached Image" class="uploaded-image rounded" />
                        </c:forEach>
                    </div>
                </c:if>
            </div>
			
			<!-- 추천수  -->
            <div class="detail-buttons">
                <form action="/qanda/recommend" method="post" style="display: inline;">
                    <input type="hidden" name="boardNo" value="${detail.boardNo}">
                    <c:if test="${isLogin}">
                        <button type="submit" class="btn btn-outline-success">추천</button>
                    </c:if>
                </form>
            </div>
            <p>추천 수: ${recommendCount}</p>
            <!-- 추천수 끝 -->

            <div class="card-footer detail-buttons">
                <c:if test="${isLogin and dto1.userno == detail.userno}">
                    <a href="/qanda/update?boardNo=${detail.boardNo}" class="btn btn-warning">게시물 수정</a>
                    <a href="/qanda/delete?boardNo=${detail.boardNo}" class="btn btn-danger">게시물 삭제</a>
                </c:if>
                <a href="/story/list" class="btn btn-secondary">목록</a>
            </div>
        </div>

        <div class="card comment-section">
            <div class="card-header">
                <h5>댓글</h5>
            </div>
            <div class="card-body">
                <ul class="list-group list-group-flush">
                    <c:forEach items="${reply}" var="reply">
                        <li class="list-group-item">
                            <div>
                                <p>
                                    <strong>${reply.nickname}</strong> /
                                    <fmt:formatDate value="${reply.createDate}" pattern="yyyy-MM-dd" />
                                </p>
                                <p>${reply.content}</p>
                                <p>
                                    <c:if test="${isLogin and dto1.userno == reply.userno}">
                                        <!-- 각 데이터값의 파라미터를 댓글 수정링크에 전달 -->
                                        <a href="/reply/qandareplymodify?boardNo=${detail.boardNo}&rno=${reply.rno}&userno=${reply.userno}&content=${reply.content}" class="btn btn-sm btn-outline-primary">수정</a>
                                        <form method="post" action="/reply/qandareplydelete" style="display: inline;">
                                            <input type="hidden" name="boardNo" value="${detail.boardNo}">
                                            <input type="hidden" name="rno" value="${reply.rno}">
                                            <input type="hidden" name="userno" value="${reply.userno}">
                                            <button type="submit" class="btn btn-sm btn-outline-danger">삭제</button>
                                        </form>
                                    </c:if>
                                </p>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="card-footer comment-form">
                <form method="post" action="/reply/write">
                    <c:if test="${isLogin}">
                        <!-- 유저번호는 안보이게함 -->
                        <input type="hidden" name="userno" id="userno" value="${sessionScope.dto1.userno}" readonly class="form-control">
                        <div class="mb-3">
                            <label for="nickname" class="form-label">댓글 작성자</label>
                            <input type="text" name="nickname" id="nickname" value="${sessionScope.dto1.nickname}" readonly class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="content" class="form-label">댓글 내용</label>
                            <textarea rows="5" cols="50" name="content" id="content" class="form-control"></textarea>
                        </div>
                        <input type="hidden" name="boardNo" value="${detail.boardNo}">
                        <button type="submit" class="btn btn-primary">댓글 작성</button>
                    </c:if>
                </form>
            </div>
        </div>

        <div class="text-center mt-4">
            <a href="https://www.facebook.com/sharer/sharer.php?u=http://www.naver.com/story/detail?boardNo=${detail.boardNo}"
                target="_blank" class="btn btn-info">페이스북에 공유하기</a>

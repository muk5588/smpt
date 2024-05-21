<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Q&A 상세보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Noto Sans', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }
        .header {
            padding: 20px;
            background-color: #343a40;
            color: #ffffff;
            text-align: center;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .header h1 {
            margin: 0;
            font-size: 2.5em;
        }
        .header .meta {
            margin-top: 10px;
            font-size: 0.9em;
        }
        .header .meta span {
            margin-right: 15px;
        }
        .body {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .content img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .attachment {
            margin-top: 10px;
        }
        .footer {
            text-align: center;
            margin-bottom: 20px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-info {
            background-color: #17a2b8;
            border-color: #17a2b8;
        }
        .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
        }
        .comment-section {
            background-color: #ffffff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        .comment-section h5 {
            margin-bottom: 15px;
        }
        .comment-section .comment {
            padding: 10px;
            border-bottom: 1px solid #e9ecef;
        }
        .comment-section .comment:last-child {
            border-bottom: none;
        }
        .comment-section .comment .author {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .comment-section .comment .timestamp {
            font-size: 0.9em;
            color: #868e96;
        }
        .like-button {
            margin-top: 10px;
            text-align: center;
        }
        .like-count {
            margin-top: 5px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container mt-3">
    <div class="header">
        <h1>${qanda.title}</h1>
        <div class="meta">
            <span>${qanda.userid}</span>
            <span>작성일: 
                <fmt:formatDate value="${qanda.createDate}" pattern="yyyy년 MM월 dd일 HH시 mm분" timeZone="Asia/Seoul"/>
            </span>
            <span>수정일: 
                <fmt:formatDate value="${qanda.updateDate}" pattern="yyyy년 MM월 dd일 HH시 mm분" timeZone="Asia/Seoul"/>
            </span>
        </div>
    </div>
    <div class="body">
        <div class="content mb-3">
            ${qanda.content}
        </div>
        <c:if test="${not empty qanda.imagePath}">
            <div class="mb-3 text-center">
                <img src="${qanda.imagePath}" alt="이미지 파일" class="img-fluid">
            </div>
        </c:if>
        <c:if test="${not empty qanda.attachmentPath}">
            <div class="attachment text-center">
                <a href="${qanda.attachmentPath}" class="btn btn-info" download>첨부파일 다운로드</a>
            </div>
        </c:if>
        <div class="like-button text-center">
            <button id="likeButton" class="btn btn-warning">추천</button>
            <div class="like-count">추천 수: <span id="likeCount">${qanda.good}</span></div>
        </div>
    </div>
    <div class="footer">
        <a href="${pageContext.request.contextPath}/qanda/qandalist" class="btn btn-primary mt-3">목록으로 돌아가기</a>
    </div>
    <div class="comment-section">
        <h5>댓글</h5>
        <c:forEach var="comment" items="${commentList}">
            <div class="comment">
                <div class="author">${comment.userno}</div>
                <div class="timestamp">
                    <fmt:formatDate value="${comment.createDate}" pattern="yyyy년 MM월 dd일 HH시 mm분" timeZone="Asia/Seoul"/>
                </div>
                <div class="text">${comment.content}</div>
            </div>
        </c:forEach>
        <form action="${pageContext.request.contextPath}/qanda/addComment" method="post" class="mt-4">
            <input type="hidden" name="qandaId" value="${qanda.seq}">
            <div class="mb-3">
                <label for="commentContent" class="form-label">댓글 작성</label>
                <textarea class="form-control" id="commentContent" name="content" rows="3" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">댓글 작성</button>
        </form>
    </div>
</div>
<script>
    $(document).ready(function() {
        $("#likeButton").click(function() {
            $.ajax({
                url: "${pageContext.request.contextPath}/qanda/increaseLikes/${qanda.seq}",
                type: "POST",
                success: function(response) {
                    if (response.success) {
                        var likeCount = parseInt($("#likeCount").text());
                        $("#likeCount").text(likeCount + 1);
                    } else {
                        alert(response.message);
                    }
                },
                error: function() {
                    alert("추천을 할 수 없습니다. 다시 시도해주세요.");
                }
            });
        });
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>

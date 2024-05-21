<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${qanda.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-3">
    <h1>${qanda.title}</h1>
    <p>${qanda.content}</p>
    <h3>댓글</h3>
    <c:forEach items="${comments}" var="comment">
        <div class="card mt-2">
            <div class="card-body">
                <p class="card-text">${comment.commentText}</p>
                <footer class="blockquote-footer">Written by ${comment.userId} on <cite title="Source Title">${comment.createDate}</cite></footer>
            </div>
        </div>
    </c:forEach>

    <!-- 댓글 작성 폼 -->
    <form action="/qanda/addComment" method="post">
        <input type="hidden" name="qandaId" value="${qanda.id}" />
        <div class="mb-3">
            <label for="commentText" class="form-label">댓글 작성</label>
            <textarea class="form-control" id="commentText" name="commentText" rows="3"></textarea>
        </div>
        <button type="submit" class="btn btn-primary">댓글 추가</button>
    </form>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>

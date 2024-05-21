<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Q&A 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-3">
    <h1>Q&A 수정</h1>
    <form action="${pageContext.request.contextPath}/update/${qanda.seq}" method="post">
        <div class="mb-3">
            <label for="title" class="form-label">제목:</label>
            <input type="text" id="title" name="title" class="form-control" value="${qanda.title}" required>
        </div>
        <div class="mb-3">
            <label for="content" class="form-label">내용:</label>
            <textarea id="content" name="content" class="form-control" rows="5" required>${qanda.content}</textarea>
        </div>
        <button type="submit" class="btn btn-primary">수정 완료</button>
    </form>
</div>
</body>
</html>

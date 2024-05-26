<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 작성</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<style>
    .form-container {
        max-width: 600px;
        margin: 20px auto;
        padding: 20px;
        border: 1px solid #dee2e6;
        border-radius: 10px;
        background-color: #f8f9fa;
    }
    .form-title {
        text-align: center;
        margin-bottom: 20px;
    }
</style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/layout/header.jsp" />

    <div class="container form-container">
        <h2 class="form-title">게시물 작성</h2>
        <form method="post" action="/qanda/create" enctype="multipart/form-data">
        
        	<!-- 게시판 분류 코드 선택 -->
            <div class="mb-3">
                <label for="categoryNo" class="form-label">게시판 분류</label>
                <select class="form-control" id="categoryNo" name="categoryNo" required>
                    <option value="11">여행지 정보 - 여행 이야기 공유</option>
                    <option value="12">여행지 정보 - 여행 팁 및 권고사항</option>
                    <option value="13">여행지 정보 - 다양한 여행 목적지 추천</option>
                </select>
            </div>
        
        
            <div class="mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text" class="form-control" id="title" name="title" required />
            </div>
             
            <!-- 유저번호는 안보이게함 -->
            <input type="hidden" class="form-control" id="userno" name="userno" value="${sessionScope.dto1.userno}" readonly />
      
            <div class="mb-3">
                <label for="nickname" class="form-label">작성자</label>
                <input type="text" class="form-control" id="nickname" name="nickname" value="${sessionScope.dto1.nickname}" readonly />
            </div>

            

            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
            </div>
            
            <div class="mb-3">
                <label for="uploadFiles" class="form-label">이미지 업로드</label>
                <input type="file" class="form-control" id="uploadFiles" name="uploadFiles" multiple="multiple" />
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">작성</button>
                <a href="/story/list" class="btn btn-secondary">목록으로</a>
            </div>
        </form>
    </div>

    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />

</body>
</html>

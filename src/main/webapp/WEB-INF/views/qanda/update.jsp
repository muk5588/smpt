<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	

	<!-- 주의해야할 부분은, 입력 엘리먼트인 <input> 과 <textarea>의 **이름(name) 속성의 값이 BoardVO와 동일해야한다**.

	동일하지 않으면 전송을할 수 없는건 아니지만, 별도로 작업을 해주어야하기 때문에 VO(Value Object)를 만든 의미가 없다. 
	프론트단에서 전송하는 데이터 타입을 VO화 시키고, 백단인 컨트롤러에서도 같은 VO타입으로 받도록 해주면 알아서 데이터가 들어가기 때문에 편리하다 -->


	<!-- 게시물을 작성하고, DB에 입력할 수 있도록 <form> 태그를 추가 -->
	
	<form method="post" action="/qanda/update">

		 <input type="hidden" name="boardNo" value="${detail.boardNo}"> <!-- 외래키 참조조건때문에 안보이게함: 없으면 에러남 -->
		
		<label>제목</label> 
        <input type="text" name="title" value="${detail.title}" /><br />

        <label>작성자</label> 
        <input type="text" name="nickname" value="${detail.nickname}" /><br />

        <label>내용</label>
        <textarea cols="50" rows="5" name="content">${detail.content}</textarea>
        <br />
		
		
		

		<button type="submit">수정완료</button>

	</form>

	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

</body>
</html>
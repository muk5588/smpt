<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" type="text/css"
	href="/resources/css/common/paging.css">
<link rel="stylesheet" type="text/css"
	href="/resources/css/board/boardList.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>사진 갤러리</title>
    <link rel="icon" href="<%=request.getContextPath()%>/resources/img/20191208094528217881320965.png">
<style>
    .card img {
        width: 497.33px;
        height: 331.42px;
        object-fit: cover; /* This ensures the image covers the area without distorting */
    }
</style>
<script type="text/javascript">
	$(function() {

		var blank_pattern = /^\s+|\s+$/g;

		$("#searchForm").submit(function(e) {
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

		$("#deleteBtn")
				.click(
						function() {

							var datas = [];
							$("input[name=deleteNum]:checked").each(function() {
								var no = $(this).val();
								datas.push(no);
							})

							$.ajaxSettings, traditional = true
							$
									.ajax({
										type : "get",
										url : "./listDelete",
										data : {
											boardNo : datas
										},
										dataType : "json",
										success : function(res) {
											// 				console.log("AJAX 성공")
											// 				console.log(res)

											$(function() {
												$(location)
														.attr('href',
																'./list?categoryNo=${param.categoryNo}&curPage=${curPage}')
											})

										},
										error : function() {
											console.log("AJAX 실패")
										}
									})

						})

		$("#checkboxAllCheck").click(function() {
			//attr => 속성값, prop해서 변경해야함
			$(".delCheckBox").prop("checked", $(this).prop("checked"));

		})

	})
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/layout/header.jsp" />
	<jsp:include page="/WEB-INF/views/layout/boardmenu.jsp" />
	<!-- wrap 때문에 container가 반응형 X로 바뀜 -->
	<div class="wrap mx-auto">


		<div class="container">

			<h1>${name }게시판</h1>
			<div class="title">
				<div class="write">
					<a href="/">
						<button class="go_main">Home</button>
					</a>
					<c:if
						test="${(isLogin > 0)||(dto1.gradeno == 0 || dto1.gradeno == 5000)}">
						<form action="./write" method="get">
							<button id="btnWrite" me>글쓰기</button>
						</form>
					</c:if>
				</div>
				<div>
					<form action="" method="get" id="searchForm">
						<input hidden="hidden" name="categoryNo"
							value="${param.categoryNo}"> <select name="searchKind"
							id="searchKind">
							<option value="title"
								<c:if test="${paging.searchKind == 'title'}">selected</c:if>>제목</option>
							<option value="content"
								<c:if test="${paging.searchKind == 'content'}">selected</c:if>>내용
							</option>
						</select> <input type="text" name="search" id="search"
							value="${paging.search }"> <input hidden="hidden"
							name="curPage" value="${curPage}">
						<button id="searchBtn">검색</button>
					</form>
				</div>
			</div>


			<hr style="clear: both; margin-bottom: 10px">

			<!-- 게시글(카드형태) -->
			<div class="row">
				<c:choose>
					<c:when test="${not empty list }">
						<c:forEach var="photo" items="${list }">
							<div class="col-md-6 mb-3">
								<div class="card">
									<div class="card-body">
										<c:if test="${dto1.gradeno == 0 || dto1.gradeno == 5000}">
											<input type="checkbox" value="${photo.boardNo }"
												name="deleteNum" class="delCheckBox">
										</c:if>
										<!-- 이미지 출력 추가 -->
										<c:if test="${not empty photo.files}">
											<c:forEach var="file" items="${photo.files}"
												varStatus="status">
												<!-- 첫 번째 이미지 파일만 출력 -->
												<c:if test="${status.index == 0}">
												  <div class="image-wrapper">
													<img src="${pageContext.request.contextPath }/resources/boardUpload/${file.storedName}"
														alt="${file.originName}" class="img-fluid">
													</div>	
												</c:if>
											</c:forEach>
										</c:if>
										<h5 class="card-title">글 번호: ${photo.boardNo }</h5>
										<h6 class="card-subtitle mb-2 text-muted">
											제목:
											<c:if test="${not empty param.categoryNo }">
												<a
													href="./view?categoryNo=${param.categoryNo}&boardNo=${photo.boardNo}&curPage=${curPage}">${photo.title}</a>
											</c:if>
											<c:if test="${empty param.categoryNo }">
												<a href="./view?boardNo=${photo.boardNo}&curPage=${curPage}">${photo.title}</a>
											</c:if>
										</h6>
										<p class="card-text">작성자 닉네임: ${photo.nickName }</p>
										<p class="card-text">조회수: ${photo.boardView }</p>
										<p class="card-text">
											최초작성일:
											<fmt:formatDate value="${photo.createDate }"
												pattern="yyyy-MM-dd" />
										</p>
										<c:forEach items="${totalrecomm }" var="recommList">
											<c:if test="${recommList.BOARDNO eq photo.boardNo }">
												<p class="card-text">
													추천수: <a id="totalRecommend">${recommList.GOOD }</a>
												</p>
											</c:if>
										</c:forEach>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:when test="${empty list }">
						<div class="col-12">게시글이 존재하지 않습니다</div>
					</c:when>
				</c:choose>
			</div>



			<c:if test="${dto1.gradeno == 0 || dto1.gradeno == 5000}">
				<button id="deleteBtn">체크 삭제</button>
			</c:if>
		</div>
		<!-- .container End -->


		<c:import url="/WEB-INF/views/layout/boardPaging.jsp" />
	</div>

	<c:import url="/WEB-INF/views/layout/footer.jsp" />
	
	
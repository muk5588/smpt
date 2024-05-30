<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a95df8bc6dc3d5cc046900560b4e5d88&libraries=services"></script>
	
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/resources/css/common/paging.css">
<link rel="stylesheet" type="text/css" href="/resources/css/board/boardList.css">
<title>전체 게시판</title>

<script type="text/javascript">
    $(function () {

        var blank_pattern = /^\s+|\s+$/g;

        $("#searchForm").submit(function (e) {
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


        $("#deleteBtn").click(function () {

            var datas = [];
            $("input[name=deleteNum]:checked").each(function () {
                var no = $(this).val();
                datas.push(no);
            })

            $.ajaxSettings, traditional = true
            $.ajax({
                type: "get"
                , url: "./listDelete"
                , data: {
                    boardNo: datas
                }
                , dataType: "json"
                , success: function (res) {
// 				console.log("AJAX 성공")
// 				console.log(res)

                    $(function () {
                        $(location).attr('href', './list?categoryNo=${param.categoryNo}&curPage=${curPage}')
                    })

                }
                , error: function () {
                    console.log("AJAX 실패")
                }
            })

        })

        $("#checkboxAllCheck").click(function () {
            //attr => 속성값, prop해서 변경해야함
            $(".delCheckBox").prop("checked", $(this).prop("checked"));

        })

    })
    
    
</script>

<style>
.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 12px;
}

.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
	color: #000;
	text-decoration: none;
}

.map_wrap {
	position: relative;
	width: 100%;
	height: 500px;
}

#menu_wrap {
	position: absolute;
	top: 0;
	left: 0;
	bottom: 0;
	width: 250px;
	margin: 10px 0 30px 10px;
	padding: 5px;
	overflow-y: auto;
	background: rgba(255, 255, 255, 0.7);
	z-index: 1;
	font-size: 12px;
	border-radius: 10px;
}

.bg_white {
	background: #fff;
}

#menu_wrap hr {
	display: block;
	height: 1px;
	border: 0;
	border-top: 2px solid #5F5F5F;
	margin: 3px 0;
}

#menu_wrap .option {
	text-align: center;
}

#menu_wrap .option p {
	margin: 10px 0;
}

#menu_wrap .option button {
	margin-left: 5px;
}

#placesList {
  display: flex; /* 가로 정렬을 위해 flexbox 사용 */
  flex-wrap: wrap; /* 항목들이 여러 줄로 배치되도록 함 */
  list-style: none;
  padding: 0; /* 기본 패딩 제거 */
  margin: 0; /* 기본 마진 제거 */
}

/* 추가로 각 항목의 스타일을 조정할 수도 있습니다 */
#placesList .item {
  flex: 1 1 auto; /* 각 항목이 고르게 배치되도록 설정 */
  margin: 5px; /* 항목 간격 설정 */
}

/* 기존의 #placesList .item 스타일은 그대로 유지 */
#placesList .item {
  position: relative;
  border-bottom: 1px solid #888;
  overflow: hidden;
  cursor: pointer;
  min-height: 65px;
}

#placesList .item span {
  display: block;
  margin-top: 4px;
}

#placesList .item h5, #placesList .item .info {
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
}

#placesList .item .info {
  padding: 10px 0 10px 55px;
}

#placesList .info .gray {
  color: #8a8a8a;
}

#placesList .info .jibun {
  padding-left: 26px;
  background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;
}

#placesList .info .tel {
  color: #009900;
}

#placesList .item .markerbg {
  float: left;
  position: absolute;
  width: 36px;
  height: 37px;
  margin: 10px 0 0 10px;
  background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;
}

/* marker 클래스들도 그대로 유지 */
#placesList .item .marker_1 {
  background-position: 0 -10px;
}

#placesList .item .marker_2 {
  background-position: 0 -56px;
}

#placesList .item .marker_3 {
  background-position: 0 -102px
}

#placesList .item .marker_4 {
  background-position: 0 -148px;
}

#placesList .item .marker_5 {
  background-position: 0 -194px;
}

#placesList .item .marker_6 {
  background-position: 0 -240px;
}

#placesList .item .marker_7 {
  background-position: 0 -286px;
}

#placesList .item .marker_8 {
  background-position: 0 -332px;
}

#placesList .item .marker_9 {
  background-position: 0 -378px;
}

#placesList .item .marker_10 {
  background-position: 0 -423px;
}

#placesList .item .marker_11 {
  background-position: 0 -470px;
}

#placesList .item .marker_12 {
  background-position: 0 -516px;
}

#placesList .item .marker_13 {
  background-position: 0 -562px;
}

#placesList .item .marker_14 {
  background-position: 0 -608px;
}

#placesList .item .marker_15 {
  background-position: 0 -654px;
}

#pagination {
	margin: 10px auto;
	text-align: center;
}

#pagination a {
	display: inline-block;
	margin-right: 10px;
}

#pagination .on {
	font-weight: bold;
	cursor: default;
	color: #777;
}

@media (min-width: 768px) {
	.card-columns {
		column-count: 2;
	}
}
</style>


</head>
<body>
<c:import url="/WEB-INF/views/layout/header.jsp"/>
<jsp:include page="/WEB-INF/views/layout/boardmenu.jsp"/>
<!-- wrap 때문에 container가 반응형 X로 바뀜 -->
<div class="wrap mx-auto">


    <div class="container">

        <h1>${name } 게시판</h1>
        <div class="title">
            <div class="write">
                <a href="/">
                    <button class="go_main">Home</button>
                </a>
                <c:if test="${(isLogin > 0)||(dto1.gradeno == 0 || dto1.gradeno == 5000)}">
                    <form action="./write" method="get">
                        <button id="btnWrite" me>글쓰기</button>
                    </form>
                </c:if>
            </div>
            <div>
                <form action="" method="get" id="searchForm">
                    <input hidden="hidden" name="categoryNo" value="${param.categoryNo}">
                    <select name="searchKind" id="searchKind">
                        <option value="title" <c:if test="${paging.searchKind == 'title'}">selected</c:if>>제목</option>
                        <option value="content" <c:if test="${paging.searchKind == 'content'}">selected</c:if>>내용
                        </option>
                    </select>
                    <input type="text" name="search" id="search" value="${paging.search }">
                    <input hidden="hidden" name="curPage" value="${curPage}">
                    <button id="searchBtn">검색</button>
                </form>
            </div>
        </div>
        
        <!-- 지도 -->
        <div class="map_wrap">
				<div id="map"
					style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

				<div id="menu_wrap" class="bg_white">
					<div class="option">
						<div>
							<form onsubmit="searchPlaces(); return false;">
								여행지 : <input type="text" value="이태원 맛집" id="keyword" size="15">
								<button type="submit">검색하기</button>
							</form>
						</div>
					</div>
					<hr>
					<ul id="placesList"></ul>
					<div id="pagination"></div>
				</div>
		</div>
        
        
        <hr style="clear:both; margin-bottom: 10px">
		
		

        <!-- 게시글(카드형태) -->
        <div class="row">
            <c:choose>
                <c:when test="${not empty list }">
                    <c:forEach var="board" items="${list }">
                        <div class="col-md-6 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <c:if test="${dto1.gradeno == 0 || dto1.gradeno == 5000}">
                                        <input type="checkbox" value="${board.boardNo }" name="deleteNum" class="delCheckBox">
                                    </c:if>
                                    <h5 class="card-title">글 번호: ${board.boardNo }</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">제목: 
                                        <c:if test="${not empty param.categoryNo }">
                                            <a href="./view?categoryNo=${param.categoryNo}&boardNo=${board.boardNo}&curPage=${curPage}">${board.title}</a>
                                        </c:if>
                                        <c:if test="${empty param.categoryNo }">
                                            <a href="./view?boardNo=${board.boardNo}&curPage=${curPage}">${board.title}</a>
                                        </c:if>
                                    </h6>
                                    <p class="card-text">작성자 닉네임: ${board.nickName }</p>
                                    <p class="card-text">조회수: ${board.boardView }</p>
                                    <p class="card-text">최초작성일: <fmt:formatDate value="${board.createDate }" pattern="yyyy-MM-dd"/></p>
                                    <c:forEach items="${totalrecomm }" var="recommList">
                                        <c:if test="${recommList.BOARDNO eq board.boardNo }">
                                            <p class="card-text">추천수: <a id="totalRecommend">${recommList.GOOD }</a></p>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:when test="${empty list }">
                    <div class="col-12">
                        게시글이 존재하지 않습니다
                    </div>
                </c:when>
            </c:choose>
        </div>
        <c:if test="${dto1.gradeno == 0 || dto1.gradeno == 5000}">
            <button id="deleteBtn">체크 삭제</button>
        </c:if>
    </div>
    <!-- .container End -->



    <c:import url="/WEB-INF/views/layout/boardPaging.jsp"/>
</div>

<c:import url="/WEB-INF/views/layout/footer.jsp"/>

<script type="text/javascript"
		src="/resources/js/recomm/kakaorecomm.js"></script>

</body>
</html>
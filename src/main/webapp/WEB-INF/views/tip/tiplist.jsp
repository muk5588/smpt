<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript"
    src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" type="text/css"
    href="/resources/css/common/paging.css">
<link rel="stylesheet" type="text/css"
    href="/resources/css/story/storyList.css">
<link rel="stylesheet"
    href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<title>Travle Square</title>

<style>
    .wrap {
        margin-top: 20px;
    }
    .card {
        border: none;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        margin-bottom: 20px;
    }
    .card-title {
        font-weight: bold;
    }
    .card-text {
        color: #555;
    }
    #deleteBtn, #btnWrite, #searchBtn {
        margin-top: 10px;
    }
    #deleteBtn {
        background-color: #dc3545;
        color: white;
        border: none;
    }
    .go_main {
        background-color: #007bff;
        color: white;
        border: none;
    }
    .header-buttons {
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;
    }
    .search-form-wrapper {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    .search-form select,
    .search-form input,
    .search-form button {
        margin-right: 10px;
    }
</style>

<script type="text/javascript">
    $(function() {
        var blank_pattern = /^\s+|\s+$/g;

        $("#searchForm").submit(function(e) {
            console.log("#searchForm submit");
            var searchTerm = $("#search").val().trim();

            if (!searchTerm) {
                alert("검색어를 입력해주세요");
                return false;
            }

            if (searchTerm.length === 0) {
                alert(' 공백만 입력되었습니다 ');
                return false;
            }

            $("#search").val(searchTerm);
        });

        $("#deleteBtn").click(function() {
            var datas = [];
            $("input[name=deleteNum]:checked").each(function() {
                var no = $(this).val();
                datas.push(no);
            });

            $.ajax({
                type: "get",
                url: "./listDelete",
                data: { boardNo: datas },
                dataType: "json",
                success: function(res) {
                    $(function() {
                        $(location).attr('href', './list?categoryNo=${param.categoryNo}&curPage=${curPage}');
                    });
                },
                error: function() {
                    console.log("AJAX 실패");
                }
            });
        });

        $("#checkboxAllCheck").click(function() {
            $(".delCheckBox").prop("checked", $(this).prop("checked"));
        });
    });
</script>
</head>
<body>
    <c:import url="/WEB-INF/views/layout/header.jsp" />
    <jsp:include page="/WEB-INF/views/layout/boardmenu.jsp" />
    <div class="wrap mx-auto">
        <div class="container">
            <h1 class="text-center">${name }게시판</h1>
            <div class="header-buttons">
                <a href="/">
                    <button class="btn go_main">Home</button>
                </a>
                <c:if test="${isLogin == 1}">
                    <form action="./write" method="get">
                        <button id="btnWrite" class="btn btn-primary">글쓰기</button>
                    </form>
                </c:if>
            </div>
            <div class="search-form-wrapper">
                <button id="deleteBtn" class="btn">체크 삭제</button>
                <div class="search-form">
                    <form action="" method="get" id="searchForm" class="form-inline">
                        <input type="hidden" name="categoryNo" value="${param.categoryNo}">
                        <select name="searchKind" id="searchKind" class="form-control">
                            <option value="title" <c:if test="${paging.searchKind == 'title'}">selected</c:if>>제목</option>
                            <option value="content" <c:if test="${paging.searchKind == 'content'}">selected</c:if>>내용</option>
                        </select>
                        <input type="text" name="search" id="search" value="${paging.search }" class="form-control">
                        <input type="hidden" name="curPage" value="${curPage}">
                        <button id="searchBtn" class="btn btn-secondary">검색</button>
                    </form>
                </div>
            </div>

            <hr>

            <div class="row">
                <c:choose>
                    <c:when test="${not empty list}">
                        <c:forEach var="story" items="${list}">
                            <div class="col-12">
                                <div class="card">
                                    <!-- 이미지 출력 -->
                                    <c:if test="${not empty story.files}">    
                                        <c:forEach var="file" items="${story.files}">
                                            <img
                                                src="<c:url value='/resources/boardUpload/${file.storedName}'/>"
                                                alt="${file.originName}" class="card-img-top"
                                                style="max-width: 100%; height: auto; border-top-left-radius: 10px; border-top-right-radius: 10px;">
                                        </c:forEach>
                                    </c:if>
                                    <!-- 이미지 출력 끝-->
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <c:if test="${not empty param.categoryNo}">
                                                <a
                                                    href="./view?categoryNo=${param.categoryNo}&boardNo=${story.boardNo}&curPage=${curPage}">${story.title}</a>
                                            </c:if>
                                            <c:if test="${empty param.categoryNo}">
                                                <a href="./view?boardNo=${story.boardNo}&curPage=${curPage}">${story.title}</a>
                                            </c:if>
                                        </h5>
                                        <p class="card-text">글 번호: ${story.boardNo}</p>
                                        <p class="card-text">작성자 닉네임: ${story.nickName}</p>
                                        <p class="card-text">조회수: ${story.boardView}</p>
                                        <p class="card-text">
                                            최초작성일:
                                            <fmt:formatDate value="${story.createDate}"
                                                pattern="yyyy-MM-dd" />
                                        </p>
                                        <c:forEach items="${totalrecomm}" var="recommList">
                                            <c:if test="${recommList.BOARDNO eq story.boardNo}">
                                                <p class="card-text">추천수: ${recommList.GOOD}</p>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:when test="${empty list}">
                        <div class="col-12">
                            <p class="text-center">게시글이 존재하지 않습니다</p>
                        </div>
                    </c:when>
                </c:choose>
            </div>
        </div>
        <c:import url="/WEB-INF/views/layout/boardPaging.jsp" />
    </div>
    <c:import url="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>

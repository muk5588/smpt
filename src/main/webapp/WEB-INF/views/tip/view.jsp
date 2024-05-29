

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="/WEB-INF/views/layout/header.jsp" />
<link rel="stylesheet" type="text/css" href="/resources/css/story/storyView.css">
	
	

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<style type="text/css">

/* .wrap {
        width: 1100px;
    }

    table, th {
        text-align: center;
    } */

/* <!-- body { --> */
/* <!-- 	width: 1500px; --> */
/* <!-- 	margin: 0 auto; --> */
/* <!-- } --> */

/* <!-- h1 { --> */
/* <!-- 	text-align: center; --> */
/* <!-- } --> */

/* <!-- table { --> */
/* <!-- 	border: 1px solid black; --> */
/* <!-- 	margin: 0 auto; --> */
/* <!-- } --> */

/* <!-- tr, th, td { --> */
/* <!-- 	border: 1px solid black; --> */
/* <!-- } --> */

/* <!-- th { --> */
/* <!-- 	background-color: #ccc; --> */
/* <!-- } --> */

/* <!-- td.no, .title, .id, .nick, .hit, .date { --> */
/* <!-- 	text-align: center; --> */
/* <!-- } --> */

/* <!-- td.title { --> */
/* <!-- 	width: 200px; --> */
/* <!-- } --> */

/* <!-- td.content { --> */
/* <!-- 	width: 500px; --> */
/* <!-- } --> */

/* <!-- td.id, .nick { --> */
/* <!-- 	width: 150px; --> */
/* <!-- } --> */

/* <!-- td.hit { --> */
/* <!-- 	width: 50px; --> */
/* <!-- } --> */

/* <!-- td.date { --> */
/* <!-- 	width: 200px; --> */
/* <!-- } --> */
</style>
<script type="text/javascript">
    $(function () {

        $(document).ready(function () {
            //HTML전체 로딩이 끝나면 댓글을 비동기통신으로 가져오기 위해.
//             handleGetFile();
            handleFileChk();
            $("#commentRefresh").click()
            if (${empty isRecomm or isRecomm eq 0}) {
               $(".cancle").toggle()
            }
            if (${not empty isRecomm and isRecomm eq 1}) {
               $(".do").toggle()
            }

        })

        $(document).ready(function () {


            $("#commentInput").css("visibility", "visible")

        })


        $(".doRecomm").click(function () {
            console.log("#doRecomm   Click")

            $.ajax({
                type: "get"
                , url: "./recommend"
                , data: {
                    boardNo: ${story.boardNo}
                }
                , dataType: "json"
                , success: function (res) {
                    console.log("AJAX 성공")
                    console.log(res)


                    $(".do").toggle()
                    $(".cancle").toggle()

//                     if (res) {
//                         $(function () {
//                             $(location).attr('href', './view?boardNo=${board.boardNo }')
//                         })
//                     }
                }
                , error: function () {
                    console.log("AJAX 실패")
                }
            })

        })

        $("#insertBtn").click(function () {
            console.log("#insertBtn Click")

            var contentTerm = $("#commentContent").val().trim()
            if (!contentTerm) {
                alert("댓글 내용을 입력해주세요")
                $("#content").focus()
                return false;
            }

            if (contentTerm.length === 0) {
                alert('댓글내용이 공백만 입력되었습니다 ');
                $("#content").focus()
                return false;
            }

            $.ajax({
                type: "get"
                , url: "/comment/insert"
                , data: {
                    boardNo: ${story.boardNo}
                    , userNo: $("#userid").val()
                    , commContent: $("#commentContent").val()
                }
                , dataType: "json"
                , success: function (res) {
                    console.log("AJAX 성공")

                    if (res) {
                        $(function () {
                            $(location).attr('href', './view?categoryNo=${param.categoryNo}&boardNo=${board.boardNo }')
                        })
                    }

                }
                , error: function () {
                    console.log("AJAX 실패")
                }
            })

        })

        //댓글 삭제
        function handleCommentDelete() {
    	$(".commentDelete").click(function () {
        console.log(".commentDelete Click")
        var value = $(this).attr('value')
        console.log(".commentDelete Click", value)

        $.ajax({
            type: "get",
            url: "../comment/delete",
            data: {	//수정완료
                commNo: value,
                boardNo: ${story.boardNo}
            },
            dataType: "json",
            success: function (res) {
                console.log("AJAX 성공")

                if (res) {
                    $(function () {
                        $(location).attr('href', './view?categoryNo=${param.categoryNo}&boardNo=${story.boardNo}')
                    })
                }
            },
            error: function () {
                console.log("AJAX 실패")
            }
        })
    })
}

		$(document).ready(function () {
    	handleCommentDelete();
		})

        
        function handleFileChk() {
                console.log("handleFileChk")

                $.ajax({
                    type: "get"
                    , url: "./fileChk"
                    , data: {
                        boardno: ${story.boardNo}
                    }
                    , dataType: "json"
                    , success: function (res) {
                        console.log("AJAX 성공")
                        console.log(res)
                        console.log(res[0].fileNo)
                        if( res.length > 0 ){
                        var fileList = "";
                        fileList += '<p>첨부파일</p><br>'
	                        for(var i=0;  res.length >i ; i++){
								fileList += '<a href="./fileDown?fileNo=' + res[i].fileNo + '">' + res[i].originName + '<br>';
	                        }
	                        
	        			    $("#fileDown").html(fileList);
                        }

                    }
                    , error: function () {
                        console.log("AJAX 실패")
                    }
                })

        }


        function handleGetFile() {
            console.log("이미지 가져오기 실행.")

            $.ajax({
                type: "get"
                , url: "./boardFileChk"
                , data: {
                    boardno: ${story.boardNo}
                }
                , dataType: "json"
                , success: function (res) {
                    console.log("AJAX 성공")

                }
                , error: function () {
                    console.log("AJAX 실패")
                }
            })
        }


       	/* 게시글 삭제 */
        $(document).ready(function () {
            $("#btnDelete").click(function () {
                if (confirm("정말 삭제하시겠습니까?")) {
                    var boardNo = ${story.boardNo};
                    $.ajax({
                        type: "post",
                        url: "./delete",
                        data: {
                            boardNo: boardNo
                        },
                        success: function () {
                            alert("게시글이 삭제되었습니다.");
                            window.location.href = "./list";
                        },
                        error: function () {
                            alert("게시글 삭제에 실패하였습니다.");
                        }
                    });
                }
            });
        });
        
    })
</script>
</head>
<body>
	<!-- wrap 때문에 container가 반응형 X로 바뀜 -->
	<div class="wrap mx-auto">

		<header class="header text-center">
			<h1>Spring Board</h1>
		</header>

		<div class="container">

			<h1>상세보기</h1>



			<c:choose>
				<c:when test="${usrno != 0 }">
					<a href="./userbystorylist?userno=${dto1.userno}">
						<button>목록으로</button>
					</a>
				</c:when>
				<c:otherwise>
					<a href="./storylist?categoryNo=${param.categoryNo}&curPage=${curPage}">
						<button>목록으로</button>
					</a>
				</c:otherwise>
			</c:choose>
			<c:if test="${story.userNo == dto.userno }">
				<a href="./update?boardNo=${story.boardNo }">
					<button id="btnUpdate">수정</button>
				</a>
				<a href="./delete?boardNo=${story.boardNo }">
					<button id="btnDelete">삭제</button>
				</a>
			</c:if>

			<hr>

			<div id="file"></div>
			<table class="table table-striped table-hover table-sm">
				<tr>
					<th>글 번호</th>
					<th>제목</th>
					<th>본문</th>
					<th>작정자닉네임</th>
					<th>조회수</th>
					<th>최초작성일</th>
					<th>추천수</th>
				</tr>

				<tr>
					<td>
						<div id="fileDown"></div>
					</td>
				</tr>
				
				<tr>
					<td class="no">${story.boardNo }</td>
					<td class="title">${story.title }</td>
					<!-- HTML을 이스케이프하지 않고 그대로 렌더링하기 위해 c:out의 escapeXml 속성을 false로 설정 -->
					<%-- <td class="content">${fn:escapeXml(board.content)}</td> --%>
					<td class="content">${story.content }<!-- 첨부된 파일을 보여주는 부분 추가 -->
						<c:if test="${not empty files}">

							<ul>
								<c:forEach var="file" items="${files}">
									<li><img
										src="<c:url value='/resources/boardUpload/${file.storedName}'/>"
										alt="${file.originName}" style="max-width: 100%; height: 400;"></li>
								</c:forEach>
							</ul>
						</c:if>
					</td>
					<td class="nick">${story.nickName }</td>
					<td class="hit">${story.boardView }</td>
					<td class="date"><fmt:formatDate value="${story.createDate }"
							pattern="yyyy-MM-dd" /></td>
					<td><a id="totalRecommend">${recomm }</a></td>
				</tr>
			</table>


			<!-- 게시글 수정 기능 -->
			<c:if test="${isLogin > 0 and story.userNo == dto1.userno }">
				<a href="./update?boardNo=${story.boardNo }">
					<button id="btnUpdate">수정</button>
				</a>
			</c:if>

			<!-- 게시글 삭제 -->
			<c:if test="${isLogin > 0 and story.userNo == dto1.userno }">
				<a href="./delete?boardNo=${story.boardNo }">
					<button id="btnDelete">삭제</button>
				</a>
			</c:if>










			<c:if test="${isLogin > 0}">
				<div id="reBtn">
					<div class="recommendBtn doRedomm">
						<c:if test="${empty isRecomm or isRecomm eq 0 }">
							<a>
								<button class="doRecomm do">추천하기</button>
							</a>
						</c:if>
						<c:if test="${not empty isRecomm and isRecomm eq 1 }">
							<a>
								<button class="doRecomm cancel">추천취소하기</button>
							</a>
						</c:if>
					</div>
				</div>
				<button
					onclick="location.href='../report/boardReport?categoryNo=${param.categoryNo}&boardno=${story.boardNo}'">
					신고하기</button>
			</c:if>
			<hr>
			<div class="comment">
				<table border="1px" style="width: 80%; text-align: center;">
					<tr>
						<th>댓글 순번</th>
						<th>작성자</th>
						<th>댓글내용</th>
						<th>작성일</th>
						<c:if test="${isLogin > 0}">
							<th>신고하기</th>
						</c:if>
						<th>삭제</th>
					</tr>
					<c:forEach var="comment" items="${comment }">
						<tr>
							<td class="no">${comment.commNo}</td>
							<td>${comment.nickName }</td>
							<td>${comment.commContent }</td>
							<td><fmt:formatDate value="${comment.commDate }"
									pattern="yyyy-MM-dd" /></td>
							<c:if test="${isLogin > 0}">
								<td><a
									href='../report/commentReport?commno=${comment.commNo}'><button>
											댓글신고하기</button></a></td>
							</c:if>
							<c:if test="${isLogin > 0 and story.userNo == comment.userNo }">
								<td>
									<button class="commentDelete" value="${comment.commNo}">삭제</button>
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</table>




			</div>
			<c:if test="${isLogin > 0}">
				<div id="commentInput">
					<hr>
					<br>
					<table>
						<tr>
							<th></th>
							<th>닉네임</th>
							<th>댓글내용</th>
						</tr>
						<tr>
							<td><input type="hidden" value="${dto1.userno }" id="userid"
								name="userid"></td>
							<td><input class="form-control" type="text"
								value="${dto1.nickname }" id="commentWriter"
								aria-label="Disabled input example" disabled
								style="text-align: center;"></td>
							<td><input name="commentContent" id="commentContent">
							</td>
							<td>
								<button id="insertBtn">댓글 작성</button>
							</td>
						</tr>
					</table>
				</div>
			</c:if>
			<!-- 	  - 로그인아이디, 댓글 입력 창, 입력 버튼 생성 -->
			<!--   - 댓글 리스트(댓글순번, 작성자, 댓글내용, 작성일, 삭제) -->

		</div>
		<!-- .container End -->


	</div>


	<c:import url="/WEB-INF/views/layout/footer.jsp" />

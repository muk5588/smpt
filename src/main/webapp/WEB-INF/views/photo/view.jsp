<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<title>${photo.title }</title>
    <link rel="icon" href="<%=request.getContextPath()%>/resources/img/20191208094528217881320965.png">
<link href="/resources/css/board/boardView.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style type="text/css">


  .content img {
        max-width: 300px;
        height: auto;
    }


</style>
<script type="text/javascript">

    $(function () {

        $(document).ready(function () {
            //HTML전체 로딩이 끝나면 댓글을 비동기통신으로 가져오기 위해.
//             handleGetFile();
            handleFileChk();
            handleCommentDelete();
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
                    boardNo: ${photo.boardNo}
                }
                , dataType: "json"
                , success: function (res) {
                    console.log("AJAX 성공")
                    console.log(res)


                    $(".do").toggle()
                    $(".cancle").toggle()

                    if (res) {
                        $(function () {
                            $(location).attr('href', './view?categoryNo=${photo.categoryNo}&boardNo=${photo.boardNo }')
                        })
                    }
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
                    boardNo: ${photo.boardNo}
                    , userNo: $("#userid").val()
                    , commContent: $("#commentContent").val()
                }
                , dataType: "json"
                , success: function (res) {
                    console.log("AJAX 성공")

                    if (res) {
                        $(function () {
                            $(location).attr('href', './view?categoryNo=${photo.categoryNo}&boardNo=${photo.boardNo }')
                        })
                    }

                }
                , error: function () {
                    console.log("AJAX 실패")
                }
            })

        })

        function handleCommentDelete() {
            $(".commentDelete").click(function () {
                console.log(".commentDelete Click")
                var value = $(this).attr('value')
                console.log(".commentDelete Click", value)

                $.ajax({
                    type: "get"
                    , url: "/comment/delete"
                    , data: {
                        boardNo: ${photo.boardNo}
                        , commNo: value
                    }
                    , dataType: "json"
                    , success: function (res) {
                        console.log("AJAX 성공")

                        if (res) {
                            $(function () {
                                $(location).attr('href', './view?categoryNo=${param.categoryNo}&boardNo=${photo.boardNo }')
                            })
                        }
                    }
                    , error: function () {
                        console.log("AJAX 실패")
                    }
                })

            })
        }

        function handleFileChk() {
            console.log("handleFileChk")

            $.ajax({
                type: "get"
                , url: "./fileChk"
                , data: {
                    boardno: ${photo.boardNo}
                }
                , dataType: "json"
                , success: function (res) {
                    console.log("AJAX 성공")
                    console.log(res)
//                     console.log(res[0].fileNo)
                    if (res.length > 0) {
                        var fileList = "";
                        fileList += '<p>첨부파일: '
                        for (var i = 0; res.length > i; i++) {
                            fileList += '<a href="./fileDown?fileNo=' + res[i].fileNo + '">' + res[i].originName + '<br>';
                        }
                        fileList += '</p>'
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
                    boardno: ${photo.boardNo}
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

        $("#btnDelete").click(function (e) {
            e.preventDefault();
            if (confirm("정말 삭제하시겠습니까?")) {
                $.ajax({
                    type: "get",
                    url: "./delete",
                    data: {
                        boardNo: ${photo.boardNo}
                    },
                    success: function () {
                        $(location).attr('href', './list?categoryNo=${param.categoryNo}&curPage=${curPage}');
                    },
                    error: function () {
                        alert("삭제 실패");
                    }
                });
            }
        });

    })
</script>

<script type="text/javascript">
$(function () {
    // 게시물 공유 함수
    function sharePost() {
    	  var postUrl = ""; // 게시물 URL을 여기에 할당
          var postTitle = ""; // 게시물 제목을 여기에 할당
        if (navigator.share) {
            navigator.share({
                title: postTitle,
                text: '게시물을 공유합니다.',
                url: postUrl
            })
            .then(() => console.log('게시물 공유됨'))
            .catch((error) => console.error('게시물 공유 실패', error));
        } else {
            console.error('Web Share API를 지원하지 않습니다.');
        }
    }

    // 게시물 공유 버튼 클릭 시 sharePost() 함수 호출
    $("#sharePostButton").click(function () {
        sharePost();
    });
});
</script>

</head>
<body>
<c:import url="/WEB-INF/views/layout/header.jsp"/>
<jsp:include page="/WEB-INF/views/layout/boardmenu.jsp"/>

<!-- wrap 때문에 container가 반응형 X로 바뀜 -->
<div class="wrap mx-auto">

    <header class="header text-center">
        <h1>${photo.title  }</h1>
    </header>

    <div class="container">

        <h1>상세보기</h1>
        <div class="tit">
            <div>
                <c:choose>
                    <c:when test="${userno != 0 }">
                        <a href="./userbyboardlist?userno=${dto1.userno}">
                            <button>목록으로</button>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="./list?categoryNo=${param.categoryNo}&curPage=${curPage}">
                            <button>목록으로</button>
                        </a>
                    </c:otherwise>
                </c:choose>
                <c:if test="${photo.userNo == dto1.userno }">
                    <a href="./update?boardNo=${photo.boardNo }">
                        <button id="btnUpdate">수정</button>
                    </a>
                    <a href="./delete?boardNo=${photo.boardNo }">
                        <button id="btnDelete">삭제</button>
                    </a>
                </c:if>
            </div>
            <div>
                <c:if test="${isLogin > 0}">
                    <div id="reBtn">
                        <div class="recommendBtn doRedomm">
                            <c:if test="${empty isRecomm or isRecomm eq 0 }">
                                    <a class="doRecomm do"><img src="/resources/img/board/개추.png" height="13" width="15">${recomm }</a>
                            </c:if>
                            <c:if test="${not empty isRecomm and isRecomm eq 1 }">
                                    <a class="doRecomm cancel" style="background: #1e73be; color: white; border: none; padding: 0.5em 1em; text-align: center"><img src="/resources/img/board/개추.png" height="15" width="15">${recomm }</a>
                            </c:if>
                            <button onclick="location.href='../report/boardReport?categoryNo=${param.categoryNo}&boardno=${photo.boardNo}'">
                                신고하기
                            </button>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
        <hr>
        
         
      <div class="share-button">
    	<button id="sharePostButton">게시물 공유하기</button>
		</div>

        <div id="file"></div>
        <table class="table">
            <tr>
                <td colspan="6">
                    <div id="fileDown"></div>
                </td>
            </tr>
            <tr>
                <th>글 번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>작성일</th>
                <th>추천수</th>
            </tr>
            <tr class="con">
                <td class="no">${photo.boardNo }</td>
                <td class="title">${photo.title }</td>
                <td class="nick">${photo.nickName }</td>
                <td class="hit">${photo.boardView }</td>
                <td class="date">
                    <fmt:formatDate value="${photo.createDate }" pattern="yyyy-MM-dd"/>
                </td>
                <td><a id="totalRecommend">${recomm }</a></td>
            </tr>
            <tr>
                <th colspan="6">본문</th>
            </tr>
            <tr class="con">
                <td class="content" colspan="6"><div id="contentBox">${photo.content }</div></td>
            </tr>
        </table>

        <hr>
        <div class="comment">
            <table>
                <tr>
                    <th>댓글 순번</th>
                    <th>작성자</th>
                    <th>댓글내용</th>
                    <th>작성일</th>
                    <c:if test="${isLogin > 0}">
                        <th>신고하기</th>
                    </c:if>
                    <c:if test="${photo.userNo == dto1.userno }">
                        <th>삭제</th>
                    </c:if>
                </tr>
                <c:choose>
                    <c:when test="${not empty comment }">
                        <c:forEach var="comment" items="${comment }">
                            <tr>
                                <td class="no">${comment.commNo}</td>
                                <td>${comment.nickName }</td>
                                <td>${comment.commContent }</td>
                                <td>
                                    <fmt:formatDate value="${comment.commDate }" pattern="yyyy-MM-dd"/>
                                </td>
                                <c:if test="${isLogin > 0}">
                                    <td class="rpt">
                                        <a href='../report/commentReport?commno=${comment.commNo}&categoryNo=${param.categoryNo}&boardNo=${photo.boardNo}'>
                                            <img src="/resources/img/board/신고.jpg" height="30" width="30">
                                        </a>
                                    </td>
                                </c:if>
                                <c:if test="${dto1.userno == comment.userNo }">
                                    <td>
                                        <button class="commentDelete" value="${comment.commNo}">삭제</button>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>

                    </c:when>
                    <c:when test="${empty comment }">
                        <td colspan="7">
                            댓글이 존재하지 않습니다
                        </td>
                    </c:when>
                </c:choose>
            </table>
        </div>
        <hr>
        <br>
        <c:if test="${isLogin > 0}">
            <div id="commentInput">
                <table>
                    <tr hidden="hidden">
                        <td><input type="text" value="${dto1.userno }" id="userid" name="userid"></td>
                    </tr>
                    <tr>
                        <th>닉네임</th>
                        <th>댓글내용</th>
                    </tr>
                    <tr>
                        <td><input class="form-control" type="text" value="${dto1.nickname }" id="commentWriter"
                                   aria-label="Disabled input example" disabled style="text-align: center;"></td>
                        <td>
                            <input name="commentContent" id="commentContent">
                        </td>
                    </tr>
                </table>
                <button id="insertBtn"> 댓글 작성</button>
            </div>
        </c:if>
        <!-- 	  - 로그인아이디, 댓글 입력 창, 입력 버튼 생성 -->
        <!--   - 댓글 리스트(댓글순번, 작성자, 댓글내용, 작성일, 삭제) -->

    </div> <!-- .container End -->


</div>


<c:import url="/WEB-INF/views/layout/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<script type="text/javascript" src="/resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
 oAppRef: oEditors,
 elPlaceHolder: "txtContent",
 sSkinURI: "/resources/editor/SmartEditor2Skin.html",
 fCreator: "createSEditor2"
});
//‘저장’ 버튼을 누르는 등 저장을 위한 액션을 했을 때 submitContents가 호출된다고 가정한다.
function submitContents(elClickedObj) {
	// 에디터의 내용이 textarea에 적용된다.
	oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);
	
	 // 에디터의 내용에 대한 값 검증은 이곳에서
	 // document.getElementById("txtContent").value를 이용해서 처리한다.
	
	 try {
	     elClickedObj.form.submit();
	 } catch(e) {} }
	 
function save(){
	oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);  
    		//스마트 에디터 값을 텍스트컨텐츠로 전달
	var content = document.getElementById("smartEditor").value;
    		//확인용. alert로 띄우기
// 	alert(document.getElementById("txtContent").value); 
	document.getElementById("content").value = document.getElementById("txtContent").value;
    		// 값을 불러올 땐 document.get으로 받아오기
    document.getElementById('btnWrite').click();
	return; 
}
// 스마트 에디터 (사진파일 업로드 URL)
var sUploadURL = '/board/fileupload';
</script>
<script type="text/javascript">
    $(function () {

        $("#writeFrom").submit(function (e) {
            console.log("#writeFrom submit")

            var titleTerm = $("#title").val().trim()
            var contentTerm = $("#content").val().trim()
            console.log("#writeFrom submit contentTerm", contentTerm)
	
            if (!titleTerm) {
                alert("제목을 입력해주세요")
                $("#title").focus()
                return false;
            }

            if (titleTerm.length === 0) {
                alert('제목이 공백만 입력되었습니다 ');
                $("#title").focus()
                return false;
            }


            if (!contentTerm) {
                alert("내용을 입력해주세요")
                $("#content").focus()
                return false;
            }

            if (contentTerm.length === 0) {
                alert('내용이 공백만 입력되었습니다 ');
                $("#content").focus()
                return false;
            }

            $("#title").val(searchTerm)

        })


    })
</script>
<style type="text/css">
</style>
</head>

<body>

<div class="wrap mx-auto">

<header class="header text-center">
	<h1>Spring Board</h1>
</header>

	<div class="container">
	
	<h1>수정하기</h1>
	
	
	<form action="./update" method="post" enctype="multipart/form-data">
	
	<hr>
	
	<table class="table table-striped table-hover table-sm">
		<tr>
			<th>글 번호</th>
			<th>제목</th>
			<th>본문</th>
			<th>닉네임</th>
			<th>조회수</th>
			<th>최초작성일</th>
		</tr>
		
		<tr>
				<td class="no"> ${board.boardNo } <input type="text" hidden="hidden" value="${board.boardNo }" name="boardNo"> </td>
				<td class="title"><input type="text" value="${board.title }" name="title"></td>
				<td class="content"><textarea id="txtContent" name="content" style="display:none;">${board.content }</textarea></td>
				<td class="nick">${board.nickName }</td>
				<td class="hit">${board.boardView }</td>
				<td class="date">
					<fmt:formatDate value="${board.createDate }" pattern="yyyy-MM-dd"/>
				</td>
		</tr>
	</table>
	 <div class="mb-3">
        <label for="file" class="form-label">첨부파일 추가</label>
        <input type="file" id="file" name="file">
    </div>
	
	<div id="button">
	<button id="btnUpdate" type="button" onclick="submitContents(this);">수정 적용</button>
	<a href="./list?curPage=${curPage }"><button type="button">목록으로</button></a>
	</div>
	
	</form>
	
	<script id="smartEditor" type="text/javascript"> 
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "txtContent",  //textarea ID 입력
	    sSkinURI: "/resources/editor/SmartEditor2Skin.html",  //SmartEditor2Skin.html 경로 입력
	    fCreator: "createSEditor2",
	    htParams : { 
	    	// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
	        bUseToolbar : true, 
		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
		bUseVerticalResizer : false, 
		// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
		bUseModeChanger : false 
	    }
	});
</script>
	</div> <!-- .container End -->
	
<c:import url="/WEB-INF/views/layout/footer.jsp"/>
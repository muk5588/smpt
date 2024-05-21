<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Q&A 작성</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/editor/css/smart_editor2.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
<div class="container form-container">
    <h2 class="form-title">Q&A 작성</h2>
    <hr>
    <c:if test="${not empty sessionScope.dto and sessionScope.dto.userno != 0}">
        <c:if test="${not empty message}">
            <div class="alert alert-danger" role="alert">${message}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/qanda/create" method="post" enctype="multipart/form-data" onsubmit="return submitEditorContent();">
            <div class="mb-3">
                <label for="title" class="form-label">제목:</label>
                <input type="text" id="title" name="title" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="content" class="form-label">내용:</label>
                <textarea id="content" name="content" style="display:none;"></textarea>
                <textarea id="editor" style="width:100%; height:300px;"></textarea>
            </div>
            <div class="mb-3">
                <label for="imageFile" class="form-label">이미지 파일:</label>
                <input type="file" id="imageFile" name="imageFile" class="form-control">
                <small class="form-text text-muted">PNG, JPG, GIF 형식의 파일만 첨부할 수 있습니다.</small>
            </div>
            <div class="mb-3">
                <label for="attachmentFile" class="form-label">첨부 파일:</label>
                <input type="file" id="attachmentFile" name="attachmentFile" class="form-control">
            </div>
            <button type="submit" class="btn btn-primary">글쓰기</button>
        </form>
        <a href="${pageContext.request.contextPath}/qanda/qandalist" class="btn btn-primary">Q&A 목록으로 돌아가기</a>
    </c:if>
    <c:if test="${empty sessionScope.dto or sessionScope.dto.userno == 0}">
        <p>로그인이 필요합니다. <a href="${pageContext.request.contextPath}/login">로그인 페이지로 이동</a></p>
    </c:if>
</div>
<script type="text/javascript">
    var oEditors = [];

    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "editor",
        sSkinURI: "${pageContext.request.contextPath}/resources/editor/SmartEditor2Skin.html",
        fCreator: "createSEditor2",
        htParams: {
            fOnBeforeUnload: function() {},
            SE2M_AttachQuickPhoto: {
                sUploadURL: "${pageContext.request.contextPath}/qanda/uploadImage", // 이미지 업로드 URL
                sFileName: "file",
                nMaxFileSize: 10 * 1024 * 1024, // 10MB
                sMode: "html5",
                fOnUploadResponse: function(sReturnValue) {
                    var oResponse = JSON.parse(sReturnValue);
                    if (oResponse.uploaded) {
                        var sHTML = '<img src="' + oResponse.url + '" style="max-width:100%;" />';
                        oEditors.getById["editor"].exec("PASTE_HTML", [sHTML]);
                    } else {
                        alert("Image upload failed: " + oResponse.error.message);
                    }
                }
            }
        },
        fOnAppLoad: function() {
            // 에디터 초기화 시 호출
        }
    });

    function submitEditorContent() {
        oEditors.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);
        document.getElementById("content").value = document.getElementById("editor").value;
        return true;
    }

    document.getElementById('imageFile').addEventListener('change', function(event) {
        var fileInput = event.target;
        var file = fileInput.files[0];
        var allowedTypes = ['image/png', 'image/jpeg', 'image/gif'];
        
        if (file && !allowedTypes.includes(file.type)) {
            alert('지원되지 않는 형식입니다');
            fileInput.value = '';
        }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
</body>
</html>

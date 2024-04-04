<%--
  Created by IntelliJ IDEA.
  User: c
  Date: 2024-04-04
  Time: 오후 12:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
<h3>[ ${dto.name } ]고객 정보</h3>
<div class="warpper">
    <div class="warp">
        <table class='w-pct60'>
            <tr>
                <th>회원번호</th>
                <td>${dto.no }</td>
            </tr>
            <tr>
                <th>이름</th>
                <td>${dto.name }</td>
            </tr>
            <tr>
                <th>아이디</th>
                <td>${dto.userid }</td>
            </tr>
            <tr>
                <th>성별</th>
                <td>${dto.gender }</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>${dto.email }</td>
            </tr>
            <tr>
                <th>우편번호</th>
                <td>${dto.postcode }</td>
            </tr>
            <tr>
                <th>주소</th>
                <td>${dto.address }</td>
            </tr>
            <tr>
                <th>상세주소</th>
                <td>${dto.detailAddress }</td>
            </tr>
            <tr>
                <th>참고항목</th>
                <td>${dto.extraAddress }</td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td>${dto.phone }</td>
        </table>
        <div class='btnSet'>
            <a class='btn-fill' href="userList">고객 목록</a>
            <a class='btn-fill' href="userUpdate">수정</a>
            <a class='btn-fill' onclick="fn_delete()">삭제</a>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</body>
</html>
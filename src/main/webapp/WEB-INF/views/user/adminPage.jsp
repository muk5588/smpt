<%--
  Created by IntelliJ IDEA.
  User: c
  Date: 2024-04-09
  Time: 오후 2:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>관리자 페이지</h3>
<hr>
<button><a href="/user/insertUser">회원추가</a></button>
<button><a href="/grade/gradeInsert">권한추가</a></button>
<button onclick="location.href = '/grade/gradeList'">권한조회</button>
<button onclick="location.href = '/menu/menuList'">권한부여상황</button>
<button onclick="location.href = '/user/userList'">유저조회</button>
<div class="warpper">
    <div class="warp">
        <div id="content">
            <h3>전체 회원 목록</h3>
            <table class='w-pct60'>
                <tr>
                    <th class='w-px60'>회원번호</th>
                    <th>아이디</th>
                    <th class='w-px200'>이름</th>
                    <th>닉네임</th>
                    <th>성별</th>
                </tr>
                <!-- for(꺼낸 배열 변수를 담을 새로운 변수 (String x) : 배열 변수(list)) -->
                <!-- items : 배열 변수 -->
                <!-- var : 꺼낸 배열 변수를 담을 새로운 변수 -->
                <c:forEach var="UserDTO" items="${list}">
                    <tr>
                        <td>${UserDTO.userno }</td>
                        <td>${UserDTO.userid }</td>
                        <td><a href='detailUser?userno=${UserDTO.userno}'>${UserDTO.name }</a></td>
                        <td>${UserDTO.nickname}</td>
                        <td>${UserDTO.gender }</td>
                        </a>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
</body>
</html>
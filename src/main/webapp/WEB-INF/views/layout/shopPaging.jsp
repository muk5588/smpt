<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<div>

<ul>
   <c:choose>

   <c:when test="${empty paging.search and (empty paging.minPrice and empty paging.maxPrice) and empty param.userno}">
      <%-- 첫 페이지로 이동 --%>
      <c:if test="${paging.curPage ne 1}">
         <li class="page-item">
            <a class="page-link" href="${URL}?curPage=1">← 처음</a>
         </li>
      </c:if>

      <%-- 이전 페이징 리스트 이동 --%>
      <c:choose>
         <c:when test="${paging.startPage ne 1}">
            <li class="page-item">
               <a class="page-link" href="${URL}?curPage=${paging.startPage - paging.pageCount}">«</a>
            </li>
         </c:when>
         <c:when test="${paging.startPage eq 1}">
            <li class="page-item">
               <a class="page-link disabled" >«</a>
            </li>
         </c:when>
      </c:choose>

      <%-- 이전 페이지로 이동 --%>
      <c:if test="${paging.curPage > 1}">
         <li class="page-item">
            <a class="page-link" href="${URL}?curPage=${paging.curPage - 1}"><</a>
         </li>
      </c:if>

      <%-- 페이징 번호 목록 --%>
      <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
         <c:if test="${paging.curPage eq i}">
            <li class="page-item">
               <a class="page-link active" href="${URL}?curPage=${i}">${i}</a>
            </li>
         </c:if>
         <c:if test="${paging.curPage ne i}">
            <li class="page-item">
               <a class="page-link" href="${URL}?curPage=${i}">${i}</a>
            </li>
         </c:if>
      </c:forEach>

      <%-- 다음 페이지로 이동 --%>
      <c:if test="${paging.curPage < paging.totalPage}">
         <li class="page-item">
            <a class="page-link" href="${URL}?curPage=${paging.curPage + 1}">></a>
         </li>
      </c:if>

      <%-- 다음 페이징 리스트 이동 --%>
      <c:choose>
         <c:when test="${paging.startPage ne paging.totalPage}">
            <li class="page-item">
               <a class="page-link" href="${URL}?curPage=${paging.startPage + paging.pageCount}">»</a>
            </li>
         </c:when>
         <c:when test="${paging.startPage eq paging.totalPage}">
            <li class="page-item">
               <a class="page-link disabled" >»</a>
            </li>
         </c:when>
      </c:choose>

      <%-- 마지막 페이지로 이동 --%>
      <c:if test="${paging.curPage ne paging.totalPage}">
         <li class="page-item">
            <a class="page-link" href="${URL}?curPage=${paging.totalPage}">끝 →</a>
         </li>
      </c:if>
   </c:when>
    <%-- 검색어가 존재하는 경우 --%>
    <c:when test="${not empty paging.search or not empty paging.minPrice or not empty paging.maxPrice and empty param.userno}">

        <%-- 첫 페이지로 이동 --%>
        <c:if test="${paging.curPage ne 1 }">
            <li class="page-item">
                <a class="page-link" href="${URL}?curPage=1&?search=${paging.search }&minPrice=${paging.minPrice}&maxPrice=${paging.maxPrice}">← 처음</a>
            </li>
        </c:if>


        <%-- 이전 페이징 리스트 이동 --%>
        <c:choose>
            <c:when test="${paging.startPage ne 1 }">
                <li class="page-item">
                    <a class="page-link" href="${URL}?curPage=${paging.startPage - paging.pageCount }&search=${paging.search }&minPrice=${paging.minPrice}&maxPrice=${paging.maxPrice}">«</a>
                </li>
            </c:when>
            <c:when test="${paging.startPage eq 1 }">
                <li class="page-item">
                    <a class="page-link disabled" >«</a>
                </li>
            </c:when>
        </c:choose>

        <%-- 이전 페이지로 이동 --%>
        <c:if test="${paging.curPage > 1 }">
            <li class="page-item">
                <a class="page-link" href="${URL}?curPage=${paging.curPage - 1 }&search=${paging.search }&minPrice=${paging.minPrice}&maxPrice=${paging.maxPrice}"><</a>
            </li>
        </c:if>

        <%-- 페이징 번호 목록 --%>
        <c:forEach var="i" begin="${paging.startPage }" end="${paging.endPage }">
            <c:if test="${paging.curPage eq i }">
                <li class="page-item">
                    <a class="page-link active" href="${URL}?curPage=${i }&search=${paging.search }&minPrice=${paging.minPrice}&maxPrice=${paging.maxPrice}">${i }</a>
                </li>
            </c:if>
            <c:if test="${paging.curPage ne i }">
                <li class="page-item">
                    <a class="page-link" href="${URL}?curPage=${i }&search=${paging.search }&minPrice=${paging.minPrice}&maxPrice=${paging.maxPrice}">${i }</a>
                </li>
            </c:if>
        </c:forEach>

        <%-- 다음 페이지로 이동 --%>
        <c:if test="${paging.curPage < paging.totalPage }">
            <li class="page-item">
                <a class="page-link" href="${URL}?curPage=${paging.curPage + 1 }&search=${paging.search }&minPrice=${paging.minPrice}&maxPrice=${paging.maxPrice}">></a>
            </li>
        </c:if>

        <%-- 다음 페이징 리스트 이동 --%>
        <c:choose>
            <c:when test="${paging.startPage ne paging.totalPage }">
                <li class="page-item">
                    <a class="page-link" href="${URL}?curPage=${paging.startPage + paging.pageCount }&search=${paging.search }&minPrice=${paging.minPrice}&maxPrice=${paging.maxPrice}">»</a>
                </li>
            </c:when>
            <c:when test="${paging.startPage eq paging.totalPage }">
                <li class="page-item">
                    <a class="page-link disabled" >»</a>
                </li>
            </c:when>
        </c:choose>

        <%-- 마지막 페이지로 이동 --%>
        <c:if test="${paging.curPage ne paging.totalPage }">
            <li class="page-item">
                <a class="page-link" href="${URL}?curPage=${paging.totalPage }&search=${paging.search }&minPrice=${paging.minPrice}&maxPrice=${paging.maxPrice}">끝 →</a>
            </li>
        </c:if>
    </c:when>
</c:choose>
</ul>

   </div>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
    <ul class="pagination pagination-sm justify-content-center">
        <c:choose>
            <c:when test="${empty paging.search and empty param.userno}">
                <%-- 첫 페이지로 이동 --%>
                <c:if test="${paging.curPage != 1}">
                    <li class="page-item">
                        <a class="page-link" href="/shop/?curPage=1">&larr; 처음</a>
                    </li>
                </c:if>

                <%-- 이전 페이징 리스트 이동 --%>
                <c:if test="${paging.startPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="/shop/?curPage=${paging.startPage - paging.pageCount}">&laquo;</a>
                    </li>
                </c:if>

                <%-- 이전 페이지로 이동 --%>
                <c:if test="${paging.curPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="/shop/?curPage=${paging.curPage - 1}">&lt;</a>
                    </li>
                </c:if>

                <%-- 페이징 번호 목록 --%>
                <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
                    <c:if test="${paging.curPage == i}">
                        <li class="page-item active">
                            <a class="page-link" href="/shop/?curPage=${i}">${i}</a>
                        </li>
                    </c:if>
                    <c:if test="${paging.curPage != i}">
                        <li class="page-item">
                            <a class="page-link" href="/shop/?curPage=${i}">${i}</a>
                        </li>
                    </c:if>
                </c:forEach>

                <%-- 다음 페이지로 이동 --%>
                <c:if test="${paging.curPage < paging.totalPage}">
                    <li class="page-item">
                        <a class="page-link" href="/shop/?curPage=${paging.curPage + 1}">&gt;</a>
                    </li>
                </c:if>

                <%-- 다음 페이징 리스트 이동 --%>
                <c:if test="${paging.endPage < paging.totalPage}">
                    <li class="page-item">
                        <a class="page-link" href="/shop/?curPage=${paging.startPage + paging.pageCount}">&raquo;</a>
                    </li>
                </c:if>

                <%-- 마지막 페이지로 이동 --%>
                <c:if test="${paging.curPage != paging.totalPage}">
                    <li class="page-item">
                        <a class="page-link" href="/shop/?curPage=${paging.totalPage}">끝 &rarr;</a>
                    </li>
                </c:if>
            </c:when>

            <%-- 검색어가 존재하는 경우 --%>
            <c:when test="${not empty paging.search and empty param.userno}">
                <%-- 첫 페이지로 이동 --%>
                <c:if test="${paging.curPage != 1}">
                    <li class="page-item">
                        <a class="page-link" href="/shop/?curPage=1&search=${paging.search}&searchKind=${paging.searchKind}">&larr; 처음</a>
                    </li>
                </c:if>

                <%-- 이전 페이징 리스트 이동 --%>
                <c:if test="${paging.startPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="/shop/?curPage=${paging.startPage - paging.pageCount}&search=${paging.search}&searchKind=${paging.searchKind}">&laquo;</a>
                    </li>
                </c:if>

                <%-- 이전 페이지로 이동 --%>
                <c:if test="${paging.curPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="/shop/?curPage=${paging.curPage - 1}&search=${paging.search}&searchKind=${paging.searchKind}">&lt;</a>
                    </li>
                </c:if>

                <%-- 페이징 번호 목록 --%>
                <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
                    <c:if test="${paging.curPage == i}">
                        <li class="page-item active">
                            <a class="page-link" href="/shop/?curPage=${i}&search=${paging.search}&searchKind=${paging.searchKind}">${i}</a>
                        </li>
                    </c:if>
                    <c:if test="${paging.curPage != i}">
                        <li class="page-item">
                            <a class="page-link" href="/shop/?curPage=${i}&search=${paging.search}&searchKind=${paging.searchKind}">${i}</a>
                        </li>
                    </c:if>
                </c:forEach>

                <%-- 다음 페이지로 이동 --%>
                <c:if test="${paging.curPage < paging.totalPage}">
                    <li class="page-item">
                        <a class="page-link" href="/shop/?curPage=${paging.curPage + 1}&search=${paging.search}&searchKind=${paging.searchKind}">&gt;</a>
                    </li>
                </c:if>

                <%-- 다음 페이징 리스트 이동 --%>
                <c:if test="${paging.endPage < paging.totalPage}">
                    <li class="page-item">
                        <a class="page-link" href="/shop/?curPage=${paging.startPage + paging.pageCount}&search=${paging.search}&searchKind=${paging.searchKind}">&raquo;</a>
                    </li>
                </c:if>

                <%-- 마지막 페이지로 이동 --%>
                <c:if test="${paging.curPage != paging.totalPage}">
                    <li class="page-item">
                        <a class="page-link" href="/shop/?curPage=${paging.totalPage}&search=${paging.search}&searchKind=${paging.searchKind}">끝 &rarr;</a>
                    </li>
                </c:if>
            </c:when>
        </c:choose>
    </ul>
</div>

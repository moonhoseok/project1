<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>회원목록보기</title>
</head>
<body>
   <div class="w3-content w3-padding-64">
      <div style="margin-bottom: 25px">
         <select class="w3-border-black w3-round" style="margin: 0 30px 0 0px; width: 150px;
            padding: 7px">
            <option>제목</option>
            <option>영웅</option>
         </select> 
         <select class="w3-border-black w3-round"
            style="margin: 0 30px 0 0px; width: 150px; padding: 7px;">
            <option>날짜</option>
            <option>04-25</option>
            <option>04-26</option>
            <option>04-27</option>
         </select> 
         <select class="w3-border-black w3-round"
            style="margin: 0 30px 0 0px; width: 150px; padding: 7px">
            <option>시간</option>
            <option>15:00</option>
            <option>19:00</option>
            <option>21:00</option>
         </select>
      </div>
      <div class="w3-center"
         style="border: 1px solid #333; border-radius: 10px; padding: 10px;">
         <table class="w3-table">
            <tr style="background-color:#000; color:#fff">
               <th width="20%">제목</th>
               <th width="20%">날짜</th>
               <th width="20%">시간</th>
               <th width="20%">예약자ID</th>
               <th width="20%">취소</th>
            </tr>
            <tr>
               <th colspan="5" style="padding:10px 0px"><hr style="margin:0; opacity:0"></th>
            </tr>
            <tr>
               <th colspan="5" style="padding:0"><hr style="margin:0"></th>
            </tr>
            <c:forEach var="i" items="${rlist}">
               <tr>
                  <td width="20%">${i.rmtitle}</td>
                  <td width="20%">${i.rmd}</td>
                  <td width="20%">${i.rtime}</td>
                  <td width="20%">${i.id}</td>
                  <td width="20%"><a href="${path}/admin/delete?id=${i.id}&rno=${i.rno}" class="btn btn-dark">예약취소</a></td>
               </tr>
               <tr>
               <th colspan="5" style="padding:10px 0px"><hr style="margin:0; border-color:#555"></th>
           	   </tr>
            </c:forEach>
            <%-- 페이지 처리하기 --%>
            <tr>
               <td colspan="5" class="w3-center"><c:if test="${pageNum <= 1}">[이전]</c:if>
                  <c:if test="${pageNum > 1}">
                     <a href="list?pageNum=${pageNum}">[이전]</a>
                  </c:if> <c:forEach var="a" begin="${startpage}" end="${endpage}">
                     <c:if test="${a == pageNum}">[${a}]</c:if>
                     <c:if test="${a != pageNum}">
                        <a href="list?pageNum=${a}">[${a}]</a>
                     </c:if>
                  </c:forEach> <c:if test="${pageNum >= maxpage}">[다음]</c:if> <c:if
                     test="${pageNum < maxpage}">
                     <a href="list?pageNum=${pageNum + 1}">[다음]</a>
                  </c:if></td>
            </tr>
         </table>
      </div>
   </div>
</body>
</html>
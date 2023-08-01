<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="path" value="${pageContext.request.contextPath}" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>회원목록보기</title>
</head>
<body>
   <div class="w3-content w3-padding-64">
      <div>
      <form action="memListForm" method="post" name="sf">
         <input type="hidden" name="pageNum" value="1">
         <ul style="list-style:none; display:flex; justify-content: flex-end;">
            <li><input type="text" placeholder="search"  class="form-control"
            style="padding:5px 10px; border: 1px solid #333" name="column" value="${param.column}"></li>
            <li><button type="submit" class="btn btn-dark">
            <i class="fa fa-search"></i></button></li>
         </ul>
      </form>
      </div>
      <div class="w3-center" style="border: 1px solid #333; border-radius: 10px; padding: 10px;">
         <table class="w3-table">
            <tr style="background-color:#000; color:#fff">
               <th style="border-radius:10px 0px 0px 0px">회원ID</th>
               <th>이름</th>
               <th>전화번호</th>
               <th>Email</th>
               <th>가입 날짜</th>
               <th style="border-radius:0px 10px 0px 0px">탈퇴</th>
            </tr>
            <tr>
               <th colspan="6" style="padding:10px 0px"><hr style="margin:0; opacity:0"></th>
            </tr>
            
            <c:forEach var="m" items="${list}">
            <tr>
               <td><a href="${path}/member/infoForm?id=${m.id}">${m.id}</a></td>
               <td>${m.name}</td>
               <td>${m.tel}</td>
               <td>${m.email}</td>
                 <td><fmt:formatDate value="${m.regdate}" pattern="YYYY-MM-dd" /></td>
                 <td><a href="${path}/member/deleteForm?id=${m.id}" class="btn btn-dark">탈퇴</a></td>
              </tr>
              <tr>
               <th colspan="6" style="padding:10px 0px"><hr style="margin:0; border-color:#555"></th>
            </tr>
            </c:forEach>
            <tr>
               <td colspan="6" class="w3-center"><c:if test="${pageNum <= 1}">[이전]</c:if>
                  <c:if test="${pageNum > 1}">
                     <a href="javascript:listsubmit(${pageNum-1})">[이전]</a>
                  </c:if> 
                  <c:forEach var="a" begin="${startpage}" end="${endpage}">
                     <c:if test="${a == pageNum}">[${a}]</c:if>
                     <c:if test="${a != pageNum}">
                           <a href="javascript:listsubmit(${a})">[${a}]</a>
                     </c:if>
                  </c:forEach> 
                  <c:if test="${pageNum >= maxpage}">[다음]</c:if>
                  <c:if test="${pageNum < maxpage}">
                        <a href="javascript:listsubmit(${pageNum+1})">[다음]</a>
                  </c:if>
               </td>
            </tr>
         </table>
      </div>
   </div>
<script type="text/javascript">
    function listsubmit(page) {
       f = document.sf;  //검색 form 태그
       f.pageNum.value = page;
       f.submit();
    }
</script>  
</body>
</html>
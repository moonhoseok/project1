<%@ page language="java" contentType="text/html; ccharset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style type="text/css">
   #infoa {color:#000}
   #infoa:hover {color:#000; font-weight: bold;}
   .form-group>p>a:hover b {text-decoration:underline;}
</style>
</head>
<body>
<div class="w3-content w3-padding-64">
   <h3>${mem.name}님</h3>
   <div style="display:flex; align-items: center; margin-bottom:50px;">   
      <div style="position:relative; margin-right:40px;">
         <img src="${path}/picture/${mem.con}" width="200px" height="200px" id="pic"
            style="border-radius:100px; border: 1px solid #ddd">
         <a href="pictureForm?id=${mem.id}" 
            style="position:absolute; bottom:22px; right:5px; border-radius:25px; border: 1px solid #ddd; background-color:#fefefe;">
            <img src="${path}/img/pencil.svg" style="width:40px; padding:10px;">
         </a>
      </div>
      <div class="form-group">
            <p>보유 포인트:&nbsp;
               <a href="${path}/member/pointForm?id=${mem.id}" style="color:#000; text-decoration: none"><b>${p.point}</b></a>
            </p>
            <p>일반회원 &nbsp;&nbsp;|&nbsp;&nbsp;
            <a href="${path}/member/updateForm?id=${mem.id}" style="text-decoration: none; color:#000" id="infoa">내 정보 확인</a>
            </p>
      </div>
   </div>   
   <b style="font-size:21px; display:block; margin-bottom:15px">예매내역</b>
   <c:if test="${!empty reslist}">
      <c:forEach var="i" items="${reslist}">
      <div class="w3-margin-bottom" style="border: 1px solid #333; border-radius:10px; padding:20px; 
      position: relative; display:flex; align-items: center;">
         <table class="w3-table">
            <tr>
               <td rowspan="5"><img src="../img/${mainlist[0].mpos}" width="130px" id="pic"></td>
               <td colspan="2"><b style="font-size:16px">${i.rmtitle}</b></td>
            </tr>
            <tr>
               <td>상영일시</td>
               <td>&nbsp; ${i.rmd}&emsp;${i.rtime}</td>
            </tr>
            <tr>
               <td colspan="2"><b style="font-size:16px; display:block; margin:10px 0px">
               좌석번호 : ${i.rseat1},${i.rseat2},${i.rseat3}</b></td>
            </tr>
            <tr>
               <td>예약번호</td>
               <td>&nbsp;${i.rno}</td>
            </tr>
            <tr>
               <td>예매시간</td>
               <td>&nbsp;<fmt:formatDate value="${i.rpmdate}" pattern="YYYY-MM-dd HH" /></td>
            </tr>
         </table>
         <button type="button" class="btn btn-dark" 
         style="position:absolute; top: 15px; right:20px" onclick="location.href='reserdel?id=${mem.id}&rno=${i.rno}'">예매취소</button>
      </div>
         </c:forEach>
      </c:if>
      <c:if test="${empty reslist}">
      <div class="w3-margin-bottom" style="border: 1px solid #333; border-radius:10px; padding:20px; 
      position: relative; display:flex; align-items: center;">
         <div>
            <p style="text-align:center; margin-bottom:0">예매 내역이 없습니다.</p>
         </div>
         </div>
      </c:if>
   <div class="w3-margin-bottom" style="padding:20px 0px; margin-bottom:50px">
      <b style="font-size:21px; display:block; margin-bottom:15px">작성한 리뷰</b>
      <c:if test="${!empty comlist}">
      <div>
         <table style="line-height:30px" class="w3-table-all">
         <tr>
            <th>영화번호</th><th>id</th><th>내용</th><th>별점</th><th>작성시간</th>
         </tr>
         <c:forEach var="i" items="${comlist}">
            <tr>
               <td>${i.msno}</td>
               <td>${i.id}</td>
               <td>${i.ccontent}</td>
               <td>${i.cstar}</td>
               <td>${i.cdate}</td>
            </tr>
         </c:forEach>
         </table>
      </div>
      </c:if>
      <c:if test="${empty comlist}">
      <div>
         <p style="text-align:center; margin-bottom:0">작성한 리뷰가 없습니다.</p>
      </div>
      </c:if>
   </div>
</div>
<script type="text/javascript">
   function win_upload(){
      var op = "width=500,height=300,left=50, top=150";
      open("pictureForm","",op);
   }
</script>
</body>
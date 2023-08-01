<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<style>
   table th {float:right}
</style>
<div class="w3-content w3-padding-64" style="max-width: 600px">
   <h3 class="w3-center w3-padding-16"> 예매 정보 확인</h3>
   <form action="payment" method="post" name="f">
      <input type="hidden" name="dmd" value="${dmd}">
      <input type="hidden" name="time" value="${time}">
      <input type="hidden" name="seat" value="${seat}">
      <input type="hidden" name="sum" value="${sum}">
      <input type="hidden" name="title" value="${mainlist[0].mtitle}">
      <input type="hidden" name="msno" value="${mainlist[0].msno}">
   <div style="display:flex" class="w3-padding-32">
      <div style="width:50%">
         <img src="../img/${mainlist[0].mpos}" style="width: 100%">
      </div>
      <table class="w3-table">
         <tr>
            <th>제&nbsp;&emsp;&emsp;목:</th>
            <td>${mainlist[0].mtitle}</td>
         </tr>
         <tr>
            <th>일&nbsp;&emsp;&emsp;시:</th>
            <td>${dmd} ${time}</td>
         </tr>
         <tr>
            <th>장&nbsp;&emsp;&emsp;소:</th>
            <td>블루스퀘어 신한카드홀</td>
         </tr>
         <tr>
            <th>좌&nbsp;&emsp;&emsp;석:</th>
            <td>${seat}</td>
         </tr>
         <tr>
            <th>금&nbsp;&emsp;&emsp;액:</th>
            <td>${sum}</td>
         </tr>
         <tr>
            <th>예약번호:</th>
            <td>${num}</td>
         </tr>
      </table>
   </div>
      <div class="w3-center" style="margin-top: 20px">
         <button type="submit" class="btn btn-dark">결제하기</button>
         <button type="button" class="btn btn-outline-dark" onclick="location.href='../member/main'">취소</button>
      </div>
   </form>
   
</div>
</body>
</html>
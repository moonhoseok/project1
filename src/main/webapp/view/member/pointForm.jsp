<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트 내역</title>
<script type="text/javascript">
function win_open(page){
	let op = "width=350, height=350, left=150, top=150"
	open(page,"",op)
}
</script>
</head>
<body>
<div class="w3-padding-64">
	<div class="w3-content">
		<h3 class="w3-center">포인트 내역</h3>
		<button type="button" onclick="win_open('point?id=${id}')" class="btn btn-dark" style="float:right"><b>포인트 충전</b></button>
		<br>
		<div style="background-color:#f8f9fa; margin-top:25px">
	
			<table class="w3-table">
				<tr>
					<th>목록(충전/결제)</th>
					<th>내역(충전금액/사용내역)</th>
					<th>결제일</th>
				</tr>
				<c:forEach var="p" items="${list}">
				<tr>
					<td>
						<c:if test="${p.point > 0 }"> 충전</c:if>
						<c:if test="${p.point < 0 }"> 결제</c:if>
					</td>
					<td>${p.point}</td>
					<td>${p.regdate}</td>
				</tr>
				</c:forEach>
			</table>
			
		</div>
	</div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보 수정</title>

</head>
<body>
<style>
#del {
	padding: 5px;
	color: #555;
	font-size: 0.9rem;
	text-align: center;
	width: 100px;
	display: block;
	margin: 0 auto;
	margin-top: 15px;
}

#del:hover {
	color: #000;
	font-weight:bold;
	cursor: pointer;
}
</style>
	<div class="w3-padding-64">
		<h3 class="w3-center" style="margin-bottom: 15px">내 정보</h3>
		<div class="w3-content"
			style="max-width: 600px; background-color: #f8f9fa; border-radius: 20px; display: block; padding: 20px 30px; width: 100%;">
			<table style="font-size: 14px; line-height: 40px;">
				<tr>
					<td colspan="3"><b>${mem.name}님</b></td>
				</tr>
				<tr>
					<td width="20%">ID</td>
					<td colspan="2" width="80%">${mem.id}</td>
				</tr>
				<tr>
					<td width="30%">전화번호</td>
					<td width="60%">${mem.tel}</td>
					<td width="10%"><button type="button" class="btn btn-dark"
							style="width: 100%; padding: 5px 10px;" onclick="location.href='telForm?id=${mem.id}'">수정</button></td>
				</tr>
				<tr>
					<td width="30%">이메일</td>
					<td width="60%">${mem.email}</td>
					<td width="10%"><button type="button" class="btn btn-dark"
							style="width: 100%; padding: 5px 10px;" onclick="location.href='emailForm?id=${mem.id}'">수정</button></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td colspan="2">${mem.bir}</td>
				</tr>
			</table>
			<div style="margin-top: 20px; padding-bottom: 10px">
				<b style="font-size: 16px">내가 쓴 리뷰 보기</b>&nbsp;&nbsp;
				<button type="button" class="btn btn-outline-dark"
					style="font-size: 10px; padding: 3px 7px; margin-top: -3px">▼</button>
			</div>
		</div>
		<a id="del" href="deleteForm?id=${mem.id}">회원탈퇴</a>
	</div>

</body>
</html>
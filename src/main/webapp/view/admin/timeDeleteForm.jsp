<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뮤지컬 정보 삭제</title>
</head>
<body>
<div class="w3-padding-64" style="width:600px; margin: 0 auto" >
	<h2 style="margin-bottom:20px">뮤지컬 회차 정보 삭제</h2>
	<p style="margin-bottom:20px">관리자 비밀번호를 입력하면 해당 정보가 삭제됩니다.</p>
	<form action="timedelete" method="post">
		<input type="hidden" name="msno" value="${param.msno}">
		<input type="hidden" name="dmd" value="${param.dmd}">
		<label>Password:</label>
		<input type="password" class="form-control" name="pass">
		<div id="center" style="padding:3px;">
			<button type="submit" style="margin-top:10px" class="btn btn-dark">회차 정보 삭제</button>
		</div>
	</form>
</div>
</body>
</html>
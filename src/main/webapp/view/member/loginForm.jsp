<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<body>
<div class="w3-padding-64">
	<div class="w3-padding-64">
		<form action="login" method="post" name="f" onsubmit="return input_check(this)">
			<div class="w3-container w3-content w3-padding-48">
				<h2 style="text-align:center;">LOGIN</h2>
				<div class="form-group" style="width:70%; margin:0 auto">
					<label for="user">ID</label>
					<input type="text" class="form-control" id="user" name="id">
					<br>
					<label for="pwd">Password</label>
					<input type="password" class="form-control" id="pwd" name="pass">
				</div>
				<div style="width:70%; text-align: center; margin: 0 auto; margin-top:50px">
					<button type="submit" class="btn btn-dark">로그인</button>
					<button type="button" onclick="win_open('idForm')" class="btn btn-outline-dark">아이디 찾기</button>
					<button type="button" onclick="win_open('pwForm')" class="btn btn-outline-dark">비밀번호 찾기</button>
				</div>
			</div>
		</form>
	</div>
</div>
<script>
	function input_check(f) {
		if(f.id.value.trim() == ""){
			alert("아이디가 입력되지 않았습니다.");
			f.id.focus();
			return false;
		}
		if(f.pass.value.trim() == ""){
			alert("비밀번호가 입력되지 않았습니다.");
			f.pass.focus();
			return false;
		}
		return true;
	}
	function win_open(page) {
		let op = "width=500, height=400, left=50, top=150";
		open(page,"",op)
	}
</script>
</body>
</html>
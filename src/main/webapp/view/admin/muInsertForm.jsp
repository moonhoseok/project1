<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뮤지컬 등록</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<div class="w3-content w3-padding-64" style="max-width:800px">
	<h3 style="margin-bottom:15px;">뮤지컬 정보 등록</h3>
		<form action="muinsert" method="post" name="f" onsubmit="return input_check(this)">
			<input type="hidden" name="poster" value="">
			<div class="form-group">
				<table class="w3-table">
					<tr>
						<th rowspan="7" style="width:30%; background-color:#eee; margin-right:20px">
							<img src="" width="100%" id="pos">
						</th>
					</tr>
					<tr>
						<th style="width:20%; padding-left:16px"><label for="title">제목</label></th>
						<td style="width:50%"><input type="text" class="form-control" name="title" id="title"></td>
					</tr>
					<tr>
						<th><label for="age">관람등급</label></th>
						<td><select class="form-control" name="age" id="age">
								<option value="">관람 등급을 선택하세요.</option>
								<option value="전체 관람 가능">전체 관람 가능</option>
								<option value="8세 이상 관람 가능">8세 이상 관람 가능</option>
								<option value="12세 이상 관람 가능">12세 이상 관람 가능</option>
								<option value="15세 이상 관람 가능">15세 이상 관람 가능</option>
								<option value="18세 이상 관람 가능">18세 이상 관람 가능</option>
							</select>
						</td>
					</tr>
					<tr>
						<th><label for="date">상영기간</label></th>
						<td><input type="text" class="form-control" name="date"	id="date"></td>
					</tr>
					<tr>
						<th><label for="time">공연시간</label></th>
						<td><input type="text" class="form-control" name="time" id="time"></td>
					</tr>
					<tr>
						<th style="padding-left:16px"><label for="vid">동영상URL</label></th>
							<td><input type="text" class="form-control" name="vid" id="vid" placeholder="YouTube 동영상 소스코드복사 후 붙여넣기">
						</td>
					</tr>
					<tr>
						<th><label for="cast">캐스팅</label></th>
						<td><input type="text" class="form-control" name="cast"	id="cast"></td>
					</tr>
					<tr>	
						<th style="padding:0">
							<a href="javascript:win_upload()" class="btn btn-dark" style="width:100%">포스터 등록</a>
						</th>
						<th style="padding-left:16px"><label for="pd">감독</label></th>
							<td><input type="text" class="form-control" name="pd" id="pd">
						</td>
					</tr>
				</table>
			</div>
			<br>
			<div id="center" style="padding: 3px; text-align: center; margin: 0 auto; margin-top:20px">
				<button type="reset" class="btn btn-outline-dark">다시작성</button>
				<button type="submit" class="btn btn-dark">등록하기</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">
	function input_check(f) {
		if (f.title.value.trim() == "") {
			alert("제목을 입력하세요")
			f.title.focus()
			return false;
		}
		if (f.age.value.trim() == "") {
			alert("관람등급를 입력하세요")
			f.age.focus()
			return false;
		}
		if (f.date.value.trim() == "") {
			alert("상영기간을 입력하세요")
			f.date.focus()
			return false;
		}
		return true;
	}
	// 포스터 등록
	function win_upload() {
		var op = "width=500, height=500, left=50, top=150";
		open("posterForm","",op);
	}

</script>
</body>
</html>
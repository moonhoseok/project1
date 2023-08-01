<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>뮤지컬 회차 시간 등록</title>
</head>
<body>
	<div class="w3-content w3-padding-64" style="max-width:800px">
		<h3 style="margin-bottom:15px;" class="w3-center">시간 정보 등록</h3>
		<form action="timeupdate" method="post" name="f" onsubmit="">
			<input type="hidden" name="msno" value="${param.msno}">
			<input type="hidden" name="dmd" value="${param.dmd}">

			<div class="form-group">
				<table class="w3-table">
					<tr>
						<th>상영 일</th>
						<th colspan="3">상영 시간</th>
						<th></th>
					</tr>
					<tr>
						<td><input type="date" class="form-control" 
							name="days" value="${tu.dmd}"></td>
						<td><input type="time" class="form-control" 
							name="timetable1" id="timetable" value="${tu.time1}"></td>
						<td><input type="time" class="form-control" 
							name="timetable2" id="timetable" value="${tu.time2}"></td>
						<td><input type="time" class="form-control" 
							name="timetable3" id="timetable" value="${tu.time3}"></td>
						<td><input type="button" value="+" class="btn btn-dark" id="addTime"></td>
						<td><input type="button" value="-" class="btn btn-dark" id="remTime"></td>
					</tr>
				</table>
			</div>
			<br>
			<div id="center" style="padding: 3px; text-align: center; margin: 0 auto; margin-top:20px">
				<button type="reset" class="btn btn-outline-dark" onclick="timeadd()">다시작성</button>
				<button type="submit" class="btn btn-dark">등록하기</button>
			</div>
		</form>
	</div>
	<script>
		$(function(){
			$("#addTime").click(function(){
				$.ajax("/project/view/admin/addTime.jsp",{
					success : function(data) {
						$("table").append(data)
					},
					error : function(e) {
						alert("서버 오류:"+e.status)
					}
				})
			})
	
			$("#remTime").click(function(){
				$("#addTr").eq(-1).remove()
			})
		})
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전화번호 변경</title>
</head>
<body>
<div class="w3-content w3-padding-64" style="max-width: 600px">
<h2 class="w3-center">전화번호 변경</h2>
<form action="tel" name="f" onsubmit="return input_check(this)">
 <table class="w3-table">
  <tr>
  	<td> <input type="text" id="tel" name="tel" class="form-control" placeholder="전화번호를 입력하세요"></td>
  </tr>
  <tr>
  	<td colspan="2">
  	  <button type="submit" class="btn btn-dark" style="width: 100%; padding: 5px 10px;">수정</button>
  	</td>
  </tr>
 </table>
</form>
</div>
<script>
		function input_check(f) {
			if (f.tel.value.trim() == "") {
				alert("전화번호가 입력되지 않았습니다.");
				f.tel.focus();
				return false;
			}
		}	
</script>
</body>
</html>
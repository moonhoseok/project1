<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
<form action="delete" method="post" onsubmit="return inputcheck(this)">
  <input type="hidden" name="id" value="${param.id}" >
  <h2 id="center">회원비밀번호 입력</h2>
  <table class="w3-table">
  <tr><th>아이디</th>
  	<td>
  	<input type="text" name="id2" readonly class="form-control" value=${param.id}>
  	</td> 
  <tr><th>비밀번호</th>
  <td><input type="password" name="pass" class="form-control"></td></tr>
  <tr><td colspan="2" id="center"><input type="submit" value="탈퇴하기" /></td></tr>    
  </table>
</form>
</div>
<script type="text/javascript">
   function inputcheck(f) {
	   if(f.pass.value == '') {
		   alert("비밀번호를 입력하세요")
		   f.pass.focus()
		   return false
	   }
   }
</script>			
</body>
</html>
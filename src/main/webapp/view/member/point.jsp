<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>포인트충전</title>
<script type="text/javascript">
function input_check(f){
	if(f.p.value.trim() ==""){
		alert("금액을 입력하세요");
		f.p.focus();
		return false;
	}
	if(f.p.value.trim() < 0){
		alert("양수를 입력하세요");
		f.p.focus();
		return false;
	}
	if(f.p.value.trim() > 500000){
	      alert("50만원이상 충전 불가")
	      f.p.focus();
	      return false;
	   }
	return true;
}
</script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>

<h3>포인트 충전 </h3>
<form action="point2"  name="f" method="post" onsubmit="return input_check(this)">
<input type="hidden" name="id"  value="${param.id }" />
	<table>
		<tr><th>충전금액</th><td><input type="number"  name="p"></td></tr>
		<tr><td colspan="2"><input type="submit" value="충전하기"></td></tr>
	</table>
	
</form>

</body>
</html>
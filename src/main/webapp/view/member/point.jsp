<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����Ʈ����</title>
<script type="text/javascript">
function input_check(f){
	if(f.p.value.trim() ==""){
		alert("�ݾ��� �Է��ϼ���");
		f.p.focus();
		return false;
	}
	if(f.p.value.trim() < 0){
		alert("����� �Է��ϼ���");
		f.p.focus();
		return false;
	}
	if(f.p.value.trim() > 500000){
	      alert("50�����̻� ���� �Ұ�")
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

<h3>����Ʈ ���� </h3>
<form action="point2"  name="f" method="post" onsubmit="return input_check(this)">
<input type="hidden" name="id"  value="${param.id }" />
	<table>
		<tr><th>�����ݾ�</th><td><input type="number"  name="p"></td></tr>
		<tr><td colspan="2"><input type="submit" value="�����ϱ�"></td></tr>
	</table>
	
</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="w3-content w3-padding-64 w3-center" style="max-width: 600px">
	<h2 >${p}원 ${msg}</h2>
	<button onclick="windowClose()"
  				class="btn btn-primary">닫기</button>
</div>
<script>
    function windowClose(){
        opener.location.reload();
        self.close();
    }
</script>
</body>

</html>
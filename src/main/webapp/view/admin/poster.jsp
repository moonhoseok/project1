<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	img = opener.document.getElementById("pos");
	img.src ="/project/poster/${pname}"; 
	opener.document.f.poster.value="${pname}";
	self.close();
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<jsp:useBean id="now" class="java.util.Date" />

<c:if test="${!empty c[0].time1.trim()}">
	<li>
		 <button type="button" class="btn btn-outline-danger">${c[0].time1}</button>
	</li>
</c:if>
<c:if test="${!empty c[0].time2.trim()}">
	<li>	
		<button type="button" class="btn btn-outline-danger">${c[0].time2}</button>
	</li>
</c:if>
<c:if test="${!empty c[0].time3.trim()}">
	<li>
		 <button type="button" class="btn btn-outline-danger">${c[0].time3}</button>
	</li>
</c:if>
<c:if test="${empty c[0].time1.trim() && empty c[0].time2.trim() && empty c[0].time3.trim()}">
	<p style="padding-top:10px; text-align:center; color:#555">상영 정보가 없습니다.</p>
</c:if>

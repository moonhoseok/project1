<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />	 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>뮤지컬 리스트</title>
</head>
<body>
	<style>
		.w3-table td, .w3-table th, .w3-table-all td, .w3-table-all th {vertical-align: center;}
		.btn>a {font-size: 14px}
		.btn>a:hover {color:#fff}
		.table tr, .table td {font-size:1.1rem}
	
	</style>
	<div class="w3-content w3-padding-64">
		<div>
			<form action="muListForm" method="post" name="sf">
				<input type="hidden" name="pageNum" value="1">
				<ul style="list-style:none; display:flex; justify-content: flex-end;">
					<li><input type="text" placeholder="search"  class="form-control"
					style="padding:5px 10px; border: 1px solid #333" name="column" value="${param.column}"></li>
					<li><button type="submit" class="btn btn-dark">
					<i class="fa fa-search"></i></button></li>
				</ul>
			</form>
		</div>

		<input type="hidden" value="msno">
		<div class="w3-center" style="border: 1px solid #333; border-radius: 10px; padding: 10px;">
			<table class="w3-table" style="vertical-align: center !important;" >
				<tr style="background-color:#000; color:#fff;">
					<th style="border-radius:8px 0px 0px 0px">포스터</th>
					<th colspan="2">뮤지컬 정보</th>
					<th style="border-radius:0px 8px 0px 0px">수정/삭제/추가</th>
				</tr>
				<tr>
					<th colspan="4" style="padding-bottom: 10px; opacity: 0;"><hr style="margin:0"></th>
				</tr>
				<c:forEach var="mu" items="${list}">
					<tr style="padding: 10px 0px">
						<th rowspan="5"><img src="${path}/img/${mu.mpos}" width="150px"></th>
					</tr>
					<tr>
						<th>제목</th>
						<td>${mu.mtitle}</td>
						<td><a href="updateForm?msno=${mu.msno}" id="up" class="btn btn-outline-dark">뮤지컬 정보 수정</a></td>
					</tr>
					<tr>
						<th>관람 연령</th>
						<td>${mu.mage}</td>
						<td><a href="deleteForm?msno=${mu.msno}" id="de" class="btn btn-dark">뮤지컬 정보 삭제</a></td>
					</tr>
					<tr>
						<th>상영 기간</th>
						<td>${mu.mdate}</td>
						<td><a href="timeInsertForm?msno=${mu.msno}" id="timeIn" class="btn btn-outline-dark">일별 상영회차 등록</a></td>
					</tr>
					<tr>
						<th>상영 시간</th>
						<td>${mu.mtime}</td>
						<td><a href="timeListForm?msno=${mu.msno}" id="timeSel" class="btn btn-dark">일별 상영회차 조회</a></td>
					</tr>
					<tr>
						<th colspan="4" style="padding:5px 0px"><hr style="margin:0; border-color:#555"></th>
					</tr>
				</c:forEach>
				
				<%-- 페이지 처리하기 --%>
				<tr>
					<td colspan="4" class="w3-center"><c:if test="${pageNum <= 1}">[이전]</c:if>
						<c:if test="${pageNum > 1}">
							<a href="javascript:listsubmit(${pageNum-1})">[이전]</a>
						</c:if> 
						<c:forEach var="a" begin="${startpage}" end="${endpage}">
							<c:if test="${a == pageNum}">[${a}]</c:if>
							<c:if test="${a != pageNum}">
									 <a href="javascript:listsubmit(${a})">[${a}]</a>
							</c:if>
						</c:forEach> 
						<c:if test="${pageNum >= maxpage}">[다음]</c:if>
						<c:if test="${pageNum < maxpage}">
								 <a href="javascript:listsubmit(${pageNum+1})">[다음]</a>
						</c:if>
					</td>
				</tr>
			</table>
		</div>
		<a href="${path}/admin/muInsertForm" class="btn btn-dark" style="float:right; margin-top:15px">뮤지컬 등록</a>
	</div>
	<script type="text/javascript">
	
		function listsubmit(page) {
			f = document.sf;  //검색 form 태그
		    f.pageNum.value = page;
		    f.submit();
	    }
	</script>
</body>
</html>
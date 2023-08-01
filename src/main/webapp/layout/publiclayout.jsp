<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />	 
<!DOCTYPE html>
<html lang="en">
<head>
<title><sitemesh:write property='title'/></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<style>
body {font-family: "Lato", sans-serif}
#logo {font-family: "Old English Text MT", sans-serif;
	font-size:24px}
.mySlides {display: none}
p {margin-bottom:0.3rem}
#ad-nav {position: absolute; list-style: none; width: 30%; left: 35%;
    				display: flex; justify-content: space-around;}
@media (max-width: 1200px) {
  #ad-nav {
   width:40%;
   left: 30%
  }
}
</style>
<script src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js"></script> 
<!-- 에디터 스크립트 넣어줘야함 -->
<sitemesh:write property="head"/>
</head>
<body>
<!-- Navbar -->
<div class="w3-top">
  <div class="w3-bar w3-black w3-card">
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" 
    href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <a href="${path}/member/main" class="w3-bar-item w3-button" id="logo">Musical</a>
 	 <%-- 로그아웃 상태 --%>
 	 <c:if test="${empty sessionScope.login}">
 		<a href="${path}/member/joinForm" class="w3-padding-large w3-hide-small w3-right" 
				style="color: #fff; box-sizing: border-box; padding:24px" id="nav-a">JOIN</a>
		<a href="${path}/member/loginForm" class="w3-padding-large w3-hide-small w3-right" 
		style="color: #fff; box-sizing: border-box;  padding:24px" id="nav-a">LOGIN</a>
 	</c:if>
 	
 	<%-- 일반회원 로그인 상태 --%>
 	<c:if test="${!empty sessionScope.login && !login.equals('admin')}">
 		<a href="${path}/member/logout" class="w3-padding-large w3-hide-small w3-right" 
				style="color: #fff; box-sizing: border-box; padding:24px" id="nav-a">로그아웃</a>
		<a href="${path}/member/infoForm?id=${sessionScope.login}" class="w3-padding-large w3-hide-small w3-right" 
		style="color: #fff; box-sizing: border-box;  padding:24px" id="nav-a">${sessionScope.login}님</a>
	</c:if>
	
	<%-- 관리자 로그인 상태 --%>
 	<c:if test="${!empty sessionScope.login && login.equals('admin')}">
 		<ul id="ad-nav">
 			<li><a href="${path}/admin/muListForm" class="w3-bar-item w3-button w3-padding-large w3-hide-small w3-center"
 				style="padding: 15px 24px!important;" id="adnav">뮤지컬 관리</a></li>
 			<li><a href="${path}/admin/memListForm" class="w3-bar-item w3-button w3-padding-large w3-hide-small w3-center"
 				style="padding: 15px 24px!important;" id="adnav">회원관리</a></li>
 			<li><a href="${path}/admin/muReserListForm" class="w3-bar-item w3-button w3-padding-large w3-hide-small w3-center"
 				style="padding: 15px 24px!important;" id="adnav">예매관리</a></li>
 		</ul>

 		<a href="${path}/member/logout" class="w3-padding-large w3-hide-small w3-right" 
				style="color: #fff; box-sizing: border-box; padding:24px" id="nav-a">로그아웃</a>
		<a href="${path}/member/infoForm?id=${sessionScope.login}" class="w3-padding-large w3-hide-small w3-right" 
		style="color: #fff; box-sizing: border-box;  padding:24px" id="nav-a">${sessionScope.login}님</a>
 	</c:if>
  </div>
</div>

<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
	<a href="${path}/member/joinForm"  class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">LOGIN</a>
	<a href="${path}/member/loginForm" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">JOIN</a>
</div>

<!-- Page content -->
<div class="w3-content" style="max-width:2000px; margin-top:46px">

  <!-- The Tour Section -->

  <sitemesh:write property="body"/>
    
<!-- Footer -->
<div style="background-color:#f8f9fa">
  <footer class="w3-container w3-content w3-padding" id="contact">
    <div class="w3-row" style="padding-top:10px">
      <div class="w3-col m6 w3-large w3-margin-bottom">
        <i class="fa fa-map-marker" style="width:30px; font-size:16px"></i><span style="font-size:12px;">블루스퀘어 신한카드홀</span><br>
        <i class="fa fa-phone" style="width:30px; font-size:16px"></i> <span style="font-size:12px">Tel: 1544-15915</span><br>
      	<i class="fa fa-clock" style="width:30px; font-size:16px"></i> <span style="font-size:12px"> 화~ 금 19:30, 토, 일, 공휴일 14:00, 19:00</span>
      </div>
    </div>
  </footer>
</div>
</div>
<script>

function carousel() {
// Used to toggle the menu on small screens when clicking on the menu button
	function myFunction() {
	  var x = document.getElementById("navDemo");
	  if (x.className.indexOf("w3-show") == -1) {
	    x.className += " w3-show";
	  } else { 
	    x.className = x.className.replace(" w3-show", "");
	  }
	}

	// When the user clicks anywhere outside of the modal, close it
	var modal = document.getElementById('ticketModal');
	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
}

</script>

</body>
</html>
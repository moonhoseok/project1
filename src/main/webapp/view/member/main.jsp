<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈페이지</title>
</head>
<body>
<div class="w3-black w3-padding-32">
   <h2 class="w3-wide w3-center">Musical</h2>
    <p class="w3-opacity w3-center"><i>It's a musical that's playing</i></p>
    <br>
    <div style="text-align:center">
         <iframe width="980" height="580"
         src="${mainlist[0].mvid}?autoplay=1&mute=1" controls="0"
         frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
         allowfullscreen></iframe>
     </div>
   <div class="w3-content">
      <div style="text-align:center;">
            <b class="w3-wide">${mainlist[0].mtitle}</b><br>
            <span style="color:#aaa">${mainlist[0].mdate}</span>
            <br>
            <br>
            <form action="${path}/reservation/reserInfoForm" method="post" name="f">
            <input type="hidden" value="${mainlist[0].msno}" name="msno">
            <button type="submit" class="btn btn-light" style="border-radius: 0"><b>자세히 보기</b></button>
            </form>
         </div>
         <br>
         <br>
         <br>
         <hr>
   </div>
   <div class="w3-black w3-padding-64 w3-content">
      <b style="margin-bottom:15px; display:block; font-size:21px">상영 예정작</b>
      <div class="wrap">
         <div>
            <div class="img_wrap"></div>
            <div class="com_inner">
               <b>Coming Soon</b>
               <ul>
                  <li>${mainlist[1].mtitle}</li>
                  <li>${mainlist[1].mdate}</li>
               </ul>
            </div>
         </div>
         <div>
            <div class="img_wrap"></div>
            <div class="com_inner">
               <b>Coming Soon</b>
               <ul>
                  <li>${mainlist[2].mtitle}</li>
                  <li>${mainlist[2].mdate}</li>
               </ul>
            </div>
         </div>
         <div>
            <div class="img_wrap"></div>
            <div class="com_inner">
               <b>Coming Soon</b>
               <ul>
                  <li>${mainlist[3].mtitle}</li>
                  <li>${mainlist[3].mdate}</li>
               </ul>
            </div>
         </div>
      </div>
   </div>
</div>
<style>
   .wrap {display: flex;
    justify-content: space-between;}
    .wrap>div {position: relative;}
   .poster {width: 300px;}
   
   .img_wrap {
      width:300px;
      height: 427px;}
   
   .wrap>div:nth-child(1) .img_wrap {background-image: url(../img/${mainlist[1].mpos});
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
   }
   .wrap>div:nth-child(2) .img_wrap {background-image: url(../img/${mainlist[2].mpos});
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
   }
   .wrap>div:nth-child(3) .img_wrap {background-image: url(../img/${mainlist[3].mpos});
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
   }
   
   .com_inner {
      position: absolute;
      width:100%;
       top: 38%;
       text-align: center}
   .com_inner {opacity: 0;}
   .wrap>div:hover .com_inner {opacity:1}
   .wrap>div:hover .img_wrap {opacity:0.3}
   
   .com_inner>b {text-align: center;
      display:block;
      margin-bottom:10px;
      font-size: 18px}
   .com_inner ul {list-style:none;
      padding:0;
      line-height: 1.8rem}
</style>
</body>
</html>
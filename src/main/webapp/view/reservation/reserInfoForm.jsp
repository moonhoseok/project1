<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<title>영화 정보</title>
<style>
@import
   url('https://fonts.googleapis.com/css?family=Questrial&display=swap');

.Calendar {
   text-align: center;
}

.Calendar>thead>tr:first-child>td {
   font-family: 'Questrial', sans-serif;
   font-size: 1.1em;
   font-weight: bold;
}

.Calendar>thead>tr:last-child>td {
   font-family: 'Questrial', sans-serif;
   font-weight: 600;
}

.Calendar>tbody>tr>td>p {
   font-family: 'Montserrat', sans-serif;
   /*   height: 45px;
   width: 45px;*/
   border-radius: 45px;
   transition-duration: .2s;
   /*   line-height: 45px; */
   margin: 2.5px;
   padding: 5px;
   display: block;
   text-align: center;
}

.pastDay {
   color: lightgray;
}

.today {
   background-color: red;
   color: #fff;
   font-weight: 600;
   cursor: pointer;
   padding: 3px 5px !important;
}

.futureDay {
   background-color: #FFFFFF;
   cursor: pointer;
}

.futureDay:hover {
   background: #eee;
}

.futureDay.choiceDay, .today.choiceDay {
   background: #0A174E;
   color: #fff;
   font-weight: 600;
   cursor: pointer;
   padding: 3px 5px !important;
}

.info-table th {
   padding-right: 15px
}

b {
   font-size: 1.1rem
}

.w3-table td:nth-child(2) {
   padding-top: 14px
}

.w3-table td:nth-child(3) {
   padding-top: 14px
}

.clickButton {
   background-color: red;
   color: #fff
}
</style>
</head>
<body>
   <div class="w3-padding-24">
      <div class="w3-content w3-padding-64"
         style="display: flex; justify-content: space-between;">
         <div style="width: 30%">
            <img src="../img/${mainlist[0].mpos}" style="width: 100%">
         </div>
         <div style="width: 35%">
            <table class="info-table"
               style="line-height: 38px; width: 98%; margin: 0 auto;">
               <tr>
                  <th colspan="3"><b>${mainlist[0].mtitle}</b></th>
               </tr>
               <tr>
                  <th>공연 장소</th>
                  <td colspan="2">블루스퀘어 신한카드홀</td>
               </tr>
               <tr>
                  <th>공연 기간</th>
                  <td colspan="2">${mainlist[0].mdate}</td>
               </tr>
               <tr>
                  <th>공연 시간</th>
                  <td colspan="2">${mainlist[0].mtime}</td>
               </tr>
               <tr>
                  <th>연령</th>
                  <td colspan="2">${mainlist[0].mage}</td>
               </tr>
               <tr>
                  <th>감독</th>
                  <td colspan="2">${mainlist[0].mpd}</td>
               </tr>
               <tr>
                  <th>가격</th>
                  <td style="color: #aaa">VIP석</td>
                  <td><b>150,000원</b></td>
               </tr>
               <tr>
                  <th></th>
                  <td style="color: #aaa">R석</td>
                  <td><b>130,000원</b></td>
               </tr>
               <tr>
                  <th></th>
                  <td style="color: #aaa">S석</td>
                  <td><b>100,000원</b></td>
               </tr>
               <tr>
                  <th></th>
                  <td style="color: #aaa">A석</td>
                  <td><b>70,000원</b></td>
               </tr>
               <tr>
                  <th></th>
                  <td colspan="2">
                     <button class="w3-button w3-round w3-black"
                        style="width: 100%; margin-top: 30px; padding: 3px 0px"
                        id="rebutton">예매하기</button>
                  </td>
               </tr>
            </table>

         </div>
         <div
            style="width: 30%; border: 1px solid #333; padding: 20px 0px; border-radius: 10px">
            <table class="Calendar" style="margin: 0 auto;">
               <thead style="line-height: 33px">
                  <tr>
                     <td onClick="prevCalendar();" style="cursor: pointer;">&#60;</td>
                     <td colspan="5" style="text-align: center"><span
                        id="calYear"></span>년 <span id="calMonth"></span>월</td>
                     <td onClick="nextCalendar();" style="cursor: pointer;">&#62;</td>
                  </tr>
                  <tr style="background-color: #eee; text-align: center">
                     <td style="border-radius: 20px 0px 0px 20px;">일</td>
                     <td>월</td>
                     <td>화</td>
                     <td>수</td>
                     <td>목</td>
                     <td>금</td>
                     <td style="border-radius: 0px 20px 20px 0px">토</td>
                  </tr>
               </thead>
               <tbody>

               </tbody>
            </table>


            <ul
               style="list-style: none; width: 80%; margin: 0 auto; padding-left: 0; margin-top: 15px; display: flex; justify-content: space-evenly"
               id="ultime">

            </ul>


            <ul
               style="list-style: none; width: 80%; margin: 0 auto; padding-left: 0">
               <li><strong style="display: block; padding: 25px 0px 5px 0px">캐스팅</strong></li>
               <li>${mainlist[0].mcast}</li>
            </ul>
         </div>
      </div>
      <div class="w3-content" style="padding-bottom: 64px">
         <div>
            <b style="margin-right: 15px; display: inline-block">리뷰</b> <span>총
               <strong>${ccount}</strong>개의 관람 후기가 등록되었습니다.
            </span> <b>&nbsp;(★${staravg}) </b>
         </div>

         <hr>
         <form action="rewrite" method="post" name="f" onsubmit="return input_check(this)">
            <input type="hidden" name="msno" value="${msno}">
            <table style="width: 100%;" class="w3-table">
               <tr>
                  <th style="width: 8%; padding-top: 13px">내용</th>
                  <th width="63%"><input type="text" class="form-control"
                     name="content"></th>
                  <th style="width: 8%; text-align: center; padding-top: 13px">별점</th>
                  <th width="15%"><select class="form-control"
                     style="color: orange;" name="star">
                        <option style="color: orange" value="">☆☆☆☆☆</option>
                        <option style="color: orange" value="1">★☆☆☆☆&nbsp;<b>1</b></option>
                        <option style="color: orange" value="2">★★☆☆☆&nbsp;<b>2</b></option>
                        <option style="color: orange" value="3">★★★☆☆&nbsp;<b>3</b></option>
                        <option style="color: orange" value="4">★★★★☆&nbsp;<b>4</b></option>
                        <option style="color: orange" value="5">★★★★★&nbsp;<b>5</b></option>
                  </select></th>
                  <th style="width: 6%; text-align: center;"><input
                     type="submit" value="등록" class="btn btn-dark"></th>
               </tr>
            </table>
         </form>
         <table class="w3-table" style="margin-top: 20px">
            <tr class="w3-black">
               <th width="15%">작성자</th>
               <th width="40%">내용</th>
               <th width="20%">작성시간</th>
               <th width="19%">별점</th>
               <th width="6%"></th>
               <th style="width: 6%; text-align: center"></th>
            </tr>
            <tr>
               <th colspan="6" style="padding: 5px 0px; opacity: 0"><hr
                     style="margin: 0"></th>
            </tr>
            <c:forEach var="c" items="${clist}">
               <tr>
                  <td>${c.id}</td>
                  <td>${c.ccontent}</td>
                  <td><fmt:formatDate value="${c.cdate}" pattern="YYYY-MM-dd" /></td>
                  <c:choose>
                     <c:when test="${c.cstar ==1 }">
                        <td><p style="color: orange">
                              ★☆☆☆☆&nbsp;<b style="color: black">1</b>
                           </p></td>
                     </c:when>
                     <c:when test="${c.cstar ==2 }">
                        <td><p style="color: orange">
                              ★★☆☆☆&nbsp;<b style="color: black">2</b>
                           </p></td>
                     </c:when>
                     <c:when test="${c.cstar ==3 }">
                        <td><p style="color: orange">
                              ★★★☆☆&nbsp;<b style="color: black">3</b>
                           </p></td>
                     </c:when>
                     <c:when test="${c.cstar ==4 }">
                        <td><p style="color: orange">
                              ★★★★☆&nbsp;<b style="color: black">4</b>
                           </p>
                     </c:when>
                     <c:when test="${c.cstar ==5 }">
                        <td><p style="color: orange">
                              ★★★★★&nbsp;<b style="color: black">5</b>
                           </p></td>
                     </c:when>
                  </c:choose>
                  <td style="width: 6%; text-align: center;">
                     <form action="commdel?id=${c.id}&&msno=${msno}" method="post">
                        <input type="submit" value="삭제" class="btn btn-dark">
                     </form>
                  </td>
               </tr>
               <tr>
                  <th colspan="6" style="padding: 5px 0px"><hr
                        style="margin: 0"></th>
               </tr>
            </c:forEach>
            <tr>
               <td colspan="6" class="w3-center"><c:if test="${pageNum <= 1}">[이전]</c:if>
                  <c:if test="${pageNum > 1}">
                     <a href="reserInfoForm?pageNum=${pageNum}&&msno=${msno}">[이전]</a>
                  </c:if> <c:forEach var="a" begin="${startpage}" end="${endpage}">
                     <c:if test="${a == pageNum}">[${a}]</c:if>
                     <c:if test="${a != pageNum}">
                        <a href="reserInfoForm?pageNum=${a}&&msno=${msno}">[${a}]</a>
                     </c:if>
                  </c:forEach> <c:if test="${pageNum >= maxpage}">[다음]</c:if> <c:if
                     test="${pageNum < maxpage}">
                     <a href="reserInfoForm   ?pageNum=${pageNum + 1}&&msno=${msno}">[다음]</a>
                  </c:if></td>
            </tr>
         </table>
      </div>
   </div>
<script>


$(function(){
   window.onload = function() {
   buildCalendar();   
   // ajax 시간 정보
   let ty = today.getFullYear();
   let tm = ''+(today.getMonth()+1);
   if (tm.length < 2) {
      tm = '0'+tm;
   } else {
      tm = tm
   }
   let td = today.getDate();
   let to = ty+"-"+tm+"-"+td;
 
   $("#rebutton").click(function(){
      if($(".btn").hasClass("btn-danger") == false) {
         alert("시간을 선택해주세요.")
      }
   })
   if($("p").hasClass("today") === true) {
      const xhttp = new XMLHttpRequest();
      xhttp.open("GET","/project/reservation/calendar?dmd="+to+"&msno="+${mainlist[0].msno})
      xhttp.send()
      xhttp.onreadystatechange = function() {
      if(this.readyState == 4 && this.status == 200){
         document.querySelector("#ultime").innerHTML = this.responseText; 
         let time = null;
         $(".btn").click(function(){
            $(this).removeClass("btn-outline-danger")
            $(this).addClass("btn-danger");
            $(this).parent().siblings().find(".btn").removeClass("btn-danger")
            $(this).parent().siblings().find(".btn").addClass("btn-outline-danger")
            time = this.innerText;
            $("#rebutton").click(function(){
               if($(".btn").hasClass("btn-danger")) {
                  $(location).attr("href", "seatForm?dmd="+to+"&msno="+${mainlist[0].msno}+"&time="+time)
               }
            })
         })    
      }
   }
   }
   }// 웹 페이지가 로드되면 buildCalendar 실행

   let nowMonth = new Date(); // 현재 달을 페이지를 로드한 날의 달로 초기화
   let today = new Date(); // 페이지를 로드한 날짜를 저장
   today.setHours(0, 0, 0, 0); // 비교 편의를 위해 today의 시간을 초기화
  
   // 달력 생성 : 해당 달에 맞춰 테이블을 만들고, 날짜를 채워 넣는다.
   function buildCalendar() {
      let firstDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth(), 1); // 이번달 1일
      let lastDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, 0); // 이번달 마지막날
      let tbody_Calendar = document.querySelector(".Calendar > tbody");
      document.getElementById("calYear").innerText = nowMonth.getFullYear(); // 연도 숫자 갱신
      document.getElementById("calMonth").innerText = leftPad(nowMonth.getMonth() + 1); // 월 숫자 갱신

         while (tbody_Calendar.rows.length > 0) { // 이전 출력결과가 남아있는 경우 초기화
            tbody_Calendar.deleteRow(tbody_Calendar.rows.length - 1);
         }
         let nowRow = tbody_Calendar.insertRow(); // 첫번째 행 추가           
         for (let j = 0; j < firstDate.getDay(); j++) { // 이번달 1일의 요일만큼
            let nowColumn = nowRow.insertCell(); // 열 추가
         }
         for (let nowDay = firstDate; nowDay <= lastDate; nowDay.setDate(nowDay.getDate() + 1)) { 
         // day는 날짜를 저장하는 변수, 이번달 마지막날까지 증가시키며 반복  
         let nowColumn = nowRow.insertCell(); // 새 열을 추가하고
            let newDIV = document.createElement("p");
            newDIV.innerHTML = leftPad(nowDay.getDate()); // 추가한 열에 날짜 입력
            nowColumn.appendChild(newDIV);
            if (nowDay.getDay() == 6) { // 토요일인 경우
               nowRow = tbody_Calendar.insertRow(); // 새로운 행 추가
            }
            if (nowDay < today) { // 지난날인 경우
               newDIV.className = "pastDay";
         } else if (nowDay.getFullYear() == today.getFullYear() && nowDay.getMonth() == today.getMonth() && nowDay.getDate() == today.getDate()) { // 오늘인 경우         
            newDIV.className = "today";
            newDIV.onclick = function() {
               choiceDate(this);
               function choiceDate(newDIV) {      // 날짜 선택
                  if (document.getElementsByClassName("choiceDay")[0]) { // 기존에 선택한 날짜가 있으면
                  document.getElementsByClassName("choiceDay")[0].classList.remove("choiceDay");} // 해당 날짜의 "choiceDay" class 제거
                  newDIV.classList.add("choiceDay"); // 선택된 날짜에 "choiceDay" class 추가
               }
                  // ajax 시간 정보
                   let ty = today.getFullYear();
                   let tm = ''+(today.getMonth()+1);
                   if (tm.length < 2) {
                   		tm = '0'+tm;
                   } else {
                 		 tm = tm
                   }
                   let td = today.getDate();
                   let to = ty+"-"+tm+"-"+td;
                   const xhttp = new XMLHttpRequest();
                    xhttp.open("GET","/project/reservation/calendar?dmd="+to+"&msno="+${mainlist[0].msno})
                    xhttp.send()
                    xhttp.onreadystatechange = function() {
                  if(this.readyState == 4 && this.status == 200){
                     document.querySelector("#ultime").innerHTML = this.responseText; 
                        $(".btn").click(function(){
                        $(this).removeClass("btn-outline-danger")
                        $(this).addClass("btn-danger");
                        $(this).parent().siblings().find(".btn").removeClass("btn-danger")
                        $(this).parent().siblings().find(".btn").addClass("btn-outline-danger")
                        time = this.innerText;
                        $("#rebutton").click(function(){
                        	 // ajax 시간 정보
                            let ty = today.getFullYear();
                            let tm = ''+(today.getMonth()+1);
                            if (tm.length < 2) {
                            		tm = '0'+tm;
                            } else {
                          		 tm = tm
                            }
                            let td = today.getDate();
                            let to = ty+"-"+tm+"-"+td;
                           if($(".btn").hasClass("btn-danger")) {
                              $(location).attr("href", "seatForm?dmd="+to+"&msno="+${mainlist[0].msno}+"&time="+time)
                           	 console.log("rebutton"+to)
                           }
                        })
                     })    // button
                 }    
               }
            }    // function 끝
            } else { // 미래인 경우
               newDIV.className = "futureDay";
               newDIV.onclick = function() {
                  choiceDate(this);
                  let y = document.querySelector("#calYear").innerText;
                  let m = document.querySelector("#calMonth").innerText;
                  let d = this.innerText;
                  let to = y+"-"+m+"-"+d;
                  
            // ajax 시간 정보
            const xhttp = new XMLHttpRequest();
            xhttp.open("GET","/project/reservation/calendar?dmd="+to+"&msno="+${mainlist[0].msno})
            xhttp.send()
            xhttp.onreadystatechange = function() {
               if(this.readyState == 4 && this.status == 200){
                  document.querySelector("#ultime").innerHTML = this.responseText; 
                     let time = null;
                  $(".btn").click(function(){
                     $(this).removeClass("btn-outline-danger");
                     $(this).addClass("btn-danger");
                     $(this).parent().siblings().find(".btn").removeClass("btn-danger");
                     $(this).parent().siblings().find(".btn").addClass("btn-outline-danger");
                     time = event.target.textContent;
                     console.log(time)
                     $("#rebutton").click(function(){
                       		if($(".btn").hasClass("btn-danger")) {
                           		$(location).attr("href", "seatForm?dmd="+to+"&msno="+${mainlist[0].msno}+"&time="+time)
                        }
                     })
                  })    
               }
            }
         }
      }
   }
   function choiceDate(newDIV) {   // 이전달 버튼 클릭
      if (document.getElementsByClassName("choiceDay")[0]) { // 기존에 선택한 날짜가 있으면
         document.getElementsByClassName("choiceDay")[0].classList.remove("choiceDay"); // 해당 날짜의 "choiceDay" class 제거
      }
      newDIV.classList.add("choiceDay"); // 선택된 날짜에 "choiceDay" class 추가
   }
   function prevCalendar() {   // 이전달 버튼 클릭
      nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() - 1, nowMonth.getDate()); // 현재 달을 1 감소
      buildCalendar(); // 달력 다시 생성
   }
   // 다음달 버튼 클릭
   function nextCalendar() {
      nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, nowMonth.getDate()); // 현재 달을 1 증가
      buildCalendar(); // 달력 다시 생성
   }
   // input값이 한자리 숫자인 경우 앞에 '0' 붙혀주는 함수
   function leftPad(value) {
      if (value < 10) {
         value = "0" + value;
         return value;
      }
      return value;
   }
}
})
function input_check(f) {
    if (f.content.value.trim() == "") {
       alert("내용이 입력되지 않았습니다.");
          f.content.focus();
          return false;
    }
    if (f.star.value.trim() == "") {
       alert("별점이 입력되지 않았습니다.");
          f.star.focus();
          return false;
    }
    return true;
 }
</script>
</body>
</html>
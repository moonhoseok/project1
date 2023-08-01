<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>좌석 선택하기</title>

</head>
<body>
<form action="paymentForm" method="post" name="pf">
   <input type="hidden" value="${mainlist[0].msno}" name="msno">
   <div class="w3-black w3-padding-24"
      style="line-height: 1.8rem; font-size: 0.9rem">
      <div class="w3-content"
         style="display: flex; justify-content: space-between;">
         <div style="display: flex;">
            <div
               style="overflow: hidden; height: 80px; width: 80px; margin-right: 10px">
               <img alt="뮤지컬" src="../img/${mainlist[0].mpos}" style="width: 100%">
            </div>
            <div>
               <b>${mainlist[0].mtitle}</b><br>
               <ul style="list-style: none; padding: 0">
                  <li>장소: 블루스퀘어 신한카드홀</li>
                  <li>연령: ${mainlist[0].mage}</li>
               </ul>
            </div>
         </div>
         <div style="width: 1px; background-color: #555"></div>
         <div>
            <table>
               <tr>
                  <th>인원</th>
                  <td>
                     <select style="padding: 0px 10px; width: 100%" name="pcnt">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                     </select>
                  </td>
               </tr>
               <tr>
                  <td colspan="2" style="font-size: 0.8rem">ID 당 최대 3매 가능</td>
               </tr>
            </table>
         </div>
         <div style="width: 1px; background-color: #555"></div>
         <div>
            <ul style="list-style: none; padding: 0;">
               <li>공연 기간:&nbsp; ${mainlist[0].mdate}</li>
               <li>공연 시간:&nbsp; ${mainlist[0].mtime}</li>
               <li>선택 좌석:<input type="text" name="reseat" 
               style="font-weight: bold; font-size: 16px; margin-top: 3px;"
            id="li" readonly="true"></li>
            </ul>
         </div>
         <div style="width: 1px; background-color: #555"></div>
         <div>
            <table>
               <tr>
                  <td>다른 날짜 선택 &nbsp;</td>
                  <td><select style="width: 100%" name="chgday" id="chgday">
                        <option value="${param.dmd}" class="chkse">${param.dmd}</option>
                        <c:forEach var="i" items="${daylist}">
                           <option value="${i}">${i}</option>
                        </c:forEach>
                  </select></td>
               </tr>
               <tr>
                  <td>다른 시간 선택 &nbsp;</td>
                  <td><select style="width: 100%" id="chgti" name="chgti">
                        <option value="${param.time}" class="chkse">${param.time}</option>
                  </select></td>
               </tr>
            </table>
         </div>
      </div>
   </div>
   <div class="w3-content w3-padding-16">
      <div style="display: flex;">
         <div style="width: 75%; margin-bottom: 35px">
            <b
               style="display: block; text-align: center; padding-top: 25px; padding-bottom: 40px">SCREEN</b>
            <div
               style="width: 90%; height: 10px; background-color: #dee2e6; margin-bottom: 30px"></div>
            <table style="width: 90%; border-collapse: inherit;" id="seat-table" name="seat-table">

            </table>
         </div>
         <div
            style="line-height: 1.9rem; margin-top: 12vh; font-size: 0.9rem;">
            <div
               style="border: 1px solid #333; padding: 20px; border-radius: 5px; float: right">
               <b style="font-size: 1rem; display: block; padding: 5px 0px">좌석
                  등급/가격</b>
               <table>
                  <tr>
                     <td><font color="#D118B">■</font>&nbsp;</td>
                     <td>VIP석 &nbsp;&nbsp;&nbsp;</td>
                     <td>150,000원</td>
                  </tr>
                  <tr>
                     <td><font color="#FFC000">■</font></td>
                     <td>R석</td>
                     <td>130,000원</td>
                  </tr>
                  <tr>
                     <td><font color="#92D050">■</font></td>
                     <td>S석</td>
                     <td>100,000원</td>
                  </tr>
                  <tr>
                     <td><font color="#4472C4">■</font></td>
                     <td>A석</td>
                     <td>70,000원</td>
                  </tr>
               </table>
            </div>
            <button type="submit" class="w3-button w3-black w3-margin-top" id="bb"
               style="width: 74%; border-radius: 5px; padding: 4px; float: right">
               결제하기
            </button>
         </div>
      </div>
   </div>
</form>
<style type="text/css">
#seat-table tr {
   height: 7vh;
}

#seat-table tr button {
   height: 7vh;
   width: 70%;
   margin: 0 auto;
   margin-bottom: 15px;
   border-radius: 35px 35px 5px 5px
}
.chkse {
   display: none;
}
.clickdiv {
   background-color: gray;
}
</style>
   <script>
$(function(){
   window.onload=function(){
      
      const xhttp = new XMLHttpRequest();
      xhttp.open("GET","/project/reservation/day?dmd=${param.dmd}&msno="
            +${mainlist[0].msno})
      xhttp.send()
      xhttp.onreadystatechange = function() {
            if(this.readyState == 4 && this.status == 200){
               document.querySelector("#chgti").innerHTML = this.responseText;
                  /*let i = 0;
                  let sum = 0
                  let a = $("select[name=pcnt]").val()
                  $(".btn").click(function(){
                     i++;
                    sum = i;
                    console.log(sum)
                    if($("select[name=pcnt]").val() < i) {
                       alert("선택하신 인원을 초과하셨습니다.")
                    } else {
                       $(this).removeClass();
                       $(this).addClass("btn btn-secondary");
                       document.querySelector("#li").innerHTML += ($(this).val()+",");
                    }
                    
                 })*/
            }
      }
      const xhttp2 = new XMLHttpRequest();
      xhttp2.open("GET","/project/reservation/seat?dmd=${param.dmd}&msno="
            +${mainlist[0].msno}+"&time=${param.time}")
      xhttp2.send()
      xhttp2.onreadystatechange = function() {
            if(this.readyState == 4 && this.status == 200){
               document.querySelector("#seat-table").innerHTML = this.responseText;
               let i = 0;
               let sum = 0
               let a = $("select[name=pcnt]").val()
               $(".btn").click(function(){
                  i++;
                 sum = i;
                 console.log(sum)
                 if($("select[name=pcnt]").val() < i) {
                	 i-=1;
                    alert("선택하신 인원을 초과하셨습니다.")
                 } else {
                    $(this).removeClass();
                    $(this).addClass("btn btn-secondary");
                    let seat = $(this).val();
                    document.pf.reseat.value += (seat+",")
                 }
                 
              })
              
               }      
            }
      
   }
      $(document).on("change", "#chgday", function(){
      let day = this.value;
      const xhttp = new XMLHttpRequest();
      xhttp.open("GET","/project/reservation/day?dmd="+day+"&msno="+${mainlist[0].msno})
      xhttp.send()
      xhttp.onreadystatechange = function() {
            if(this.readyState == 4 && this.status == 200){
               document.querySelector("#chgti").innerHTML = this.responseText;
                  let i = 0;
                  let sum = 0
                  let a = $("select[name=pcnt]").val()
                  $(".btn").click(function(){
                     console.log($(this).val())
                     i++;
                    sum = i;
                    if($("select[name=pcnt]").val() < i) {
                    	i-=1;
                       alert("선택하신 인원을 초과하셨습니다.")
                    } else {
                       $(this).removeClass();
                       $(this).addClass("btn btn-secondary");
                       document.querySelector("#li").value += ($(this).val()+",");
                    }
                 })
               }      
            } 
      })
      $(document).on("change", "#chgti", function(){
         let day = $("#chgday option:selected").val();
         let time = this.value;
         const xhttp = new XMLHttpRequest();
         xhttp.open("GET","/project/reservation/seat?dmd="+day+"&msno="
               +${mainlist[0].msno}+"&time="+time)
         xhttp.send()
         xhttp.onreadystatechange = function() {
               if(this.readyState == 4 && this.status == 200){
                  document.querySelector("#seat-table").innerHTML = this.responseText;
                     let i = 0;
                     let sum = 0
                     let a = $("select[name=pcnt]").val()
                     $(".btn").click(function(){
                        console.log($(this).val())
                        i++;
                       sum = i;
                       if($("select[name=pcnt]").val() < i) {
                          alert("선택하신 인원을 초과하셨습니다.")
                          i-=1;
                       } else {
                          $(this).removeClass();
                          $(this).addClass("btn btn-secondary");
                          document.querySelector("#li").innerHTML += $(this).val();
                       }
                    })
                 
                  }      
               }
      })
})
</script>
</body>
</html>
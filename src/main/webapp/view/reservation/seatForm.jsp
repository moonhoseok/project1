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
                     <select name="pcnt" onchange="pcntFunc(this)"
                     style="padding: 0px 10px; width: 100%" id="pcnt">
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
               <li>선택 좌석:&nbsp; <input type="text" name="reseat" value=""
               style="font-weight: bold; font-size: 16px; margin-top: 3px;"
            id="li" readonly="true"></li>
            </ul>
         </div>
         <div style="width: 1px; background-color: #555"></div>
         <div>
            <table>
               <tr>
                  <td>다른 날짜 선택 &nbsp;</td>
                  <td><select onchange="changeDay(this)" name="dmd"
                  style="width: 100%" name="chgday" id="chgday">
                        <option value="${param.dmd}" class="chkse">${param.dmd}</option>
                        <c:forEach var="i" items="${daylist}">
                           <option value="${i}">${i}</option>
                        </c:forEach>
                  </select></td>
               </tr>
               <tr>
                  <td>다른 시간 선택 &nbsp;</td>
                  <td><select onchange="changeTime(this)"
                  style="width: 100%" id="chgti" name="time">
						<c:if test="${param.dmd == dmd.value}">
						 <option value="${param.time}" class="chkse">${param.time}</option>
	                        <c:forEach var="t" items="${timelist}">
	                        	<c:if test="${!empty t}">
	                        		<option value="${t}">${t}</option>
	                        	</c:if>
	                        </c:forEach>
						</c:if>
						<c:if test="${param.time != dmd.value}">
                  			<c:forEach var="t" items="${timelist}">
                  				<c:if test="${!empty t}">
	                        		<option value="${t}">${t}</option>
	                        	</c:if>
                       		</c:forEach>
                  		</c:if>
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
            <button class="w3-button w3-black w3-margin-top" id="submitBtn"
               style="width: 74%; border-radius: 5px; padding: 4px; float: right"
              disabled="disabled">
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
	let dmd
	let msno = ${mainlist[0].msno}
	let time
	let minu
	window.onload=function(){
		
		let year = ${param.dmd.substring(0,4)}
		let mon = ${param.dmd.substring(5,7)}
		let day = ${param.dmd.substring(8,10)}
		if (mon.toString().length < 2) {
			mon = "0"+mon
		}
		if (day.toString().length < 2) {
			day = "0"+day
		} 
		let hour = ${param.time.substring(0,2)}
		minu = ${param.time.substring(3,5)}
		console.log("1) " + minu)
		if(minu == 0) {
			minu = "0"+minu.toString()
		}
		if (hour.toString().length < 2) {
			hour = "0"+hour
		}
		dmd = year+"-"+mon+"-"+day;
		time = hour+":"+minu
		console.log("minu: "+minu)
		console.log("dmd: "+ dmd+ ", msno: "+msno+", time: "+time)
		
		ajax(dmd, msno, time);
		
	}
	// 좌석 정보 불러오기
	function ajax(dmd,msno,time) {
		$.ajax({
			url:"/project/reservation/seat",
			type:"GET",
			data: "dmd="+dmd+"&msno="+msno+"&time="+time,
			success : function(data) {
				document.querySelector("#seat-table").innerHTML = data;
				let pcnt = $("select[name=pcnt]").val()
				btnFunc()
			}
		})
	}
	
	//날짜 변경  
	function changeDay(cd) {
		let paramtime = $("#chgti option:selected").val();
		time = document.pf.time.value.substring(0,2)+":"+document.pf.time.value.substring(3,5)
		dmd = $(cd).val()
		console.log("[day] dmd:"+dmd+", msno: "+msno+", tiem: "+time);
		$.ajax({
			url : "/project/reservation/seatForm",
			type: "GET",
			data: "dmd="+dmd+"&msno="+msno+"&time="+time,
			success : function(result) {
				console.log("성공")
				var option_time = $("select[name=time]").html(result).find('#chgti>option');
				$("#chgti").html(option_time);
				
				let time = $("#chgti option:selected").val();
				ajax(dmd, msno, time)
			}
		})
	}
	
	// 시간 변경
	function changeTime(chgtime) {
		dmd = $("#chgday option:selected").val();
		let chgti = $(chgtime).val();
		time = chgti.substring(0,2)+":"+chgti.substring(3,5);
		console.log("[time] dmd:"+dmd+", msno: "+msno+", tiem: "+time);
		ajax(dmd, msno, time)
	}
	
	
	let pcnt = $("select[name=pcnt]").val()
	// 인원 수 변경 시
	function pcntFunc(pcntval) {
		pcnt = $(pcntval).val();
	}
	
	// 버튼
	let reseatVal = "";
    let i = 0;
	let btnFunc = function () {
		$(".btn").click(function(){
			let cnt;
			let seatNum = $(this).val();
		
			if(i < pcnt) {
			
				$("#submitBtn").attr("disabled",false);
				
				if(seatNum <= 5) {
					if($(this).hasClass("btn-danger")== true) {
						$(this).removeClass();
						$(this).addClass("btn btn-secondary");
						i++;
					} else if ($(this).hasClass("btn-danger") == false) {
						$(this).removeClass();
						$(this).addClass("btn btn-danger");
						i--;
					}
				} else if (seatNum <= 10) {
					if($(this).hasClass("btn-warning")== true) {
						$(this).removeClass();
						$(this).addClass("btn btn-secondary");
						i++;
					} else if ($(this).hasClass("btn-warning") == false) {
						$(this).removeClass();
						$(this).addClass("btn btn-warning");
						i--;
					}
				} else if (seatNum <= 15) {
					if($(this).hasClass("btn-success")== true) {
						$(this).removeClass();
						$(this).addClass("btn btn-secondary");
						i++;
					} else if ($(this).hasClass("btn-success") == false) {
						$(this).removeClass();
						$(this).addClass("btn btn-success");
						i--;
					}
				} else if (seatNum <= 20) {
					if($(this).hasClass("btn-primary")== true) {
						$(this).removeClass();
						$(this).addClass("btn btn-secondary");
						i++;
					} else if ($(this).hasClass("btn-primary") == false) {
						$(this).removeClass();
						$(this).addClass("btn btn-primary");
						i--;
					}
				}
				// 좌석 정보
			  	if(reseatVal.includes(seatNum) == false) {
			  		if(reseatVal.length == 0) {
						reseatVal += seatNum
					} else {
						reseatVal += ","+seatNum
					}
				} else if(reseatVal.includes(seatNum) == true) {
				  	if(reseatVal.length == 1) {
				  		reseatVal = reseatVal.replace(seatNum, "");
					} else {
						if(reseatVal.indexOf(seatNum) == 0) {
							reseatVal = reseatVal.replace(seatNum+",", "");
						}
						reseatVal = reseatVal.replace(","+seatNum, "");
					}
				}
			} else if (i == pcnt) {
				alert("선택하신 인원을 초과하였습니다.");
			} 
			document.pf.reseat.value = reseatVal;
				
		})	// btn function
	} // btnFunc 마지막
	

</script>
</body>
</html>
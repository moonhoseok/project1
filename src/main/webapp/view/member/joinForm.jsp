<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>회원가입</title>
</head>
<body>
<style>
   table tr:nth-child(5) select {text-align: center}
</style>
   <div class="w3-content w3-padding-64" style="max-width: 600px">
      <h2 class="w3-center">JOIN</h2>
      <form action="join" method="post" name="f"
         onsubmit="return input_check(this)">
         <input type="hidden" name="chkm" value="1" id="chkm">
         <input type="hidden" name="chkid" value="1" id="chkid">
         <input type="hidden" name="jF" value="1" id="jF">
         <table class="w3-table">
            <tr>
               <td colspan="3" width="80%"><input type="text" name="id" 
                  placeholder="ID를 입력해주세요" class="form-control" value="${param.id}"> <c:if
                     test="${dbMem != null}">
                     <p>${msg}</p>
                  </c:if> <c:if test="${dbMem == null}">
                     <p>${msg}</p>
                  </c:if></td>
               <td width="20%"><button type="button" onclick="idchk()"
                     class="btn btn-dark" style="width: 100%">중복확인</button></td>
            </tr>
            <tr>
               <td colspan="4"><input type="password" name="pass" value="${param.pass}"
                  placeholder="비밀번호 8~16자 숫자,영어 포함" class="form-control" maxlength="12"></td>
            </tr>
            <tr>
               <td colspan="4"><input type="password" name="chkpass" value="${param.chkpass}"
                  placeholder="비밀번호 재확인" class="form-control" maxlength="12"></td>
            </tr>
            <tr>
               <td colspan="4"><input type="text" name="name"
                  placeholder="이름" class="form-control"  value="${param.name}"></td>
            </tr>
            <tr>
               <td width="33%" colspan="2">
                  <select class="form-control" name="year">
                       <option value="">태어난 년도</option>
                     <c:forEach var="i" begin="1980" end="2010">
                        <option value="${i}">${i}</option>
                     </c:forEach>
                  </select>
                  <script>
                         document.f.year.value='${param.year}'
                  </script>
               </td>
               <td width="33%">
                  <select class="form-control" name="month">
                     <option value="">태어난 월</option>
                     <c:forEach var="i" begin="1" end="12">
                        <c:if test="${i<10}">
                           <option value="0${i}">0${i}</option>
                        </c:if>
                        <c:if test="${i>=10}">
                           <option value="${i}">${i}</option>
                        </c:if>
                     </c:forEach>
                  </select>
                  <script>
                   document.f.month.value='${param.month}'
                  </script>
               </td>
               <td colspan="2" width="34%">
                  <select class="form-control" name="day">
                     <option value="">태어난 일</option>
                     <c:forEach var="i" begin="1" end="31">
                        <c:if test="${i<10}">
                           <option value="0${i}">0${i}</option>
                        </c:if>
                        <c:if test="${i>=10}">
                           <option value="${i}">${i}</option>
                        </c:if>
                     </c:forEach>
                  </select>
               <script>
                   document.f.day.value='${param.day}'
               </script>                  
               </td>
            </tr>
            <tr>
               <td colspan="4"><input type="text" name="tel" value="${param.tel }"
                  placeholder="-을 포함한 전화번호 10자리 또는 11자리" class="form-control">
               </td>
            </tr>
            <tr>
               <td colspan="4">성별 &nbsp; <input type="radio" name="gender"
                  value="1" <c:if test='${param.gender==1 }'>checked</c:if>>남 &nbsp; <input type="radio" name="gender"
                  value="2" <c:if test='${param.gender==2 }'>checked</c:if>>여
            </tr>
            <tr>
               <td width="39%"><input type="text" name="email" id="email" 
                  class="form-control" value="${param.email}" placeholder="email"></td>
               <td width="2%">@</td>
               <td width="39%"><select class="form-control" name ="com" id="com">
                     <option value="">주소를 선택하세요</option>
                     <option value="naver.com">naver.com</option>
                     <option value="nate.com">nate.com</option>
                     <option value="gmail.com">gmail.com</option>
               </select></td>
               <script>
                   document.f.com.value='${param.com}'
               </script>                  
               <td width="20%">
<%--                   <button type="button" onclick="mail_check(this.form.email.value, this.form.com.value)" class="btn btn-dark" --%>
                  <button type="button" onclick="mail_check(this.form)" class="btn btn-dark"
                     style="width: 100%">인증하기</button>
               </td>
            </tr>
            <tr>
               <td colspan="3" width="80%"><input type="text"
                  placeholder="인증 번호를 입력해주세요" class="form-control" name="emailchk" value="${param.emailchk}">
               </td>
               <td width="20%">
                   <button type="button" onclick="code_check(this.form.emailchk.value)" class="btn btn-dark"
                     style="width: 100%">번호확인</button> 
            </tr>
         </table>
         <div class="w3-center" style="margin-top: 20px">
            <button type="submit" class="btn btn-dark" id="jobutton">회원가입</button>
            <button type="reset" class="btn btn-outline-dark">다시 작성</button>
         </div>
      </form>
   </div>
   <script>  
      $(function(){
         $("input[name=mail]").on('keyup', function(event){
           if (!(event.keyCode >=37 && event.keyCode<=40)) { 
             var inputVal=$(this).val();

             $(this).val(inputVal.replace(/[^a-z0-9@_.-]/gi,''));  
           } 
         });
      });
       function code_check(emailchk){
          if (document.f.emailchk.value == "") {
            alert("인증번호를 입력하세요");
            f.emailchk.focus();
         }else{
            let data = ${content}
            if(document.f.emailchk.value == data){
               alert("인증확인")
               document.getElementById("chkm").value = "2";
            }else{
               alert("인증번호 오류")
               document.getElementById("chkm").value = "1";
            }
         }
      } 
       function mail_check(f){
           let mail =document.f.email.value
           let com =document.f.com.value
          if (mail == "") {
             alert("이메일을 입력하세요");
             f.email.focus();
          }else{
             alert(mail+"@"+com+"님 이메일전송")
             let jF = document.f.jF.value
             f.action="mailSend?f="+jF;
             f.submit()
          }
       }    
      function input_check(f) {
         if (f.id.value.trim() == "") {
            alert("아이디가 입력되지 않았습니다.");
            f.id.focus();
            return false;
         }
         if (f.pass.value.trim() == "") {
            alert("비밀번호가 입력되지 않았습니다.");
            f.pass.focus();
            return false;
         }
         if (f.chkpass.value.trim() == "") {
            alert("비밀번호를 다시 입력해주세요.");
            f.chkpass.focus();
            return false;
         }
         if (f.name.value.trim() == "") {
            alert("이름이 입력되지 않았습니다.");
            f.name.focus();
            return false;
         }
         if (f.year.value.trim() == "") {
            alert("생년월일이 입력되지 않았습니다.");
            f.year.focus();
            return false;
         }
         if (f.day.value.trim() == "") {
            alert("생년월일이 입력되지 않았습니다.");
            f.day.focus();
            return false;
         }
         if (f.tel.value.trim() == "") {
            alert("전화번호가 입력되지 않았습니다.");
            f.tel.focus();
            return false;
         }
         if (f.gender.value.trim() == "") {
            alert("성별을 선택해주세요.");
            return false;
         }
         if (f.email.value.trim() == "") {
            alert("이메일을 입력해주세요.");
            f.email.focus();
            return false;
         }
         if (f.emailchk.value.trim() == "") {
            alert("인증번호를 입력해주세요.");
            f.emailchk.focus();
            return false;
         }
         if (f.chkm.value.trim() == "1") {
            alert("인증번호를 확인하세요.");
            f.emailchk.focus();
            return false;
         }
         if (f.chkid.value.trim() == "1") {
             alert("아이디 중복확인 해주세요.");
             f.emailchk.focus();
             return false;
          }
         if (f.pass.value.trim() != f.chkpass.value.trim() ) {
             alert("비밀번호가 일치하지 않았습니다.");
             f.chkpass.focus();
             return false;
          }
         if (f.pass.value.length < 6) {
             alert("비밀번호 6자리 이상 입력하세요.");
             f.pass.focus();
             return false;
          }
         return true;
      }
      function win_open(page) {
         let op = "width=500, height=400, left=50, top=150";
         open(page, "", op)
      }
      function idchk() {
         if (document.f.id.value == "") {
            alert("아이디를 입력하세요");
            f.id.focus();
         }else{
           document.getElementById("chkid").value = "2";
            let op = "width=350, height=350, left=50, top=150"
               open("idchk?id="+document.f.id.value,"",op)
            }
      }
   </script>
</body>
</html>
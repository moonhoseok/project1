<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta charset="UTF-8">
<title>이메일 변경</title>
</head>
<body>
   <div class="w3-content w3-padding-64" style="max-width: 600px">
      <h2 class="w3-center">이메일 변경</h2>
      <form action="email" method="post" name="f" onsubmit="return input_check(this)">
         <input type="hidden" name="chkm" value="1" id="chkm">
         <input type="hidden" name="eF" value="2" id="eF">
         <table class="w3-table">
            <tr>
               <td><input type="text" name="email"
               value="${param.email}"
                  class="form-control" placeholder="이메일을 입력하세요"></td>
               <td>@</td>
               <td><select class="form-control" name ="com" id="com">
                     <option>주소를 선택하세요</option>
                     <option value="naver.com">naver.com</option>
                     <option value="nate.com">nate.com</option>
                     <option value="gmail.com">gmail.com</option>
               </select></td>
               <script>
                   document.f.com.value='${param.com}'
               </script>   
               <td>
                  <button type="button" onclick="mail_check(this.form)" class="btn btn-dark"
                     style="width: 100%">인증하기</button>
               </td>
            </tr>
            <tr>
               <td colspan="3"><input type="text" placeholder="인증 번호를 입력해주세요"
                  class="form-control" name="emailchk"></td>
               <td>
                  <button type="button" onclick="code_check(this.form.emailchk.value)" class="btn btn-dark"
                     style="width: 100%">번호확인</button>
            </tr>
         </table>

         <div class="w3-center" style="margin-top: 20px">
            <button type="submit" class="btn btn-dark">수정</button>
         </div>
      </form>
   </div>
   <script>
     $(function(){
         $('input[name=email]').on('keyup', function(event){
           if (!(event.keyCode >=37 && event.keyCode<=40)) { 
             var inputVal=$(this).val();

             $(this).val(inputVal.replace(/[^a-z0-9@_.-]/gi,''));  
           } 
         });
       });
     
      function code_check(emailchk) {
         if (document.f.emailchk.value == "") {
            alert("인증번호를 입력하세요");
            f.emailchk.focus();
         } else {
            let data = ${content}
            if (document.f.emailchk.value == data) {
               alert("인증확인")
               document.getElementById("chkm").value = "2";
            } else {
               alert("인증번호 오류")
               document.getElementById("chkm").value = "1";
            }
         }
      }
      function mail_check(f) {
         let mail = document.f.email.value
         if (mail == "") {
            alert("이메일을 입력하세요");
            f.email.focus();
         } else {
            alert(mail + "님 이메일전송")
            let eF = document.f.eF.value
            f.action = "mailSend?f="+eF;
            f.submit()
         }
      }
      function input_check(f) {
         if (f.email.value.trim() == "") {
            alert("이메일이 입력되지 않았습니다.");
            f.email.focus();
            return false;
         }
         if (f.emailchk.value.trim() == "") {
            alert("인증번호가 입력되지 않았습니다.");
            f.emailchk.focus();
            return false;
         }
      }
   </script>
</body>
</html>
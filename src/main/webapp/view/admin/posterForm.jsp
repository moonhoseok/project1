<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뮤지컬 포스터 등록</title>
</head>
<body>
	<div class="container">
		<h3>사진 업로드</h3>
		<table class="table">
			<tr>
				<td><img id="preview" src=""></td>
			</tr>
			<tr>
				<td>
					<form action="poster" method="post" enctype="multipart/form-data">
						<input type="file" name="poster" id="imageFile" accept="img/*">
						<input type="submit" value="사진등록">
					</form>
				</td>
			</tr>
		</table>
	</div>
<script>
	// 업로드 전에 이미지를 화면에 나타내 미리 확인
	let imagefile = document.querySelector("#imageFile"); 
	let preview = document.querySelector("#preview");	
	imagefile.addEventListener("change", function(e) {	
		let get_file = e.target.files;
		// 이벤트가 발생돼서 선택 된 파일
		let reader = new FileReader();
		// 자바스크립트에선 스트림정도로 생각 - 파일을 읽기 위한 스트림
		reader.onload = (function (Img) {	// 여기 img랑 Img <= preview 저장	|| 3.읽으면 onload 이벤트가 실행
		// 파일 객체가 준비가 되면 img를 집어 넣어서
			return function(e) {											// 4. 이벤트가 실행되면 
				Img.src = e.target.result;	// 여기 img랑 대소문자 같아야함
				// 선택된 파일의 파일 명을 function(Img)의 src에 넣어라 	
		}
		}) (preview);														// (preview) 실행...
		if(get_file) {	
		// 1. get_file: 선택 된 파일이 있다면, 
			reader.readAsDataURL(get_file[0]); // 2. 선택된 파일의 첫번째를 읽어 =>  
		}
	});
</script>
</body>
</html>
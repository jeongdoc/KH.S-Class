<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="memberError.jsp"%>
<%
	String keycode = (String)session.getAttribute("keycode");
%>
<!DOCTYPE html>
<html id='admitbody'>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/doggybeta/resources/css/member/enroll.css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type='text/javascript' src='/doggybeta/resources/js/jzCheckAdmitJS.js'></script>
</head>
</head>
<body>
<section id='bodystyle'>
<!-- <h2>회원가입페이지</h2><br> -->
	<div id='tb'>
	<h1 id='maintitle'>Create a new Account!</h1>
	<img id='doglogo' src='/doggybeta/resources/images/로고test2.png'>
	<form action="/doggybeta/resistenroll" method="post">
		<span class='first_span'>
			<input type="text" name="userid" class='mainInputForm inputForm' id="userid" required onclick='getValue();'/>
				<label class='inputLabel labelJeong' for='userid' data-content='*아 이 디'>
					<span class='input_span span_second_jeong'>*아 이 디</span>
				</label>
		</span>
		<input type='button' id='chkId' onclick="return checkid();" value='중복&#x00A;확인'>
		
		<span class='first_span'>
			<input type="text" name="username" class='mainInputForm inputForm' required id='username'/>
				<label class='inputLabel labelJeong' for='username' data-content='*이 름'>
					<span class='input_span span_second_jeong'>*이 름</span>
				</label>
		</span>
		<span class='first_span'>
			<input type='email' name='email' id='email' class='mainInputForm inputForm' required placeholder='이메일 입력후 전송버튼을 눌러주세요'/>

				<label class='inputLabel labelJeong' for='email' data-content='*이 메 일'>
					<span class='input_span span_second_jeong'>*이 메 일</span>
				</label>
		</span>
		<input type='submit' id='sendbtn' onclick='return admit();' value='전송'/>
		
		<span class='first_span'>
			<input type='text' name='number' id='number' class='mainInputForm inputForm' placeholder='인증번호를 입력해주세요' required/>
				<label class='inputLabel labelJeong' for='number' data-content='*인 증 번 호 입 력'>
					<span class='input_span span_second_jeong'>* 인 증 번 호 입 력</span>
				</label>
		</span>
		<input type='button' id='btnok' onclick='return confirmNum();' value='확인'/>
		
		<span class='first_span'>
			<input type="password" name="userpwd" id="userpwd1" class='mainInputForm inputForm' required placeholder='비밀번호를 입력해주세요'/>
				<label class='inputLabel labelJeong' for='userpwd1' data-content='*비 밀 번 호'>
					<span class='input_span span_second_jeong'>*비 밀 번 호</span>
				</label>
		</span>
		<span class='first_span'>
			<input type="password" name="userpwd" id="userpwd2" class='mainInputForm inputForm' required/>
				<label class='inputLabel labelJeong' for='userpwd2' data-content='*비 밀 번 호 확 인'>
					<span class='input_span span_second_jeong'>*비 밀 번 호 확 인</span>
				</label>
		</span>
		<span class='first_span'>
			<input type='tel' name='phone' id='phone' class='mainInputForm inputForm'/>
				<label class='inputLabel labelJeong' for='phone' data-content='전 화 번 호'>
					<span class='input_span span_second_jeong'>전 화 번 호</span>
				</label>
		</span>
		<input type="submit" value="가입하기" id='signupbtn'/>
		<input type="reset" value="작성취소"/><br>
		<p id='nes'>* 표시 항목은 필수입력 항목입니다.</p>
		<a href="/doggybeta/index.jsp">시작 페이지로</a>
	</form>
	</div>
</section>
<input type='hidden' id='number2' class='mainInputForm inputForm'/>
</body>
</html>
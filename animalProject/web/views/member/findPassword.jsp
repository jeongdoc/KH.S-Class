<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import='member.model.vo.Member' %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	String message = (String)request.getAttribute("message");
%>
<!DOCTYPE html>
<html id='findPinHtml'>
<head>
<meta charset="UTF-8">
<title>도그하우스</title>
<link rel="stylesheet" href="/doggybeta/resources/css/member/findPin.css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function () {
		$('#btnSend').click(function() {
			var userId = $('#userid').val();
			var useremail = $('#email').val();
			
			var data = "userid="+userId+"&email="+useremail;
			
			$.ajax({
				type: 'post',
				data: {userid : userId, email : useremail },
				url: '/doggybeta/jipsafindpwd',
				success: function(result) {
					var obj = decodeURIComponent(result.str);
					
					alert(obj);
				}//success
				,
				error: function(jqXHR, textStatus, errorThrown) {
					console.log("error : "+jqXHR+","+textStatus+","+errorThrown);
				}
			});//ajax
		});//btn
	});
</script>
</head>
<body>
<form action='/doggybeta/jipsafindpwd'>
<div id='tb'>
<img id='doglogo' src='/doggybeta/resources/images/로고test2.png'>
<h3> 비밀번호를 잊으셨나요? </h3>
	<span class='first_span'>
		<input type="text" name="userid" class='mainInputForm inputForm' id="userid" required placeholder='아이디를 입력해주세요' />
			<label class='inputLabel labelJeong' for='userid' data-content='*아 이 디'>
				<span class='input_span span_second_jeong'>*아 이 디</span>
			</label>
	</span>
	<span class='first_span'>
		<input type='email' name='email' id='email' class='mainInputForm inputForm' required placeholder='이메일 입력후 전송버튼을 눌러주세요'/>
			<label class='inputLabel labelJeong' for='email' data-content='*이 메 일'>
				<span class='input_span span_second_jeong'>*이 메 일</span>
			</label>
	</span>
	<input type='submit' value='전송' id='btnSend'/>
	<p>※전송버튼을 누르면 임시비밀번호 발급메일이 발송됩니다.</p>
</div>
</form>
</body>
</html>
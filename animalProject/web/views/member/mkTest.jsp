<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon.ico">
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<body>
<%@ include file="../common/menu.jsp"%>
	<div id="wrap">
		  <div id="content">
<header>
회원정보변경
</header>

<div class="top">
회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 확인합니다.
<div id="userid">
아이디 <%=loginUser.getUserId() %>
<br>
비밀번호 
<input type="password" id="password">
</div>

</div>

<div class="bottom">
<input type="submit" value="확인">
<button onclick="location.href='/doggybeta/'"></button>
</div>

</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
</div>

</body>
</html>
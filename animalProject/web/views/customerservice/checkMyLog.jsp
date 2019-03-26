<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>이용내역/예약 확인</title>
	<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="/doggybeta/resources/css/checkMyLog.css">
</head>

<body>
	<%@ include file="..//common/menu.jsp" %>
	<input type="hidden" name="userid" value="<%=loginUser.getUserId() %>">
	<div class="wrap_content">
		<!-- section1 - 변경 버튼's -->
		<div class="section1">
			<input type="radio" name="item" id="cml_booking" value="booking" checked>
			<input type="radio" name="item" id="cml_host" value="host">

			<ul class="navigation__list">
				<li class="navigation__item"><label for="cml_booking" class="item__icon"><span class="icon__emoji"><img
								src="/doggybeta/resources/images/dog.png"></span></label><span
						class="item__text">예약/결제내역</span></li>
				<li class="navigation__item"><label for="cml_host" class="item__icon"><span class="icon__emoji"><img
								src="/doggybeta/resources/images/dog2.png"></span></label><span class="item__text">
									호스트 서비스</span></li>
				<li class="navigation__item"><label class="item__icon"><span class="icon__emoji"><img
								src="/doggybeta/resources/images/dog3.png"></span></label><span
						class="item__text">마이펫 등록</span></li>
			</ul><span class="icon__emoji">
		</div>
		<div class="section2">section2 - 페이지 내용 헤더</div>
		<div class="section3">section3 - 알람 정보</div>
		<!-- section4 - 예약/결제내역/내정보 수정 등의 메인 섹션 -->
		<div class="section4">
			<table id="reserv_table">
				<thead>
					<tr>
						<th>예약번호</th>
						<th>서비스 종류</th>
						<th>강아지 이름</th>
						<th>주소</th>
						<th>가격</th>
						<th>펫시터</th>
						<th>이용날짜</th>
						<th>진행상황</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
			<div class="host_main">
				<div class="host_table">
					<table>
						<thead>
							<tr>
								<th>예약번호</th>
								<th>서비스 종류</th>
								<th>이름</th>
								<th>요구사항/특징</th>
								<th>이용날짜</th>
								<th>총 가격</th>
								<th>진행 상황</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
				<div class="host_side1">
					<div class="host_map" id="host_map"></div>
					<p id="addr_text"></p>
				</div>
				<div class="host_side2">
					<%if(loginUser.getPetSitter().equals("1")){ // 승인 대기중인 회원 페이지 %>
					<span>
						<p><%= loginUser.getUserName()%>님의 승인 신청이 완료되었습니다.</p>
						<p>현재 승인 대기 상태이며, 24시간 이내에 승인여부를 확인하실 수 있습니다.</p>
					</span>
					<%} else if (loginUser.getPetSitter().equals("2")){ // 호스트인 회원 페이지 %>
					<span>
						<p><%= loginUser.getUserName() %> 호스트님 환영합니다.</p>
						<p>귀여운 강아지들이 <%= loginUser.getUserName() %>님을 기다리고 있습니다!</p>
					</span>
					<%} else { // 일반 회원 페이지%>
					<span>
						<p><%=loginUser.getUserName()%>님 안녕하세요</p>
						<p>호스트 신청을하여 귀여운 강아지들을 만나보세요!</p>
						<button>펫시터 신청</button>
					</span>
					<%} %>
				</div>
			</div>
		</div>
		<div class="section5">section5 - 페이징 변경 섹션</div>
	</div>
	<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	<script src="/doggybeta/resources/js/checkMyLog.js"></script>
	<script src="/doggybeta/resources/js/hmap.js"></script>
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import='member.model.vo.Member' %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	String access_token = (String)session.getAttribute("access_token");
%>
<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/doggybeta/resources/css/psForm.css">
<link href='/doggybeta/resources/css/member/login.css' rel='stylesheet' type='text/css'>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />

<link href="/doggybeta/resources/css/mainV2.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script type="text/javascript">
	 $(function() {
 		$('.login-form').hide();
		 
		$('.btn').click(function() {
			$('body').append('<div id="mask"></div>');
		    $('#mask').fadeIn(300);
		    $('.login-form').fadeIn(300);
			$('.login-form').show();
			
		    $('#mask').click(function() {
		    	$('#mask, .login-form').fadeOut(300);
		    });
		    
		});
	});

</script>
<style>
</style>

</head>

<body>

	<% if(loginUser == null) { %>

	<input type='checkbox' id='menu_state' checked />
	<div id='mask'> </div>
	<nav>
		<ul class='doghouse'>
			<li><a><span>doghouse</span></a></li>
		</ul>
		<span class='btn btn-1 btn-sign'>회원가입/로그인</span>
		<!-- ---------------------------------------------------------------------------- -->
		<!-- MENU -->
		<ul class='icon' id='icon'>
			<li><a href='/doggybeta' id='icon1'> <span>&nbsp;&nbsp;&nbsp;홈</span>
				</a></li>
			<li class="m1"><a href="#" id='icon2'><span>&nbsp;&nbsp;&nbsp;About
						us</span></a>
				<ul class="m2">
					<li><a href="/doggybeta/views/aboutus/companyIntroduce.jsp">회사소개</a></li>
					<li><a>연혁</a></li>
					<li><a href="/doggybeta/views/aboutus/teamIntroduce.jsp">팀
							도그집사</a></li>
					<li><a href="/doggybeta/views/aboutus/location.jsp">오시는 길</a></li>
				</ul>
			</li>
			<li><a href='/doggybeta/views/findSitter/petSitterListView.jsp' id='icon3'> <span>&nbsp;&nbsp;&nbsp;펫시터
						찾기</span></a> </li>
			<li class="m1"><a href='#' id='icon4'> <span>&nbsp;&nbsp;&nbsp;게시판</span>
				</a>
				<ul class="m2">
					<li><a href='/doggybeta/nlist'>공지사항</a></li>
					<li><a href='/doggybeta/flist'>자유게시판</a></li>
					<li><a href='/doggybeta/tlist'>팁</a></li>
				</ul>
			</li>
			<li class="m1"><a href="#" id='icon5'> <span>&nbsp;&nbsp;&nbsp;고객센터</span></a>
				<ul class="m2">
					<li><a href='/doggybeta/faqlist'>FAQ</a></li>
					<li><a href='#'>이용방법</a></li>
					<li><a href='#'>1:1문의</a></li>
				</ul>
			</li>

			<li class="m1"><a href="#" id='icon6'><span>&nbsp;&nbsp;&nbsp;마이페이지</span></a>
				<ul class="m2">
					<li><a href='#'>정보수정</a></li>
					<li><a href='#'>이용내역/예약확인</a></li>
					<li><a href='#' id="pet_reg__btn">펫시터신청</a></li>
					<li><a href='#'>사전문의확인</a></li>
				</ul>
			</li>

		</ul>
	</nav>
	<!-- Login Form ---------------------------------------------------------------------------- -->
	<div class='loginbody'>
	<form class="login-form" method='post' action='/doggybeta/jipsalogin'>
		<!-- <img id='cancelBtn' src='/doggybeta/resources/images/cancel-button.jpg'> -->
		<p class="login-text">
			DOGHOUSE
		</p>
		<input type="text" name='userid' id='userid' class="login-username" autofocus required placeholder="Id" />
		<input type="password" name='userpwd' id='passwd' class="login-password" required required
			placeholder="Password" />
		<a href='/doggybeta/jipsalogin'>
			<input type="submit" name="Login" value="Login" class="login-submit" id='btnLogin' /></a><br>
		<a href='/doggybeta/views/member/termsOfService.jsp'>
			<input type="button" name='enroll' value='회원가입' class='login-submit' id='btnEnroll' /></a>
		<p align='center' id='orid'>------- 또는 -------</p>
			<%
   				 String clientId = "obXTFPuiHDCuNQb5kAmx";//애플리케이션 클라이언트 아이디값";
   				 String redirectURI = URLEncoder.encode("http://127.0.0.1:8888/doggybeta/naverlogin", "UTF-8");
   				 SecureRandom random = new SecureRandom();
   				 String state = new BigInteger(130, random).toString();
   				 String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
   				 apiURL += "&client_id=" + clientId;
   				 apiURL += "&redirect_uri=" + redirectURI;
   				 apiURL += "&state=" + state;
   				 session.setAttribute("state", state);
    		 %>
			<a href="<%=apiURL%>"><img id='naver_id_login' style='position:relative;' height="47" width='260'  src="/doggybeta/resources/images/naverButton/네이버 아이디로 로그인_완성형_White.PNG"/></a> 
			<br>
			<br>
  			<a href="/doggybeta/views/member/findPassword.jsp" class="login-forgot-pass" id='tempPwd'>비밀번호를 잊으셨나요?</a>

	</form>
	</div>
	<script type="text/javascript">
		$('.m1').click(function () {
			if ($(this).children('.m2').is(':visible')) {
				$(this).children('.m2').slideUp(200);
			} else {
				$(this).children('.m2').slideDown(200);
			}
		});
	</script>
	<% } else { %>
		<a href='/doggybeta/jipsalogout'>로그아웃</a>
		<input type='checkbox' id='menu_state' checked />

	<nav>
		<ul class='doghouse'>
			<li><a><span><img src="/doggybeta/resources/images/로고test2.png" style="margin-left: 50px; padding: 10px 10px;" width="80px"></span></a></li>
		</ul>

		<a  href='/doggybeta/jipsalogout'><span class='btn btn-1 btn-sign'>로그아웃</span></a>
		<% if(access_token != null) { %>
		<!-- 네이버로그인이 제대로 되었음을 확인 -->
			<%= loginUser.getUserName() %> 님 환영합니다
		<% } else { %>
			<%= loginUser.getUserName() %> 님 환영합니다
		<% } %>

		<!-- -------------------------------------------------------------------------  -->
		<ul class='icon' id='icon'>
			<li><a href='/doggybeta' id='icon1'> <span>&nbsp;&nbsp;&nbsp;홈</span>

			</a></li>
			<li class="m1"><a
				href="#" id='icon2'><span>&nbsp;&nbsp;&nbsp;About

						us</span></a>
				<ul class="m2">
					<li><a href="/doggybeta/views/aboutus/companyIntroduce.jsp">회사소개</a></li>
					<li><a>연혁</a></li>
					<li><a href="/doggybeta/views/aboutus/teamIntroduce.jsp">팀
							도그집사</a></li>
					<li><a href="/doggybeta/views/aboutus/location.jsp">오시는 길</a></li>
				</ul></li>
			<li><a href='/doggybeta/finding' id='icon3'> <span>&nbsp;&nbsp;&nbsp;펫시터	찾기</span></a> </li>
			<li class="m1"><a href='#'  id='icon4'> <span>&nbsp;&nbsp;&nbsp;게시판</span>
			</a>
				<ul class="m2">
					<li><a href='/doggybeta/nlist'>공지사항</a></li>
					<li><a href='/doggybeta/flist'>자유게시판</a></li>
					<li><a href='/doggybeta/tlist'>팁</a></li>
				</ul>
			</li>
			<li class="m1"><a href="#" id='icon5'> <span>&nbsp;&nbsp;&nbsp;고객센터</span></a>
				<ul class="m2">
					<li><a href='/doggybeta/faqlist'>FAQ</a></li>
					<li><a href='#'>이용방법</a></li>
					<li><a href='#'>1:1문의</a></li>
				</ul>
			</li>

			<li class="m1"><a href="#" id='icon6'><span>&nbsp;&nbsp;&nbsp;마이페이지</span></a>
				<ul class="m2">
					<li><a href='#'>정보수정</a></li>
					<li><a href='/doggybeta/views/customerservice/checkMyLog.jsp'>이용내역/예약확인</a></li>
					<li><a href='#' id="pet_reg__btn">펫시터신청</a></li>
					<li><a href='#'>사전문의확인</a></li>
				</ul>
			</li>
		</ul>
	</nav>

	<!-- 펫시터 신청 버튼 클릭시 생성 보여지는 HTML 부분. 로그인 부분 구현시 인풋에 세션으로 값 넣어놓고 readonly 처리할 것  -->

	<form class="ps_reg_form" action="/doggybeta/hostup" method="POST" enctype="multipart/form-data">
		<span class="close">x</span>
		<div class="section1">
			<p>아이디</p>
			<input name="userid" value="<%=loginUser.getUserId() %>" class="ps_input input_id" autocomplete="off"
				readonly>
			<p>이름</p>
			<input name="username" value="<%=loginUser.getUserName() %>" class="ps_input input_name" autocomplete="off"
				readonly>
			<p>연락처</p>
			<input type="tel" name="phone" value="<%=loginUser.getPhone() %>" class="ps_input input_phone" autocomplete="off"
				required>
			<p>이메일</p>
			<input type="email" name="email" value="<%=loginUser.getEmail() %>" class="ps_input input_email" autocomplete="off"
				required>
				<p>희망 일급(원)</p>
				<input type="number" name="price" placeholder="가격 입력" class="ps_input input_price" required>
		</div>
		<div class="section2">
			<p>프로필 사진 추가</p>
			<div class="image_box">
				<img class="image_box_pic" />
				<input type="file" id="real-file" name="pic" hidden="hidden" / required>
				<span>
					<button id="fake-file-btn">Choose a File</button>&nbsp;
					<span id="file-text"></span>
				</span>
			</div>
			<p>펫시팅 장소</p>
			<input name="postcode" id="sample6_postcode" class="ps_input" placeholder="우편번호" required>
			<input type="button" onclick="sample6_execDaumPostcode()" id="post-search" value="우편번호 찾기">
			<input name="addr" id="sample6_address" class="ps_input input_addr" placeholder="주소" required>
			<input name="daddr" id="sample6_detailAddress" class="ps_input" placeholder="상세주소" required>
			<input name="extra" id="sample6_extraAddress" class="ps_input" placeholder="참고항목" readonly>
		</div>
		<div class="section3">
			<p>시설/장소 사진 추가 (최대 3개 / 10MB)</p>

			<div class="ppics_list">
				<img class="pp1" />
				<img class="pp2" />
				<img class="pp3" />
			</div>
				<input type="file" name="placepics" id="place_pics" multiple required>
				<input type="hidden" name="fileList" id="fileList">
			<button id="ppics_upload">Upload Files</button>
			<span id="ppics-text"></span>
			<div id="reg_map_box"></div>
			<span><button type="submit" id="submit-btn">펫시터 등록하기</button></span>
		</div>
	</form>

	<script type="text/javascript" src="/doggybeta/resources/js/petSitting.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b9810167e43ee638a44b19264113db0d&libraries=services"></script>
	<script src="/doggybeta/resources/js/addr.js"></script>
	<script type="text/javascript">

		$('.m1').click(function () {
			if ($(this).children('.m2').is(':visible')) {
				$(this).children('.m2').slideUp(200);
			} else {
				$(this).children('.m2').slideDown(200);
			}
		});
	</script>
	<% } %>
</body>

</html>
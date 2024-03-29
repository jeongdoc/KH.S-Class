<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.model.vo.*, java.util.*"%>
<%
	ArrayList<SearchingInfo> list = (ArrayList<SearchingInfo>)request.getAttribute("list");
	
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon.ico">
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
  	
<script>
/* $(document).ready(function(){
	$("#begin").datepicker({
		minDate:0,
		onSelect: function(selected) {
		$("#end").datepicker("option","minDate", selected)
	}
});
		$("#end").datepicker({						
		onSelect: function(selected) {
		$("#begin").datepicker("option","maxDate", selected)
	}
	});
}); */

					
</script>
<style type="text/css">
body{
	width: 1500px;
}
.checked {
  color: orange;
}
#searchpettable{
	background-color: #f3f6f7;
	padding: 30px 30px;
	margin: 10px 10px;
	height: auto;
	width: 800px;
				
}
input[type=button]{
	background-color: #2ec4b6;
	width:100px; height:30px;
	border: none;
	border-radius: 12px;
	color: white;
 	text-align: center;
}

table td{
text-align: center;
}
 #detail table{
	margin: 8px;
} 

#detailtable:hover{
	background-color: rgba(210, 222, 225, 0.5);
}
#bringpetinfo{
	position: relative;
	text-align: center;
}
</style>
</head>
<body>
<%@ include file="..//common/menu.jsp" %>

<div id="wrap" >
<div id="content">
<form name="petinfo" method="post" action="/doggybeta/finding">
	<!-- 조건 검색 테이블  -->	
		<input type="hidden" name="userid" value="<%=loginUser.getUserId() %>">
<div id="bringpetinfo">		
		<%=loginUser.getUserName() %> 님 안녕하세요!
<input type="submit" value="우리 강아지 정보 가져오기">

</div>
</form> 
			<table id=searchpettable>
				<tr>
					<th width="100">서비스</th>
					<th width="200">날짜</th>
					<th width="100">견종</th>
					<th width="100">반려견크기</th>
					<th width="100">반려견나이</th>
				</tr>		
				<tr>
<form name="conditioninfo" method="post" action="doggybeta/fplist">				
					<td>  
						<select name="opt" style="width:180px; height:30px;">
						  <option value="0">[당일]우리집으로 부르기</option>
						  <option value="1">우리집으로 부르기</option>
						  <option value="2">[당일]펫시터 집에 맡기기</option>
						  <option value="3">펫시터 집에 맡기기</option>
						</select>
					</td>
					<td>
				
					<p style="width:180px; height:30px;">
					
					<input type="date" id="begin">~
					<input type="date" id="end"> 
					</p>
					</td>

				  	    <% if(list != null){for(SearchingInfo SI : list){ %>
				 	  
					<td><%= SI.getPetBreads() %></td>
					<td><%= SI.getPetSize() %></td>
					<td><%= SI.getAge() %> 살</td>
					<%} }%> 
				</tr>
			</table>
			<br>
<!-- 지역 검색 -->
<div align="center">
  <select name="city" onChange="cat1_change(this.value,sido)" style="width:80px; height:30px;">
   <option selected>-선택-</option>
<option value='1'>서울</option>
<option value='2'>부산</option>
<option value='3'>대구</option>
<option value='4'>인천</option>
<option value='5'>광주</option>
<option value='6'>대전</option>
<option value='7'>울산</option>
<option value='8'>강원</option>
<option value='9'>경기</option>
<option value='10'>경남</option>
<option value='11'>경북</option>
<option value='12'>전남</option>
<option value='13'>전북</option>
<option value='14'>제주</option>
<option value='15'>충남</option>
<option value='16'>충북</option>
  </select>
  <select name="sido" style="width:80px; height:30px;">
   <option selected>-선택-</option>
<option value='215'>군산시</option>
<option value='216'>김제시</option>
<option value='217'>남원시</option>
<option value='218'>익산시</option>
<option value='219'>전주시 덕진구</option>
<option value='220'>전주시 완산구</option>
<option value='221'>정읍시</option>
<option value='222'>고창군</option>         
<option value='223'>무주군</option>
<option value='224'>부안군</option>
<option value='225'>순창군</option>
<option value='226'>완주군</option>
<option value='227'>임실군</option>
<option value='228'>장수군</option>
<option value='229'>진안군</option>
</select>
<script language=javascript>

 var cat1_num = new Array(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16);
 var cat1_name = new Array('서울','부산','대구','인천','광주','대전','울산','강원','경기','경남','경북','전남','전북','제주','충남','충북');


 var cat2_num = new Array();
 var cat2_name = new Array();


 cat2_num[1] = new Array(17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41);
 cat2_name[1] = new Array('강남구','강동구','강북구','강서구','관악구','광진구','구로구','금천구','노원구','도봉구','동대문구','동작구','마포구','서대문구','서초구','성동구','성북구','송파구','양천구','영등포구','용산구','은평구','종로구','중구','중랑구');


 cat2_num[2] = new Array(42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57);
 cat2_name[2] = new Array('강서구','금정구','남구','동구','동래구','부산진구','북구','사상구','사하구','서구','수영구','연제구','영도구','중구','해운대구','기장군');


 cat2_num[3] = new Array(58,59,60,61,62,63,64,65);
 cat2_name[3] = new Array('남구','달서구','동구','북구','서구','수성구','중구','달성군');


 cat2_num[4] = new Array(66,67,68,69,70,71,72,73,74,75);
 cat2_name[4] = new Array('계양구','남구','남동구','동구','부평구','서구','연수구','중구','강화군','옹진군');


 cat2_num[5] = new Array(76,77,78,79,80);
 cat2_name[5] = new Array('광산구','남구','동구','북구','서구');


 cat2_num[6] = new Array(81,82,83,84,85);
 cat2_name[6] = new Array('대덕구','동구','서구','유성구','중구');


 cat2_num[7] = new Array(86,87,88,89,90);
 cat2_name[7] = new Array('남구','동구','북구','중구','울주군');


 cat2_num[8] = new Array(91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108);
 cat2_name[8] = new Array('강릉시','동해시','삼척시','속초시','원주시','춘천시','태백시','고성군','양구군','양양군','영월군','인제군','정선군','철원군','평창군','홍천군','화천군','횡성군');


 cat2_num[9] = new Array(109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148);
 cat2_name[9] = new Array('고양시 덕양구','고양시 일산구','과천시','광명시','광주시','구리시','군포시','김포시','남양주시','동두천시','부천시 소사구','부천시 오정구','부천시 원미구','성남시 분당구','성남시 수정구','성남시 중원구','수원시 권선구','수원시 장안구','수원시 팔달구','시흥시','안산시 단원구','안산시 상록구','안성시','안양시 동안구','안양시 만안구','오산시','용인시','의왕시','의정부시','이천시','파주시','평택시','하남시','화성시','가평군','양주군','양평군','여주군','연천군','포천군');


 cat2_num[10] = new Array(149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168);
 cat2_name[10] = new Array('거제시','김해시','마산시','밀양시','사천시','양산시','진주시','진해시','창원시','통영시','거창군','고성군','남해군','산청군','의령군','창녕군','하동군','함안군','함양군','합천군');


 cat2_num[11] = new Array(169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192);
 cat2_name[11] = new Array('경산시','경주시','구미시','김천시','문경시','상주시','안동시','영주시','영천시','포항시 남구','포항시 북구','고령군','군위군','봉화군','성주군','영덕군','영양군','예천군','울릉군','울진군','의성군','청도군','청송군','칠곡군');


 cat2_num[12] = new Array(193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214);
 cat2_name[12] = new Array('광양시','나주시','목포시','순천시','여수시','강진군','고흥군','곡성군','구례군','담양군','무안군','보성군','신안군','영광군','영암군','완도군','장성군','장흥군','진도군','함평군','해남군','화순군');


 cat2_num[13] = new Array(215,216,217,218,219,220,221,222,223,224,225,226,227,228,229);
 cat2_name[13] = new Array('군산시','김제시','남원시','익산시','전주시 덕진구','전주시 완산구','정읍시','고창군','무주군','부안군','순창군','완주군','임실군','장수군','진안군');


 cat2_num[14] = new Array(230,231,232,233);
 cat2_name[14] = new Array('서귀포시','제주시','남제주군','북제주군');


 cat2_num[15] = new Array(234,235,236,237,238,239,240,241,242,243,244,245,246,247,248);
 cat2_name[15] = new Array('공주시','논산시','보령시','서산시','아산시','천안시','금산군','당진군','부여군','서천군','연기군','예산군','청양군','태안군','홍성군');


 cat2_num[16] = new Array(249,250,251,252,253,254,255,256,257,258,259,260);
 cat2_name[16] = new Array('제천시','청주시 상당구','청주시 흥덕구','충주시','괴산군','단양군','보은군','영동군','옥천군','음성군','진천군','청원군');


function cat1_change(key,sel){
 if(key == '') return;
 var name = cat2_name[key];
 var val = cat2_num[key];

 for(i=sel.length-1; i>=0; i--)
  sel.options[i] = null;
 sel.options[0] = new Option('-선택-','', '', 'true');
 for(i=0; i<name.length; i++){
  sel.options[i+1] = new Option(name[i],val[i]);
 }
}

</script>
<input type="submit" value="펫시터 찾기">
</form>

</div>
<!-- 지역검색 닫기 -->
<br><br>
<!-- 조건에 대한 결과 -->
<div id="detailmain" style="width:1400px" >
<div id="petinfo"  style="float: left; width: 50%">
상단 : 검색 결과 건수 조회
<hr>
<br>
	<div id="detail" style="overflow-x: hidden; overflow-y:scroll; height:550px;">
		<div id="detailtable" style="float:left; width: 50%;">
		<table style="border: 1px solid #d2dee1; width: 300px;">			
		<tr>
		<td>
			<div style="position: relative;">
			<img src="/doggybeta/resources/images/house.jpeg" height="150px;" width="100%;">
			</div>
			<div style="position: relative; top: -40px;">
			<img src="/doggybeta/resources/images/dog1.jpg" style="height: 60px; width : 60px; border-radius: 50px; border: 3px solid white">
			</div>		
		</td>
		</tr>
		<tr>
		<th>내 가족처럼 안전하게~</th>
		</tr>
		<tr>
		<td>서울시 서초구</td>
		</tr>
		<tr>
		<td>반려견 1마리</td>
		<tr>
		<td style="float:left;">가격 : 50000원/1일</td> 
		<td style="float:right;">평점 : 
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star"></span>
		<span class="fa fa-star"></span>	
		</td>
		</tr>		
		</table>
		</div>
		<div id="detailtable" style="float:left; width: 50%;">
		<table style="border: 1px solid #d2dee1; width: 300px;">			
		<tr>
		<td>
			<div style="position: relative;">
			<img src="/doggybeta/resources/images/house.jpeg" height="150px;" width="100%;">
			</div>
			<div style="position: relative; top: -40px;">
			<img src="/doggybeta/resources/images/dog1.jpg" style="height: 60px; width : 60px; border-radius: 50px; border: 3px solid white">
			</div>	
					
		</td>
		</tr>
		<tr>
		<th>내 가족처럼 안전하게~</th>
		</tr>
		<tr>
		<td>서울시 서초구</td>
		</tr>
		<tr>
		<td>반려견 1마리</td>
		<tr>
		<td style="float:left;">가격 : 50000원/1일</td> 
		<td style="float:right;">평점 : 
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star"></span>
		<span class="fa fa-star"></span>	
		</td>
		</tr>		
		</table>
		</div>
		<div id="detailtable" style="float:left; width: 50%;">
		<table style="border: 1px solid #d2dee1; width: 300px;">			
		<tr>
		<td>
			<div style="position: relative;">
			<img src="/doggybeta/resources/images/house.jpeg" height="150px;" width="100%;">
			</div>
			<div style="position: relative; top: -40px;">
			<img src="/doggybeta/resources/images/dog1.jpg" style="height: 60px; width : 60px; border-radius: 50px; border: 3px solid white">
			</div>
		
		</td>
		</tr>
		<tr>
		<th>내 가족처럼 안전하게~</th>
		</tr>
		<tr>
		<td>서울시 서초구</td>
		</tr>
		<tr>
		<td>반려견 1마리</td>
		<tr>
		<td style="float:left;">가격 : 50000원/1일</td> 
		<td style="float:right;">평점 : 
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star"></span>
		<span class="fa fa-star"></span>	
		</td>
		</tr>		
		</table>
		</div>
		<div id="detailtable" style="float:left; width: 50%;">
		<table style="border: 1px solid #d2dee1; width: 300px;">			
		<tr>
		<td>
			<div style="position: relative;">
			<img src="/doggybeta/resources/images/house.jpeg" height="150px;" width="100%;">
			</div>
			<div style="position: relative; top: -40px;">
			<img src="/doggybeta/resources/images/dog1.jpg" style="height: 60px; width : 60px; border-radius: 50px; border: 3px solid white">
			</div>	
					
		</td>
		</tr>
		<tr>
		<th>내 가족처럼 안전하게~</th>
		</tr>
		<tr>
		<td>서울시 서초구</td>
		</tr>
		<tr>
		<td>반려견 1마리</td>
		<tr>
		<td style="float:left;">가격 : 50000원/1일</td> 
		<td style="float:right;">평점 : 
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star checked"></span>
		<span class="fa fa-star"></span>
		<span class="fa fa-star"></span>	
		</td>
		</tr>		
		</table>
		</div>
		
	</div>
	<!-- detailinfo닫기 -->

</div>
</div>

<div style="float:left; width:50%;">
지도출력
<hr>
<br>
<div id="map" style="width:100%;height:550px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=61e779cba5e3e9729c7fb3b2830dba72"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    	mapOption = { 
        center: new daum.maps.LatLng(37.499274, 127.032963), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // 마우스 드래그로 지도 이동 가능여부를 설정합니다
    map.setDraggable(true);  

</script>
</div>
</div> 
</div>
		
<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	
</body>
</html>
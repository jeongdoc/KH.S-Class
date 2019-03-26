<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon.ico">
<style type="text/css">
#imgmap{
	position: absolute;
 	top: 260px; 
 	width: 400px;	
}
#map{
 	position: absolute;
 	top: 200px;
 	left:500px;
 	
}
h2{
   position: relative;
   top: 20px;
   left : 200px;
   
  
}
</style>
</head>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon.ico">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<body>
<%@ include file="../common/menu.jsp"%>
	<div id="wrap">
		  <div id="content">

	

<h2 align="center">오시는 길</h2>
<img id="imgmap" src="/doggybeta/resources/images/map.JPG" width="400">

<div id="map" style="width:800px; height:400px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=61e779cba5e3e9729c7fb3b2830dba72"></script>

<script>

var markers = 
{
  position: new daum.maps.LatLng(37.499274, 127.032963), 
  text: '도그하우스' // text 옵션을 설정하면 마커 위에 텍스트를 함께 표시할 수 있습니다     
};
 
var container = document.getElementById('map'), // 이미지 지도를 표시할 div  
	option = { 
    center: new daum.maps.LatLng(37.499274, 127.032963), // 이미지 지도의 중심좌표
    level: 3, // 이미지 지도의 확대 레벨
    marker: markers // 이미지 지도에 표시할 마커 
};    

//이미지 지도를 생성합니다
var map = new daum.maps.StaticMap(container, option);


</script>		
</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta charset="UTF-8">
<title>Dog House</title>
<script type="text/javascript" src="/doggybeta/SE2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon.ico">
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
function moveList(){
   location.href="/doggybeta/faqlist"
}
</script>
</head>
<style type="text/css">
.board{
	position: relative;
   left : 300px;
   top: 50px;

}
h2{
   position: relative;
   top: 20px;
   left : 100px;
}
.title{
	width: 70px;
	padding: 7px 13px;
	border:1px solid #e9e9e9;
	border-left:0;
	background:#f5f8f9;
	text-align:left
	
}
.button{
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  margin: 4px 2px;
  cursor: pointer;
  position: relative;
  left :350px;
  top: 100px;
}
</style>
<body>
<%@ include file="../common/menu.jsp"%>
	<div id="wrap">
		  <div id="content">


<h2 align="center">FAQ 등록 페이지</h2>

<br>

<form action="/doggybeta/faqinsert" method="post">
	
<table class="board" align="center" width="1000">
<tr>
<th class="title">구분</th>
<td>
<input type="radio" name="type" value="결제">결제
<input type="radio" name="type" value="취소/환불">취소/환불
<input type="radio" name="type" value="펫시터찾기">펫시터찾기
<input type="radio" name="type" value="펫시터되기">펫시터되기
<input type="radio" name="type" value="기타">기타
</td>
</tr>
<tr>
<th class="title">제목</th>
<td><input type="text" name="title" size="60" style="width:766px"></td>
</tr>
<tr>
<th class="title" height="200">내용</th>
<td><textarea name="ir1" id="ir1" rows="10" cols="100" style="width:766px; height:412px;"></textarea></td></tr>
		<tr><th colspan="2" align="center">
		<input type="button" onclick="submitContents(this);" value="등록하기" />
		<input type="button" onclick="moveList();" value="목록으로">
</tr>
</table>
</form>
<script type="text/javascript">
var oEditors = [];

var sLang = "ko_KR";	// 언어 (ko_KR/ en_US/ ja_JP/ zh_CN/ zh_TW), default = ko_KR

// 추가 글꼴 목록
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "/doggybeta/SE2/SmartEditor2Skin.html",	
	htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		//bSkipXssFilter : true,		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
		fOnBeforeUnload : function(){
			//alert("완료!");
		},
		I18N_LOCALE : sLang
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["ir1"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
	
	try {
		elClickedObj.form.submit();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '궁서';
	var nFontSize = 24;
	oEditors.getById["ir1"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>
</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
</div>
</body>
</html>
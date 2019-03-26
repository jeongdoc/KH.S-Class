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
<script type="text/javascript">
function showWriteForm(){
   location.href="/doggybeta/views/notice/noticeWriteForm.jsp"
}

$(function(){
	showDiv();
	
	$("input[name=item]").on("change", function(){
		showDiv();
	});
});

function showDiv(){
	if($("input[name=item]").eq(0).is(":checked")){
		$("#titleDiv").css("display", "block");
		$("#dateDiv").css("display", "none");
		
	}
	if($("input[name=item]").eq(1).is(":checked")){
		$("#titleDiv").css("display", "none");
		$("#dateDiv").css("display", "block");
	}

}
</script>
<style type="text/css">

/* 화면에 보여지는 글 목록 테이블 */
h2{
   position: relative;
   top: 20px;
   left : 200px;
   width: 70%;
   padding: 2rem 0px;
}
.board { 
   position: relative;
   left : 150px;
   top: 100px;
   width: 60%;
   border-collapse: collapse;
   text-align: left;
   line-height: 1.5;
   table-layout:fixed; 
   
}
.button{
   position: relative;
   left : 200px;
   top: 50px;
}

/* list_table 에서 사용되는 thead */
.board thead th{ 
	padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;}

/* list_table 에서 사용되는 tbody */
.board tbody td { 
	width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;   
    
}

.board tbody tr:hover{
	background-color : #f3f6f7;
}
header{
	text-align:center;	
	padding: 2rem 0px;
}

.board tbody td a{
	text-decoration: none;
	color: black;
}
.search{
	display: flex;
	justify-content: center;
}
.insert{
	padding: 0 2rem;
}
#wrap{
	left: 200px;
	border: 1px solid red;
	margin: 0 auto;
}
</style>
</head>

<body>
<%@ include file="../common/menu.jsp"%>
	<div id="wrap">
		  <div id="content">

<h2 align="center">공지사항 게시판</h2>
<header>
<div class="search">
	<form action="/doggybeta/nsearch" method="post">
	<select name="opt"> <!-- 검색 컬럼 -->
		<option value="0">제목</option>
		<option value="1">내용</option>
		<option value="2">제목+내용</option>
	</select>
	<input type="text" size="20" name="search"> 
	<input type="submit" value="검색">
	</form>
	<div class="insert">
<% if(loginUser != null){ %>
	<input type="button" onclick="showWriteForm();" value="글쓰기">
<%} %>
	</div>
</div>


</header>

<br>
<!-- 테이블 시작 -->
   <table class="board">
      <thead>
         <tr>
            <th width="50">번호</th>
            <th width="200">제목</th>
            <th width="100">작성자</th>
            <th width="130">작성일</th>
            <th width="70">조회수</th>
            <th width="100">첨부파일</th>
            
         </tr>   
      </thead>
      <tbody>      
       <%   for(Notice notice : list){ %>
   <tr>
   <td><%= notice.getNoticeNo() %></td>
   
   <td>
   <%if(loginUser != null){ %>
   <a href="/doggybeta/ndetail?no=<%= notice.getNoticeNo()%>"><%= notice.getNoticeTitle() %></a>
   <% }else{ %>
   <%= notice.getNoticeTitle() %>
   <% } %>
   </td>
   <td><%= notice.getManagerId() %></td>
   <td><%= notice.getNoticeDate() %></td>
   <td><%= notice.getNoticeViews() %></td>
   <td>
   <%if(notice.getNoticeOriginFile() != null) {%>
   <img src="/doggybeta/resources/images/paw.png" width="20px;" align="center;">
   <% }else{ %>
   &nbsp;
   <%} %>
   </td>
   </tr>   
   <% } %>     
   </tbody>   
</table>
<br>         
<!-- 테이블 종료 -->


</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
</div>

</body>
</html>
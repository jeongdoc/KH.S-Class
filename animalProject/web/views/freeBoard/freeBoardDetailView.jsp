<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member, freeboard.model.vo.FreeBoard, java.sql.Date, freeboardreply.model.vo.FreeBoardReply,
				  java.util.*"%>
<%
	FreeBoard freeboard = (FreeBoard)request.getAttribute("freeboard");
//	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); 
	ArrayList<FreeBoardReply> replyList = (ArrayList<FreeBoardReply>)request.getAttribute("replyList");
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doggybeta</title>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function(){
		$.ajax({
			url:"/doggybeta/freply",
			type: "post",
			dataType: "json",
			success: function(data){
				var jsonStr = JSON.stringfy(data);
				var json = JSON.parse(jsonStr);
				
				var values = $("#p5").html() + "<br>";
				for(var i in json.list){
					values += json.list[i].replyNo + ", " + decodeURIComponent(json.list[i].replyContent) +  ", " 
					+ json.list[i].replyDate + ", " + json.list[i].replyBoardNo + ", "
					+ json.list[i].replyDelete + "<br>"				
				}
				$("#p5").html(values);
			}
	})//ajax
});//ready

/* $(function(){
	$("save").click(function(){
		if($("#"))
		
		
		
		
	}) //click
}); //ready
 */

</script>
<style type="text/css">

table{
	position: relative;
	left: 400px;
	border-collapse: separate;
    border-spacing: 1px;
    text-align: left;
    line-height: 1.5;
    margin: 20px 10px;
}
h2{
	position: relative;
	left: 700px;
    text-align: left;
    line-height: 1.5;
    margin: 20px 10px;

}
#t11 {
	resize: none;
}


</style> 
</head>
<body>
<%@ include file="../common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
		  
<%-- 상세보기  --%>		  
<h2><%= freeboard.getFreeboardNo() %>번 게시글 상세보기</h2>
<br>
<table id="t" align="right" cellpadding="10" cellspacing="0" border="1" width="800">
<tr>
	<th>제목</th>
	<td align="center"><%= freeboard.getFreeboardTitle() %></td>
</tr>
<tr>
	<th>작성자</th>
	<td align="center"><%= freeboard.getUserId() %></td>
</tr>
<tr>
	<th>첨부파일</th>
	<td align="center">
	 		<% if(freeboard.getFreeboardOriginalFile() != null){ %>
			<a href="/doggybeta/ffdown?ofile=<%= freeboard.getFreeboardOriginalFile() %>&rfile=<%= freeboard.getFreeboardRefile() %>"><%= freeboard.getFreeboardOriginalFile()%></a>
		<% }else{ %>
			첨부파일없음
		<% } %> 
	</td>
</tr> 
<tr>
	<th>내용</th>
	<td align="center"><%= freeboard.getFreeboardContent() %></td>
</tr>
<tr>
	<th colspan="2" align="center">
<% if(loginUser.getUserId().equals(freeboard.getUserId())){ %> 
		<a href="/doggybeta/fupview?fnum=<%= freeboard.getFreeboardNo() %>">[수정페이지로 이동]</a> 
		&nbsp; &nbsp;
		<a href="/doggybeta/fdelete?fnum=<%= freeboard.getFreeboardNo() %>">[글삭제]</a>
	 <% } %> 
	&nbsp; &nbsp;
	 <a href="/doggybeta/flist">[목록]</a> 
	</th>	
</tr>
</table>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


<p id="p5" style="width:500px;height:300px;border:1px solid red;"></p>
<%-- 댓글 보이기 --%>
<form action="/doggybeta/freply?frnum=<%= freeboard.getFreeboardNo() %>" method="post" >
	<% if(replyList != null) {%>
	<% for(FreeBoardReply f : replyList){ %>
	<div class="form-group">
	<label for="userId" class="userId">작성자</label>
		<div class="userId" id="userId" name="userId"></div>
	</div>
	<div class="form=group">
	<label for="frcontent" class="frcontent">내용</label>
		<div class="frcontent" id="frcontent" name="frcontent"></div>
	</div>
	<% }}%>
</form>
<hr>




<%-- 댓글등록 --%>
<% if(loginUser != null){ %>
	<form action="/doggybeta/freply" method="post">		
		<input type="hidden" name="fnum" value="<%= freeboard.getFreeboardNo() %>">
		<input type="hidden" name="page" value="">
	<table align="center">
<!-- 	<tr><th>제목</th><td><input type="text" name="btitle" style="width:766px"></td></tr> -->
	<tr><th>작성자</th><td><input type="text" name="fwriter" style="width:766px" readonly value="<%= loginUser.getUserId() %>"></td></tr>
	<tr><th>내용</th><td><textarea cols="50" rows="4" name="fcontent" style="width:766px"></textarea></td></tr>
	<tr><th colspan="2" align="center">
	<input type="submit" value="댓글등록"> &nbsp; 
	<a href="/doggybeta/flist">[목록]</a>
	</th></tr>
	</table>
</form>
<% } %>

<button id="save" name="save"></button>

	
</div>
<hr>


		<div id="footer" align="right">
			<%@ include file="..//common/footer.jsp"%></div>
	</div>
</body>
</html>	






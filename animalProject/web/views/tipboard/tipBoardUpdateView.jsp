<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="tipboard.model.vo.TipBoard" %>  
<%
	TipBoard tboard = (TipBoard)request.getAttribute("tboard");
	int currentPage = ((Integer)request.getAttribute("page")).intValue();
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팁 게시판</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@ include file="..//common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
<h2 align="center"><%=tboard.getTipBoardNo() %>번 게시글 수정페이지</h2>
<br>
<%-- <% if(board.getBoardReplyLev() == 0){ //원글 수정 %> --%>
<form action="/doggybeta/toriginup" method="post" enctype="multipart/form-data">
<input type="hidden" name="page" value="<%= currentPage %>">
<input type="hidden" name="tnum" value="<%= tboard.getTipBoardNo() %>">
<input type="hidden" name="tofile" value="<%= tboard.getTipBoardOriginFile() %>">
<input type="hidden" name="trfile" value="<%= tboard.getTipBoardReFile() %>">
<table align="center">
<tr><th>제목</th><td><input type="text" name="ttitle" value="<%= tboard.getTipBoardTitle() %>"></td></tr>
<tr><th>작성자</th><td><input type="text" name="twriter" readonly value="<%= tboard.getUserId() %>"></td></tr>
<tr><th>첨부파일</th>
<td><% if(tboard.getTipBoardOriginFile() != null){ %>
	<%= tboard.getTipBoardOriginFile() %>
<% } %><br>
<input type="file" name="tupfile">
</td>
</tr>
<tr><th>내용</th>
<td><textarea rows="7" cols="50" name="tcontent"><%= tboard.getTipBoardContent() %></textarea></td></tr>
<tr><th colspan="2">
	<input type="submit" value="수정하기"> &nbsp;
	<a href="/doggybeta/tlist?page=<%= currentPage %>">[목록]</a>
</th></tr>
</table>
</form>
<%-- <% }else{ //댓글 수정 %>
<form action="/doggybeta/treplyup" method="post">
<input type="hidden" name="page" value="<%= currentPage %>">
<input type="hidden" name="tnum" value="<%= tboard.getTipBoardNo() %>">
<table align="center">
<tr><th>제목</th><td><input type="text" name="ttitle" value="<%= tboard.getTipBoardTitle() %>"></td></tr>
<tr><th>작성자</th><td><input type="text" name="twriter" readonly value="<%= tboard.getUserId() %>"></td></tr>
<tr><th>내용</th>
<td><textarea rows="7" cols="50" name="tcontent"><%= tboard.getTipBoardContent() %></textarea></td></tr>
<tr><th colspan="2">
	<input type="submit" value="수정하기"> &nbsp;
	<a href="/doggybeta/tlist?page=<%= currentPage %>">[목록]</a>
</th></tr>
</table></form>
<% } %> --%>
</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
</div>
</body>
</html>






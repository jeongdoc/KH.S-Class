<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="freeboard.model.vo.FreeBoard, java.util.ArrayList" %>
   <%
   ArrayList<FreeBoard> slist = (ArrayList<FreeBoard>)request.getAttribute("slist"); 
   
	int listCount = ((Integer)request.getAttribute("listCount")).intValue(); 
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); 
   
	String opt = null;
	String inputdata = null;
	
		if(request.getAttribute("opt") != null){
			opt = request.getAttribute("opt").toString();
			
			if(request.getAttribute("inputdata") != null){
				inputdata = request.getAttribute("inputdata").toString();	 
			}}
   %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
function showWriteForm(){
	location.href = "/doggybeta/views/freeBoard/freeBoardWriteForm.jsp";
}	

</script>
<style type="text/css">
	th{ 
	background-color : #D09E88;
	}
	
	#searchT{ 
	text-align:center;	
	}
	
	.icon-left-open 
	{ *zoom: expression( this.runtimeStyle['zoom'] = '1',
	 this.innerHTML = '&#xe800;&nbsp;'); }
	
</style>

</head>
<body>
<%@ include file="../common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
<h2 align="center">자유게시판</h2>
<%-- <h4 align="center">총 게시글 갯수 : <%= listCount %></h4> --%>
<br><br><br>
<table align="center"  border="0"  width="800">
<%-- --%>
<tr>
	<th>글번호</th><th>작성자</th><th>제목</th><th>날짜</th><th>조회수</th><th>첨부파일</th>
</tr>
<% for(FreeBoard f : slist){ %>
	<tr><td align="center"><%= f.getFreeboardNo() %></td>
		<td align="center"><%= f.getUserId() %></td>
	<% if(loginUser != null){ %>
	<td align="center"><a href="/doggybeta/fdetail?fnum=<%= f.getFreeboardNo() %>"><%= f.getFreeboardTitle() %></a></td>
	<% }else{ %>
	<td align="center"><%= f.getFreeboardTitle() %></td>
	<% } %>	
	<td align="center"><%= f.getFreeboardDate() %></td>
 	<td align="center"><%= f.getFreeboardViews() %></td>
	<td align="center">
	<% if(f.getFreeboardOriginalFile() != null){ %>
		有
	<% }else{ %>
		
	<% } %>
	</td>
	</tr>
<% } %>
</table>

<%-- 글쓰기 --%>
<% if(loginUser != null){ %>
	<div style="align:center; text-align:center;">
	<button type="button" style="float:right;" onclick="showWriteForm()";>글쓰기</button>
	</div>
<% } %> 

<%-- 검색기능 --%>
<br>
<div id="searchT">
 <form name="form1" method="post" action="/doggybeta/flist">
  <select name="opt">
  <option value="0" >제목</option>
  <option value="1" >작성자</option>
  <option value="2" >제목+내용</option>
   </select>
 <input type="text" size="20" name="inputdata" />&nbsp;
 <input type="submit" value ="검색"/>
</form>
</div>
	
	<%-- 페이지징 처리 --%>
<div style="text-align:center;">
<% if(currentPage <= 1){ %>
	[맨처음]&nbsp;
<% }else{ %>
	<a href="/doggybeta/flist?page=1">[맨처음]</a>&nbsp;
<% } %> 
<!-- 이전 -->
<% if((currentPage - 10) <= startPage && (currentPage - 10) >= 1){ %>
	<a href="/doggybeta/flist?page=<%= startPage - 1 %>"></a>
<% }else{ %>
	[prev]
<% } %>

<!-- 현재 페이지가 포함된 페이지 그룹 숫자 출력 처리 -->
<% for(int p = startPage; p <= endPage; p++){ %>
	<% if(opt == null){ %>
	<a href="/doggybeta/flist?page=<%= p %>"><%= p %></a>
	<% }else{ %>
	<a href="/doggybeta/flist?opt=<%= opt %>&inputdata=<%= inputdata %>&page=<%= p %>"><%= p %></a>
<% }} %> &nbsp;

<!-- 다음 -->
<% if((currentPage + 10) > endPage && currentPage != 1){ %>
	<a href="/doggybeta/flist?page=<%= endPage + 1 %>">[next]</a>&nbsp;
<% }else{ %>
	[next]&nbsp;
<% } %>

<% if(currentPage >= maxPage){ %>
	[맨끝]
<% }else{ %>
	<a href="/doggybeta/flist?page=<%= maxPage %>">[맨끝]</a>
<% } %>
</div> 	  
	

		</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>

<br>

</body>
</html>
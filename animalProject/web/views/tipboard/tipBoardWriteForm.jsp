<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member" %>
<%-- <%@ page import="java.util.UUID"%> 
<%@ page import="java.io.File"%> 
<%@ page import="java.io.FileOutputStream"%> 
<%@ page import="java.io.InputStream"%> 
<%@ page import="java.io.OutputStream"%> 
<%@ page import="org.apache.commons.fileupload.FileItem"%> 
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%> 
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%> --%>

<%
	/* Member loginUser = (Member)session.getAttribute("loginUser"); */
%>
<%-- <% // 로컬경로에 파일 저장하기 ============================================ 
String sFileInfo = ""; // 파일명 - 싱글파일업로드와 다르게 멀티파일업로드는 HEADER로 넘어옴 
String name = request.getHeader("file-name"); // 확장자 
String ext = name.substring(name.lastIndexOf(".")+1); // 파일 기본경로 
String defaultPath = request.getServletContext().getRealPath("/"); // 파일 기본경로 _ 상세경로 
String path = defaultPath + "upload" + File.separator; 
File file = new File(path); 
if(!file.exists()) { 
	file.mkdirs(); 
} 
String realname = UUID.randomUUID().toString() + "." + ext; 
InputStream is = request.getInputStream(); 
OutputStream os = new FileOutputStream(path + realname); 
int numRead; // 파일쓰기 
byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))]; 
while((numRead = is.read(b,0,b.length)) != -1) { 
	os.write(b,0,numRead); 
} 
if(is != null) { 
	is.close(); 
} 
os.flush(); 
os.close(); 
System.out.println("path : "+path); 
System.out.println("realname : "+realname); // 파일 삭제 // File f1 = new File(path, realname); // if (!f1.isDirectory()) { // if(!f1.delete()) { // System.out.println("File 삭제 오류!"); // } // } 
sFileInfo += "&bNewLine=true&sFileName="+ name+"&sFileURL="+"/upload/"+realname; 
out.println(sFileInfo); 
// ./로컬경로에 파일 저장하기 ============================================
%> --%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팁게시판</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script> 
<script type="text/javascript" src="/doggybeta/SE2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
$(function(){
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "smarteditor", //textarea에서 지정한 id와 일치해야 합니다. 
          //SmartEditor2Skin.html 파일이 존재하는 경로
          sSkinURI: "/doggybeta/SE2/SmartEditor2Skin.html",  
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,             
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : true,     
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : true,      
              bSkipXssFilter : true,
              fOnBeforeUnload : function(){
                   
              }
          }, 
          fOnAppLoad : function(){
              //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
              oEditors.getById["smarteditor"].exec("PASTE_HTML",[""]);
          },
          fCreator: "createSEditor2"
      });
      
      //저장버튼 클릭시 form 전송
      $("#savebutton").click(function(){
          oEditors.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
          $("#frm").submit();
      });    
});

</script>

</head>
<body>
<%@ include file="..//common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
			<form action="/doggybeta/tinsert" method="post" enctype="multipart/form-data" id="frm">
				<table align="center">
					<tr><td>제목</td><td><input type="text" name="ttitle" style="width:766px"></td></tr>
					<tr><td>작성자</td><td><input type="text" name="twriter" style="width:766px" readonly value="<%=loginUser.getUserId()%>"></td></tr>
					<tr><td>첨부파일</td>
					<td><input type="file" name="tupfile"></td></tr>
					<tr><td>내용</td>
					<!-- <td><textarea cols="50" rows="7" name="tcontent"></textarea></td></tr> -->
					<td>
					<textarea name="smarteditor" id="smarteditor" rows="10" cols="100" style="width:766px; height:412px;"> </textarea>
					</td></tr>
					<tr><td colspan="2" align="center">
						<input type="submit" value="등록하기" id="savebutton"> &nbsp; 
						<input type="reset" value="입력취소"> &nbsp; 
						<a href="/doggybeta/tlist?page=1">[목록]</a>
					</td></tr>
				</table>
				
			</form>
		
		</div>
		  	<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>
</body>
</html>
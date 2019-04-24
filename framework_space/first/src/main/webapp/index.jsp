<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>First Spring FrameWork Project</title>
</head>
<body>
<!-- <h1>My first spring framework</h1> -->
<jsp:forward page='main.do'/>
<%-- == <% request.getRequestDispatcher("main.do").forward(request, response)%> --%>
</body>
</html>
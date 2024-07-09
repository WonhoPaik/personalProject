<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page isErrorPage = "true" %>
<% response.setStatus(HttpServletResponse.SC_OK); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예외발생</title>
</head>
<body>
	<h1>요청 처리 과정에서 예외가 발생하였습니다.</h1>
	<h1>빠른시간안에 해결을 하겠습니다.</h1>
	<br>
	에러타입 <%= exception.getClass().getName() %> <br>
	에러메세지 <%= exception.getMessage() %>
</body>
</html>
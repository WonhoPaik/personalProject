<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="membertwo.CustomerDAO" scope="page" />

<%
String id = (String) request.getParameter("userId");
boolean check = dao.idCheck(id);
%>
<html>
<head>
<title>ID중복체크</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>
<body bgcolor="white">
	<br>
	<center>
		<b><%=id%></b>
		<%
		if (check) {
			out.println("는 이미 존재하는 ID입니다.<br></br>");
		} else {
			out.println("는 사용 가능 합니다.<br></br>");
		}
		%>
		<a href="#" onClick="javascript:self.close()">닫기</a>
	</center>
</body>
</html>
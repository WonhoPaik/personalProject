<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="boardone.BoardDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%
request.setCharacterEncoding("euc-kr");
%>
<%
int num = Integer.parseInt(request.getParameter("num"));
int pageNum = Integer.parseInt(request.getParameter("pageNum"));
String pass = request.getParameter("pass");
BoardDAO dbPro = BoardDAO.getInstance();
int check = dbPro.deleteArticle(num, pass);
if (check == 1) {
%>
<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>">
<%
} else if (check == 0) {
%>
<script language="JavaScript">
<!--
	alert("비밀번호가 맞지 않습니다");
	history.go(-1);
	-->
</script>
<%
} else {
%>
<script language="JavaScript">
<!--
	alert("데이터베이스 오류");
	history.go(-1);
	-->
</script>
<%
}
%>
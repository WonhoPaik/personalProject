<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="boardone.NoticeDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="article" class="boardone.NoticeVO" scope="page">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>

<%
article.setRegdate(new Timestamp(System.currentTimeMillis()));
//싱글톤방식 객체관리
NoticeDAO dpPro = NoticeDAO.getInstance();
boolean flag = dpPro.insertArticle(article);

if (flag == true) {
	response.sendRedirect("noticeList.jsp");
} else {
	String message = "입력이 성공하지 못했습니다.";
%>
<script>
	alert("<%=message%>
	");
	history.go(-1);
</script>

<%
}
%>


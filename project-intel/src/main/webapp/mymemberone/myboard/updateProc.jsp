<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardone.BoardDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="article" scope="page" class="boardone.BoardVO">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>
<%
//자바빈즈에서 받지못한 데이터값을 getParameter로 받는다.
String pageNum = request.getParameter("pageNum");
BoardDAO dbPro = BoardDAO.getInstance();
int check = dbPro.updateArticle(article);
//수정성공
if (check == 1) {
%>
<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>">
<%
} else if(check == 0){
%>
	<script language="JavaScript">
	<!--
	alert("비밀번호가 맞지 않습니다");
	history.go(-1);
	-->
	</script>
<%
}else{
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
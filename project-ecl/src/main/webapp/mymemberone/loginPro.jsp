<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="dao" class="membertwo.CustomerDAO" />
<%
String id = request.getParameter("userid");
String pass = request.getParameter("pwd");
int check = dao.loginCheck(id, pass);
%>
<%
if (check == 1) {//로그인 성공
	session.setAttribute("loginID", id);
	response.sendRedirect("mainPage.jsp");
} else if (check == 0) {//아이디는 있는데 비밀번호 오류
%>
<script>
	alert("비밀번호가 틀렸습니다");
	history.go(-1);
</script>
<%
} else {//아이디 자체가 존재하지 않는 경우
%>
<script>
	alert("아이디가 존재하지 않습니다");
	history.go(-1);
</script>
<%
}
%>
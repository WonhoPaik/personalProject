<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="membertwo.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="membertwo.CustomerDAO" />
<jsp:useBean id="vo" class="membertwo.CustomerVO">
	<jsp:setProperty name="vo" property="*" />
</jsp:useBean>
<%
String loginID = (String) session.getAttribute("loginID");
vo.setUserId(loginID);
dao.updateMember(vo);
session.invalidate();
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="Refresh" content="3;url=loginPage.jsp">
<title>Update Process</title>
<link rel="stylesheet" href="./css/mainPage.css" type="text/css">
<script script type="text/javascript" src="script.js?ver=1"></script>
<script src="https://kit.fontawesome.com/dd1c09ef10.js" defer
	crossorigin="anonymous"></script>
<script>
	let myWindow = null
	function createLoginWindow(event) {
		if (myWindow === null) {
			myWindow = window.open("loginPage.jsp", '_top');
			event.preventDefault();
		}
	}
	function createBoardWindow(event) {
		if (myWindow === null) {
			myWindow = window.open("./myboard/list.jsp", '_top');
			event.preventDefault();
		}
	}
	function createHomeWindow(event) {
		if (myWindow === null) {
			myWindow = window.open("mainPage.jsp", '_top');
			event.preventDefault();
		}
	}
	function createRegisterWindow(event) {
		if (myWindow === null) {
			myWindow = window.open("registerPage.jsp", '_top');
			event.preventDefault();
		}
	}
	function createWayWindow(event) {
		if (myWindow === null) {
			myWindow = window.open("WayPage.html", '_top');
			event.preventDefault();
		}
	}
</script>

</head>

<body onload="call_js()">
	<header>
		<img src="./img/dog.jpg" alt="">
		<ul>
			<li class="menu"><a href="#home" class="dropbtn">Home</a></li>
			<li class="menu"><a href="#sitemap" class="dropbtn">Sitemap</a></li>
		</ul>
	</header>
	<nav>
		<ul>
			<li class="menu"><a href="#home" class="dropbtn"
				onclick="createHomeWindow(event)">홈</a></li>
			<li class="menu"><a href="#gallery" class="dropbtn">갤러리</a></li>
			<li class="menu"><a href="#board" class="dropbtn">게시판</a>
				<div class="content">
					<a href="#" onclick="createBoardWindow(event)">자유 게시판</a> <a
						href="#">문의 게시판</a> <a href="#">건의 게시판</a>
				</div></li>
			<li class="menu"><a href="#" class="dropbtn">상품구매</a>
				<div class="content">
					<a href="#">상품목록</a> <a href="#">장바구니</a> <a href="#">주문확인 /
						배송조회</a>
				</div></li>
			<li class="menu"><a href="#" class="dropbtn"
				onclick="createWayWindow(event)">찾아오시는길</a></li>
						<%
			if (loginID == null) {
			%>
			<li class="member"><a href="#" class="dropbtn"
				onclick="createRegisterWindow(event)">회원가입</a></li>
			<li class="member"><a href="#" class="dropbtn"
				onclick="createLoginWindow(event)">로그인</a></li>
			<%
			} else if (loginID.equals("admin")) {
			%>
			<li class="menu"><span>관리자님 환영합니다!!!!!!!!!!!!!!!!!!!!!!!</span></li>
			<li class="menu"><a href="#" class="dropbtn">회원관리</a>
				<div class="content">
					<a href="modUser.jsp">회원정보수정(나중에)</a> <a href="deleteUser.jsp">회원삭제</a>
					<a href="logoff.jsp">로그아웃</a>
				</div></li>
			<%
			} else {
			%>
			<li class="menu"><span><%=loginID%>님 환영합니다</span></li>
			<li class="menu"><a href="#" class="dropbtn">마이페이지</a>
				<div class="content">
					<a href="modPage.jsp">내정보수정</a> <a href="deletePage.jsp">회원탈퇴</a> <a
						href="logoff.jsp">로그아웃</a>
				</div></li>
			<%
			}
			%>
		</ul>
	</nav>
	<section>
		<font size="5" face="바탕체"> 입력하신 내용대로 <b>회원정보가 수정 되었습니다.</b><br></br>
			3초후에 Login Page로 이동합니다
		</font>
	</section>
	<footer>
		<div class="footer content1">
			<a href="">다운로드</a> <a href="">개인정보처리방침</a> <a href="">저작권지침및신고</a> <a
				href="">이메일무단수집거부</a>
		</div>
		<div class="footer content2">
			<p>강남지원 3관 : 서울특별시 강남구 테헤란로 130 호산빌딩 5F, 6F (T: 1544-9970)</p>
			<p>
				Copyright <span>ⓒ</span> 2018 mrhi, Inc. All right reserved. Contact
				webmaster for more information. 23-455-1234
			</p>
		</div>
	</footer>
</body>

</html>
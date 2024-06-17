<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="membertwo.*"%>
<jsp:useBean id="dao" class="membertwo.CustomerDAO" />
<!DOCTYPE html>
<html lang="en">
<%
String loginID = (String) session.getAttribute("loginID");
CustomerVO vo = dao.getMember(loginID);
%>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
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
	function logout() {
	    fetch('logout', {
	        method: 'GET',
	        credentials: 'same-origin'
	    })
	    .then(response => {
	        if (response.redirected) {
	            window.location.href = response.url; // 로그아웃 후 리다이렉트
	        }
	    })
	    .catch(error => console.error('Error during logout:', error));
	}
</script>

</head>

<body onload="call_js()">
	<header>
		<img src="./img/logo.jpeg" alt="">
		<nav style="height: 100%;">
			<!-- 	css 때문에 만듦. div 개수는 참고만. -->
			<div id="nav">
				<!-- nav시작 -> 앵커와 div를 중앙 정렬하면 중앙 위치가 안 맞아서 position으로 위치 정렬 필요 -->
				<div id="navDiv">
					<!-- 앵커 -->
					<a href="" class="boardA" onclick="createHomeWindow(event)">홈 </a>
					<a href="" class="boardA">갤러리</a> <a href="" id="boardAA"
						class="boardA">게시판</a> <a href="" class="boardA">상품구매</a>
					<%
					if (loginID == null) {
					%>
					<a href="" class="boardA"></a>
					<%
					} else if (loginID.equals("admin")) {
					%>
					<a href="" class="boardA">고객관리</a>
					<%
					} else {
					%>
					<a href="" class="boardA">마이페이지</a>
					<%
					}
					%>
					<!-- 숨겨진 메뉴 시작 -->
					<div id="boardDiv">
						<div id="boardHide">
							<div id="hideBoard">
								<div>
									<!-- id를 따로 만든 이유는 마우스 올라갈 때 div배경색 변경하게 하려고 -->
									<div class="boardHide" id="board19">
										<a href=""></a>
									</div>
									<div class="boardHide" id="board29">
										<a href=""></a>
									</div>
									<div class="boardHide" id="board3">
										<a href="" onclick="createBoardWindow(event)">자유게시판</a> <a
											href="">문의게시판</a> <a href="">건의게시판</a> <a href=""></a>
									</div>
									<div class="boardHide" id="board4">
										<a href="">상품목록</a> <a href="">장바구니</a> <a href="">주문확인 /
											배송조회</a>
									</div>
									<%
									if (loginID == null) {
									%>
									<div class="boardHide" id="board9">
										<a href=""></a>
									</div>
									<%
									} else if (loginID.equals("admin")) {
									%>
									<div class="boardHide" id="board5">
										<a href="customerList.jsp">회원삭제</a> <a href="logout.jsp">로그아웃</a>
									</div>
									<%
									} else {
									%>
									<div class="boardHide" id="board5">
										<a href="modPage.jsp">내정보수정</a> <a href="deletePage.jsp">회원탈퇴</a>
										<a href="logoff.jsp">로그아웃</a>
									</div>
									<%
									}
									%>
									<div class="boardHide" id="board9">
										<a href=""></a>
									</div>
									<div class="boardHide" id="board9">
										<a href=""></a>
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</nav>
		<ul class="member">
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
			<li class="menu"><span>관리자님 환영합니다</span></li>
			<%
			} else {
			%>
			<li class="menu"><span><%=loginID%>님 환영합니다</span></li>
			<%
			}
			%>
		</ul>
	</header>

		<!-- 회원가입 코드-->
		<div class="register">
			<h1>회원수정</h1>

			<div>
				<span style="color: red;">●</span><span
					style="font-weight: bold; font-size: large;"> 회원 정보수정</span>
				<hr />
				<p>&middot; 고객님의 정보는 개인정보정책에 의해 철저하게 보호됩니다.</p>
				<hr />
			</div>
			<form action="modPro.jsp" method="post" name="regpage">
				<table>
					<tbody>
						<tr>
							<!-- ID -->
							<label for="userId">
								<th>사용자ID<span> *</span></th>
							</label>
							<td><%=vo.getUserId()%></td>
						</tr>
						<tr>
							<!-- PW -->
							<label for="pwd">
								<th>비밀번호<span> *</span></th>
							</label>
							<td><input type="password" name="pwd" id="pwd" size="20"
								minlength="4" maxlength="12" required
								onblur="userPwCheck('blur')" onfocus="userPwCheck('focus')" />
								<span id="pwdInfo"></span></td>
						</tr>
						<tr>
							<!-- PW CHECK -->
							<label for="pwdCk">
								<th>비밀번호 확인<span> *</span></th>
							</label>
							<td><input type="password" name="pwdCk" id="pwdCk" size="20"
								minlength="4" maxlength="12" required onblur="userPwCkCheck()" />
								<span id="pwdCkInfo"></span></td>
						</tr>
						<tr>
							<!-- NAME -->
							<label for="userName">
								<th>성명<span> *</span></th>
							</label>
							<td><input type="text" name="userName" id="userName"
								size="20" minlength="2" maxlength="4" required
								onblur="userNameCheck()" /> <span id="userNameInfo"></span></td>
						</tr>
						<tr>
							<!-- EMAIL -->
							<label for="email">
								<th>E-mail<span> *</span></th>
							</label>
							<td><input type="text" name="email" id="email" size="12"
								minlength="5" required onblur="userEmailCheck()" /><span>
									@</span> <input class="box" name="domain" id="domain" type="text"
								style="margin-left: 0px;" onblur="userEmailCheck()" /> <select
								class="box" id="domain-list" onblur="userEmailCheck()">
									<option value="type">직접 입력</option>
									<option value="naver.com">naver.com</option>
									<option value="google.com">google.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="nate.com">nate.com</option>
									<option value="kakao.com">kakao.com</option>
							</select> <input type="checkbox" name="getMail" id="getMail"> <b>메일수신여부</b><br />
								<span id="emailInfo"></span><br> <span></span> &middot; 할인
								이벤트정보 및 할인쿠폰, 관심분야 등 꼭 필요한 정보를 빠르게 받아보실 수 있습니다.</span><br /> <span>
									&middot; 비밀번호 분실시 E-mail로 확인해 드리니,<span
									style="font-weight: bold; color: blue">정확한 E-mail주소를 기입</span>해
									주세요
							</span><span></span></td>
						</tr>
						<tr>
							<!-- POSTAL CODE -->
							<label for="postal">
								<th>우편번호<span> *</span></th>
							</label>
							<td><input type="text" name="postal" id="sample6_postcode"
								size="3" maxlength="3" required /> <input type="button"
								value="우편번호 검색" onclick="sample6_execDaumPostcode()" /></td>
						</tr>
						<tr>
							<!-- ADDRESS -->
							<label for="address1">
								<th>주소<span> *</span></th>
							</label>
							<td><input type="text" name="address1" id="sample6_address"
								size="40" required onblur="addressCheck()" /> &middot; 주소 <span
								id="addressInfo"></span><br /> <input type="text"
								name="address2" id="sample6_detailAddress" size="40"
								placeholder="ex&#41; kh빌딩, 302호" /> &middot; 상세주소<br /> <input
								type="text" name="address3" id="sample6_extraAddress" size="40" />
								&middot; 참고항목</td>
						</tr>
						<tr>
							<!-- PHONE -->
							<label for="phone">
								<th>휴대폰번호<span> *</span></th>
							</label>
							<td><input type="tel" name="phone" id="phone" minlength="11"
								maxlength="11" required onblur="userPhoneCheck('blur')"
								onfocus="userPhoneCheck('focus')" /><span id="phoneInfo"></span></td>
						</tr>
						<tr>
							<!-- SUBMIT BUTTON -->
							<td colspan="2" style="text-align: center;">
								<button type="submit" onclick="allCheck(event)">업데이트</button>
								&nbsp;&nbsp; <input type="button" value="취소"
								onClick="javascript:window.location='loginPage.jsp'" />
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<!-- 회원가입 코드 끝 -->
	
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
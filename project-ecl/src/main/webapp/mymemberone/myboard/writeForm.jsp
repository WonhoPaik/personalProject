<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="color.jsp"%>
<%
request.setCharacterEncoding("utf-8");
%>
<%@ page import="membertwo.CustomerDAO"%>
<%@ page import="membertwo.CustomerVO"%>
<jsp:useBean id="dao" class="membertwo.CustomerDAO" scope="page" />
<%
String loginID = (String) session.getAttribute("loginID");
//게시판 답글을 작성할때 사용합니다. (원글 num = 0, ref = 1, step = 0, depth = 0, 답글: 원글바탕하에 num,ref,step,depth 결정됨)
int num = 0, ref = 1, step = 0, depth = 0;
try {
	if (request.getParameter("num") != null) {
		num = Integer.parseInt(request.getParameter("num"));
		ref = Integer.parseInt(request.getParameter("ref"));
		step = Integer.parseInt(request.getParameter("step"));
		depth = Integer.parseInt(request.getParameter("depth"));
	}
	CustomerVO vo = dao.getMember(loginID);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="../css/mainPage.css" type="text/css">
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
		<img src="../img/logo.jpeg" alt="">
		<nav style="height: 100%;">
			<!-- 	css 때문에 만듦. div 개수는 참고만. -->
			<div id="nav">
				<!-- nav시작 -> 앵커와 div를 중앙 정렬하면 중앙 위치가 안 맞아서 position으로 위치 정렬 필요 -->
				<div id="navDiv">
					<!-- 앵커 -->
					<a href="../mainPage.jsp" class="boardA">홈 </a>
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
										<a href="list.jsp">자유게시판</a> <a
											href="">문의게시판</a> <a href="">공지사항</a> <a href=""></a>
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
										<a href="../deleteUser.jsp">회원삭제</a> <a href="../logoff.jsp">로그아웃</a>
									</div>
									<%
									} else {
									%>
									<div class="boardHide" id="board5">
										<a href="../modPage.jsp">내정보수정</a> <a href="../deletePage.jsp">회원탈퇴</a>
										<a href="../logoff.jsp">로그아웃</a>
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
			<li class="member"><a href="../registerPage" class="dropbtn">회원가입</a></li>
			<li class="member"><a href="../loginPage" class="dropbtn">로그인</a></li>
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
<section id="writeSection">
    <div class="write-container">
        <h2>글쓰기</h2>
        <form method="post" name="writeForm" action="writeProc.jsp" enctype="multipart/form-data" onsubmit="return writeSave()">
            <input type="hidden" name="num" value="<%=num%>">
            <input type="hidden" name="ref" value="<%=ref%>">
            <input type="hidden" name="step" value="<%=step%>">
            <input type="hidden" name="depth" value="<%=depth%>">
            
            <div class="form-group">
                <label for="writer">이름</label>
                <input type="text" id="writer" name="writer" maxlength="12" required>
            </div>
            
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" maxlength="30" required>
            </div>
            
            <div class="form-group">
                <label for="subject">제목</label>
                <% if (request.getParameter("num") == null) { %>
                <input type="text" id="subject" name="subject" maxlength="50" required>
                <% } else { %>
                <input type="text" id="subject" name="subject" value="[답변]" maxlength="50" required>
                <% } %>
            </div>
            
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" rows="10" required></textarea>
            </div>
            
            <div class="form-group">
                <label for="pass">비밀번호</label>
                <input type="password" id="pass" name="pass" maxlength="10" required>
            </div>
            
            <div class="form-group">
                <label for="filename">첨부파일</label>
                <input type="file" id="filename" name="filename">
            </div>
            
            <div class="button-group">
                <input type="submit" value="글쓰기" class="btn-submit">
                <input type="reset" value="다시작성" class="btn-reset">
                <input type="button" value="목록" class="btn-list" onclick="window.location='list.jsp'">
            </div>
            
        </form>
        </div>
		<%
		} catch (Exception e) {
		}
		%>
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
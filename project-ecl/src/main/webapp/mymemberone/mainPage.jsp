<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="boardone.BoardDAO"%>
<%@ page import="boardone.BoardVO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
String loginID = (String) session.getAttribute("loginID");

//멤버변수 수정 <1>
//리스트에 전체 보여줄 페이지 라인수 (페이지당 10개를 보여주세요)
int pageSize = 5;
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//<수정 2>
//페이지를 지정한게 없으면 기본으로 1페이지를 세팅한다.
String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1";
}
//현재페이지와 현재페이지 시작라인, 끝라인 계산한다.
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;

int count = 0;
int number = 0;
List<BoardVO> articleList = null;
//싱글톤방식 객체
BoardDAO dbPro = BoardDAO.getInstance();
count = dbPro.getArticleCount();//전체 글수
if (count > 0) {
	articleList = dbPro.getArticles(startRow, endRow);//수정<3>
}
//번호순으로 보여주고 싶을때 계산한다.
number = count - (currentPage - 1) * pageSize;//수정<4>
%>
<!DOCTYPE html>
<html lang="en">

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
										<a href="deleteUser.jsp">회원삭제</a> <a href="logoff.jsp">로그아웃</a>
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
	<section>
		<div class="section">
			<div class="slideshow">
				<div class="slideshow_slides">
					<a href="#"><img src="./img/furniture1.jpg" alt="slide1"></a>
					<a href="#"><img src="./img/furniture2.jpg" alt="slide2"></a>
					<a href="#"><img src="./img/furniture3.jpg" alt="slide3"></a>
					<a href="#"><img src="./img/furniture4.jpg" alt="slide4"></a>
				</div>
				<div class="slideshow_nav">
					<a href="" class="prev"><i
						class="fa-solid fa-circle-chevron-left"></i></a> <a href=""
						class="next"><i class="fa-solid fa-circle-chevron-right"></i></a>
				</div>
				<div class="indicator">
					<a href="#" class="active"><i class="fa-solid fa-circle-dot"></i></a>
					<a href="#"><i class="fa-solid fa-circle-dot"></i></a> <a href="#"><i
						class="fa-solid fa-circle-dot"></i></a> <a href="#"><i
						class="fa-solid fa-circle-dot"></i></a>
				</div>
			</div>

			<div class="category">
				<!-- 게시판 표시 시작 -->
				<div class="board">
  <div class="board-header">
    <span id="board_name"><b>최신글보기</b></span>
    <a href="myboard/writeForm.jsp" class="write-btn" >글쓰기</a>
  </div>
  <%
  if (count == 0) {
  %>
  <table width="600" border="1" cellpadding="0" cellspacing="0" class="board-table">
    <tr>
      <td align="center" class="no-posts">게시판에 저장된 글이 없습니다.</td>
    </tr>
  </table>
  <%
  } else {
  %>
  <table border="1" width="600" cellpadding="0" cellspacing="0" align="center" class="board-table">
    <tr height="30" class="board-header">
      <td align="center" width="50">번 호</td>
      <td align="center" width="250">제 목</td>
      <td align="center" width="100">작성자</td>
      <td align="center" width="150">작성일</td>
      <td align="center" width="50">조 회</td>
    </tr>
    <%
    for (int i = 0; i < articleList.size(); i++) {
      BoardVO article = (BoardVO) articleList.get(i);
    %>
    <tr height="30" class="board-row">
      <td align="center" width="50"><%=number--%></td>
      <td width="250">
        <%
        int wid = 0;
        if (article.getDepth() > 0) {
          wid = 5 * (article.getDepth());
        %>
        <img src="images/level.gif" width="<%=wid%>" height="16">
        <img src="images/re.gif">
        <%
        } else {
        %>
        <img src="images/level.gif" width="<%=wid%>" height="16">
        <%
        }
        %>
        <a href="myboard/content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>" class="subject-link">
          <%=article.getSubject()%></a>
        <%
        if (article.getReadcount() >= 20) {
        %>
        <img src="images/hot.gif" border="0" height="16">
        <%
        }
        %>
      </td>
      <td align="center" width="100"><a href="mailto:<%=article.getEmail()%>" class="email-link"><%=article.getWriter()%></a></td>
      <td align="center" width="150"><%=sdf.format(article.getRegdate())%></td>
      <td align="center" width="50"><%=article.getReadcount()%></td>
    </tr>
    <%
    }
    %>
    <%
    }
    %>
  </table>
</div>
				<!-- 게시판 표시 끝 -->
				<div class="board">
  <div class="notice-header">
    <span id="board_notice"><b>공지사항 (전체 글:<%=count%>)</b></span>
  </div>
  <%
  if (count == 0) {
  %>
  <table width="600" border="1" cellpadding="0" cellspacing="0" class="board-table">
    <tr>
      <td align="center" class="no-posts">게시판에 저장된 글이 없습니다.</td>
    </tr>
  </table>
  <%
  } else {
  %>
  <table border="1" width="600" cellpadding="0" cellspacing="0" align="center" class="board-table">
    <tr height="30" class="board-header">
      <td align="center" width="50">번 호</td>
      <td align="center" width="250">제 목</td>
      <td align="center" width="100">작성자</td>
      <td align="center" width="150">작성일</td>
      <td align="center" width="50">조 회</td>
    </tr>
    <%
    for (int i = 0; i < articleList.size(); i++) {
      BoardVO article = (BoardVO) articleList.get(i);
    %>
    <tr height="30" class="board-row">
      <td align="center" width="50"><%=number--%></td>
      <td width="250">
        <%
        int wid = 0;
        if (article.getDepth() > 0) {
          wid = 5 * (article.getDepth());
        %>
        <img src="images/level.gif" width="<%=wid%>" height="16">
        <img src="images/re.gif">
        <%
        } else {
        %>
        <img src="images/level.gif" width="<%=wid%>" height="16">
        <%
        }
        %>
        <a href="myboard/content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>" class="subject-link">
          <%=article.getSubject()%></a>
        <%
        if (article.getReadcount() >= 20) {
        %>
        <img src="images/hot.gif" border="0" height="16">
        <%
        }
        %>
      </td>
      <td align="center" width="100"><a href="mailto:<%=article.getEmail()%>" class="email-link"><%=article.getWriter()%></a></td>
      <td align="center" width="150"><%=sdf.format(article.getRegdate())%></td>
      <td align="center" width="50"><%=article.getReadcount()%></td>
    </tr>
    <%
    }
    %>
    <%
    }
    %>
  </table>
</div>
			</div>
		</div>
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
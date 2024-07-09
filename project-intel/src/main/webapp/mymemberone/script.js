/**
 * 
 */
//콜백함수 (onLoad call back funct)
function call_js() {
	//ui객체참조변수 선언
	let slideshow = document.querySelector(".slideshow");
	let slideshow_slides = document.querySelector(".slideshow_slides");
	//<a href="#"><img></a> ui객체배열
	let slides = document.querySelectorAll(".slideshow_slides a");
	let prev = document.querySelector(".prev");
	let next = document.querySelector(".next");
	let indicators = document.querySelectorAll(".indicator a")
	//회전목마 현재위치값, 시간설정, 슬라이드 수
	let currentIndex = 0;
	let timer = null;
	let slideCount = slides.length;

	//회전목마 이미지를 우측으로 배치시켜준다.
	for (let i = 0; i < slides.length; i++) {
		let newLeft = i * 100 + '%';
		slides[i].style.left = newLeft;
	}
	//회전목마를 움직인다.() slideshow_slides 왼쪽으로 -100% 이동
	function gotoSlide(index) {
		currentIndex = index;
		let newLeft = index * -100 + '%';
		slideshow_slides.style.left = newLeft;
		indicators.forEach((e) => {
			e.classList.remove("active");
		});
		// for (let i = 0; i < indicators.length; i++) {
		//   indicators[i].classList.remove("active");
		// }
		indicators[currentIndex].classList.add("active");
	}
	//0번부터 3번까지 3초간 gotoSlide를 불러준다.
	gotoSlide(0);
	//3초간
	function startTimer() {
		timer = setInterval(() => {
			currentIndex += 1;
			let index = currentIndex % slideCount;
			gotoSlide(index)
		}, 3000);
	}
	startTimer();

	//이벤트처리 
	slideshow_slides.addEventListener("mouseenter", function() {
		clearInterval(timer);
	});
	slideshow_slides.addEventListener("mouseleave", function() {
		startTimer();
	});
	prev.addEventListener("mouseenter", function() {
		clearInterval(timer);
	});
	next.addEventListener("mouseenter", function() {
		clearInterval(timer);
	});
	prev.addEventListener("click", function(e) {
		e.preventDefault(); // atag 기본기능을 막는다
		currentIndex -= 1;
		if (currentIndex < 0) {
			currentIndex = slideCount - 1;
		}
		gotoSlide(currentIndex);
	});
	next.addEventListener("click", function(e) {
		e.preventDefault();
		currentIndex += 1;
		if (currentIndex > slideCount - 1) {
			currentIndex = 0;
		}
		gotoSlide(currentIndex);
	});
	indicators.forEach((e) => {
		e.addEventListener("mouseenter", () => {
			clearInterval(timer);
		});
	});
	for (let i = 0; i < indicators.length; i++) {
		indicators[i].addEventListener("click", (e) => {
			e.preventDefault();
			gotoSlide(i);
		});
	}
}
//회전목마

//회원가입페이지관련
//  회원가입 js
//아이디 중복확인
function idCheck(id) {
	if (id == "") {
		alert("아이디를 입력해 주세요.");
		document.regForm.id.focus();
	} else {
		url = "idCheck.jsp?id=" + id;
		window.open(url, "post", "width=300,height=150");
	}
}
//비밀번호
function userPwCheck(state) {
	const pwd = document.querySelector("#pwd");
	const pwdInfo = document.querySelector("#pwdInfo");
	if (state === "blur") {
		if (pwd.value === "") {
			pwdInfo.innerHTML = ` 필수입력항목입니다.`;
			return false;
		} else if (pwd.value.length >= 4 && pwd.value.length <= 12) {
			pwdInfo.innerHTML = ` 사용가능합니다.`;
			return true;
		}
	} else if (state === "focus") {
		pwdInfo.innerHTML = `&middot; 4~12자리의 영문,숫자,특수문자(!, @, $, %, ^, &, *)만 가능`;
		return false;
	}
}
function userPwCkCheck() {
	const pwd = document.querySelector("#pwd");
	const pwdCk = document.querySelector("#pwdCk");
	const pwdCkInfo = document.querySelector("#pwdCkInfo");
	if (pwd.value !== pwdCk.value) {
		pwdCkInfo.innerHTML = `비밀번호가 일치하지않습니다`;
		return false;
	} else if (pwdCk.value === "") {
		pwdCkInfo.innerHTML = ``;
	} else {
		pwdCkInfo.innerHTML = `일치합니다.`;
		return true;
	}
}
//성명
function userNameCheck() {
	const userName = document.querySelector("#userName");
	const userNameInfo = document.querySelector("#userNameInfo");
	//한글 2~4문자 패턴
	let nameExp = /^[가-힣]{2,4}$/;
	if (userName.value === "") {
		userNameInfo.innerHTML = ` &middot; 필수입력항목입니다.`;
		return false;
	} else if (!userName.value.match(nameExp) === true) {
		userNameInfo.innerHTML = `한글 2~4문자 입력바람`;
		return false;
	} else {
		userNameInfo.innerHTML = `사용가능합니다.`;
		return true;
	}
}
//이메일
function userEmailCheck() {
	const email = document.querySelector("#email");
	const domain = document.querySelector("#domain");
	const emailInfo = document.querySelector("#emailInfo");
	//이메일 정규식
	let emailExp = /^[a-zA-Z0-9._-]{1,12}$/i;
	let domainExp = /^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i
	if (email.value === "" || domain.value === "") {
		emailInfo.innerHTML = ` &middot; 필수입력항목입니다.`;
		return false;
	} else if (!email.value.match(emailExp) === true || !domain.value.match(domainExp) === true) {
		emailInfo.innerHTML = ` &middot; 이메일 형식에 맞게 입력바람`;
		return false;
	} else {
		emailInfo.innerHTML = ` &middot; 사용가능합니다.`;
		return true;
	}
}
const domainListEl = document.querySelector('#domain-list')
const domainInputEl = document.querySelector('#domain')
// select 옵션 변경 시
domainListEl.addEventListener('change', (event) => {
	// option에 있는 도메인 선택 시
	if (event.target.value !== "type") {
		// 선택한 도메인을 input에 입력하고 disabled
		domainInputEl.value = event.target.value
		domainInputEl.disabled = true
	} else { // 직접 입력 시
		// input 내용 초기화 & 입력 가능하도록 변경
		domainInputEl.value = ""
		domainInputEl.disabled = false
	}
})
//주소
function addressCheck() {
	const address = document.querySelector("#address1");
	const addressInfo = document.querySelector("#addressInfo")
	if (address.value === "") {
		addressInfo.innerHTML = ` &nbsp;&middot; 필수입력항목입니다.`;
		return false;
	} else {
		addressInfo.innerHTML = ``;
		return true;
	}
}
//폰번호
function userPhoneCheck(state) {
	const phone = document.querySelector("#phone");
	const phoneInfo = document.querySelector("#phoneInfo");
	let result = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	if (state === "blur") {
		if (phone.value === "") {
			phoneInfo.innerHTML = ` &middot; 필수입력항목입니다.`;
			return false;
		} else if (!phone.value.match(result) === true) {
			phoneInfo.innerHTML = ` &middot; 형식에 맞게 입력바람`;
			return false;
		} else {
			phoneInfo.innerHTML = ` &middot; 사용가능합니다.`;
			return true;
		}
	} else if (state === "focus") {
		phoneInfo.innerHTML = ` &middot; -을 제외한 숫자만 입력해주세요.`;
		return false;
	}
}
function allCheck(event) {
	const userId = document.querySelector("#userId");
	const pwd = document.querySelector("#pwd");
	const pwdCk = document.querySelector("#pwdCk");
	const userName = document.querySelector("#userName");
	const email = document.querySelector("#email");
	const domain = document.querySelector("#domain");
	const postal = document.querySelector("#postal");
	const address1 = document.querySelector("#address1");
	const address2 = document.querySelector("#address2");
	const phone = document.querySelector("#phone");
	const address = address1.value + ' ' + address2.value;
	const emailDomain = email.value + '@' + domain.value;
	if (pwd.value !== pwdCk.value) {
		alert("비밀번호가 일치하지 않습니다.");
		event.preventDefault();
		return false;
	} else {
		if (userId.value === "" || pwd.value === "" || pwdCk.value === "" || userName.value === "" || email.value === "" || emailDomain.value === "" || postal.value === "" || address.value === "" || phone.value === "") {
			alert("모든 필수항목 입력바람");
			event.preventDefault();
			return false;
		} else {
			alert(`아이디 = ${userId.value}\n비밀번호 = ${pwd.value}\n성명 = ${userName.value}\n이메일 = ${emailDomain}\n우편번호 = ${postal.value}\n주소 = ${address}\n휴대폰번호 = ${phone.value}`);
			return true;
		}
	}

}
// 회원가입 js 끝
// 로그인 js 시작
const userId = document.querySelector("#userId");
const loginUserId = document.querySelector("#loginId");
const pwd = document.querySelector("#pwd");
const loginPwd = document.querySelector("#loginPwd");
function registeredCheck(event) {
  if (userId.value !== loginUserId.value || userId.value === "") {
    alert("등록되지않은 계정입니다.");
    event.preventDefault();
    return false;
  } else if (pwd.value === "" || pwd.value !== loginPwd.value) {
    alert("비밀번호를 확인해주세요");
    event.preventDefault();
    return false;
  } else {
    alert(`로그인에 성공했습니다.`);
    return true;
  }
}
//  로그인 js 끝

//아이디체크
function idCheck(id) {
	if (id == "") {
		alert("아이디를 입력해 주세요.");
		document.registerPage.id.focus();
	} else {
		url = "idCheck2.jsp?userId=" + id;
		window.open(url, "post", "width=300,height=150");
	}
}

//로그인하면 메뉴 바꿔줌
/*function checkLoginStatus() {
    	if(loginID != null){
    		return loginID; 
    	}
	}
	
	function updateUserMenu() {
		const username = checkLoginStatus();
		const memberMenu = document.querySelector('.member-menu');
		
		if (username) {
			memberMenu.innerHTML = `
				<li class="menu"><span>${username}님 환영합니다</span></li>
				<li class="menu"><a href="#" class="dropbtn">정보수정</a></li>
				<li class="menu"><a href="#" class="dropbtn">회원탈퇴</a></li>
				<li class="menu"><a href="#" class="dropbtn">로그아웃</a></li>
			`;
		} else {
			memberMenu.innerHTML = `
				<li class="menu"><a href="#" class="dropbtn" onclick="createRegisterWindow(event)">회원가입</a></li>
				<li class="menu"><a href="#" class="dropbtn" onclick="createLoginWindow(event)">로그인</a></li>
			`;
		}
	}
	
	window.onload = function() {
		updateUserMenu();
	};*/
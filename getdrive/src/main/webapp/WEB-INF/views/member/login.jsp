<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="../common/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.js"></script>
<style type="text/css">
#loginzone {
	width: 40%;
	height: 80%;
	vertical-align: middle;
	display: inline-block;
	margin-top:120px; 
}
input {
	-webkit-writing-mode: horizontal-tb !important;
	text-rendering: auto;
	color: initial;
	letter-spacing: normal;
	word-spacing: normal;
	text-transform: none;
	text-indent: 0px;
	text-shadow: none;
	display: inline-block;
	text-align: start;
	-webkit-appearance: textfield;
	background-color: white;
	-webkit-rtl-ordering: logical;
	cursor: text;
	margin: 0em;
	padding: 1px 0px;
	border-width: 2px;
	border-style: inset;
	border-color: initial;
	border-image: initial;
}

.inner_login {
	position: absolute;
	left: 50%;
	top: 50%;
	margin: -145px 0 0 -160px;
}
.screen_out {
	position: absolute;
	width: 0;
	height: 0;
	overflow: hidden;
	line-height: 0;
	text-indent: -9999px;
}


body, button, input, select, td, textarea, th {
	font-size: 13px;
	line-height: 1.5;
}

fieldset, img {
	border: 0;
}

.box_login {
	width: 100%;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #fff;
	box-sizing: border-box;
}


.inp_text {
	position: relative;
	width: 100%;
	margin: 0;
	padding: 8px 19px 8px;
	box-sizing: border-box;
	font-size : 50pt;
}

.inp_text+.inp_text {
	border-top: 1px solid #ddd;
}

.inp_text input {
	display: block;
	width: 100%;
	height: 40px;
	font-size: 18px;
	font-family :sans-serif;
	font-weight: 600;
	color: #444444;
	border: none;
	outline: 0;
	-webkit-appearance: none;
	background-color: transparent;
	cursor: pointer;
}

.inp_text input::placeholder{
	color: #999999;
}

.btn_login {
	background: #6DBFF2;
	border-radius: 5px;
	color: white;
	cursor: pointer;
	border: 1px solid rgb(107, 185, 237);
	padding: 7px;
	width: 100%;
	height: 40px;
	text-align: center;
	font-weight: 600;
	font-size: 12pt;
}

.btn_login:active {
	color: white;
	background: rgb(200, 230, 255);
	border:none;
}

.login_append.txt_find {
	float: right;
	color: #666666;
	text-align: center;
	font-weight: 600;
	text-decoration-line: none;
}

.login_append.txt_find:active {
	color: #999999;
	border:none;
}

.QR_login {
	color: #666666;
	line-height: 2.1;
	font-weight: 600;
	text-decoration-line: none;
}

.QR_login:active {
	color: #999999;
}

#google {
	margin: 10px;
	width: 40px;
}

#kakao {
	margin: 10px;
	width: 40px;
}

#naver {
	margin: 10px;
	width: 40px;
}

.join_button {
	background: #6DBFF2;
	border-radius: 5px;
	color: white;
	cursor: pointer;
	border: 1px solid rgb(107, 185, 237);
	padding: 7px;
	width: 100%;
	height: 40px;
	text-align: center;
	font-weight: 600;
	font-size: 12pt;
}

.join_button:active {
	color: white;
	background: rgb(200, 230, 255);
	border:none;
}

.loginErrorMessage {
	width: 100%;
	height: 20px;
	color: red;
	text-align: left;
}
</style>
<script type="text/javascript">
function moveContractPage(){
	location.href = "contractPage.do";
}
</script>
<script src="/getdrive/resources/js/kakao.min.js"></script>
<script>
	//발급받은 키 중 javascript키를 사용해준다.
	
	//카카오로그인
	/* function kakaoLogin() {
    Kakao.Auth.login({
    	scope: 'profile_nickname,account_email',
        success: function(authObj) {  
        	console.log(authObj);
            Kakao.API.request({
                url: '/v2/user/me',
                success: res => {
                	const id = res.id;
                    const email = res.kakao_account.email;
                    const name = res.properties.nickname;
                    
                    console.log(id);
                    console.log(email);
                    console.log(name);
                    
                    $('#kakaoEmail').val(email);
                    $('#kakaoName').val(name);
                    $('#kakaoId').val(id);

                
               
					},
					fail : function(error) {
						console.log("Kakao API 요청 실패: " + error);
					}
				});
			},
			fail : function(error) {
				console.log("Kakao 로그인 실패: " + error);
			}
		});
	} */
	Kakao.init('4d2b700f21f5db14e8df9701c31eef5e');
	console.log(Kakao.isInitialized()); // sdk초기화여부판단
	//로그인 후 정보 받기
	//카카오톡 로그인
	function kakaoLogin() {
    Kakao.Auth.login({
        success: function(response) { 
            Kakao.API.request({
                url: '/v2/user/me',
                success: function(response) {
                    console.log(response);
                    console.log("카톡 로그인 아이디 : " + response.id)   
                    console.log("카톡 닉네임 : " + response.properties.nickname)
                    console.log("카톡 이메일 : " + response.kakao_account.email)

                    //location.href="datatest.do?" + "id=" + response.id + "&" + "nickname=" + response.properties.nickname;
                    $.get("kakao_register.do?" + "id=" + response.id + "&" + "nickname=" + response.properties.nickname + "&" + "email=" + response.kakao_account.email)
                    console.log("kakao_register.do?" + "id=" + response.id + "&" + "nickname=" + response.properties.nickname + "&" + "email=" + response.kakao_account.email);

					},
					fail : function(error) {
						console.log("Kakao API 요청 실패: " + error);
					}
				});
			},
			fail : function(error) {
				console.log("Kakao 로그인 실패: " + error);
			}
		});
	}
	//카카오로그아웃  
	function kakaoLogout() {
		if (Kakao.Auth.getAccessToken()) {
			Kakao.API.request({
				url : '/v1/user/unlink',
				success : function(response) {
					console.log(response)
					
				},
				fail : function(error) {
					console.log(error);
				},
			})
			Kakao.Auth.setAccessToken(undefined);
		}
	}
</script>
</head>
<body>
		<div id="loginzone">
			<fieldset>
				<legend class="screen_out">로그인 정보 입력폼</legend>
			<form id="loginForm" action="login.do" method="post">
				<div class="box_login">
					<div class="inp_text">
					
						<label for="loginId" class="screen_out"> 아이디</label> 
						<input type="email" id="loginEmail" name="email" placeholder="이메일" class="pos">
					</div>
					<div class="inp_text">
						<label for="loginPw" class="screen_out"> 비밀번호</label> 
						<input type="password" id="loginPw" name="pwd" placeholder="비밀번호" class="pos">
					</div>
				</div>
				<h3> ${ requestScope.message }</h3>
				<input type="submit" class="btn_login" value="Sign in">
			</form>
				<div class="login_append">
					<span class="QR_login"> <a href="/member/find/password"
						class="QR_login">QR코드로 로그인하기</a>
					</span> <br> <span class="QR_login"> 
						<a href="/member/find/password" class="QR_login">비밀번호 찾기</a>
					</span>
					<hr>
				</div>
				<div class="login_bottom">
					<div class="snsicon">
						<a href="http://www.google.com"><img id="google" alt="getdrive" src="/getdrive/resources/images/google.png"></a> 
						<img id="kakao" alt="getdrive" type="submit" onclick="kakaoLogin();" src="/getdrive/resources/images/kakao.jpg">
						<a href="http://www.naver.com"><img id="naver" alt="getdrive"src="/getdrive/resources/images/naver.png"></a>
						<button onclick="kakaoLogout();">카카오 로그아웃</button>
				
					</div>
					<div>
						<button onclick="moveContractPage(); return false" type="submit" class="join_button">아직 계정이 없으신가요?</button>
					</div>
				</div>
			</fieldset>
		</div>
	
</body>
</html>
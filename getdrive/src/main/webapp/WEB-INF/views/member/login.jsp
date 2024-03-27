<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="../common/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>first</title>
<style type="text/css">
#loginzone {
	width: 40%;
	margin: 5%;
	vertical-align: middle;
	display: inline-block;
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
	font: 400 13.3333px Arial;
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

.login_tistory {
	position: relative;
	width: 320px;
	margin: 0 auto;
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
}

.inp_text+.inp_text {
	border-top: 1px solid #ddd;
}

.inp_text input {
	display: block;
	width: 100%;
	height: 40px;
	font-size: 13px;
	color: #000;
	border: none;
	outline: 0;
	-webkit-appearance: none;
	background-color: transparent;
}

.btn_login {
	background: rgb(107, 185, 237);
	border-radius: 5px;
	color: white;
	cursor: pointer;
	border: 1px solid rgb(107, 185, 237);
	padding: 7px;
	width: 100%;
	height: 40px;
	text-align: center;
}

.btn_login:active {
	color: white;
	background: rgb(200, 230, 255);
}

.login_append {
	overflow: hidden;
	padding: 0 0 0;
}

.inp_chk {
	display: inline-block;
	position: relative;
	margin-bottom: -1px;
}

.login_append .inp_chk {
	float: left;
}

.inp_chk .inp_radio {
	position: absolute;
	z-index: -1;
	top: 0;
	left: 0;
	width: 18px;
	height: 18px;
	border: 0;
}

.inp_chk .lab_g {
	display: inline-block;
	margin-right: 19px;
	color: #909090;
	font-size: 13px;
	line-height: 19px;
	vertical-align: top;
}

.inp_chk .ico_check {
	display: inline-block;
	width: 18px;
	height: 18px;
	margin: 1px 4px 0 0;
	background-position: -60px 0;
	color: #333;
}

.inp_chk .txt_lab {
	vertical-align: top;
}

.login_append.txt_find {
	float: right;
	color: #777;
	text-align: center;
}

.login_append.txt_find:active {
	color: gray;
}

.QR_login {
	line-height: 2.1;
}

.QR_login:active {
	color: gray;
}

.login_bottom {
	height: 500px;
}

.snsicon {
	
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
	background: rgb(107, 185, 237);
	border-radius: 5px;
	color: white;
	cursor: pointer;
	border: 1px solid rgb(107, 185, 237);
	padding: 7px;
	width: 100%;
	height: 40px;
	text-align: center;
}

.join_button:active {
	color: white;
	background: rgb(200, 230, 255);
}

.notpermission {
	color: red;
	text-align: left;
}
</style>
</head>
<body>
	<div id="loginzone">
		<input type="hidden" name="redirectUrl"value="https://apost.dev/manage">
		<fieldset>
			<legend class="screen_out">로그인 정보 입력폼</legend>
			<div class="box_login">
				<div class="inp_text">
					<label for="loginId" class="screen_out"> 아이디</label> 
					<input type="email" id="uid" name="userId" placeholder="ID" class="pos">
				</div>
				<div class="inp_text">
					<label for="loginPw" class="screen_out"> 비밀번호</label> 
					<input type="password" id="upwd" name="userPwd" placeholder="Password" class="pos">
				</div>
			</div>
			<div class="notpermission">아이디 또는 비밀번호가 일치하지 않습니다.</div>
			<button type="submit" class="btn_login" disabled>Sign in</button>
			<div class="login_append">
				<span class="QR_login"> <a href="/member/find/password"
					class="QR_login">QR코드로 로그인하기</a>
				</span> <br> <span class="QR_login"> <a
					href="/member/find/password" class="QR_login">비밀번호 찾기</a>
				</span>
				<hr>
			</div>
			<div class="login_bottom">
				<div class="snsicon">
					<a href="http://www.google.com">
						<img id="google" alt="getdrive" src="/getdrive/resources/images/google.png">
					</a> 
					<a href="http://www.daum.net">
						<img id="kakao" alt="getdrive"src="/getdrive/resources/images/kakao.jpg">
					</a> 
					<a href="http://www.naver.com">
						<img id="naver" alt="getdrive"src="/getdrive/resources/images/naver.png">
					</a>
				</div>
				<div>
					<a href="/getdrive/views/page/provision.html">
					<button type="button" class="join_button" disabled>아직 계정이 없으신가요?</button></a>
				</div>
			</div>
		</fieldset>
	</div>
</body>
</html>
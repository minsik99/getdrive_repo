<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
#guide {
	width: 60%;
	height: 400px;
	float: left;
	margin: 7%;
	text-align: center;
}

#butt {
	float: right;
}

.joinButt {
	background: rgb(107, 185, 237);
	border-radius: 5px;
	color: white;
	cursor: pointer;
	border: 1px solid rgb(107, 185, 237);
	padding: 7px;
	width: 80px;
	height: 35px;
	text-align: center;
}

.joinButt:active {
	color: white;
	background: rgb(200, 230, 255);
}

.teamcreateButt {
	background: rgb(107, 185, 237);
	border-radius: 5px;
	color: white;
	cursor: pointer;
	border: 1px solid rgb(107, 185, 237);
	padding: 7px;
	width: 80px;
	height: 35px;
	text-align: center;
}

.teamcreateButt:active {
	color: white;
	background: rgb(200, 230, 255);
}

.teamselectButt {
	background: rgb(107, 185, 237);
	border-radius: 5px;
	color: white;
	cursor: pointer;
	border: 1px solid rgb(107, 185, 237);
	padding: 7px;
	width: 80px;
	height: 35px;
	text-align: center;
}

.teamselectButt:active {
	color: white;
	background: rgb(200, 230, 255);
}
</style>
</head>
<body>
	<div id="guide">
		<h2>Class.getDrive 처음 방문이신가요?</h2>
		<h4>우선 회원가입을 해주세요.</h4>
		<br>
		<h3>팀원들과 함께 프로젝트를 하려는 건가요?</h3>
		<h4>로그인 후 팀 개설과 팀원 초대를 해 주세요.</h4>
		<br>
		<h3>팀장 또는 팀원으로 부터 초대를 받으셨나요?</h3>
		<h4>로그인 후 팀을 선택해주세요.</h4>
		<br>
	</div>
	<div id="bott">
		<br>
		<br>
		<br>
		<br>
		<br> <a href="/getdrive/views/page/provision.html"><input
			class="joinButt" type="button" value="회원가입"><br>
		<br>
		<br>
		<br>
		<br></a> <input class="teamcreateButt" type="button" value="팀 개설"><br>
		<br>
		<br>
		<br>
		<br> <input class="teamselectButt" type="button" value="팀 선택"><br>
		<br>
		<br>
		<br>
		<br>
	</div>


</body>
</html>
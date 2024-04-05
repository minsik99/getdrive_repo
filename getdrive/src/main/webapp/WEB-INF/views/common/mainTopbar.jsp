<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>getdrive 초기화면</title>
<style type="text/css">
#logo {
	margin: 10px;
	width: 150px;
}

#logospace {
	width: 50%;
	float: left;
	height:80px;	
}

#Temporaryspace {
	width: 50%;
	float: right;
	height:80px;	
	text-align: right;
}
</style>

</head>
<body>

	<div align="left">
		파일명 : mainTopbar.jsp <br>
		세션 : ${ loginMember } <br>
		고유번호 : ${ loginMember.accountNo } | 아이디 : ${ loginMember.email }, 이름 : ${ loginMember.name },
		가입일 : ${ loginMember.cdate }
	</div>	
	
	<div id="logospace">
	<%--로그인 하지 않았을 때 --%>
	<c:if test="${ empty sessionScope.loginMember }">
		<a href="${ pageContext.servletContext.contextPath }/teamMain.do">
		<img id="logo" alt="getdrive"src="/getdrive/resources/images/logo.png">
		</a>
	</c:if>
	
	<%-- 로그인 했을 때 --%>
	<c:if test="${ !empty sessionScope.loginMember }">
		<a href="${ pageContext.servletContext.contextPath }/mainPage.do">
		<img id="logo" alt="getdrive"src="/getdrive/resources/images/logo.png">
		</a>
	</c:if>
	</div>
	
	<div id="Temporaryspace">
		[ <a href="logout.do"> 로그아웃 </a> ]	
	</div>		
</body>
</html>
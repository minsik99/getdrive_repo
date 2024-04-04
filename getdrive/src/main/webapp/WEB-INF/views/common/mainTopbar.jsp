<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
#logo {
	margin: 10px;
	width: 150px;
}
#logospace {
	margin: 10px;
	width: 180px;
	cursor: pointer;
}
</style>
</head>
<body>
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
</body>
</html>
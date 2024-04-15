<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
		String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg=" + errMsg);
		return;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	<div>카테고리 추가</div>
	<form method="post" action="/shop/emp/addCategoryAction.jsp">
		카테고리 : 
		<input type="text" name="category">
		<button type="submit">추가</button>
	</form>

</body>
</html>
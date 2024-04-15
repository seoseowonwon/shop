<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") != null){
		response.sendRedirect("/shop/customer/goodsList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EmpLoginForm</title>
</head>
<body>
	<form method="post" action="/shop/customer/loginAction.jsp">
	
		Email : <input type="email" name="customerEmail">
		Pw : <input type="password" name="customerPw">
		<button type="submit">login</button>
		
	</form>
</body>
</html>
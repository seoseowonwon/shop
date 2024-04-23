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
<title>customerLoginForm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
.container {
	display: flex;
	flex-direction: column;
}

</style>
</head>
<body>

	<nav class="navbar navbar-light">
		<div class="container">
			<a class="navbar-brand" href="/shop/customer/loginForm.jsp"> <img
				src="/shop/upload/hanger.jpg" alt="사진" width="200"
				height="200">
			</a>
		</div>
	</nav>
	<hr>
	<div class="container">
  		<div class="row">
    		<div class="col-4"></div>
    		<div class="col-4">
     			<form method="post" action="loginAction.jsp">
     				
					<div class="input-group mb-3">
						<input type="email" class="form-control" placeholder="이메일" name="customerEmail">
     				</div>
					<div class="input-group mb-3">
					  <input type="password" class="form-control" placeholder="비밀번호" name="customerPw">
					  <button class="btn btn-success" type="submit">제출</button>
					</div>
				</form>
    		</div>
   			<div class="col-4"></div>
  		</div>
	</div>
	
</body>
</html>
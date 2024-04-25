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
.text {
	text-align: center;
}

.img {
	text-align: center;
}

</style>
</head>
<body class="container bg-success">
	<div class="row">
		<div class="col-3"></div>
		<div class="col-6 content bg-white shadow lgPgCenterDiv"><br>
			<div class="img">
		  		<a href="/shop/customer/loginForm.jsp">
		  			<span style="margin-left:5%"><img src="/shop/upload/hanger.jpg" style="width:200px;"></span>
		  		</a>	
			</div>
			<h2>로그인</h2><hr style="border: 1px solid gray;"><br> 
			<form method="post" action="loginAction.jsp">
    				
				<div class="input-group mb-3">
					<input type="email" class="form-control" placeholder="이메일" name="customerEmail">
    				</div>
				<div class="input-group mb-3">
				  <input type="password" class="form-control" placeholder="비밀번호" name="customerPw">
				</div>
				  <button class="form-control btn btn-primary btn-lg" type="submit">로그인</button>		
			</form>
			<br>
    		<div class="text"><a href="/shop/emp/empLoginForm.jsp">직원로그인 페이지 이동</a></div>
    		<br>
    		<br>
    		<br>
    		<br>
    		<br>
    		<br>
    		<br>
    		<br>
    		<br>
    		<br>
    		<br>
    		<br>
    		<br>
    		<br>
    		<br>
    		<br>
    		<br>
    		<br>
    		<div class="position-absolute top-100 start-50 translate-middle text" style="font-size: 12px;">made by 서기원 in goodee</div>
    		<hr>
   		</div>
    	<div class="col-3"></div>
    </div>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 인증분기 : 세션변수 이름 - loginEmp
if (session.getAttribute("loginEmp") != null) {
	response.sendRedirect("/shop/emp/empList.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>empLoginForm</title>
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
<body>
	<body class="container bg-success">
	<div class="row">
		<div class="col-3"></div>
		<div class="col-6 content bg-white shadow lgPgCenterDiv"><br>
			<div class="img">
		  		<a href="/shop/emp/empLoginForm.jsp">
		  			<span style="margin-left:5%"><img src="/shop/upload/hanger.jpg" style="width:200px;"></span>
		  		</a>	
			</div>
			<h2>로그인</h2><hr style="border: 1px solid gray;"><br> 
			<form action="/shop/emp/empLoginAction.jsp">
    				
				<div class="input-group mb-3">
					<input type="text" class="form-control" placeholder="아이디" name="empId">
    				</div>
				<div class="input-group mb-3">
				  <input type="password" class="form-control" placeholder="비밀번호" name="empPw">
				</div>
				  <button class="form-control btn btn-primary btn-lg" type="submit">로그인</button>
				  <br>		
			</form>
    		<div class="text"><a href="/shop/customer/loginForm.jsp">고객 페이지로 이동</a></div>
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
    		<hr>
    		<div class="position-absolute top-100 start-50 translate-middle text" style="font-size: 12px;">made by 서기원 in goodee</div>
    		
   		</div>
    	<div class="col-3"></div>
   		
    </div>
	
	<!--  
	<div class="container">
		<form action="/shop/emp/empLoginAction.jsp">
			<table>
				<tr>
					<td><input type="text" name="empId" placeholder="ID:"></td>
				</tr>
				<tr>
					<td><input type="password" name="empPw"
						placeholder="PASSWORD:"></td>
				</tr>
			</table>
			<button type="submit">로그인</button>
		</form>
	</div>
	-->
</body>
</html>
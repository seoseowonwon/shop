<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("addCustomerForm 로그인");
%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/goodsList.jsp");
		return;
	}
%>
<%
	String checkedEmail = request.getParameter("checkEmail");
	String check = request.getParameter("check");

	System.out.println(checkedEmail + "<-- addCustomerAction param checkedEmail");
	System.out.println(check + "<-- addCustomerAction param check");
	
	//검사한 이메일 checkEmail, 검사 완료 후 사용가능 판정난 이메일 checkedEmail
	String checkEmail = null;
	String checkMsg = "사용 가능한 이메일입니다.";
	
	if(check == null){
		check = "";
		checkMsg = "";
	}
	
	if(checkedEmail == null){
		checkedEmail = "";
	} else{
		checkEmail = checkedEmail;
	}
	
	if(check.equals("X")){
		checkedEmail = "";
		checkMsg = "사용할 수 없는 이메일입니다.";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
	
	<form method="post" action="/shop/customer/checkMailAction.jsp">
		<div>
			EmailCheck : <input type="email" name="customerEmail" value="<%=checkEmail %>">
			<button type="submit">확인</button>
		</div>
		<div>
			<p><%=checkMsg %></p>
		</div>
	</form>
	
	
	<form method="post" action="/shop/customer/addCustomerAction.jsp">
		<div>
			Email : <input type="email" name="customerEmail" value="<%=checkedEmail %>">
		</div>
		<div>
			Pw : <input type="password" name="customerPw">
		</div>
		<div>
			name : <input type="text" name="customerName">
		</div>
		<div>
			birth : <input type="date" name="birth">
		</div>
		<div>
			gender : <input type="radio" name="gender" value="남">남
			<input type="radio" name="gender" value="여">여
		</div>
		<button type="submit">회원가입</button>
	</form>
</body>
</html>
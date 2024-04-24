<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

	System.out.println("addCustomerAction param checkedEmail --> " + checkedEmail );
	System.out.println("addCustomerAction param check --> " + check );
	
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
	<div class="container-fluid">
		
  		<div class="row">
    		<div class="col-4"></div>
    		<div class="col-4">
    			<h1>회원가입</h1>


				<form method="post" action="/shop/customer/checkMailAction.jsp">
					<div class="input-group mb-3">
						<input type="email" class="form-control" placeholder="이메일 중복확인" name="customerEmail">
						<button type="submit">확인</button>
	     			</div>
				</form>
					<div>
						<p><%=checkMsg%></p>
					</div>

				<form method="post" action="/shop/customer/addCustomerAction.jsp">
					<div class="input-group mb-3">
						<input type="email" class="form-control" placeholder="이메일"
							name="customerEmail" value="<%=checkedEmail%>">
					</div>
					
					<div class="input-group mb-3">
						<input type="password" class="form-control" placeholder="비밀번호"
							name="customerPw">
					</div>
					
					<div class="input-group mb-3">
						<input type="text" class="form-control" placeholder="이름"
							name="customerName">
					</div>
					
					<div class="input-group mb-3">
						<input type="date" class="form-control" placeholder="생일"
							name="birth">
					</div>
					
					<div class="input-group mb-3">
						<input type="radio"  name="gender" value="남">&nbsp; 남 &nbsp; 
						<input type="radio"  name="gender" value="여">&nbsp; 여 
					</div>
					
					<button type="submit">회원가입</button>
				</form>
			</div>
   			<div class="col-4"></div>
  		</div>
	</div>
</body>
</html>
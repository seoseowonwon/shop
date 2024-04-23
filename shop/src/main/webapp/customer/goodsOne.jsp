<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>   
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}
%>
<%
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	HashMap<String, Object> list = GoodsDAO.goodsOne(goodsNo);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	.text{
		text-align: center;
		font-size: x-large
		
	}
</style>
</head>
<body>
	<div class="container-fluid">
	<div class="row">
    		<div class="col-4"></div>
    		<div class="col-4">
				<div class = "text"><%=(String)(list.get("goodsTitle"))%></div>
				<hr>
				<div>
					<img src="../upload/<%=(String)(list.get("filename")) %>" 
						width="600" height ="600">
				</div>
				<hr>
				<div>
					<%=(String)(list.get("goodsContent"))%>
				</div>
				<hr>
				
				<div>가격: <%=(String)(list.get("goodsPrice"))%></div>
				<hr>
				<div>수량: <%=(String)(list.get("goodsAmount"))%></div>
				<hr>
			</div>
			<div class="col-4"></div>
		</div>
</body>
</html>
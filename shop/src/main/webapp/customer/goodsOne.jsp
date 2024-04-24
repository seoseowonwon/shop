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
<%

	System.out.println(goodsNo + "<-- goodsOne param goodsNo");
	HashMap<String, Object> goods = GoodsDAO.selectGoods(goodsNo);
	ArrayList<HashMap<String, Object>> reviewList = ReviewDAO.selectReviewList(goodsNo);
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
	<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
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
				<div>
					<form method="post" action="/shop/customer/addOrders.jsp?">
						수량 <input type="number" name="amount"> 주소 <input
							type="text" name="address"> <input type="hidden"
							name="goodsPrice"
							value="<%=(Integer) (goods.get("goodsPrice"))%>"> <input
							type="hidden" name="goodsNo" value="<%=goodsNo%>">

						<button type="submit">주문</button>
					</form>
				</div>
			<hr>
			<div>
			
				<%
					if(reviewList != null){
				%>
						
						<table class="table table-striped">
				<%
						for(HashMap m : reviewList){
							System.out.println("상품후기 작동중!");
				%>
							<tr>
								<td>별점: </td>
								<td> <%=m.get("score") %></td>
							</tr>
							
							<tr>
								<td>후기: </td>
								<td><%=m.get("content") %></td>
							</tr>
						</table>
				<%
						}
					}
				%>
			</div>
		</div>
		</div>
		<div class="col-4"></div>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>   
<%
	//�α��� ���� �б�
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
			
			<div>����: <%=(String)(list.get("goodsPrice"))%></div>
			<hr>
			<div>����: <%=(String)(list.get("goodsAmount"))%></div>
			<hr>
				<div>
					<form method="post" action="/shop/customer/addOrders.jsp?">
						���� <input type="number" name="amount"> �ּ� <input
							type="text" name="address"> <input type="hidden"
							name="goodsPrice"
							value="<%=(Integer) (goods.get("goodsPrice"))%>"> <input
							type="hidden" name="goodsNo" value="<%=goodsNo%>">

						<button type="submit">�ֹ�</button>
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
							System.out.println("��ǰ�ı� �۵���!");
				%>
							<tr>
								<td>����: </td>
								<td> <%=m.get("score") %></td>
							</tr>
							
							<tr>
								<td>�ı�: </td>
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
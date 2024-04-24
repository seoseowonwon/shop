<%@page import="shop.dao.ReviewDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.dao.OrdersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}
%>
<%
	//로그인
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
	String mail = (String)(loginCustomer.get("customerEmail"));
	//페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + "<-- goodsList currentPage");
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * 10;
	
	int lastPage = 0;
	int cnt = OrdersDAO.selectOrdersCount();
	
	if(cnt % rowPerPage == 0){
		lastPage = cnt / rowPerPage;
	} else {
		lastPage = cnt / rowPerPage + 1;
	}
	
	ArrayList<HashMap<String, Object>> ordersList = OrdersDAO.selectOrdersListByCustomer(mail, startRow, rowPerPage);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
	<div class="container">
  		<div class="row">
    		<div class="col-1"></div>
    		<div class="col-10">
				<h1>주문 내역</h1>
				<table  class="table table-striped">
					<tr>
						<td>상품 이름</td>
						<td>상품 개수</td>
						<td>배송 주소</td>
						<td>총 가격</td>
						<td>주문 날짜</td>
						<td>주문 상태</td>
						<td></td>
					</tr>
					<%
						for(HashMap<String, Object> m : ordersList){
							boolean write = ReviewDAO.selectReview((Integer)(m.get("ordersNo")));
					%>
							<tr>
								<td><%=(String)(m.get("goodsTitle")) %></td>
								<td><%=(Integer)(m.get("totalAmount")) %></td>
								<td><%=(String)(m.get("address")) %></td>
								<td><%=(Integer)(m.get("totalPrice")) %></td>
								<td><%=(String)(m.get("createDate")) %></td>
								<td><%=(String)(m.get("state")) %></td>
								<td>
					<%
								if(((String)(m.get("state"))).equals("배송완료") && write == true){
					%>
									<a href="/shop/customer/addReviewForm.jsp?ordersNo=<%=(Integer)(m.get("ordersNo")) %>">리뷰 작성</a>
					<%
								} else if(((String)(m.get("state"))).equals("접수")){
					%>
									<a href="/shop/customer/deleteOrders.jsp?ordersNo=<%=(Integer)(m.get("ordersNo")) %>&amount=<%=(Integer)(m.get("totalAmount")) %>&goodsNo=<%=(Integer)(m.get("goodsNo")) %>">주문 취소</a>
					<%
								} else if(((String)(m.get("state"))).equals("배송완료") && write == false){
					%>
									<div><a href="/shop/customer/deleteReview.jsp?ordersNo=<%=m.get("ordersNo")%>">리뷰 삭제</a></div>
					<%
								}
					%>
								</td>
					<%
						}
					%>
				</table>
			</div>
			<div class="col-1"></div>	
		</div>
</body>
</html>
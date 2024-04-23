<%@page import="java.util.HashMap"%>
<%@page import="shop.dao.OrdersDAO"%>
<%@page import="shop.dao.ReviewDAO"%>
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
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	int score = Integer.parseInt(request.getParameter("score"));
	String content = request.getParameter("content");
	
	System.out.println(ordersNo + "<-- addReviewAction param ordersNo");
	System.out.println(score + "<-- addReviewAction param score");
	System.out.println(content + "<-- addReviewAction param content");
	
	int row = ReviewDAO.insertReview(ordersNo, score, content);
	
	HashMap<String, Object> orders = OrdersDAO.selectOrders(ordersNo);
	int goodsNo = (Integer)(orders.get("goodsNo"));
	
	if(row == 1){
		//리뷰 입력 성공
		System.out.println("리뷰 입력 성공");
		response.sendRedirect("/shop/customer/goodsOne.jsp?goodsNo=" + goodsNo);
	} else {
		//리뷰 입력 실패
		System.out.println("리뷰 입력 실패");
		response.sendRedirect("/shop/customer/ordersList.jsp?");
	}
%>
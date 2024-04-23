<%@page import="shop.dao.GoodsDAO"%>
<%@page import="java.util.HashMap"%>
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
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	int price = Integer.parseInt(request.getParameter("goodsPrice"));
	String address = request.getParameter("address");
	HashMap<String, Object> sessionInfo = (HashMap<String, Object>)(session.getAttribute("loginCustomer")); 
	String mail = (String)(sessionInfo.get("customerEmail"));
	
	System.out.println("addOrders param goodsNo --> " + goodsNo);
	System.out.println("addOrders param amount --> " + amount);
	System.out.println("addOrders param price --> " + price);
	System.out.println("addOrders param address --> " + address);
	System.out.println("addOrders param mail --> " + mail);
	
	
	int row = GoodsDAO.updateGoodsAmount(goodsNo, amount);
	if(row == 1){
		//상품 수량 수정 성공
		System.out.println("상품 수량 수정 성공");
		row = OrdersDAO.insertOrders(mail, goodsNo, amount, price, address);
		if(row == 1){
			//입력 성공
			System.out.println("입력 성공");
			response.sendRedirect("/shop/customer/ordersList.jsp");
			return;
		} else {
			//입력 실패
			System.out.println("수정 실패");
		}
	} else {
		//상품 수량 수정 실패
		System.out.println("입력실패");
	}
	response.sendRedirect("/shop/customer/goodsOne.jsp?goodsNo=" + goodsNo);
	
%>
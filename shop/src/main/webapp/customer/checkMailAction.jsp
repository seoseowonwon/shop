<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/goodsList.jsp");
		return;
	}
%>
<%
	String customerEmail = request.getParameter("customerEmail");

	System.out.println(customerEmail + "<-- checkMailAction param customerEmail");
	
	String sql = null;
	sql = "select mail, pw, name, birth, gender from customer where mail =?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, customerEmail);
	System.out.println(stmt);
	ResultSet rs = null;
	rs = stmt.executeQuery();
	
	String check = "O";
	
	if(rs.next()){
			check = "X";
	}
	
	response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkEmail=" + customerEmail + "&check=" + check);
%>
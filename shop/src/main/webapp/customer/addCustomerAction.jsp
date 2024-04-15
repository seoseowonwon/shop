<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") != null){
		response.sendRedirect("/shop/customer/goodsList.jsp");
		return;
	}
%>
<%
	String customerEmail = request.getParameter("customerEmail");
	String customerPw = request.getParameter("customerPw");
	String customerName = request.getParameter("customerName");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");

	
	System.out.println(customerEmail + "<-- addCustomerAction param customerEmail");
	System.out.println(customerPw + "<-- addCustomerAction param customerPw");
	System.out.println(customerName + "<-- addCustomerAction param customerName");
	System.out.println(birth + "<-- addCustomerAction param birth");
	System.out.println(gender + "<-- addCustomerAction param gender");
	
	String sql = "insert into customer (mail, pw, name, birth, gender) values (?, ?, ?, ?, ?)";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, customerEmail);
	stmt.setString(2, customerPw);
	stmt.setString(3, customerName);
	stmt.setString(4, birth);
	stmt.setString(5, gender);
	System.out.println(stmt);
	int row = 0;
	row = stmt.executeUpdate();
	
	if(row == 1){
		//회원가입 성공
		System.out.println("회원가입 성공");
		response.sendRedirect("/shop/customer/loginForm.jsp");
	} else {
		//회원가입 실패
		System.out.println("회원가입 실패");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");
	}
%>
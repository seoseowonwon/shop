<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="shop.dao.*"%>


<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/goodsList.jsp");
		return;
	}
%>
<%
	String mail = request.getParameter("customerEmail");
	String pw = request.getParameter("customerPw");
	String name = request.getParameter("customerName");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");

	
	System.out.println("addCustomerAction param mail --> " + mail);
	System.out.println("addCustomerAction param pw --> " + pw);
	System.out.println("addCustomerAction param name --> " + name);
	System.out.println("addCustomerAction param birth --> "+ birth);
	System.out.println("addCustomerAction param gender --> "+ gender);
	
	/*
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
	System.out.println("addCustomerAction stmt--> "+stmt);
	int row = 0;
	row = stmt.executeUpdate();
	*/
	
	int addCustomer = CustomerDAO.addCustomer(mail, pw, name, birth, gender);
	
	if(addCustomer == 1){
		//회원가입 성공
		System.out.println("회원가입 성공");
		response.sendRedirect("/shop/customer/loginForm.jsp");
	} else {
		//회원가입 실패
		System.out.println("회원가입 실패");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");
	}
%>
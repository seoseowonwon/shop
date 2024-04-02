<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="java.net.URLEncoder"%>
<%
//인증분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") != null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>
<%
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	//디버깅
	System.out.println("empLoginAction --> "+empId);
	System.out.println("empLoginAction --> "+empPw);
	
	String sql = "select emp_id empId from emp where active='ON' and emp_id = ? and emp_pw = password(?)";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,empId);
	stmt.setString(2,empPw);
	rs = stmt.executeQuery();
	System.out.println("empLoginAction --> "+stmt);
	
	
	if(rs.next()){ // 로그인 성공
		response.sendRedirect("/shop/emp/empList.jsp");
		System.out.println("로그인 성공");
	} else { // 로그인 실패
		String errMsg = URLEncoder.encode( "ID와 PW를 확인해 주세요", "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg="+errMsg);
		System.out.println("로그인 실패");
	}
	
	
	
	
	/*
		select emp_id empId
		from emp
		where active='ON' and emp_id = ? and emp_pw = password(?)
	*/
	
	/*
		실패 /emp/empLoginForm.jsp
		성공 empList.jsp
	*/
%>
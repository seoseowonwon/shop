<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.net.*"%>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	String empId = request.getParameter("empId");
	String active = request.getParameter("active");
	
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "UPDATE emp SET active = ? WHERE emp_id = ?";
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	int row = 0;
 	if(active.equals("ON")) {
        // active가 ON일 경우
        System.out.println("active가 ON일 경우");
        active = "OFF";
        stmt.setString(1, active);
        stmt.setString(2, empId);
        row = stmt.executeUpdate();
    } else {    
        // active가 OFF일 경우
        System.out.println("active가 OFF일 경우");
        active = "ON";
       	stmt.setString(1, active);
        stmt.setString(2, empId);
        row = stmt.executeUpdate();
    }
 	
	response.sendRedirect("/shop/emp/empList.jsp");
	
%>